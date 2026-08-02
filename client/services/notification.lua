local DEFAULT_TYPE = 'info'
local DEFAULT_DURATION = 4000
local DEFAULT_POSITION = 'top-center'

local FeatherMenu
local InvalidProviderReported = false
local ProviderErrors = {}

local function NormalizeNotification(message, typeOrDuration, maybeDuration)
    if message == nil then
        return nil
    end

    local notifyType = DEFAULT_TYPE
    local duration = DEFAULT_DURATION

    if type(typeOrDuration) == 'string' then
        notifyType = typeOrDuration
        duration = tonumber(maybeDuration) or DEFAULT_DURATION
    elseif type(typeOrDuration) == 'number' then
        duration = typeOrDuration
    end

    return tostring(message), notifyType, math.max(0, duration)
end

local function GetFeatherMenu()
    if FeatherMenu then
        return FeatherMenu
    end

    local succeeded, menu = pcall(function()
        return exports['feather-menu'].initiate()
    end)
    if not succeeded or not menu then
        print('^1[bcc-farming] Failed to initialize feather-menu notifications: ' .. tostring(menu))
        return nil
    end

    FeatherMenu = menu
    return FeatherMenu
end

local function NotifyWithFeather(message, notifyType, duration)
    local menu = GetFeatherMenu()
    if not menu then
        return false
    end

    menu:Notify({
        message = message,
        type = notifyType,
        autoClose = duration,
        position = DEFAULT_POSITION,
        transition = 'slide',
        icon = true,
        hideProgressBar = false,
        rtl = false,
        style = {},
        toastStyle = {},
        progressStyle = {}
    })
    return true
end

local function NotifyWithVorp(message, _, duration)
    Core.NotifyRightTip(message, duration)
    return true
end

local Providers = {
    ['feather-menu'] = NotifyWithFeather,
    ['vorp-core'] = NotifyWithVorp
}

function Notify(message, typeOrDuration, maybeDuration)
    local normalizedMessage, notifyType, duration = NormalizeNotification(
        message,
        typeOrDuration,
        maybeDuration
    )
    if not normalizedMessage then
        return false
    end

    local providerName = tostring(Config.Notify or ''):lower()
    local provider = Providers[providerName]
    if not provider then
        if not InvalidProviderReported then
            InvalidProviderReported = true
            print('^1[bcc-farming] Invalid Config.Notify provider: ' .. tostring(Config.Notify))
        end
        return false
    end

    local succeeded, result = pcall(provider, normalizedMessage, notifyType, duration)
    if not succeeded then
        if not ProviderErrors[providerName] then
            ProviderErrors[providerName] = true
            print(('^1[bcc-farming] %s notification failed: %s'):format(providerName, tostring(result)))
        end
        return false
    end

    return result ~= false
end

BccUtils.RPC:Register('bcc-farming:NotifyClient', function(data)
    if type(data) ~= 'table' then
        DBG:Error('Invalid NotifyClient payload: ' .. tostring(data))
        return
    end

    Notify(data.message, data.type, data.duration)
end)
