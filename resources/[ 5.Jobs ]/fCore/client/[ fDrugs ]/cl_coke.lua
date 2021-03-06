local ESX = exports.es_extended:getSharedObject()


CreateThread(function()
    if fDrugs.jeveuxblipcoke then
        local blip = AddBlipForCoord(fDrugs.coke.recolte.x, fDrugs.coke.recolte.y, fDrugs.coke.recolte.z)
        SetBlipSprite(blip, 501)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Récolte coke')
        EndTextCommandSetBlipName(blip)
    end
end)  

CreateThread(function()
    if fDrugs.jeveuxblipcoke then
        local blip = AddBlipForCoord(fDrugs.coke.traitement.x, fDrugs.coke.traitement.y, fDrugs.coke.traitement.z)
        SetBlipSprite(blip, 501)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Traitement coke')
        EndTextCommandSetBlipName(blip)
    end
end)  

local function fCokeRecolte()
    local fCR = RageUI.CreateMenu("Coke", "Récolte")
      RageUI.Visible(fCR, not RageUI.Visible(fCR))
              while fCR do
                  Wait(0)
                      RageUI.IsVisible(fCR, true, true, true, function()

                        RageUI.ButtonWithStyle("Récolter de la coke", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then     
                                TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                                Wait(100)         
                                recolteCoke()
                                ClearPedTasksImmediately(PlayerPedId())
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fCR) then
                        fCR = RMenu:DeleteType("Coke", true)
                end
            end
        end

local function fCokeTraitement()
    local fCT = RageUI.CreateMenu("Coke", "Traitement")
        RageUI.Visible(fCT, not RageUI.Visible(fCT))
                while fCT do
                    Wait(0)
                        RageUI.IsVisible(fCT, true, true, true, function()

                        RageUI.ButtonWithStyle("Mettre de la coke en sachet", nil, {}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
                                Wait(100)         
                                traitementcoke()
                                ClearPedTasksImmediately(PlayerPedId())
                                RageUI.CloseAll()
                            end
                        end)
                    end, function()
                    end)       
                    if not RageUI.Visible(fCT) then
                        fCT = RMenu:DeleteType("Coke", true)
                end
            end
        end



    ---------------------------------------- Position du Menu --------------------------------------------
local recoltepossible = false
CreateThread(function()
    local interval, zoneDistance
    while (true) do
        interval = 1000
        zoneDistance = #(GetEntityCoords(PlayerPedId()) - fDrugs.coke.recolte)
        if (zoneDistance <= 10.0 and fDrugs.jeveuxmarker) then
            interval = 0
            DrawMarker(20, fDrugs.coke.recolte.x, fDrugs.coke.recolte.y, fDrugs.coke.recolte.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if (zoneDistance <= 1.5) then
            interval = 0
            RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour récolter de la coke", time_display = 1 })
            if IsControlJustPressed(1, 51) then
                fCokeRecolte()
            end
        end
        --print(1, zoneDistance)
        if (zoneDistance > 1.5) then
            --print(2, 'is executed')
            recoltepossible = false
        end
        Wait(0)
    end
end)


-------------------------------------------------------------------------------
local traitementpossible = false
CreateThread(function()
    local interval, dist4
    while (true) do
        interval = 1000
        dist4 = #(GetEntityCoords(PlayerPedId()) - fDrugs.coke.traitement)
        if (dist4 <= 10.0 and fDrugs.jeveuxmarker) then
            interval = 0
            DrawMarker(20, fDrugs.coke.traitement.x, fDrugs.coke.traitement.y, fDrugs.coke.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if (dist4 <= 1.5) then
            interval = 0
            RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour mettre la coke en sachet", time_display = 1 })
            if IsControlJustPressed(1, 51) then
                fCokeTraitement()
            end
        end
        Wait(interval)
    end
end)
    
function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end



function recolteCoke()
    if not recoltepossible then recoltepossible = true end
    while recoltepossible do
        coords = #(GetEntityCoords(PlayerPedId()) - fDrugs.coke.recolte)
        if (coords > 1.5) then return end
        if (coords < 1.5) then
            TriggerServerEvent('rcoke')
        end
    Wait(2000)
    end
end

function traitementcoke()
    if not traitementpossible then traitementpossible = true end
    while traitementpossible do
        coords = #(GetEntityCoords(PlayerPedId()) - fDrugs.coke.traitement)
        if (coords > 1.5) then return end
        if (coords < 1.5) then
            TriggerServerEvent('tcoke')
        end
    Wait(2000)
    end
end