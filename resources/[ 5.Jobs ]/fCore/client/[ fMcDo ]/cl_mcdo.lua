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

function defESX()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end

CreateThread(function()
    defESX()
end)


local index = {
    items = 1
}

local percent = 100
local a = 255
local nombre = {}

local max = 10
Numbers = {}

CreateThread(function()
    for i = 1, max do
        table.insert(Numbers, i)
    end
end)

local lescommande = {}

local function getInfoReport()
    local info = {}
    ESX.TriggerServerCallback('fMcDo:infocommande', function(info)
        lescommande = info
    end)
end

CreateThread(function()
    if mcdonalds.jeveuxblips then
    local mcdonaldsmap = AddBlipForCoord(mcdonalds.pos.blips.position.x, mcdonalds.pos.blips.position.y, mcdonalds.pos.blips.position.z)

    SetBlipSprite(mcdonaldsmap, 78)
    SetBlipColour(mcdonaldsmap, 46)
    SetBlipScale(mcdonaldsmap, 0.65)
    SetBlipAsShortRange(mcdonaldsmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("McDonald's")
    EndTextCommandSetBlipName(mcdonaldsmap)
end
end)

function Frigomcdonalds()
    local frigomcdo = RageUI.CreateMenu("Frigo", "~y~McDonald's")
    frigomcdo:SetRectangleBanner(255, 0, 0)
  
    RageUI.Visible(frigomcdo, not RageUI.Visible(frigomcdo))
  
    while frigomcdo do
        Wait(0)
        RageUI.IsVisible(frigomcdo, true, true, true, function()
   
            for k,v in pairs(Frigo) do
                RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = (v.Price).."€"}, true, function(Hovered, Active, Selected)
                  if (Selected) then
                      TriggerServerEvent('mcdonalds:frigo', v.Name, v.Price)
                    end
                end)
            end
        end)


  
        if not RageUI.Visible(frigomcdo) then
            frigomcdo = RMenu:DeleteType("frigomcdo", true)
          end
      end
  end

  CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcdonalds' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, mcdonalds.pos.frigo.position.x, mcdonalds.pos.frigo.position.y, mcdonalds.pos.frigo.position.z)
        if dist3 <= 10.0 and mcdonalds.jeveuxmarker then
            Timer = 0
            DrawMarker(20, mcdonalds.pos.frigo.position.x, mcdonalds.pos.frigo.position.y, mcdonalds.pos.frigo.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
            Timer = 0   
                RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au frigo", time_display = 1 })
                if IsControlJustPressed(1,51) then           
                    Frigomcdonalds()
                end   
            end
        end 
    Wait(Timer)
 end
end)

