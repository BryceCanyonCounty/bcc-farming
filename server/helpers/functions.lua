VorpInv = {}
VorpInv = exports.vorp_inventory:vorp_inventoryApi()
VORPcore = {}
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
BccUtils = exports['bcc-utils'].initiate()