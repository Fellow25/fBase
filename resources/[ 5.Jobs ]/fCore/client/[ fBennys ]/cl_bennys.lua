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
    if Bennys.jeveuxblips then
    local bennysmap = AddBlipForCoord(Bennys.pos.blips.position.x, Bennys.pos.blips.position.y, Bennys.pos.blips.position.z)
        SetBlipSprite(bennysmap, 402)
        SetBlipColour(bennysmap, 5)
        SetBlipScale(bennysmap, 1.20)
        SetBlipAsShortRange(bennysmap, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Benny's")
        EndTextCommandSetBlipName(bennysmap)
    end
end)

function Menuf6Bennys()
    local fBennysf6 = RageUI.CreateMenu("Benny's", "Interactions")
    local fBennysf6Sub = RageUI.CreateSubMenu(fBennysf6, "Benny's", "Annonces")
    local fBennysf6Sub1 = RageUI.CreateSubMenu(fBennysf6, "Benny's", "Interaction véhicule")
    fBennysf6:SetRectangleBanner(150, 0, 0)
    fBennysf6Sub:SetRectangleBanner(150, 0, 0)
    fBennysf6Sub1:SetRectangleBanner(150, 0, 0)
    RageUI.Visible(fBennysf6, not RageUI.Visible(fBennysf6))
    while fBennysf6 do
        Wait(0)
            RageUI.IsVisible(fBennysf6, true, true, true, function()

                RageUI.Separator("~y~↓ Facture ↓")

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mechanic', ('Benny\'s'), montant)
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


                RageUI.Separator("~y~↓ Annonce ↓")

                RageUI.ButtonWithStyle("Passer une annonce", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fBennysf6Sub)

                RageUI.Separator("~y~↓ Entretiens ↓")

                RageUI.ButtonWithStyle("Interaction véhicule", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fBennysf6Sub1)

                end, function() 
                end)

                RageUI.IsVisible(fBennysf6Sub, true, true, true, function()
                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('fBennys:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fBennys:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('fBennys:Perso', msg)
                    end
                end)

                RageUI.ButtonWithStyle("Demande de dépanneur", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local playerPed = PlayerPedId()
                        local coords  = GetEntityCoords(playerPed)
                        local info = 'Demande'
                        local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
                        TriggerServerEvent('fBennys:Fourriere', info, message)
                        TriggerServerEvent('fBennys:renfort', coords)
                        RageUI.CloseAll()
                    end
                end)
                end, function() 
                end)

                RageUI.IsVisible(fBennysf6Sub1, true, true, true, function()
                    RageUI.ButtonWithStyle("Réparer le véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                    local playerPed = PlayerPedId()
                    local vehicle   = ESX.Game.GetVehicleInDirection()
                    local coords    = GetEntityCoords(playerPed)
                
                    ESX.TriggerServerCallback("fBennys:checkkit", function(haveKit)
                        if haveKit then
                            Canrepaire = true
                        end
                    end)
                
                    
                    if Canrepaire then
                        if IsPedSittingInAnyVehicle(playerPed) then
                            ESX.ShowNotification('Veuillez descendre de la voiture.')
                            return
                        end
                
                        if DoesEntityExist(vehicle) then
                            isBusy = true
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                            CreateThread(function()
                                TriggerServerEvent("fBennys:delkit")
                                Wait(20000)
                                SetVehicleFixed(vehicle)
                                SetVehicleDeformationFixed(vehicle)
                                SetVehicleUndriveable(vehicle, false)
                                SetVehicleEngineOn(vehicle, true, true)
                                ClearPedTasksImmediately(playerPed)
                
                                ESX.ShowNotification('Le véhicule est réparer')
                                isBusy = false
                            end)
                        else
                            ESX.ShowNotification('Aucun véhicule à proximiter')
                        end
                            else
                                ESX.ShowNotification('~r~Vous avez pas de kit de réparation')
                    end
                end
            end)
                        
                        RageUI.ButtonWithStyle("Nettoyer véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                local playerPed = PlayerPedId()
                                local vehicle   = ESX.Game.GetVehicleInDirection()
                                local coords    = GetEntityCoords(playerPed)
                    
                                if IsPedSittingInAnyVehicle(playerPed) then
                                    ESX.ShowNotification('Veuillez sortir de la voiture?')
                                    return
                                end
                    
                                if DoesEntityExist(vehicle) then
                                    isBusy = true
                                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                                    CreateThread(function()
                                        Wait(10000)
                    
                                        SetVehicleDirtLevel(vehicle, 0)
                                        ClearPedTasksImmediately(playerPed)
                    
                                        ESX.ShowNotification('Voiture néttoyé')
                                        isBusy = false
                                    end)
                                else
                                    ESX.ShowNotification('Aucun véhicule trouvée')
                                    end
                                end
                            end)

                            end, function() 
                            end)
    
                if not RageUI.Visible(fBennysf6) and not RageUI.Visible(fBennysf6Sub) and not RageUI.Visible(fBennysf6Sub1) then
                    fBennysf6 = RMenu:DeleteType("Benny's", true)
        end
    end
