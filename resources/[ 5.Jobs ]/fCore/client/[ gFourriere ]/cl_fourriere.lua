ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyfourrieremoney = nil

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

gFourriere = {
    listefourriere = {}
}

CreateThread(function()
    local blip = AddBlipForCoord(configFourriere.fourriere.position.x, configFourriere.fourriere.position.y, configFourriere.fourriere.position.z)
    SetBlipSprite(blip, 67)
    SetBlipColour(blip, 64)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.65)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Fourrière")
    EndTextCommandSetBlipName(blip)
end)


function Menuf6fourriere()
    local fourrieref6 = RageUI.CreateMenu("Fourrière", "Interactions")
    RageUI.Visible(fourrieref6, not RageUI.Visible(fourrieref6))
    while fourrieref6 do
        Wait(0)
            RageUI.IsVisible(fourrieref6, true, true, true, function()

                RageUI.Separator("~o~"..ESX.PlayerData.job.grade_label.." - "..GetPlayerName(PlayerId()))

                RageUI.Separator("↓ Facture ↓")

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_fourriere', ('Fourrière'), montant)
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
                        TriggerServerEvent('gfourriere:ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('gfourriere:ferme')
                    end
                end)

                RageUI.Separator("↓ Autres ↓")

                RageUI.ButtonWithStyle("Repport",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        ESX.TriggerServerCallback('gfourriere:affichereport', function(keys)
                            reportlistesql = keys
                      end)
                      Repportmenu()
                    end
                end)

                end, function() 
                end)
    
                if not RageUI.Visible(fourrieref6) then
                    fourrieref6 = RMenu:DeleteType("fourrieref6", true)
        end
    end
end

Keys.Register('F6', 'Fourrière', 'Ouvrir le menu Fourrière', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fourriere' then
    	Menuf6fourriere()
	end
end)

reportlistesql = {}

function Repportmenu()
    local reportmenu = RageUI.CreateMenu("Repport Menu", "Fourrière")
    local reportmenu2 = RageUI.CreateSubMenu(reportmenu, "Repport Menu", "Fourrière")
    
        RageUI.Visible(reportmenu, not RageUI.Visible(reportmenu))
            while reportmenu do
            Wait(0)
            RageUI.IsVisible(reportmenu, true, true, true, function()
            for numreport = 1, #reportlistesql, 1 do
                RageUI.ButtonWithStyle(reportlistesql[numreport].plaque.. " - "..reportlistesql[numreport].date,nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        agent = reportlistesql[numreport].agent
                        plaque = reportlistesql[numreport].plaque
                        date = reportlistesql[numreport].date
                        numeroreport = reportlistesql[numreport].numeroreport
                        motif = reportlistesql[numreport].motif
                        vehicle = reportlistesql[numreport].vehicle
                        supprimer = reportlistesql[numreport].id
                    end
                end, reportmenu2)
            end
        end, function()
        end)
            RageUI.IsVisible(reportmenu2, true, true, true, function()
                RageUI.ButtonWithStyle("Numéro Repport : ",nil, {RightLabel = numeroreport}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end)
                RageUI.ButtonWithStyle("Motif : ",nil, {RightLabel = motif}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end)
                RageUI.ButtonWithStyle("Date : ",nil, {RightLabel = date}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end)
                RageUI.ButtonWithStyle("Plaque : ",nil, {RightLabel = plaque}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end)
                RageUI.ButtonWithStyle("Véhicule : ",nil, {RightLabel = vehicle}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end)
                RageUI.ButtonWithStyle("Agent : ",nil, {RightLabel = agent}, true, function(Hovered, Active, Selected)
                    if Selected then
                    end
                end)
                RageUI.ButtonWithStyle("~r~Supprimer le report~s~", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('gfourriere:supprimereport', supprimer)
                        Menuf6fourriere()
                    end
                end)
            end, function()
            end)
            if not RageUI.Visible(reportmenu) and not RageUI.Visible(reportmenu2) then
                reportmenu = RMenu:DeleteType("Repport Menu", true)
        end
    end
end

