ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1000)
	end
end)

local playerPed = PlayerPedId()

CreateThread(function()
    if fDrugs.jeveuxbliplsd then
        local blip = AddBlipForCoord(fDrugs.lsd.recolte.position.x, fDrugs.lsd.recolte.position.y, fDrugs.lsd.recolte.position.z)
        SetBlipSprite(blip, 57)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 28)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Récolte lsd')
        EndTextCommandSetBlipName(blip)
    end
end)  

CreateThread(function()
    if fDrugs.jeveuxbliplsd then
        local blip = AddBlipForCoord(fDrugs.lsd.traitement.position.x, fDrugs.lsd.traitement.position.y, fDrugs.lsd.traitement.position.z)
        SetBlipSprite(blip, 57)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 28)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Traitement lsd')
        EndTextCommandSetBlipName(blip)
    end
end)  

function fLSDRecolte()
    local fLSDR = RageUI.CreateMenu("LSD", "Récolte")
      RageUI.Visible(fLSDR, not RageUI.Visible(fLSDR))
              while fLSDR do
                  Wait(0)
                      RageUI.IsVisible(fLSDR, true, true, true, function()

                        RageUI.ButtonWithStyle("Récolter de la LSD", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then  
                                TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                                Wait(100)     
                                recoltelsd()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fLSDR) then
                        fLSDR = RMenu:DeleteType("LSD", true)
                end
            end
        end

function fLSDTraitement()
    local fLSDT = RageUI.CreateMenu("LSD", "Traitement")
        RageUI.Visible(fLSDT, not RageUI.Visible(fLSDT))
                while fLSDT do
                    Wait(0)
                        RageUI.IsVisible(fLSDT, true, true, true, function()

                        RageUI.ButtonWithStyle("Mettre de la LSD en sachet", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
                                Wait(100)
                                traitementlsd()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fLSDT) then
                        fLSDT = RMenu:DeleteType("LSD", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.lsd.recolte.position.x, fDrugs.lsd.recolte.position.y, fDrugs.lsd.recolte.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fLSDRecolte()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.lsd.recolte.position.x, fDrugs.lsd.recolte.position.y, fDrugs.lsd.recolte.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.lsd.recolte.position.x, fDrugs.lsd.recolte.position.y, fDrugs.lsd.recolte.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour récolter de la LSD", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fLSDRecolte()
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.lsd.traitement.position.x, fDrugs.lsd.traitement.position.y, fDrugs.lsd.traitement.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fLSDRecolte()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.lsd.traitement.position.x, fDrugs.lsd.traitement.position.y, fDrugs.lsd.traitement.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.lsd.traitement.position.x, fDrugs.lsd.traitement.position.y, fDrugs.lsd.traitement.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour mettre la LSD en sachet", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fLSDTraitement()
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

function recoltelsd()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Wait(2000)
            TriggerServerEvent('rlsd')
    end
    else
        recoltepossible = false
    end
end

function traitementlsd()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Wait(2000)
            TriggerServerEvent('tlsd')
    end
    else
        traitementpossible = false
    end
end