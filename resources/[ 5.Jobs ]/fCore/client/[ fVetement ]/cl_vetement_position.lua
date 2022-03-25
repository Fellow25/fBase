local isInZone, isInZoneJob = false, false

position = {
    {72.254, -1399.102, 29.376},
    {-703.776, -152.258, 37.415},
    {-167.863, -298.969, 39.733},
    {428.694, -800.106, 29.491},
    {-829.413,-1073.710, 11.328},
    {-1447.797, -242.461, 49.820},
    {11.632, 6514.224, 30.877},
    {123.646, -219.440, 54.557},
    {1696.291, 4829.312, 42.063},
    {618.093, 2759.629, 42.088},
    {1190.550, 2713.441, 38.222},
    {-1193.429, -772.262, 17.324},
    {-3172.496, 1048.133, 10.863},
    {-1108.441, 2708.923, 19.107},
}

CreateThread(function()
    for _,v in pairs(position) do
        local blip = AddBlipForCoord(v[1], v[2], v[3])
        SetBlipSprite (blip, 73)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.65)
        SetBlipColour (blip, 47)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Boutique de vétement')
        EndTextCommandSetBlipName(blip)
    end    
end)

CreateThread(function()
    while true do
        local Timer = 500
        for _,v in pairs(position) do
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, v[1], v[2], v[3])
        if dist3 <= 7.0 then
            Timer = 0
            DrawMarker(20, v[1], v[2], v[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 165, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~o~E~w~ pour accéder à la boutique !", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        GetComponent()      
                        fVetements()
                    end   
                end
            end
        Wait(Timer)
    end
end)