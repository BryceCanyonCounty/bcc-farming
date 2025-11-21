local BccUtils = exports['bcc-utils'].initiate()
FeatherMenu = exports['feather-menu'].initiate()
local VORPcore = exports.vorp_core:GetCore()

function Notify(message, typeOrDuration, maybeDuration)
    local notifyType = "info"
    local notifyDuration = 4000

    -- Detect which argument is which
    if type(typeOrDuration) == "string" then
        notifyType = typeOrDuration
        notifyDuration = tonumber(maybeDuration) or 4000
    elseif type(typeOrDuration) == "number" then
        notifyDuration = typeOrDuration
    end

    if Config.Notify == "feather-menu" then
        FeatherMenu:Notify({
            message = message,
            type = notifyType,
            autoClose = notifyDuration,
            position = "top-center",
            transition = "slide",
            icon = true,
            hideProgressBar = false,
            rtl = false,
            style = {},
            toastStyle = {},
            progressStyle = {}
        })
    elseif Config.Notify == "vorp-core" then
        -- Only message and duration supported
        VORPcore.NotifyRightTip(message, notifyDuration)
    else
        print("^1[Notify] Invalid Config.Notify: " .. tostring(Config.Notify))
    end
end

BccUtils.RPC:Register("bcc-farming:NotifyClient", function(data)
    Notify(data.message, data.type, data.duration)
end)
