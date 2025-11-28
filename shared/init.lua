Core = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()
DBG = BccUtils.Debug:Get("bcc-farming", Config.DevMode)

if DBG and Config.DevMode then 
    DBG:Enable() 
end
DBG:Info("Farming debug initialized (client)")