function reportfourriere(veh, motif)
    local plaqueveh = GetVehicleNumberPlateText(veh)
    local numeroreport = "P78FH"..math.random(1,999)
    local vehicleModel = GetEntityModel(veh)
    local nomvoituremodelee = GetDisplayNameFromVehicleModel(vehicleModel)
    local nomvoituretexte  = GetLabelText(nomvoituremodelee)
TriggerServerEvent('gfourriere:ajoutreport',motif,GetPlayerName(PlayerId()),plaqueveh,numeroreport,nomvoituretexte)
end

function Garagefourriere()
    local Gfourriere = RageUI.CreateMenu("Garage", "Fourrière")
      RageUI.Visible(Gfourriere, not RageUI.Visible(Gfourriere))
          while Gfourriere do
              Wait(0)
                  RageUI.IsVisible(Gfourriere, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              end 
                          end
                      end) 
  
                      for k,v in pairs(configFourrierevoiture) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Wait(1)  
                              spawnuniCar(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Gfourriere) then
              Gfourriere = RMenu:DeleteType("Garage", true)
          end
      end
  end


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fourriere' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, configFourriere.pos.garage.position.x, configFourriere.pos.garage.position.y, configFourriere.pos.garage.position.z)
        if dist3 <= 10.0 and configFourriere.jeveuxmarker then
            Timer = 0
            DrawMarker(20, configFourriere.pos.garage.position.x, configFourriere.pos.garage.position.y, configFourriere.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
            Timer = 0   
                RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder au garage", time_display = 1 })
                if IsControlJustPressed(1,51) then           
                    Garagefourriere()
                end   
            end
        end 
    Wait(Timer)
 end
end)

function spawnuniCar(car)
local car = GetHashKey(car)

RequestModel(car)
while not HasModelLoaded(car) do
    RequestModel(car)
    Wait(0)
end

local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
local vehicle = CreateVehicle(car, configFourriere.pos.spawnvoiture.position.x, configFourriere.pos.spawnvoiture.position.y, configFourriere.pos.spawnvoiture.position.z, configFourriere.pos.spawnvoiture.position.h, true, false)
SetEntityAsMissionEntity(vehicle, true, true)
local plaque = "fourriere"..math.random(1,9)
SetVehicleNumberPlateText(vehicle, plaque)
SetVehRadioStation(vehicle, "OFF")
SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

function OpenfourriereMenu()
  local fourriere = RageUI.CreateMenu("Fourrière", "Voici les véhicules en fourrière")
  RageUI.Visible(fourriere, not RageUI.Visible(fourriere))
  while fourriere do
      Wait(0)
      RageUI.IsVisible(fourriere, true, true, true, function()
        for i = 1, #gFourriere.listefourriere, 1 do
            local hashvoiture = gFourriere.listefourriere[i].vehicle.model
        	local modelevoiturespawn = gFourriere.listefourriere[i].vehicle
        	local nomvoituremodele = GetDisplayNameFromVehicleModel(hashvoiture)
        	local nomvoituretexte  = GetLabelText(nomvoituremodele)
        	local plaque = gFourriere.listefourriere[i].plate
            local Nomdumec = gFourriere.listefourriere[i].Nomdumec
            RageUI.ButtonWithStyle("Propriétaire : "..Nomdumec.." - "..nomvoituretexte.." | "..plaque, nil, {RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    sortirvoiture(modelevoiturespawn, plaque)
                    RageUI.CloseAll()
                end
            end)
        end
    end)

      if not RageUI.Visible(fourriere) then
          fourriere = RMenu:DeleteType("Fourrière", true)
        end
    end
end
    
CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fourriere' then
        local plycrdjob = GetEntityCoords(PlayerPedId(), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, configFourriere.fourriere.position.x, configFourriere.fourriere.position.y, configFourriere.fourriere.position.z)
        if jobdist <= 10.0 and configFourriere.jeveuxmarker then
            Timer = 0
            DrawMarker(20, configFourriere.fourriere.position.x, configFourriere.fourriere.position.y, configFourriere.fourriere.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if jobdist <= 1.0 then
                Timer = 0
                    RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour ouvrir la fourrière", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        ESX.TriggerServerCallback('gfourriere:listevehiculefourriere', function(result)
                            gFourriere.listefourriere = result
                        end)
                    OpenfourriereMenu()   
            end
        end 
    end
    Wait(Timer)   
end
end)

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fourriere' then
        local plycrdjob = GetEntityCoords(PlayerPedId(), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, configFourriere.mettrefourriere.position.x, configFourriere.mettrefourriere.position.y, configFourriere.mettrefourriere.position.z)
            if jobdist <= 2.0 then
                Timer = 0
                    RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour Mettre véhicule en fourriere", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                    local playerPed = PlayerPedId()

                    if IsPedSittingInAnyVehicle(playerPed) then
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
                        if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                            local motif = KeyboardInput("Motif", "", 25)
                            reportfourriere(vehicle, motif)
                            ESX.Game.DeleteVehicle(vehicle)
                            ESX.ShowNotification('La voiture à été placer en fourriere.')

                           
                        else
                            ESX.ShowNotification('Mais toi place conducteur, ou sortez de la voiture.')
                        end
                    else
                        local vehicle = ESX.Game.GetVehicleInDirection()
        
                        if DoesEntityExist(vehicle) then
                            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                            local motif = KeyboardInput("Motif", "", 25)
                            reportfourriere(vehicle, motif)
                            Wait(5000)
                            ClearPedTasks(playerPed)
                            ESX.Game.DeleteVehicle(vehicle)
                            ESX.ShowNotification('La voiture à été placer en fourriere.')
        
                        else
                            ESX.ShowNotification('Aucune voitures autour')
                        end
                    end   
            end
        end 
    end
    Wait(Timer)   
