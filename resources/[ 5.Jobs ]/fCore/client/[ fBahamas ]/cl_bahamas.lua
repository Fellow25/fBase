ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


CreateThread(function()
    if Bahamas.jeveuxblips then
    local bahamasmap = AddBlipForCoord(Bahamas.pos.blips.position.x, Bahamas.pos.blips.position.y, Bahamas.pos.blips.position.z)
    SetBlipSprite(bahamasmap, 279)
    SetBlipColour(bahamasmap, 7)
    SetBlipScale(bahamasmap, 0.65)
    SetBlipAsShortRange(bahamasmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Bahamas")
    EndTextCommandSetBlipName(bahamasmap)
    end
end)

function Menuf6Bahamas()
    local fBahamasf6 = RageUI.CreateMenu("Bahamas", "Interactions")
    fBahamasf6:SetRectangleBanner(153, 50, 204)
    RageUI.Visible(fBahamasf6, not RageUI.Visible(fBahamasf6))
    while fBahamasf6 do
        Wait(0)
            RageUI.IsVisible(fBahamasf6, true, true, true, function()

                RageUI.Separator("↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_bahamas', ('Bahamas'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)


                RageUI.Separator("↓ Annonce ↓")



                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('fBahamas:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fBahamas:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('fBahamas:Perso', msg)
                    end
                end)
                end, function() 
                end)
    
                if not RageUI.Visible(fBahamasf6) then
                    fBahamasf6 = RMenu:DeleteType("Bahamas", true)
        end
    end
end

Keys.Register('F6', 'Bahamas', 'Ouvrir le menu Bahamas', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas' then
    	Menuf6Bahamas()
	end
end)

function OpenPrendreMenuBahamas()
    local PrendreMenu = RageUI.CreateMenu("Bahamas", "Nos produits")
    PrendreMenu:SetRectangleBanner(153, 50, 204)
        RageUI.Visible(PrendreMenu, not RageUI.Visible(PrendreMenu))
    while PrendreMenu do
        Wait(0)
            RageUI.IsVisible(PrendreMenu, true, true, true, function()
            for k,v in pairs(Bahamas.Bar.item) do
            RageUI.ButtonWithStyle(v.Label.. ' Prix: ' .. v.Price .. '€', nil, { }, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fBahamas:bar', v.Name, v.Price)
                end
            end)
        end
                end, function() 
                end)
    
                if not RageUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Bahamas", true)
        end
    end
end


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bahamas.pos.MenuPrendre.position.x, Bahamas.pos.MenuPrendre.position.y, Bahamas.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and Bahamas.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Bahamas.pos.MenuPrendre.position.x, Bahamas.pos.MenuPrendre.position.y, Bahamas.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 153, 50, 204, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder au bar", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenPrendreMenuBahamas()
                    end   
                end
            end 
        Wait(Timer)
    end
end)



function Coffrebahamas()
    local Cbahamas = RageUI.CreateMenu("Coffre", "Bahamas")
    Cbahamas:SetRectangleBanner(153, 50, 204)
        RageUI.Visible(Cbahamas, not RageUI.Visible(Cbahamas))
            while Cbahamas do
            Wait(0)
            RageUI.IsVisible(Cbahamas, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BahamasRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BahamasDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cbahamas) then
            Cbahamas = RMenu:DeleteType("Cbahamas", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Bahamas.pos.coffre.position.x, Bahamas.pos.coffre.position.y, Bahamas.pos.coffre.position.z)
            if jobdist <= 10.0 and Bahamas.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Bahamas.pos.coffre.position.x, Bahamas.pos.coffre.position.y, Bahamas.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 153, 50, 204, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrebahamas()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function GarageBahamas()
  local GBahamas = RageUI.CreateMenu("Garage", "Bahamas")
  GBahamas:SetRectangleBanner(153, 50, 204)
    RageUI.Visible(GBahamas, not RageUI.Visible(GBahamas))
        while GBahamas do
            Wait(0)
                RageUI.IsVisible(GBahamas, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GBahamasvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarBahamas(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GBahamas) then
            GBahamas = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bahamas.pos.garage.position.x, Bahamas.pos.garage.position.y, Bahamas.pos.garage.position.z)
            if dist3 <= 10.0 and Bahamas.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Bahamas.pos.garage.position.x, Bahamas.pos.garage.position.y, Bahamas.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 153, 50, 204, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageBahamas()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarBahamas(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Bahamas.pos.spawnvoiture.position.x, Bahamas.pos.spawnvoiture.position.y, Bahamas.pos.spawnvoiture.position.z, Bahamas.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Bahamas"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end



itemstock = {}
function BahamasRetirerobjet()
    local Stockbahamas = RageUI.CreateMenu("Coffre", "Bahamas")
    Stockbahamas:SetRectangleBanner(153, 50, 204)
    ESX.TriggerServerCallback('fbahamas:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockbahamas, not RageUI.Visible(Stockbahamas))
        while Stockbahamas do
            Wait(0)
                RageUI.IsVisible(Stockbahamas, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fbahamas:getStockItem', v.name, tonumber(count))
                                    BahamasRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockbahamas) then
            Stockbahamas = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function BahamasDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Bahamas")
    StockPlayer:SetRectangleBanner(153, 50, 204)
    ESX.TriggerServerCallback('fbahamas:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('fbahamas:putStockItems', item.name, tonumber(count))
                                            BahamasDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end
