ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local demandelist = {}

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

local function getInfoReport()
    local info = {}
    ESX.TriggerServerCallback('rFire:infoReport', function(info)
        demandelist = info
    end)
end


CreateThread(function()
    if Fire.jeveuxblips then
    local firemap = AddBlipForCoord(Fire.pos.blips.position.x, Fire.pos.blips.position.y, Fire.pos.blips.position.z)
    SetBlipSprite(firemap, 436)
    SetBlipColour(firemap, 1)
    SetBlipScale(firemap, 0.70)
    SetBlipAsShortRange(firemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Sapeur-Pompier")
    EndTextCommandSetBlipName(firemap)
    end
end)

function Menuf6Fire()
    local rFiref6 = RageUI.CreateMenu("Sapeur-Pompier", "Interactions")
    local rFireappel = RageUI.CreateSubMenu(rFiref6, "Appel Pompier", "Interactions")
    local rFireappelinfo = RageUI.CreateSubMenu(rFireappel, "Appel Pompier Info", "Interactions")
    rFiref6:SetRectangleBanner(255, 0, 0, 255)
    rFireappel:SetRectangleBanner(255, 0, 0, 255)
    rFireappelinfo:SetRectangleBanner(255, 0, 0, 255)
    getInfoReport()
    defESX()
    RageUI.Visible(rFiref6, not RageUI.Visible(rFiref6))
    while rFiref6 do
        Wait(0)
            RageUI.IsVisible(rFiref6, true, true, true, function()


                RageUI.Separator("~r~"..ESX.PlayerData.job.grade_label.." - "..GetPlayerName(PlayerId()))


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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_fire', ('Sapeur-Pompier'), montant)
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
                        TriggerServerEvent('rFire:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('rFire:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        TriggerServerEvent('rFire:Perso', msg)
                    end
                end)

                RageUI.Separator("↓ Autres ↓")


                RageUI.ButtonWithStyle("Intéraction Appels", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                end, rFireappel)
                
                end, function() 
                end)

                RageUI.IsVisible(rFireappel, true, true, true, function()
                    if #demandelist >= 1 then
                        RageUI.Separator("↓ Nouvelle Appel ↓")

                        for k,v in pairs(demandelist) do
                            RageUI.ButtonWithStyle(k.." - Demande envoyer par [~r~"..v.nom.."~s~] | Id : [~p~"..v.id.."~s~]", nil, {RightLabel = "→→"},true , function(_,_,s)
                                if s then
                                    nom = v.nom
                                    nbreport = k
                                    id = v.id
                                    raison = v.args
                                    gps = v.gps
                                end
                            end, rFireappelinfo)
                        end
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucune Appel~s~")
                        RageUI.Separator("")
                    end
                end, function() 
                end)

                
                RageUI.IsVisible(rFireappelinfo, true, true, true, function()

                    RageUI.Separator("Demande numéro : ~r~"..nbreport)
                    RageUI.Separator("Demande envoyer par : ~r~"..nom.."~s~ [~r~"..id.."~s~]")
                    RageUI.Separator("Raison de la Demande : ~r~"..raison)

                    RageUI.ButtonWithStyle("Récupérer les coordonnées GPS", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            SetNewWaypoint(gps.x, gps.y)
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Supprime l'appel", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent('rFire:CloseReport',nom, raison)
                            RageUI.CloseAll()
                        end
                    end)

                end, function() 
                end)
    
                if not RageUI.Visible(rFiref6) and not RageUI.Visible(rFireappel) and not RageUI.Visible(rFireappelinfo) then
                rFiref6 = RMenu:DeleteType("Sapeur-Pompier", true)
        end
    end
end

Keys.Register('F6', 'Sapeur-Pompier', 'Ouvrir le menu Sapeur-Pompier', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fire' then
    	Menuf6Fire()
	end
end)

RegisterNetEvent("rFire:envoielanotif")
AddEventHandler("rFire:envoielanotif", function()
    ESX.ShowAdvancedNotification("Sapeur-Pompier", "~r~Demande de Pompier", "Quelqu'un a besoin d'un Pompier ! Ouvrez votre menu [F6] pour intervenir", "CHAR_CALL911", 8)
end)

RegisterNetEvent("rFire:envoielanotifclose")
AddEventHandler("rFire:envoielanotifclose", function(nom)
    ESX.ShowAdvancedNotification("Sapeur-Pompier", "~r~Fermeture d'un appel", "L'appel de "..nom.." a ete ferme par "..GetPlayerName(PlayerId()), "CHAR_CALL911", 8)
end)

function CoffreFire()
    local Cfire = RageUI.CreateMenu("Coffre", "Sapeur-Pompier")
    Cfire:SetRectangleBanner(255, 0, 0, 255)
        RageUI.Visible(Cfire, not RageUI.Visible(Cfire))
            while Cfire do
            Wait(0)
            RageUI.IsVisible(Cfire, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FireRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FireDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cfire) then
            Cfire = RMenu:DeleteType("Cfire", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fire' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Fire.pos.coffre.position.x, Fire.pos.coffre.position.y, Fire.pos.coffre.position.z)
            if jobdist <= 10.0 and Fire.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Fire.pos.coffre.position.x, Fire.pos.coffre.position.y, Fire.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreFire()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function GarageFire()
  local GFire = RageUI.CreateMenu("Garage", "Sapeur-Pompier")
  GFire:SetRectangleBanner(255, 0, 0, 255)
    RageUI.Visible(GFire, not RageUI.Visible(GFire))
        while GFire do
            Wait(0)
                RageUI.IsVisible(GFire, true, true, true, function()
 
                    for k,v in pairs(GFirevoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarFire(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GFire) then
            GFire = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fire' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Fire.pos.garage.position.x, Fire.pos.garage.position.y, Fire.pos.garage.position.z)
            if dist3 <= 10.0 and Fire.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Fire.pos.garage.position.x, Fire.pos.garage.position.y, Fire.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageFire()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

---- Ranger la voiture

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fire' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Fire.pos.deletevoiture.position.x, Fire.pos.deletevoiture.position.y, Fire.pos.deletevoiture.position.z)
            if dist3 <= 1.0 then
            Timer = 0   
                RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour ranger la voiture", time_display = 1 })
                if IsControlJustPressed(1,51) then           
                    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                end   
            end
        end 
    Wait(Timer)
 end
end)


function spawnuniCarFire(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Fire.pos.spawnvoiture.position.x, Fire.pos.spawnvoiture.position.y, Fire.pos.spawnvoiture.position.z, Fire.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Pompier"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque)
    SetVehRadioStation(vehicle, "OFF") 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end



itemstock = {}
function FireRetirerobjet()
    local Stockfire = RageUI.CreateMenu("Coffre", "Sapeur-Pompier")
    Stockfire:SetRectangleBanner(255, 0, 0, 255)
    ESX.TriggerServerCallback('rFire:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockfire, not RageUI.Visible(Stockfire))
        while Stockfire do
            Wait(0)
                RageUI.IsVisible(Stockfire, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 8)
                                    TriggerServerEvent('rFire:getStockItem', v.name, tonumber(count))
                                    FireRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockfire) then
            Stockfire = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function FireDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Sapeur-Pompier")
    StockPlayer:SetRectangleBanner(255, 0, 0, 255)
    ESX.TriggerServerCallback('rFire:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('rFire:putStockItems', item.name, tonumber(count))
                                            FireDeposerobjet()
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


-- Vestiaire

function VestiaireFire()
	local VFire = RageUI.CreateMenu("Vestiaire", "Sapeur-Pompier")
    VFire:SetRectangleBanner(255, 0, 0, 255)
        RageUI.Visible(VFire, not RageUI.Visible(VFire))
            while VFire do
            Wait(0)
            RageUI.IsVisible(VFire, true, true, true, function()

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Uniforme",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformeFire()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_fire()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(VFire) then
            VFire = RMenu:DeleteType("Vestiaire", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fire' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'fire' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Fire.pos.vestiaire.position.x, Fire.pos.vestiaire.position.y, Fire.pos.vestiaire.position.z)
            if jobdist <= 10.0 and Fire.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Fire.pos.vestiaire.position.x, Fire.pos.vestiaire.position.y, Fire.pos.vestiaire.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au vestiaire", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            VestiaireFire()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

function vuniformeFire()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Fire.Tenue.male
        else
            uniformObject = Fire.Tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_fire()
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