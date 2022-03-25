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
    if Split.jeveuxblips then
    local splitmap = AddBlipForCoord(Split.pos.blips.position.x, Split.pos.blips.position.y, Split.pos.blips.position.z)
    SetBlipSprite(splitmap, 93)
    SetBlipColour(splitmap, 48)
    SetBlipScale(splitmap, 0.65)
    SetBlipAsShortRange(splitmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Split Sides")
    EndTextCommandSetBlipName(splitmap)
    end
end)

function Menuf6Split()
    local fSplitf6 = RageUI.CreateMenu("Split Sides", "Interactions")
    fSplitf6:SetRectangleBanner(5, 0, 0)
    RageUI.Visible(fSplitf6, not RageUI.Visible(fSplitf6))
    while fSplitf6 do
        Wait(0)
            RageUI.IsVisible(fSplitf6, true, true, true, function()

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_split', ('Split'), montant)
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
                        TriggerServerEvent('fSplit:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fSplit:Fermer')
                    end
                end)

                RageUI.ButtonWithStyle("Annonces soirée",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fSplit:Soire')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('fSplit:Perso', msg)
                    end
                end)
                end, function() 
                end)
    
                if not RageUI.Visible(fSplitf6) then
                    fSplitf6 = RMenu:DeleteType("Split", true)
        end
    end
end

Keys.Register('F6', 'Split', 'Ouvrir le menu Split', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'split' then
    	Menuf6Split()
	end
end)

function OpenPrendreMenuSplit()
    local PrendreMenu = RageUI.CreateMenu("Split Sides", "Nos produits")
    PrendreMenu:SetRectangleBanner(5, 0, 0)
        RageUI.Visible(PrendreMenu, not RageUI.Visible(PrendreMenu))
    while PrendreMenu do
        Wait(0)
            RageUI.IsVisible(PrendreMenu, true, true, true, function()
            for k,v in pairs(Split.Bar.item) do
            RageUI.ButtonWithStyle(v.Label.. ' Prix: ' .. v.Price .. '€', nil, { }, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fSplit:bar', v.Name, v.Price)
                end
            end)
        end
                end, function() 
                end)
    
                if not RageUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Split", true)
        end
    end
end


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'split' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Split.pos.MenuPrendre.position.x, Split.pos.MenuPrendre.position.y, Split.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and Split.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Split.pos.MenuPrendre.position.x, Split.pos.MenuPrendre.position.y, Split.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 1, 140, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder au bar", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenPrendreMenuSplit()
                    end   
                end
            end 
        Wait(Timer)
    end
end)



function Coffresplit()
    local Csplit = RageUI.CreateMenu("Coffre", "Split Sides")
    Csplit:SetRectangleBanner(5, 0, 0)
        RageUI.Visible(Csplit, not RageUI.Visible(Csplit))
            while Csplit do
            Wait(0)
            RageUI.IsVisible(Csplit, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SplitRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SplitDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Csplit) then
            Csplit = RMenu:DeleteType("Csplit", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'split' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Split.pos.coffre.position.x, Split.pos.coffre.position.y, Split.pos.coffre.position.z)
            if jobdist <= 10.0 and Split.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Split.pos.coffre.position.x, Split.pos.coffre.position.y, Split.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 1, 140, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffresplit()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function GarageSplit()
  local GSplit = RageUI.CreateMenu("Garage", "Split Sides")
  GSplit:SetRectangleBanner(5, 0, 0)
    RageUI.Visible(GSplit, not RageUI.Visible(GSplit))
        while GSplit do
            Wait(0)
                RageUI.IsVisible(GSplit, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GSplitvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarSplit(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GSplit) then
            GSplit = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'split' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Split.pos.garage.position.x, Split.pos.garage.position.y, Split.pos.garage.position.z)
            if dist3 <= 10.0 and Split.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Split.pos.garage.position.x, Split.pos.garage.position.y, Split.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 1, 140, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageSplit()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarSplit(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Split.pos.spawnvoiture.position.x, Split.pos.spawnvoiture.position.y, Split.pos.spawnvoiture.position.z, Split.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Split"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end



itemstock = {}
function SplitRetirerobjet()
    local Stocksplit = RageUI.CreateMenu("Coffre", "Split Sides")
    Stocksplit:SetRectangleBanner(5, 0, 0)
    ESX.TriggerServerCallback('fsplit:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stocksplit, not RageUI.Visible(Stocksplit))
        while Stocksplit do
            Wait(0)
                RageUI.IsVisible(Stocksplit, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fsplit:getStockItem', v.name, tonumber(count))
                                    SplitRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stocksplit) then
            Stocksplit = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function SplitDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Split Sides")
    StockPlayer:SetRectangleBanner(5, 0, 0)
    ESX.TriggerServerCallback('fsplit:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('fsplit:putStockItems', item.name, tonumber(count))
                                            SplitDeposerobjet()
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
