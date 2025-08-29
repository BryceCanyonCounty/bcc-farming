-- bcc-farming resource debug system (resource-scoped global)
-- DO NOT MAKE CHANGES TO THIS FILE
if not BCCFarmingDebug then
    ---@class BCCFarmingDebugLib
    ---@field Info fun(message: string)
    ---@field Error fun(message: string)
    ---@field Warning fun(message: string)
    ---@field Success fun(message: string)
    ---@field DevModeActive boolean
    BCCFarmingDebug = {}

    BCCFarmingDebug.DevModeActive = Config and Config.devMode and Config.devMode.active or false

    -- No-op function
    local function noop() end

    -- Function to create loggers
    local function createLogger(prefix, color)
        if BCCFarmingDebug.DevModeActive then
            return function(message)
                print(('^%d[%s] ^3%s^0'):format(color, prefix, message))
            end
        else
            return noop
        end
    end

    -- Create loggers with appropriate colors
    BCCFarmingDebug.Info = createLogger("INFO", 5)    -- Purple
    BCCFarmingDebug.Error = createLogger("ERROR", 1)  -- Red
    BCCFarmingDebug.Warning = createLogger("WARNING", 3) -- Yellow
    BCCFarmingDebug.Success = createLogger("SUCCESS", 2) -- Green

    -- Make it globally available
    _G.BCCFarmingDebug = BCCFarmingDebug
end
