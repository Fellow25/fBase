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
    if Tequila.jeveuxblips then
    local tequilamap = AddBlipForCoord(Tequila.pos.blips.position.x, Tequila.pos.blips.position.y, Tequila.pos.blips.position.z)
    SetBlipSprite(tequilamap, 93)
    SetBlipColour(tequilamap, 24)
    SetBlipScale(tequilamap, 0.65)
    SetBlipAsShortRange(tequilamap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Tequila")
    EndTextCommandSetBlipName(tequilamap)
    end
end)

function Menuf6Tequila()
    local fTequilaf6 = RageUI.CreateMenu("Tequila", "Interactions")
    fTequilaf6:SetRectangleBanner(173, 248, 2)
    RageUI.Visible(fTequilaf6, not RageUI.Visible(fTequilaf6))
    while fTequilaf6 do
        Wait(0)
            RageUI.IsVisible(fTequilaf6, true, true, true, function()

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_tequila', ('Tequila'), montant)
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
                        TriggerServerEvent('fTequila:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fTequila:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('fTequila:Perso', msg)
                    end
                end)
                end, function() 
                end)
    
                if not RageUI.Visible(fTequilaf6) then
                    fTequilaf6 = RMenu:DeleteType("Tequila", true)
        end
    end
end

Keys.Register('F6', 'Tequila', 'Ouvrir le menu Tequila', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tequila' then
    	Menuf6Tequila()
	end
end)

function OpenPrendreMenuTequila()
    local PrendreMenu = RageUI.CreateMenu("Tequila", "Nos produits")
    PrendreMenu:SetRectangleBanner(173, 248, 2)
        RageUI.Visible(PrendreMenu, not RageUI.Visible(PrendreMenu))
    while PrendreMenu do
        Wait(0)
            RageUI.IsVisible(PrendreMenu, true, true, true, function()
            for k,v in pairs(Tequila.Bar.item) do
            RageUI.ButtonWithStyle(v.Label.. ' Prix: ' .. v.Price .. '€', nil, { }, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fTequila:bar', v.Name, v.Price)
                end
            end)
        end
                end, function() 
                end)
    
                if not RageUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Tequila", true)
        end
    end
end


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tequila' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Tequila.pos.MenuPrendre.position.x, Tequila.pos.MenuPrendre.position.y, Tequila.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and Tequila.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Tequila.pos.MenuPrendre.position.x, Tequila.pos.MenuPrendre.position.y, Tequila.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 173, 248, 2, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder au bar", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenPrendreMenuTequila()
                    end   
                end
            end 
        Wait(Timer)
    end
end)



function Coffretequila()
    local Ctequila = RageUI.CreateMenu("Coffre", "Tequila")
    Ctequila:SetRectangleBanner(173, 248, 2)
        RageUI.Visible(Ctequila, not RageUI.Visible(Ctequila))
            while Ctequila do
            Wait(0)
            RageUI.IsVisible(Ctequila, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TequilaRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TequilaDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Ctequila) then
            Ctequila = RMenu:DeleteType("Ctequila", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tequila' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Tequila.pos.coffre.position.x, Tequila.pos.coffre.position.y, Tequila.pos.coffre.position.z)
            if jobdist <= 10.0 and Tequila.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Tequila.pos.coffre.position.x, Tequila.pos.coffre.position.y, Tequila.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 173, 248, 2, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffretequila()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function GarageTequila()
  local GTequila = RageUI.CreateMenu("Garage", "Tequila")
  GTequila:SetRectangleBanner(173, 248, 2)
    RageUI.Visible(GTequila, not RageUI.Visible(GTequila))
        while GTequila do
            Wait(0)
                RageUI.IsVisible(GTequila, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GTequilavoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarTequila(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GTequila) then
            GTequila = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tequila' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Tequila.pos.garage.position.x, Tequila.pos.garage.position.y, Tequila.pos.garage.position.z)
            if dist3 <= 10.0 and Tequila.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Tequila.pos.garage.position.x, Tequila.pos.garage.position.y, Tequila.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 173, 248, 2, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageTequila()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarTequila(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Tequila.pos.spawnvoiture.position.x, Tequila.pos.spawnvoiture.position.y, Tequila.pos.spawnvoiture.position.z, Tequila.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Tequila"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end



itemstock = {}
function TequilaRetirerobjet()
    local Stocktequila = RageUI.CreateMenu("Coffre", "Tequila")
    Stocktequila:SetRectangleBanner(173, 248, 2)
    ESX.TriggerServerCallback('ftequila:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stocktequila, not RageUI.Visible(Stocktequila))
        while Stocktequila do
            Wait(0)
                RageUI.IsVisible(Stocktequila, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('ftequila:getStockItem', v.name, tonumber(count))
                                    TequilaRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stocktequila) then
            Stocktequila = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function TequilaDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Tequila")
    StockPlayer:SetRectangleBanner(173, 248, 2)
    ESX.TriggerServerCallback('ftequila:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('ftequila:putStockItems', item.name, tonumber(count))
                                            TequilaDeposerobjet()
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
