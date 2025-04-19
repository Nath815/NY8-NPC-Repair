local pedSpawned = false

CreateThread(function()
    local model = Config.PedModel
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local ped = CreatePed(0, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 1.0, Config.PedCoords.w, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    pedSpawned = true

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'repair_vehicle',
            icon = 'fas fa-wrench',
            label = '🛠️ Réparer le véhicule',
            onSelect = function(data)
                local playerPed = PlayerPedId()
                local veh = GetVehiclePedIsIn(playerPed, false)
                if veh ~= 0 and GetPedInVehicleSeat(veh, -1) == playerPed then
                    TriggerServerEvent('ny8_quickrepair:payAndRepair')
                else
                    lib.notify({type = 'error', description = 'Tu dois être dans un véhicule !'})
                end
            end,
        }
    })
end)

RegisterNetEvent('ny8_quickrepair:repair')
AddEventHandler('ny8_quickrepair:repair', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleFixed(veh)
    SetVehicleDirtLevel(veh, 0.0)
    lib.notify({type = 'success', description = '🚗 Véhicule réparé !'})
end)