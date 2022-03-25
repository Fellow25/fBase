ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1000)
	end
end)

local playerPed = PlayerPedId()

CreateThread(function()
    if fDrugs.jeveuxblipopium then
        local blip = AddBlipForCoord(fDrugs.opium.recolte.position.x, fDrugs.opium.recolte.position.y, fDrugs.opium.recolte.position.z)
        SetBlipSprite(blip, 766)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 48)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Récolte opium')
        EndTextCommandSetBlipName(blip)
    end
end)  

CreateThread(function()
    if fDrugs.jeveuxblipopium then
        local blip = AddBlipForCoord(fDrugs.opium.traitement.position.x, fDrugs.opium.traitement.position.y, fDrugs.opium.traitement.position.z)
        SetBlipSprite(blip, 766)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 48)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Traitement opium')
        EndTextCommandSetBlipName(blip)
    end
end)  

function fOpiumRecolte()
    local fOR = RageUI.CreateMenu("Opium", "Récolte")
      RageUI.Visible(fOR, not RageUI.Visible(fOR))
              while fOR do
                  Wait(0)
                      RageUI.IsVisible(fOR, true, true, true, function()

                        RageUI.ButtonWithStyle("Récolter de la opium", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then   
                                TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                                Wait(100)           
                                recolteopium()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fOR) then
                        fOR = RMenu:DeleteType("Opium", true)
                end
            end
        end

function fOpiumTraitement()
    local fOT = RageUI.CreateMenu("Opium", "Traitement")
        RageUI.Visible(fOT, not RageUI.Visible(fOT))
                while fOT do
                    Wait(0)
                        RageUI.IsVisible(fOT, true, true, true, function()

                        RageUI.ButtonWithStyle("Mettre de la opium en sachet", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
                                Wait(100)
                                traitementopium()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fOT) then
                        fOT = RMenu:DeleteType("Opium", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.opium.recolte.position.x, fDrugs.opium.recolte.position.y, fDrugs.opium.recolte.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fOpiumRecolte()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.opium.recolte.position.x, fDrugs.opium.recolte.position.y, fDrugs.opium.recolte.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.opium.recolte.position.x, fDrugs.opium.recolte.position.y, fDrugs.opium.recolte.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour récolter de la opium", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fOpiumRecolte()
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.opium.traitement.position.x, fDrugs.opium.traitement.position.y, fDrugs.opium.traitement.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fOpiumRecolte()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.opium.traitement.position.x, fDrugs.opium.traitement.position.y, fDrugs.opium.traitement.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.opium.traitement.position.x, fDrugs.opium.traitement.position.y, fDrugs.opium.traitement.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour mettre la opium en sachet", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fOpiumTraitement()
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

function recolteopium()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Wait(2000)
            TriggerServerEvent('ropium')
    end
    else
        recoltepossible = false
    end
end

function traitementopium()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Wait(2000)
            TriggerServerEvent('topium')
    end
    else
        traitementpossible = false
    end
end