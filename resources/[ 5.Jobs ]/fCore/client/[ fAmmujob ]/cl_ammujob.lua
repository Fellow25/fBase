ESX = nil

	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	
	local PlayerData = {}
	
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
		 PlayerData = xPlayer
	end)
	
	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)  
		PlayerData.job = job  
		Wait(5000) 
	end)
	
	CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Wait(10)
		end
		while ESX.GetPlayerData().job == nil do
			Wait(10)
		end
		if ESX.IsPlayerLoaded() then
	
			ESX.PlayerData = ESX.GetPlayerData()
	
		end
	end)
	
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function(xPlayer)
		ESX.PlayerData = xPlayer
	end)
	
	
	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
		ESX.PlayerData.job = job
	end)
	
	RegisterNetEvent('esx:setJob2')
	AddEventHandler('esx:setJob2', function(job2)
		ESX.PlayerData.job2 = job2
	end)

CreateThread(function()
    local ammumap = AddBlipForCoord(Ammujob.pos.blips.position.x, Ammujob.pos.blips.position.y, Ammujob.pos.blips.position.z)
    SetBlipSprite(ammumap, 313)
    SetBlipColour(ammumap, 1)
    SetBlipScale(ammumap, 0.65)
    SetBlipAsShortRange(ammumap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Ammu-Nation")
    EndTextCommandSetBlipName(ammumap)
end)

function Menuf6Ammu()
    local fAmmuf5 = RageUI.CreateMenu("Ammu-Nation", "Interactions")
    RageUI.Visible(fAmmuf5, not RageUI.Visible(fAmmuf5))
    while fAmmuf5 do
        Wait(0)
            RageUI.IsVisible(fAmmuf5, true, true, true, function()

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
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
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_ammu', ('Ammu-Nation'), montant)
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


                RageUI.Separator("")

                RageUI.Checkbox("Passer une annonce",nil, annonce,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        annonce = Checked;
    
                        if Checked then
                            annonce = true
                        else
                            annonce = false
                        end
                    end
                end)

                if annonce then
                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('fAmmu:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fAmmu:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Recrutement",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                      TriggerServerEvent('fAmmu:Recrute')
                    end
                  end)
                end 
                RageUI.Separator("")

                RageUI.Checkbox("Activer le gps",nil, gps,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
                            gps = Checked;
        
                            if Checked then
                                gps = true
                            else
                                gps = false
                            end
                        end
                    end)

                    if gps then

                RageUI.ButtonWithStyle("Récolte métaux",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(Ammujob.farm.metaux.position.x, Ammujob.farm.metaux.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Récolte mèche",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(Ammujob.farm.meche.position.x, Ammujob.farm.meche.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Récolte canon",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(Ammujob.farm.canon.position.x, Ammujob.farm.canon.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Récolte levier",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(Ammujob.farm.levier.position.x, Ammujob.farm.levier.position.y)
                    end
                end)
            end
            end, function() 
            end)
    
                if not RageUI.Visible(fAmmuf5) then
                    fAmmuf5 = RMenu:DeleteType("Ammu-Nation", true)
        end
    end
end


Keys.Register('F6', 'Ammu-Nation', 'Ouvrir le menu Ammu-Nation', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
    	Menuf6Ammu()
	end
end)

function Coffreammu()
    local Cammu = RageUI.CreateMenu("Coffre", "Ammu-Nation")
        RageUI.Visible(Cammu, not RageUI.Visible(Cammu))
            while Cammu do
            Wait(0)
            RageUI.IsVisible(Cammu, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ARetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ADeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cammu) then
            Cammu = RMenu:DeleteType("Cammu", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Ammujob.pos.coffre.position.x, Ammujob.pos.coffre.position.y, Ammujob.pos.coffre.position.z)
            if jobdist <= 10.0 and Ammujob.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Ammujob.pos.coffre.position.x, Ammujob.pos.coffre.position.y, Ammujob.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffreammu()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function GarageAmmu()
  local GAmmu = RageUI.CreateMenu("Garage", "Ammu-Nation")
    RageUI.Visible(GAmmu, not RageUI.Visible(GAmmu))
        while GAmmu do
            Wait(0)
                RageUI.IsVisible(GAmmu, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GAmmuvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarAmmu(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GAmmu) then
            GAmmu = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ammujob.pos.garage.position.x, Ammujob.pos.garage.position.y, Ammujob.pos.garage.position.z)
            if dist3 <= 10.0 and Ammujob.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Ammujob.pos.garage.position.x, Ammujob.pos.garage.position.y, Ammujob.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageAmmu()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarAmmu(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Ammujob.pos.garage.position.x, Ammujob.pos.garage.position.y, Ammujob.pos.garage.position.z, Ammujob.pos.garage.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Ammu-Nation"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end



itemstock = {}
function ARetirerobjet()
    local Stockammu = RageUI.CreateMenu("Coffre", "Ammu-Nation")
    ESX.TriggerServerCallback('fammu:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockammu, not RageUI.Visible(Stockammu))
        while Stockammu do
            Wait(0)
                RageUI.IsVisible(Stockammu, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fammu:getStockItem', v.name, tonumber(count))
                                    ARetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockammu) then
            Stockammu = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function ADeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Ammu-Nation")
    ESX.TriggerServerCallback('fammu:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('fammu:putStockItems', item.name, tonumber(count))
                                            ADeposerobjet()
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

function TheorieAmmu()
    local TAmmu = RageUI.CreateMenu("Craft Théorie", "Ammu-Nation")
      RageUI.Visible(TAmmu, not RageUI.Visible(TAmmu))
          while TAmmu do
              Wait(0)
                  RageUI.IsVisible(TAmmu, true, true, true, function()
                    for k,v in pairs(Ammujob.craft) do
                        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "?"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                            RageUI.Popup({message = "Pour craft le/la "..v.name.." vous avez besoin de :"})
                            if v.metaux ~= nil then
                            RageUI.Popup({message = "x"..v.metaux.. " Métaux"})
                            end
                            if v.canon ~= nil then
                            RageUI.Popup({message = "x"..v.canon.. " Canon"})
                            end
                            if v.meche ~= nil then
                            RageUI.Popup({message = "x"..v.meche.. " Mèche"})
                            end
                            if v.levier ~= nil then
                            RageUI.Popup({message = "x"..v.levier.. " Levier"})
                            end
                            end
                        end)
                    end
                end, function()
                end)
              if not RageUI.Visible(TAmmu) then
              TAmmu = RMenu:DeleteType("Craft Théorie", true)
          end
      end
  end

CreateThread(function()
while true do
    local Timer = 500
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
    local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
    local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ammujob.pos.theorie.position.x, Ammujob.pos.theorie.position.y, Ammujob.pos.theorie.position.z)
    if dist3 <= 10.0 and Ammujob.jeveuxmarker then
        Timer = 0
        DrawMarker(20, Ammujob.pos.theorie.position.x, Ammujob.pos.theorie.position.y, Ammujob.pos.theorie.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 3.0 then
        Timer = 0   
            RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour interagir avec la table", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                TheorieAmmu()
            end   
        end
    end 
Wait(Timer)
end
end)

function MenuCraftAmmu()
    local CraftAmmu = RageUI.CreateMenu("Craft Théorie", "Ammu-Nation")
    local CraftAmmusub = RageUI.CreateSubMenu(CraftAmmu, "Craft Théorie", "Ammu-Nation")
    ESX.TriggerServerCallback('fammu:getPlayerInventory', function(inventory)
    choixnbmet = 0
    choixnbmeche = 0
    choixnbcan = 0
    choixnblev = 0
      RageUI.Visible(CraftAmmu, not RageUI.Visible(CraftAmmu))
          while CraftAmmu do
              Wait(0)
                  RageUI.IsVisible(CraftAmmu, true, true, true, function()
                    for v = 1, #inventory.items, 1 do
                        if inventory.items[v].name == "metaux" or inventory.items[v].name == "canon" or inventory.items[v].name == "meche" or inventory.items[v].name == "levier" then
                            RageUI.ButtonWithStyle(inventory.items[v].label.." ["..inventory.items[v].count.."]", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    if inventory.items[v].name == "metaux" then
                                        nbmetaux = KeyboardInput('Veuillez choisir le nombre de métaux pour le craft', '', 3)
                                        if tonumber(nbmetaux) then
                                            if inventory.items[v].count >= tonumber(nbmetaux) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbmet = nbmetaux
                                            else
                                            RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbmet = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbmetaux = 0
                                        end
                                    end
                                    if inventory.items[v].name == "meche" then
                                        nbmeche = KeyboardInput('Veuillez choisir le nombre de mèche pour le craft', '', 3)
                                        if tonumber(nbmeche) then
                                            if inventory.items[v].count >= tonumber(nbmeche) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbmeche = nbmeche
                                            else
                                                RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbmeche = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbmeche = 0
                                        end
                                    end
                                    if inventory.items[v].name == "canon" then
                                        nbcanon = KeyboardInput('Veuillez choisir le nombre de canon pour le craft', '', 3)
                                        if tonumber(nbcanon) then
                                            if inventory.items[v].count >= tonumber(nbcanon) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbcan = nbcanon
                                            else
                                        RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbcan = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbcanon = 0
                                        end
                                    end
                                    if inventory.items[v].name == "levier" then
                                        nblevier = KeyboardInput('Veuillez choisir le nombre de levier pour le craft', '', 3)
                                        if tonumber(nblevier) then
                                            if inventory.items[v].count >= tonumber(nblevier) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnblev = nblevier
                                            else
                                        RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnblev = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nblevier = 0
                                        end
                                    end
                                end
                            end)
                        end
                    end
                    RageUI.ButtonWithStyle("Passer au craft", nil, {RightLabel = "→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}},true, function()
                    end, CraftAmmusub)
                        end, function()
                        end)
                        RageUI.IsVisible(CraftAmmusub, true, true, true, function()
                        RageUI.Separator('~b~Résumé :')
                        RageUI.Separator('x'..choixnbmet.." Métaux")
                        RageUI.Separator('x'..choixnblev.." Levier")
                        RageUI.Separator('x'..choixnbmeche.." Mèche")
                        RageUI.Separator('x'..choixnbcan.." Canon")
                        RageUI.ButtonWithStyle("Valider le craft", nil, {RightLabel = "→→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            if tonumber(choixnbmet) == Ammujob.craft[1].metaux and tonumber(choixnbmeche) == Ammujob.craft[1].meche and tonumber(choixnbcan) == Ammujob.craft[1].canon and tonumber(choixnblev) == Ammujob.craft[1].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[1].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[2].metaux and tonumber(choixnbmeche) == Ammujob.craft[2].meche and tonumber(choixnbcan) == Ammujob.craft[2].canon and tonumber(choixnblev) == Ammujob.craft[2].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[2].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[3].metaux and tonumber(choixnbmeche) == Ammujob.craft[3].meche and tonumber(choixnbcan) == Ammujob.craft[3].canon and tonumber(choixnblev) == Ammujob.craft[3].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[3].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[4].metaux and tonumber(choixnbmeche) == Ammujob.craft[4].meche and tonumber(choixnbcan) == Ammujob.craft[4].canon and tonumber(choixnblev) == Ammujob.craft[4].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[4].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[5].metaux and tonumber(choixnbmeche) == Ammujob.craft[5].meche and tonumber(choixnbcan) == Ammujob.craft[5].canon and tonumber(choixnblev) == Ammujob.craft[5].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[5].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[6].metaux and tonumber(choixnbmeche) == Ammujob.craft[6].meche and tonumber(choixnbcan) == Ammujob.craft[6].canon and tonumber(choixnblev) == Ammujob.craft[6].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[6].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[7].metaux and tonumber(choixnbmeche) == Ammujob.craft[7].meche and tonumber(choixnbcan) == Ammujob.craft[7].canon and tonumber(choixnblev) == Ammujob.craft[7].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[7].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[8].metaux and tonumber(choixnbmeche) == Ammujob.craft[8].meche and tonumber(choixnbcan) == Ammujob.craft[8].canon and tonumber(choixnblev) == Ammujob.craft[8].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[8].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[9].metaux and tonumber(choixnbmeche) == Ammujob.craft[9].meche and tonumber(choixnbcan) == Ammujob.craft[9].canon and tonumber(choixnblev) == Ammujob.craft[9].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[9].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[10].metaux and tonumber(choixnbmeche) == Ammujob.craft[10].meche and tonumber(choixnbcan) == Ammujob.craft[10].canon and tonumber(choixnblev) == Ammujob.craft[10].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[10].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[11].metaux and tonumber(choixnbmeche) == Ammujob.craft[11].meche and tonumber(choixnbcan) == Ammujob.craft[11].canon and tonumber(choixnblev) == Ammujob.craft[11].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[11].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[12].metaux and tonumber(choixnbmeche) == Ammujob.craft[12].meche and tonumber(choixnbcan) == Ammujob.craft[12].canon and tonumber(choixnblev) == Ammujob.craft[12].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[12].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            elseif tonumber(choixnbmet) == Ammujob.craft[13].metaux and tonumber(choixnbmeche) == Ammujob.craft[13].meche and tonumber(choixnbcan) == Ammujob.craft[13].canon and tonumber(choixnblev) == Ammujob.craft[13].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[13].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
			    elseif tonumber(choixnbmet) == Ammujob.craft[14].metaux and tonumber(choixnbmeche) == Ammujob.craft[14].meche and tonumber(choixnbcan) == Ammujob.craft[14].canon and tonumber(choixnblev) == Ammujob.craft[14].levier then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Ammujob.craft[14].weapon
                                TriggerServerEvent('craft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            else
                                RageUI.Popup({message = "~r~Craft non réussi, vous avez perdu tout les matériaux utilisé!"})
                                TriggerServerEvent('h4ci_craft:nonvalider', tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbcan), tonumber(choixnblev))
                            end
                            RageUI.GoBack()
                            choixnbmet = 0
                            choixnbmeche = 0
                            choixnbcan = 0
                            choixnblev = 0
                            choixnbpou = 0
                        end
                        end)
                        RageUI.ButtonWithStyle("~r~Réinitialiser et retourner en arrière", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            choixnbmet = 0
                            choixnbmeche = 0
                            choixnbcan = 0
                            choixnblev = 0
                            choixnbpou = 0
                            RageUI.GoBack()
                        end
                        end)
                        end, function()
                        end)
              if not RageUI.Visible(CraftAmmu) and not RageUI.Visible(CraftAmmusub) then
              CraftAmmu = RMenu:DeleteType("Craft Théorie", true)
          end
      end
    end)
  end

CreateThread(function()
while true do
    local Timer = 500
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
    local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
    local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ammujob.pos.craftmenu.position.x, Ammujob.pos.craftmenu.position.y, Ammujob.pos.craftmenu.position.z)
    if dist3 <= 10.0 and Ammujob.jeveuxmarker then
        Timer = 0
        DrawMarker(20, Ammujob.pos.craftmenu.position.x, Ammujob.pos.craftmenu.position.y, Ammujob.pos.craftmenu.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 3.0 then
        Timer = 0   
            RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour craft", time_display = 1 })
            if IsControlJustPressed(1,51) then         
                MenuCraftAmmu()
            end   
        end
    end 
Wait(Timer)
end
end)

function AmmuRecolteMetaux()
    local ARM = RageUI.CreateMenu("Recolte métaux", "Ammu-Nation")
    
    RageUI.Visible(ARM, not RageUI.Visible(ARM))
    
    while ARM do
        Wait(0)
        RageUI.IsVisible(ARM, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de métaux", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltemetaux()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARM) then
            ARM = RMenu:DeleteType("ARM", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Ammujob.farm.metaux.position.x, Ammujob.farm.metaux.position.y, Ammujob.farm.metaux.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            AmmuRecolteMetaux()
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

function recoltemetaux()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('metaux')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ammujob.farm.metaux.position.x, Ammujob.farm.metaux.position.y, Ammujob.farm.metaux.position.z)
        if dist3 <= 10.0 and Ammujob.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Ammujob.farm.metaux.position.x, Ammujob.farm.metaux.position.y, Ammujob.farm.metaux.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour récolter des métaux", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            AmmuRecolteMetaux()
                    end   
                end
            end 
        Wait(Timer)
    end
end)
------------------------------------
function AmmuRecolteCanon()
    local ARC = RageUI.CreateMenu("Recolte canon", "Ammu-Nation")
    
    RageUI.Visible(ARC, not RageUI.Visible(ARC))
    
    while ARC do
        Wait(0)
        RageUI.IsVisible(ARC, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de canon", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltecanon()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARC) then
            ARC = RMenu:DeleteType("ARC", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Ammujob.farm.canon.position.x, Ammujob.farm.canon.position.y, Ammujob.farm.canon.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            AmmuRecolteCanon()
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

function recoltecanon()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('canon')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ammujob.farm.canon.position.x, Ammujob.farm.canon.position.y, Ammujob.farm.canon.position.z)
        if dist3 <= 10.0 and Ammujob.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Ammujob.farm.canon.position.x, Ammujob.farm.canon.position.y, Ammujob.farm.canon.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour récolter des canons", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            AmmuRecolteCanon()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

--------------------------------
function AmmuRecolteMeche()
    local ARM = RageUI.CreateMenu("Recolte mèche", "Ammu-Nation")
    
    RageUI.Visible(ARM, not RageUI.Visible(ARM))
    
    while ARM do
        Wait(0)
        RageUI.IsVisible(ARM, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de mèche", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltemeche()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARM) then
            ARM = RMenu:DeleteType("ARM", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Ammujob.farm.meche.position.x, Ammujob.farm.meche.position.y, Ammujob.farm.meche.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            AmmuRecolteMeche()
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

function recoltemeche()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('meche')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ammujob.farm.meche.position.x, Ammujob.farm.meche.position.y, Ammujob.farm.meche.position.z)
        if dist3 <= 10.0 and Ammujob.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Ammujob.farm.meche.position.x, Ammujob.farm.meche.position.y, Ammujob.farm.meche.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour récolter des mèches", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            AmmuRecolteMeche()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

--------------------------------
function AmmuRecolteLevier()
    local ARL = RageUI.CreateMenu("Recolte levier", "Ammu-Nation")
    
    RageUI.Visible(ARL, not RageUI.Visible(ARL))
    
    while ARL do
        Wait(0)
        RageUI.IsVisible(ARL, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de levier", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltelevier()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARL) then
            ARL = RMenu:DeleteType("ARL", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Ammujob.farm.levier.position.x, Ammujob.farm.levier.position.y, Ammujob.farm.levier.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            AmmuRecolteLevier()
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

function recoltelevier()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('levier')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ammujob.farm.levier.position.x, Ammujob.farm.levier.position.y, Ammujob.farm.levier.position.z)
        if dist3 <= 10.0 and Ammujob.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Ammujob.farm.levier.position.x, Ammujob.farm.levier.position.y, Ammujob.farm.levier.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour récolter des leviers", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            AmmuRecolteLevier()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

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