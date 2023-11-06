RegisterCommand('car', function (source, args)
    local vehicleName = args[1] or 'adder'

    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = { 'You dummy, ' .. vehicleName .. ' is not a vehicle' }
        })
        return
    end

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait (10)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    local vehicle = CreateVehicle(
        vehicleName,
        pos,
        heading,
        -- isNetwork-
        true
    )
    -- -1 is the driver seat, and so on
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- Release the model from memory
    SetModelAsNoLongerNeeded(vehicleName)
end)