end

Keys.Register('F6', 'Bennys', 'Ouvrir le menu Benny\'s', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
    	Menuf6Bennys()
	end
end)

function Coffrebennys()
    local Cbennys = RageUI.CreateMenu("Coffre", "Benny's")
    Cbennys:SetRectangleBanner(150, 0, 0)
        RageUI.Visible(Cbennys, not RageUI.Visible(Cbennys))
            while Cbennys do
            Wait(0)
            RageUI.IsVisible(Cbennys, true, true, true, function()
                
               
                RageUI.Separator("~y~↓ Objet / Arme ↓")
                
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BennysRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end
                
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'ferrailleur' then
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BennysDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end
            
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                RageUI.Separator("~y~↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Uniforme",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformebennys()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_bennys()
                            RageUI.CloseAll()
                        end
                end)
                end
                end, function()
                end)
            if not RageUI.Visible(Cbennys) then
            Cbennys = RMenu:DeleteType("Cbennys", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'ferrailleur' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Bennys.pos.coffre.position.x, Bennys.pos.coffre.position.y, Bennys.pos.coffre.position.z)
            if jobdist <= 10.0 and Bennys.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Bennys.pos.coffre.position.x, Bennys.pos.coffre.position.y, Bennys.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrebennys()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function GarageBennys()
  local GBennys = RageUI.CreateMenu("Garage", "Benny's")
  GBennys:SetRectangleBanner(150, 0, 0)
    RageUI.Visible(GBennys, not RageUI.Visible(GBennys))
        while GBennys do
            Wait(0)
                RageUI.IsVisible(GBennys, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GBennysvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarBennys(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GBennys) then
            GBennys = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bennys.pos.garage.position.x, Bennys.pos.garage.position.y, Bennys.pos.garage.position.z)
            if dist3 <= 10.0 and Bennys.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Bennys.pos.garage.position.x, Bennys.pos.garage.position.y, Bennys.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageBennys()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarBennys(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Bennys.pos.spawnvoiture.position.x, Bennys.pos.spawnvoiture.position.y, Bennys.pos.spawnvoiture.position.z, Bennys.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Benny's"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end



itemstock = {}
function BennysRetirerobjet()
    local Stockbennys = RageUI.CreateMenu("Coffre", "Benny's")
    Stockbennys:SetRectangleBanner(150, 0, 0)
    ESX.TriggerServerCallback('fbennys:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockbennys, not RageUI.Visible(Stockbennys))
        while Stockbennys do
            Wait(0)
                RageUI.IsVisible(Stockbennys, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fbennys:getStockItem', v.name, tonumber(count))
                                    BennysRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockbennys) then
            Stockbennys = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function BennysDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Benny's")
    StockPlayer:SetRectangleBanner(150, 0, 0)
    ESX.TriggerServerCallback('fbennys:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('fbennys:putStockItems', item.name, tonumber(count))
                                            BennysDeposerobjet()
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

function vuniformebennys()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Bennys.tenue.male
        else
            uniformObject = Bennys.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_bennys()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end

RegisterNetEvent('fBennys:Fourriere')
AddEventHandler('fBennys:Fourriere', function(service, nom, message)
    if service == 'Demande' then
        PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
        ESX.ShowAdvancedNotification('Demande dépanneur', '~b~A lire', 'Demande par: ~g~'..nom..'\n~w~Message: ~g~'..message..'', 'CHAR_MINOTAUR', 8)
        Wait(1000)
        PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)    
    end
end)

RegisterNetEvent('fBennys:setBlip')
AddEventHandler('fBennys:setBlip', function(coords)
    local blipId = AddBlipForCoord(coords)
    SetBlipSprite(blipId, 161)
    SetBlipScale(blipId, 1.2)
    SetBlipColour(blipId, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Demande dépanneur')
    EndTextCommandSetBlipName(blipId)
    Wait(80 * 1000)
    RemoveBlip(blipId)
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