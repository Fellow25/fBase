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
    if tabac.jeveuxblips then
    local tabacmap = AddBlipForCoord(tabac.pos.blips.position.x, tabac.pos.blips.position.y, tabac.pos.blips.position.z)

    SetBlipSprite(tabacmap, 140)
    SetBlipColour(tabacmap, 52)
    SetBlipScale(tabacmap, 0.65)
    SetBlipAsShortRange(tabacmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Tabac")
    EndTextCommandSetBlipName(tabacmap)
end
end)


function Menuf6tabac()
    local fTabacf6 = RageUI.CreateMenu("Tabac", "Interactions")
    RageUI.Visible(fTabacf6, not RageUI.Visible(fTabacf6))
    while fTabacf6 do
        Wait(0)
            RageUI.IsVisible(fTabacf6, true, true, true, function()

                RageUI.ButtonWithStyle("Passer une facture",nil, {RightLabel = "→"}, true, function(_,_,s)
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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_tabac', ('Tabac'), montant)
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
                        TriggerServerEvent('AnnonceTabacOuvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('AnnonceTabacFermer')
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
                RageUI.ButtonWithStyle("Récolte tabac",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(tabac.pos.recolte.position.x, tabac.pos.recolte.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Traitement tabac",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(tabac.pos.traitement.position.x, tabac.pos.traitement.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Transformation tabac sec",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(tabac.pos.transformation.position.x, tabac.pos.transformation.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Vente malboro",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(tabac.pos.vente.position.x, tabac.pos.vente.position.y)
                    end
                end)
            end
            end, function() 
            end)

                
    
                if not RageUI.Visible(fTabacf6) then
                    fTabacf6 = RMenu:DeleteType("fTabacf6", true)
        end
    end
end


Keys.Register('F6', 'Tabac', 'Ouvrir le menu Tabac', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then
    	Menuf6tabac()
	end
end)




function Coffretabac()
    local Ctabac = RageUI.CreateMenu("Coffre", "Tabac")
        RageUI.Visible(Ctabac, not RageUI.Visible(Ctabac))
            while Ctabac do
            Wait(0)
            RageUI.IsVisible(Ctabac, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TabacRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TabacDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Tabac",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuetabac()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_tabac()
                            RageUI.CloseAll()
                        end
                    end)

                end, function()
                end)
            if not RageUI.Visible(Ctabac) then
            Ctabac = RMenu:DeleteType("Ctabac", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, tabac.pos.coffre.position.x, tabac.pos.coffre.position.y, tabac.pos.coffre.position.z)
            if jobdist <= 10.0 and tabac.jeveuxmarker then
                Timer = 0
                DrawMarker(20, tabac.pos.coffre.position.x, tabac.pos.coffre.position.y, tabac.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 75, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffretabac()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


function Garagetabac()
    local Gtabac = RageUI.CreateMenu("Garage", "Tabac")
      RageUI.Visible(Gtabac, not RageUI.Visible(Gtabac))
          while Gtabac do
              Wait(0)
                  RageUI.IsVisible(Gtabac, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              RageUI.CloseAll()
                              end 
                          end
                      end) 
  
                      for k,v in pairs(Gtabacvoiture) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Wait(1)  
                              spawnuniCartabac(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Gtabac) then
              Gtabac = RMenu:DeleteType("Garage", true)
          end
      end
  end
  
  CreateThread(function()
          while true do
              local Timer = 500
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then
              local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
              local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, tabac.pos.garage.position.x, tabac.pos.garage.position.y, tabac.pos.garage.position.z)
              if dist3 <= 10.0 and tabac.jeveuxmarker then
                  Timer = 0
                  DrawMarker(20, tabac.pos.garage.position.x, tabac.pos.garage.position.y, tabac.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 75, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                  end
                  if dist3 <= 3.0 then
                  Timer = 0   
                      RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                      if IsControlJustPressed(1,51) then           
                          Garagetabac()
                      end   
                  end
              end 
          Wait(Timer)
       end
  end)
  
  function spawnuniCartabac(car)
      local car = GetHashKey(car)
  
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Wait(0)
      end
  
      local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
      local vehicle = CreateVehicle(car, tabac.pos.spawnvoiture.position.x, tabac.pos.spawnvoiture.position.y, tabac.pos.spawnvoiture.position.z, tabac.pos.spawnvoiture.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "tabac"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
  end



function tenuetabac()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = tabac.Uniforms.male
        else
            uniformObject = tabac.Uniforms.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end


function vcivil_tabac()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end

itemstock = {}
function TabacRetirerobjet()
    local Stocktabac = RageUI.CreateMenu("Coffre", "Tabac")
    ESX.TriggerServerCallback('ftabac:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stocktabac, not RageUI.Visible(Stocktabac))
        while Stocktabac do
            Wait(0)
                RageUI.IsVisible(Stocktabac, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('ftabac:getStockItem', v.name, tonumber(count))
                                    TabacRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stocktabac) then
            Stocktabac = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function TabacDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Tabac")
    ESX.TriggerServerCallback('ftabac:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('ftabac:putStockItems', item.name, tonumber(count))
                                            TabacDeposerobjet()
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

RegisterNetEvent('f:startSmoke')
AddEventHandler('f:startSmoke', function(source)
	SmokeAnimation()
end)

function SmokeAnimation()
	local playerPed = PlayerPedId()
	
	CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)               
	end)
end
