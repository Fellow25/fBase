ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1000)
	end
end)

CreateThread(function()
    if fDrugs.jeveuxblipecstasy then
        local blip = AddBlipForCoord(fDrugs.ecstasy.recolte.position.x, fDrugs.ecstasy.recolte.position.y, fDrugs.ecstasy.recolte.position.z)
        SetBlipSprite(blip, 501)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Récolte ecstasy')
        EndTextCommandSetBlipName(blip)
    end
end)  

CreateThread(function()
    if fDrugs.jeveuxblipecstasy then
        local blip = AddBlipForCoord(fDrugs.ecstasy.traitement.position.x, fDrugs.ecstasy.traitement.position.y, fDrugs.ecstasy.traitement.position.z)
        SetBlipSprite(blip, 501)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Traitement ecstasy')
        EndTextCommandSetBlipName(blip)
    end
end)  

function fEcstasyRecolte()
    local fER = RageUI.CreateMenu("Ecstasy", "Récolte")
      RageUI.Visible(fER, not RageUI.Visible(fER))
              while fER do
                  Wait(0)
                      RageUI.IsVisible(fER, true, true, true, function()

                        RageUI.ButtonWithStyle("Récolter de la ecstasy", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then      
                                TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                                Wait(100)        
                                recolteecstasy()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fER) then
                        fER = RMenu:DeleteType("Ecstasy", true)
                end
            end
        end

function fEcstasyTraitement()
    local fET = RageUI.CreateMenu("Ecstasy", "Traitement")
        RageUI.Visible(fET, not RageUI.Visible(fET))
                while fET do
                    Wait(0)
                        RageUI.IsVisible(fET, true, true, true, function()

                        RageUI.ButtonWithStyle("Mettre de la ecstasy en sachet", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
                                Wait(100)
                                traitementecstasy()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fET) then
                        fET = RMenu:DeleteType("Ecstasy", true)
                end
            end
        end



    ---------------------------------------- Position du Menu --------------------------------------------
local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.ecstasy.recolte.position.x, fDrugs.ecstasy.recolte.position.y, fDrugs.ecstasy.recolte.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fEcstasyRecolte()
                        end
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)

CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.ecstasy.recolte.position.x, fDrugs.ecstasy.recolte.position.y, fDrugs.ecstasy.recolte.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.ecstasy.recolte.position.x, fDrugs.ecstasy.recolte.position.y, fDrugs.ecstasy.recolte.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour récolter de la ecstasy", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fEcstasyRecolte()
                    end   
                end
        Wait(Timer)
    end
end)
-------------------------------------------------------------------------------
local traitementpossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.ecstasy.traitement.position.x, fDrugs.ecstasy.traitement.position.y, fDrugs.ecstasy.traitement.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fEcstasyTraitement()
                        end
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    traitementpossible = false
                end
            end
        Wait(Timer)
    end    
end)


CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.ecstasy.traitement.position.x, fDrugs.ecstasy.traitement.position.y, fDrugs.ecstasy.traitement.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.ecstasy.traitement.position.x, fDrugs.ecstasy.traitement.position.y, fDrugs.ecstasy.traitement.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour mettre la ecstasy en sachet", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fEcstasyTraitement()
                    end   
                end
        Wait(Timer)
    end
end)

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end

function recolteecstasy()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Wait(2000)
            TriggerServerEvent('recstasy')
    end
    else
        recoltepossible = false
    end
end

function traitementecstasy()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Wait(2000)
            TriggerServerEvent('tecstasy')
    end
    else
        traitementpossible = false
    end
end