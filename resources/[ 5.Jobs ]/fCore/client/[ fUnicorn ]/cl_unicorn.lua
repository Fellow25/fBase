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
    if Unicorn.jeveuxblips then
    local unicornmap = AddBlipForCoord(Unicorn.pos.blips.position.x, Unicorn.pos.blips.position.y, Unicorn.pos.blips.position.z)
    SetBlipSprite(unicornmap, 121)
    SetBlipColour(unicornmap, 61)
    SetBlipScale(unicornmap, 0.65)
    SetBlipAsShortRange(unicornmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Vanilla Unicorn")
    EndTextCommandSetBlipName(unicornmap)
    end
end)

function Menuf6Unicorn()
    local fUnicornf6 = RageUI.CreateMenu("Vanilla Unicorn", "Interactions")
    fUnicornf6:SetRectangleBanner(147, 112, 219)
    RageUI.Visible(fUnicornf6, not RageUI.Visible(fUnicornf6))
    while fUnicornf6 do
        Wait(0)
            RageUI.IsVisible(fUnicornf6, true, true, true, function()

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_unicorn', ('Vanilla Unicorn'), montant)
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
                        TriggerServerEvent('fUnicorn:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fUnicorn:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('fUnicorn:Perso', msg)
                    end
                end)
                end, function() 
                end)
    
                if not RageUI.Visible(fUnicornf6) then
                    fUnicornf6 = RMenu:DeleteType("Vanilla Unicorn", true)
        end
    end
end

Keys.Register('F6', 'Unicorn', 'Ouvrir le menu Vanilla Unicorn', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
    	Menuf6Unicorn()
	end
end)

function OpenPrendreMenuUnicorn()
    local PrendreMenu = RageUI.CreateMenu("Vanilla Unicorn", "Nos produits")
    PrendreMenu:SetRectangleBanner(147, 112, 219)
        RageUI.Visible(PrendreMenu, not RageUI.Visible(PrendreMenu))
    while PrendreMenu do
        Wait(0)
            RageUI.IsVisible(PrendreMenu, true, true, true, function()
            for k,v in pairs(Unicorn.Bar.item) do
            RageUI.ButtonWithStyle(v.Label.. ' Prix: ' .. v.Price .. '€', nil, { }, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fUnicorn:bar', v.Name, v.Price)
                end
            end)
        end
                end, function() 
                end)
    
                if not RageUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Vanilla Unicorn", true)
        end
    end
end


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Unicorn.pos.MenuPrendre.position.x, Unicorn.pos.MenuPrendre.position.y, Unicorn.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and Unicorn.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Unicorn.pos.MenuPrendre.position.x, Unicorn.pos.MenuPrendre.position.y, Unicorn.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder au bar", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenPrendreMenuUnicorn()
                    end   
                end
            end 
        Wait(Timer)
    end
end)



function Coffreunicorn()
    local Cunicorn = RageUI.CreateMenu("Coffre", "Vanilla Unicorn")
    Cunicorn:SetRectangleBanner(147, 112, 219)
        RageUI.Visible(Cunicorn, not RageUI.Visible(Cunicorn))
            while Cunicorn do
            Wait(0)
            RageUI.IsVisible(Cunicorn, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            UnicornRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            UnicornDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cunicorn) then
            Cunicorn = RMenu:DeleteType("Cunicorn", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Unicorn.pos.coffre.position.x, Unicorn.pos.coffre.position.y, Unicorn.pos.coffre.position.z)
            if jobdist <= 10.0 and Unicorn.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Unicorn.pos.coffre.position.x, Unicorn.pos.coffre.position.y, Unicorn.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffreunicorn()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function GarageUnicorn()
  local GUnicorn = RageUI.CreateMenu("Garage", "Vanilla Unicorn")
  GUnicorn:SetRectangleBanner(147, 112, 219)
    RageUI.Visible(GUnicorn, not RageUI.Visible(GUnicorn))
        while GUnicorn do
            Wait(0)
                RageUI.IsVisible(GUnicorn, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GUnicornvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarUnicorn(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GUnicorn) then
            GUnicorn = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Unicorn.pos.garage.position.x, Unicorn.pos.garage.position.y, Unicorn.pos.garage.position.z)
            if dist3 <= 10.0 and Unicorn.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Unicorn.pos.garage.position.x, Unicorn.pos.garage.position.y, Unicorn.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageUnicorn()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarUnicorn(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Unicorn.pos.spawnvoiture.position.x, Unicorn.pos.spawnvoiture.position.y, Unicorn.pos.spawnvoiture.position.z, Unicorn.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Vanilla Unicorn"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end



itemstock = {}
function UnicornRetirerobjet()
    local Stockunicorn = RageUI.CreateMenu("Coffre", "Vanilla Unicorn")
    Stockunicorn:SetRectangleBanner(147, 112, 219)
    ESX.TriggerServerCallback('funicorn:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockunicorn, not RageUI.Visible(Stockunicorn))
        while Stockunicorn do
            Wait(0)
                RageUI.IsVisible(Stockunicorn, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('funicorn:getStockItem', v.name, tonumber(count))
                                    UnicornRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockunicorn) then
            Stockunicorn = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function UnicornDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Vanilla Unicorn")
    StockPlayer:SetRectangleBanner(147, 112, 219)
    ESX.TriggerServerCallback('funicorn:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('funicorn:putStockItems', item.name, tonumber(count))
                                            UnicornDeposerobjet()
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
