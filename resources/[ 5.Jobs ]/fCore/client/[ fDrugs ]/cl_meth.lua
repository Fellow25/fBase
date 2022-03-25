ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(1000)
	end
end)

local playerPed = PlayerPedId()

CreateThread(function()
    if fDrugs.jeveuxblipmeth then
        local blip = AddBlipForCoord(fDrugs.meth.recolte.position.x, fDrugs.meth.recolte.position.y, fDrugs.meth.recolte.position.z)
        SetBlipSprite(blip, 570)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Récolte meth')
        EndTextCommandSetBlipName(blip)
    end
end)  

CreateThread(function()
    if fDrugs.jeveuxblipmeth then
        local blip = AddBlipForCoord(fDrugs.meth.traitement.position.x, fDrugs.meth.traitement.position.y, fDrugs.meth.traitement.position.z)
        SetBlipSprite(blip, 570)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Traitement meth')
        EndTextCommandSetBlipName(blip)
    end
end)  

function fMethRecolte()
    local fMR = RageUI.CreateMenu("Meth", "Récolte")
      RageUI.Visible(fMR, not RageUI.Visible(fMR))
              while fMR do
                  Wait(0)
                      RageUI.IsVisible(fMR, true, true, true, function()

                        RageUI.ButtonWithStyle("Récolter de la meth", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then  
                                TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                                Wait(100)            
                                recoltemeth()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fMR) then
                        fMR = RMenu:DeleteType("Meth", true)
                end
            end
        end

function fMethTraitement()
    local fMT = RageUI.CreateMenu("Meth", "Traitement")
        RageUI.Visible(fMT, not RageUI.Visible(fMT))
                while fMT do
                    Wait(0)
                        RageUI.IsVisible(fMT, true, true, true, function()

                        RageUI.ButtonWithStyle("Mettre de la meth en sachet", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, true)
                                Wait(100)
                                traitementmeth()
                                ClearPedTasksImmediately(playerPed)
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fMT) then
                        fMT = RMenu:DeleteType("Meth", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.meth.recolte.position.x, fDrugs.meth.recolte.position.y, fDrugs.meth.recolte.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fMethRecolte()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.meth.recolte.position.x, fDrugs.meth.recolte.position.y, fDrugs.meth.recolte.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.meth.recolte.position.x, fDrugs.meth.recolte.position.y, fDrugs.meth.recolte.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour récolter de la meth", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fMethRecolte()
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, fDrugs.meth.traitement.position.x, fDrugs.meth.traitement.position.y, fDrugs.meth.traitement.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            fMethTraitement()
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
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fDrugs.meth.traitement.position.x, fDrugs.meth.traitement.position.y, fDrugs.meth.traitement.position.z)
        if dist3 <= 10.0 and fDrugs.jeveuxmarker then
            Timer = 0
            DrawMarker(20, fDrugs.meth.traitement.position.x, fDrugs.meth.traitement.position.y, fDrugs.meth.traitement.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour mettre la meth en sachet", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            fMethTraitement()
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

function recoltemeth()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
            Wait(2000)
            TriggerServerEvent('rmeth')
    end
    else
        recoltepossible = false
    end
end

function traitementmeth()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Wait(2000)
            TriggerServerEvent('tmeth')
    end
    else
        traitementpossible = false
    end
end