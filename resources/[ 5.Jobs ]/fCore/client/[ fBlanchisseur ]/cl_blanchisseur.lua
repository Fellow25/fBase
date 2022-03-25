ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

CreateThread(function()
if blanchisseur.jeveuxblips then
    local blanchisseurmap = AddBlipForCoord(blanchisseur.pos.blip.position.x, blanchisseur.pos.blip.position.y, blanchisseur.pos.blip.position.z)

    SetBlipSprite(blanchisseurmap, 84)
    SetBlipColour(blanchisseurmap, 1)
    SetBlipScale(blanchisseurmap, 0.65)
    SetBlipAsShortRange(blanchisseurmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Blanchisseur")
    EndTextCommandSetBlipName(blanchisseurmap)
end
end)

-- Garage

GBlanchisseurvoiture = {
	{nom = "Hakuchou", modele = "hakuchou"},
}

function GarageBlanchisseur()
  local GBlanchisseur = RageUI.CreateMenu("Garage", "Blanchisseur")
    RageUI.Visible(GBlanchisseur, not RageUI.Visible(GBlanchisseur))
        while GBlanchisseur do
            Wait(0)
                RageUI.IsVisible(GBlanchisseur, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GBlanchisseurvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarBlanchisseur(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GBlanchisseur) then
            GBlanchisseur = RMenu:DeleteType("GBlanchisseur", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'blanchisseur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'blanchisseur' then 
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, blanchisseur.pos.garage.position.x, blanchisseur.pos.garage.position.y, blanchisseur.pos.garage.position.z)
            if dist3 <= 10.0 and blanchisseur.jeveuxmarker then
                Timer = 0
                DrawMarker(20, blanchisseur.pos.garage.position.x, blanchisseur.pos.garage.position.y, blanchisseur.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 175, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageBlanchisseur()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarBlanchisseur(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, blanchisseur.pos.spawnvoiture.position.x, blanchisseur.pos.spawnvoiture.position.y, blanchisseur.pos.spawnvoiture.position.z, blanchisseur.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "XXXXXXXXX"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
    SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
    SetVehicleMaxMods(vehicle)
end

function SetVehicleMaxMods(vehicle)

    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
  
    ESX.Game.SetVehicleProperties(vehicle, props)
  
  end

-- MenuF6

function MenuF7Blanchisseur()
    local fBlanchisseurf7 = RageUI.CreateMenu("Blanchisseur", "Interactions")
    RageUI.Visible(fBlanchisseurf7, not RageUI.Visible(fBlanchisseurf7))
    while fBlanchisseurf7 do
        Wait(0)
            RageUI.IsVisible(fBlanchisseurf7, true, true, true, function()

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_blanchisseur', ('Blanchisseur'), montant)
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

                RageUI.ButtonWithStyle("Annonces disponible",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('blanchisseur:dispo')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces indisponible",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('blanchisseur:indispo')
                    end
                end)

                RageUI.Separator("↓ Fouiller ↓")

                RageUI.ButtonWithStyle("Interagir avec le citoyen",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then                
                        TriggerEvent('fellow:MenuFouille')
                        RageUI.CloseAll()
                    end
                end)

                end, function() 
                end)
    
                if not RageUI.Visible(fBlanchisseurf7) then
                    fBlanchisseurf7 = RMenu:DeleteType("Blanchisseur", true)
        end
    end
end


Keys.Register('F7', 'Blanchisseur', 'Ouvrir le menu Blanchisseur', function()
	if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'blanchisseur' then
    	MenuF7Blanchisseur()
	end
end)

-- Coffre

function CoffreBlanchisseur()
	local CBlanchisseur = RageUI.CreateMenu("Coffre", "Blanchisseur")
        RageUI.Visible(CBlanchisseur, not RageUI.Visible(CBlanchisseur))
            while CBlanchisseur do
            Wait(0)
            RageUI.IsVisible(CBlanchisseur, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BlanchisseurRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BlanchisseurDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Blanchisseur",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformeblanchisseur()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_blanchisseur()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(CBlanchisseur) then
            CBlanchisseur = RMenu:DeleteType("CBlanchisseur", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'blanchisseur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'blanchisseur' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, blanchisseur.pos.coffre.position.x, blanchisseur.pos.coffre.position.y, blanchisseur.pos.coffre.position.z)
            if jobdist <= 10.0 and blanchisseur.jeveuxmarker then
                Timer = 0
                DrawMarker(20, blanchisseur.pos.coffre.position.x, blanchisseur.pos.coffre.position.y, blanchisseur.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 175, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreBlanchisseur()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

-- Blanchisseur

function WashBlanchisseur()
	local WBlanchisseur = RageUI.CreateMenu("Blanchir l'argent", "Blanchisseur")
        RageUI.Visible(WBlanchisseur, not RageUI.Visible(WBlanchisseur))
            while WBlanchisseur do
            Wait(0)
            RageUI.IsVisible(WBlanchisseur, true, true, true, function()


                    RageUI.ButtonWithStyle("Blanchir argent",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local argent = KeyboardInput("Combien d'agent as-tu ?", '', 35)							
                            TriggerServerEvent('blanchisseur:argentsale', argent)
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(WBlanchisseur) then
            WBlanchisseur = RMenu:DeleteType("WBlanchisseur", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'blanchisseur' and ESX.PlayerData.job2.grade_name == 'brasdroit' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'blanchisseur' and ESX.PlayerData.job2.grade_name == 'boss' then            
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, blanchisseur.pos.wash.position.x, blanchisseur.pos.wash.position.y, blanchisseur.pos.wash.position.z)
            if jobdist <= 10.0 and blanchisseur.jeveuxmarker then
                Timer = 0
                DrawMarker(20, blanchisseur.pos.wash.position.x, blanchisseur.pos.wash.position.y, blanchisseur.pos.wash.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 175, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour blanchir l'argent", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        WashBlanchisseur()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

itemstock = {}
function BlanchisseurRetirerobjet()
	local StockBlanchisseur = RageUI.CreateMenu("Coffre", "Blanchisseur")
	ESX.TriggerServerCallback('blanchisseur:getStockItems', function(items) 
	itemstock = items
	RageUI.Visible(StockBlanchisseur, not RageUI.Visible(StockBlanchisseur))
        while StockBlanchisseur do
		    Wait(0)
		        RageUI.IsVisible(StockBlanchisseur, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('blanchisseur:getStockItem', v.name, tonumber(count))
                                    BlanchisseurRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockBlanchisseur) then
            StockBlanchisseur = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function BlanchisseurDeposerobjet()
    local DepositBlanchisseur = RageUI.CreateMenu("Coffre", "Blanchisseur")
    ESX.TriggerServerCallback('blanchisseur:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositBlanchisseur, not RageUI.Visible(DepositBlanchisseur))
    while DepositBlanchisseur do
        Wait(0)
            RageUI.IsVisible(DepositBlanchisseur, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('blanchisseur:putStockItems', item.name, tonumber(count))
                                            BlanchisseurDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositBlanchisseur) then
                DepositBlanchisseur = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function vuniformeblanchisseur()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = blanchisseur.tenue.male
        else
            uniformObject = blanchisseur.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_blanchisseur()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
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