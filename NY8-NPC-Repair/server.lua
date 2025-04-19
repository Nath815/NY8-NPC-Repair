ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('ny8_quickrepair:payAndRepair')
AddEventHandler('ny8_quickrepair:payAndRepair', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= Config.RepairPrice then
        xPlayer.removeMoney(Config.RepairPrice)
        TriggerClientEvent('ny8_quickrepair:repair', source)
        TriggerClientEvent('esx:showNotification', source, "🛠️ Véhicule réparé pour ~g~$" .. Config.RepairPrice)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Pas assez d'argent !")
    end
end)