function Cuisinemcdonalds()
    local cuisinemcdo = RageUI.CreateMenu("Cuisine", "~y~McDonald's")
    cuisinemcdo:SetRectangleBanner(255, 0, 0)
  
    RageUI.Visible(cuisinemcdo, not RageUI.Visible(cuisinemcdo))
  
    while cuisinemcdo do
        Wait(0)
        RageUI.IsVisible(cuisinemcdo, true, true, true, function()
   
            RageUI.ButtonWithStyle("Préparer un double cheese", "~r~Requis : ~w~Steak", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                    Wait(20000)
                    TriggerServerEvent('craft:cheese')
                    ClearPedTasksImmediately(playerPed)
                end
            end)
            
            RageUI.ButtonWithStyle("Préparer une boite de 20 Nuggets", "~r~Requis : ~w~Poulet cru", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                    Wait(20000)
                    TriggerServerEvent('craft:nuggets')
                    ClearPedTasksImmediately(playerPed)
                end
            end)

            RageUI.ButtonWithStyle("Préparer un petit wrap", "~r~Requis : ~w~Galette de pain", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                    Wait(20000)
                    TriggerServerEvent('craft:galette')
                    ClearPedTasksImmediately(playerPed)
                end
            end)

            RageUI.ButtonWithStyle("Préparer les potatoes", "~r~Requis : ~w~Potatoes surgeler", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                    Wait(20000)
                    TriggerServerEvent('craft:potatos')
                    ClearPedTasksImmediately(playerPed)
                end
            end)

            RageUI.ButtonWithStyle("Préparer les frites", "~r~Requis : ~w~Frites surgeler", {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                    Wait(20000)
                    TriggerServerEvent('craft:frites')
                    ClearPedTasksImmediately(playerPed)
                end
            end)

        end, function()
        end)
                
  
        if not RageUI.Visible(cuisinemcdo) then
            cuisinemcdo = RMenu:DeleteType("cuisinemcdo", true)
          end
      end
  end

  CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcdonalds' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, mcdonalds.pos.cuisine.position.x, mcdonalds.pos.cuisine.position.y, mcdonalds.pos.cuisine.position.z)
        if dist3 <= 10.0 and mcdonalds.jeveuxmarker then
            Timer = 0
            DrawMarker(20, mcdonalds.pos.cuisine.position.x, mcdonalds.pos.cuisine.position.y, mcdonalds.pos.cuisine.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
            Timer = 0   
                RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour cuisiner", time_display = 1 })
                if IsControlJustPressed(1,51) then           
                    Cuisinemcdonalds()
                end   
            end
        end 
    Wait(Timer)
 end
end)
-------------------------------------------------------------
function Drivemcdonalds()
    local drivemcdo = RageUI.CreateMenu("Drive", "~y~McDonald's")
    drivemcdo:SetRectangleBanner(255, 0, 0)
  
    RageUI.Visible(drivemcdo, not RageUI.Visible(drivemcdo))
  
    while drivemcdo do
        Wait(0)
        RageUI.IsVisible(drivemcdo, true, true, true, function()

            RageUI.Separator("~y~↓ ~s~Notre menu ~y~↓")
   
            for k,v in pairs(Drive) do
                RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = v.Price.." €"}, true, function(Hovered, Active, Selected)
                if selected then
                end
            end)
        end

        RageUI.Separator("")

        RageUI.ButtonWithStyle("Passer commande", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local commande = KeyboardInput("Veuillez décrire votre commande ?", '' , 50)
                TriggerServerEvent('fMcDo:addcommande', commande)
                RageUI.CloseAll()
            end
        end)

            end, function() 
            end)
  
        if not RageUI.Visible(drivemcdo) then
            drivemcdo = RMenu:DeleteType("drivemcdo", true)
          end
      end
  end

  CreateThread(function()
    while true do
        local Timer = 500

        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, mcdonalds.pos.drive.position.x, mcdonalds.pos.drive.position.y, mcdonalds.pos.drive.position.z)
        if dist3 <= 10.0 and mcdonalds.jeveuxmarkerdrive then
            Timer = 0
            DrawMarker(20, mcdonalds.pos.drive.position.x, mcdonalds.pos.drive.position.y, mcdonalds.pos.drive.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
            Timer = 0   
                RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour passer votre commande", time_display = 1 })
                if IsControlJustPressed(1,51) then           
                    Drivemcdonalds()
                end   
            end
    Wait(Timer)
 end
end)
--------------------------------------------------------------------
function Menuf6McDonalds()
    local McDonaldsf6 = RageUI.CreateMenu("McDonald's", "~y~Interactions")
    local McDonaldsf6commandes = RageUI.CreateSubMenu(McDonaldsf6, "McDonald's", "~y~Commandes")
    local McDonaldsf6info = RageUI.CreateSubMenu(McDonaldsf6commandes, "McDonald's", "~y~Commandes")
    McDonaldsf6:SetRectangleBanner(255, 0, 0)
    McDonaldsf6commandes:SetRectangleBanner(255, 0, 0)
    McDonaldsf6info:SetRectangleBanner(255, 0, 0)
    getInfoReport()
    defESX()
    RageUI.Visible(McDonaldsf6, not RageUI.Visible(McDonaldsf6))
    while McDonaldsf6 do
        Wait(0)
            RageUI.IsVisible(McDonaldsf6, true, true, true, function()

                RageUI.Separator("~y~↓ ~s~Facture ~y~↓")

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mcdonalds', ('McDonald\'s'), montant)
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


                RageUI.Separator("~y~↓ ~s~Annonce ~y~↓")


                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('AnnonceMcDonaldsOuvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('AnnonceMcDonaldsFermer')
                    end
                end)

                RageUI.Separator("~y~↓ ~s~Commandes ~y~↓")

                RageUI.ButtonWithStyle("Liste des commandes", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                end, McDonaldsf6commandes)

                end, function() 
                end)

                RageUI.IsVisible(McDonaldsf6commandes, true, true, true, function()
                    if #lescommande >= 1 then
                        RageUI.Separator("~y~↓ ~s~Nouvelle commande ~y~↓")

                        for k,v in pairs(lescommande) do
                            RageUI.ButtonWithStyle(k.." - Client [~y~"..v.nom.."~s~]", nil, {RightLabel = "→→"},true , function(_,_,s)
                                if s then
                                    nom = v.nom
                                    id = v.id
                                    nbreport = k
                                    raison = v.args
                                    lacommande = v.detaillecommande
                                end
                            end, McDonaldsf6info)
                        end
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~y~Aucune commande~s~")
                        RageUI.Separator("")
                    end
                    
                end, function() 
                end)

                RageUI.IsVisible(McDonaldsf6info, true, true, true, function()

                    RageUI.Separator("Commande numéro : ~y~"..nbreport)
                    RageUI.Separator("Client : ~y~"..nom)
                    RageUI.Separator("Lieu de la commande : ~y~"..raison)

                    RageUI.Separator("~y~↓ ~s~Détaille de la commande ~y~↓")

                    RageUI.ButtonWithStyle(lacommande, nil, {RightLabel = nil}, true, function(_,_,s)
                        if s then
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("~r~Terminer la commande", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent('fMcDo:closecommande',nom, raison)
                            RageUI.CloseAll()
                        end
                    end)

                end, function() 
                end)

                if not RageUI.Visible(McDonaldsf6) and not RageUI.Visible(McDonaldsf6commandes) and not RageUI.Visible(McDonaldsf6info) then
                    McDonaldsf6 = RMenu:DeleteType("McDonaldsf6", true)
        end
    end
end


Keys.Register('F6', 'McDonald\'s', 'Ouvrir le menu McDonald\'s', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcdonalds' then
    	Menuf6McDonalds()
	end
end)




function Coffremcdonalds()
    local Cmcdonalds = RageUI.CreateMenu("Coffre", "~y~McDonald's")
    Cmcdonalds:SetRectangleBanner(255, 0, 0)
        RageUI.Visible(Cmcdonalds, not RageUI.Visible(Cmcdonalds))
            while Cmcdonalds do
            Wait(0)
            RageUI.IsVisible(Cmcdonalds, true, true, true, function()

                RageUI.Separator("~y~↓ ~s~Objet ~y~↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("~y~↓ ~s~Vêtements ~y~↓")

                    RageUI.ButtonWithStyle("Uniforme",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuemcdonalds()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_mcdo()
                            RageUI.CloseAll()
                        end
                    end)

                end, function()
                end)
            if not RageUI.Visible(Cmcdonalds) then
            Cmcdonalds = RMenu:DeleteType("Cmcdonalds", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcdonalds' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, mcdonalds.pos.coffre.position.x, mcdonalds.pos.coffre.position.y, mcdonalds.pos.coffre.position.z)
            if jobdist <= 10.0 and mcdonalds.jeveuxmarker then
                Timer = 0
                DrawMarker(20, mcdonalds.pos.coffre.position.x, mcdonalds.pos.coffre.position.y, mcdonalds.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffremcdonalds()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


function Garagemcdonalds()
    local Gmcdonalds = RageUI.CreateMenu("Garage", "~y~McDonald\'s")
    Gmcdonalds:SetRectangleBanner(255, 0, 0)
      RageUI.Visible(Gmcdonalds, not RageUI.Visible(Gmcdonalds))
          while Gmcdonalds do
              Wait(0)
                  RageUI.IsVisible(Gmcdonalds, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              RageUI.CloseAll()
                              end 
                          end
                      end) 
  
                      for k,v in pairs(Gmcdonaldsvoiture) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Wait(1)  
                              spawnuniCarmcdonalds(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Gmcdonalds) then
              Gmcdonalds = RMenu:DeleteType("Garage", true)
          end
      end
  end
  
  CreateThread(function()
          while true do
              local Timer = 500
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mcdonalds' then
              local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
              local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, mcdonalds.pos.garage.position.x, mcdonalds.pos.garage.position.y, mcdonalds.pos.garage.position.z)
              if dist3 <= 10.0 and mcdonalds.jeveuxmarker then
                  Timer = 0
                  DrawMarker(20, mcdonalds.pos.garage.position.x, mcdonalds.pos.garage.position.y, mcdonalds.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                  end
                  if dist3 <= 3.0 then
                  Timer = 0   
                      RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au garage", time_display = 1 })
                      if IsControlJustPressed(1,51) then           
                          Garagemcdonalds()
                      end   
                  end
              end 
          Wait(Timer)
       end
  end)
  
  function spawnuniCarmcdonalds(car)
      local car = GetHashKey(car)
  
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Wait(0)
      end
  
      local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
      local vehicle = CreateVehicle(car, mcdonalds.pos.spawnvoiture.position.x, mcdonalds.pos.spawnvoiture.position.y, mcdonalds.pos.spawnvoiture.position.z, mcdonalds.pos.spawnvoiture.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "mcdonalds"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
  end



function tenuemcdonalds()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = mcdonalds.Uniforms.male
        else
            uniformObject = mcdonalds.Uniforms.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end


function vcivil_mcdo()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end

itemstock = {}
function VRetirerobjet()
    local Stockmcdonalds = RageUI.CreateMenu("Coffre", "~r~McDonald's")
    Stockmcdonalds:SetRectangleBanner(255, 0, 0)
    ESX.TriggerServerCallback('mcdonalds:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(Stockmcdonalds, not RageUI.Visible(Stockmcdonalds))
        while Stockmcdonalds do
            Wait(0)
                RageUI.IsVisible(Stockmcdonalds, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('mcdonalds:getStockItem', v.name, tonumber(count))
                                    VRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockmcdonalds) then
            Stockmcdonalds = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function VDeposerobjet()
    local Depositmcdonalds = RageUI.CreateMenu("Coffre", "~r~McDonald's")
    Depositmcdonalds:SetRectangleBanner(255, 0, 0)
    ESX.TriggerServerCallback('mcdonalds:getPlayerInventory', function(inventory)
        RageUI.Visible(Depositmcdonalds, not RageUI.Visible(Depositmcdonalds))
    while Depositmcdonalds do
        Wait(0)
            RageUI.IsVisible(Depositmcdonalds, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('mcdonalds:putStockItems', item.name, tonumber(count))
                                            VDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositmcdonalds) then
                Depositmcdonalds = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

RegisterNetEvent("fMcDo:envoielanotif")
AddEventHandler("fMcDo:envoielanotif", function()
    ESX.ShowAdvancedNotification("McDonalds", "~r~Commande", "Une nouvelle commande a été ajouter! Ouvrez votre menu [F6]", "CHAR_TOM", 8)
end)