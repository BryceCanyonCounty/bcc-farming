Core = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()
DBG = BccUtils.Debug:Get('bcc-farming', Config.DevMode)

if DBG then
    if Config.DevMode then
        DBG:Enable()
    end

    local context = IsDuplicityVersion() and 'server' or 'client'
    DBG:Info(('Farming debug initialized (%s)'):format(context))
end
