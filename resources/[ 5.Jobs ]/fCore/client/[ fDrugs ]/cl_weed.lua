ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1000)
	end
end)

local playerPed = PlayerPedId()

CreateThread(function()
    if fDrugs.jeveuxblipweed then
        local blip = AddBlipForCoord(fDrugs.weed.recolte.position.x, fDrugs.weed.recolte.position.y, fDrugs.weed.recolte.position.z)
        SetBlipSprite(blip, 140)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Récolte weed')
        EndTextCommandSetBlipName(blip)
    end
end)  

CreateThread(function()
    if fDrugs.jeveuxblipweed then
        local blip = AddBlipForCoord(fDrugs.weed.traitement.position.x, fDrugs.weed.traitement.position.y, fDrugs.weed.traitement.position.z)
        SetBlipSprite(blip, 140)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Traitement weed')
        EndTextCommandSetBlipName(blip)
    end
end)  

function fWeedRecolte()
    local fWR = RageUI.CreateMenu("Weed", "Récolte")
      RageUI.Visible(fWR, not RageUI.Visible(fWR))
              while fWR do
                  Wait(0)
                      RageUI.IsVisible(fWR, true, true, true, function()

                        RageUI.ButtonWithStyle("Récolter de la weed", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                                Wait(100)
                                recolteweed()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fWR) then
                        fWR = RMenu:DeleteType("Weed", true)
                end
            end
        end

function fWeedTraitement()
    local fWT = RageUI.CreateMenu("Weed", "Traitement")
        RageUI.Visible(fWT, not RageUI.Visible(fWT))
                while fWT do
                    Wait(0)
                        RageUI.IsVisible(fWT, true, true, true, function()

                        RageUI.ButtonWithStyle("Mettre de la weed en sachet", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
                                Wait(100)
                                traitementweed()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fWT) then
                        fWT = RMenu:DeleteType("Weed", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.weed.recolte.position.x, fDrugs.weed.recolte.position.y, fDrugs.weed.recolte.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fWeedRecolte()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.weed.recolte.position.x, fDrugs.weed.recolte.position.y, fDrugs.weed.recolte.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.weed.recolte.position.x, fDrugs.weed.recolte.position.y, fDrugs.weed.recolte.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour récolter de la weed", time_display = 1 })
                        if IsControlJustPressed(1,51) then      
                            fWeedRecolte()
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.weed.traitement.position.x, fDrugs.weed.traitement.position.y, fDrugs.weed.traitement.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fWeedRecolte()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.weed.traitement.position.x, fDrugs.weed.traitement.position.y, fDrugs.weed.traitement.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.weed.traitement.position.x, fDrugs.weed.traitement.position.y, fDrugs.weed.traitement.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour mettre la weed en sachet", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fWeedTraitement()
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

function recolteweed()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Wait(2000)
            TriggerServerEvent('rweed')
    end
    else
        recoltepossible = false
    end
end

function traitementweed()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Wait(2000)
            TriggerServerEvent('tweed')
    end
    else
        traitementpossible = false
    end
end