end
end)

CreateThread(function()
    local hash = GetHashKey("s_m_y_garbage")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_garbage", 398.54, -1629.47, 28.30, 236.524, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)


function sortirvoiture(vehicle, plate)
	x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = x,
		y = y,
		z = z 
	}, GetEntityHeading(PlayerPedId()), function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
	end)
end


function Coffrefourriere()
    local Cfourriere = RageUI.CreateMenu("Coffre", "Fourrière")
        RageUI.Visible(Cfourriere, not RageUI.Visible(Cfourriere))
            while Cfourriere do
            Wait(0)
            RageUI.IsVisible(Cfourriere, true, true, true, function()

                RageUI.Separator("↓ Objet ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FourriereRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FourriereDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Tenue de ~g~service",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenueservice()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_fourriere()
                            RageUI.CloseAll()
                        end
                    end)

                    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fourriere' and ESX.PlayerData.job.grade_name == 'boss' then

                    RageUI.Separator("↓ Actions Patron ↓")

                    if societyfourrieremoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyfourrieremoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'fourriere', amount)
                                RefreshfourriereMoney()
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'fourriere', amount)
                                RefreshfourriereMoney()
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            aboss()
                            RageUI.CloseAll()
                        end
                    end)
                end

                end, function()
                end)
            if not RageUI.Visible(Cfourriere) then
            Cfourriere = RMenu:DeleteType("Coffre", true)
        end
    end
end

function tenueservice()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = configFourriere.tenue.male
        else
            uniformObject = configFourriere.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_fourriere()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

itemstock = {}
function FourriereRetirerobjet()
    local Stockfourriere = RageUI.CreateMenu("Coffre", "Fourrière")
    ESX.TriggerServerCallback('gfourriere:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockfourriere, not RageUI.Visible(Stockfourriere))
        while Stockfourriere do
            Wait(0)
                RageUI.IsVisible(Stockfourriere, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('gfourriere:getStockItem', v.name, tonumber(count))
                                    FourriereRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockfourriere) then
            Stockfourriere = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function FourriereDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Fourrière")
    ESX.TriggerServerCallback('gfourriere:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('gfourriere:putStockItems', item.name, tonumber(count))
                                            FourriereDeposerobjet()
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


function RefreshfourriereMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyfourriereMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyfourriereMoney(money)
    societyfourrieremoney = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'fourriere', function(data, menu)
        menu.close()
    end, {wash = false})
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fourriere' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, configFourriere.pos.coffre.position.x, configFourriere.pos.coffre.position.y, configFourriere.pos.coffre.position.z)
            if jobdist <= 10.0 and configFourriere.jeveuxmarker then
                Timer = 0
                DrawMarker(20, configFourriere.pos.coffre.position.x, configFourriere.pos.coffre.position.y, configFourriere.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour le menu gestion", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrefourriere()
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