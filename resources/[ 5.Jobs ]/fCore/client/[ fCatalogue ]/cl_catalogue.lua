ESX = nil

local playerCars = {}

fellow_conc = {
	catevehi = {},
	listecatevehi = {},
}

fellow_moto = {
	catemoto = {},
	listecatemoto = {},
}

local derniermotosorti = {}
local sortirmotoacheter = {}
local derniervoituresorti = {}
local sortirvoitureacheter = {}
local CurrentAction, CurrentActionMsg, LastZone, currentDisplayVehicle, CurrentVehicleData
local CurrentActionData, Vehicles, Categories = {}, {}, {}

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

function fCatalogueMenu()
	local catalogue = RageUI.CreateMenu("Catalogue", "Véhicules")
	local vehiclemenu = RageUI.CreateSubMenu(catalogue, "Catalogue", "Catégorie véhicule")
	local vehiclemenuparam = RageUI.CreateSubMenu(catalogue, "Catalogue", "Permet d'essayer le véhicule 1 minutes")
	catalogue:SetRectangleBanner(114, 99, 85)
	vehiclemenu:SetRectangleBanner(114, 99, 85)
	vehiclemenuparam:SetRectangleBanner(114, 99, 85)
RageUI.Visible(catalogue, not RageUI.Visible(catalogue))

while catalogue do
	Wait(0)
	RageUI.IsVisible(catalogue, true, true, true, function()

		
		for i = 1, #fellow_conc.catevehi, 1 do
		RageUI.ButtonWithStyle("Catégorie - "..fellow_conc.catevehi[i].label, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if (Selected) then
					nomcategorie = fellow_conc.catevehi[i].label
					categorievehi = fellow_conc.catevehi[i].name
					ESX.TriggerServerCallback('fellow_concess:recupererlistevehicule', function(listevehi)
							fellow_conc.listecatevehi = listevehi
					end, categorievehi)
				end
			end, vehiclemenu)
		end
	end, function()
	end)

	RageUI.IsVisible(vehiclemenu, true, true, true, function()
	RageUI.Separator("↓ Catégorie : "..nomcategorie.." ↓")
            
	for i2 = 1, #fellow_conc.listecatevehi, 1 do
	RageUI.ButtonWithStyle(fellow_conc.listecatevehi[i2].name, nil, {RightLabel =  "→"},true, function(Hovered, Active, Selected)
	if (Selected) then
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			nomvoiture = fellow_conc.listecatevehi[i2].name
			modelevoiture = fellow_conc.listecatevehi[i2].model
		end
	end, vehiclemenuparam)
	
	end
	end, function()
	end)

	RageUI.IsVisible(vehiclemenuparam, true, true, true, function()

		RageUI.ButtonWithStyle("Essayer le véhicule", nil, {RightLabel =  "→"}, true, function(h, a, s)
			if s then
				rouge = fCatalogueKeyboardInput("Pourcentagem de rouge", "", 3)
				vert = fCatalogueKeyboardInput("Pourcentagem de vert", "", 3)
				bleu = fCatalogueKeyboardInput("Pourcentagem de bleu", "", 3)
				posessaie = GetEntityCoords(PlayerPedId())
				spawnuniCarCatalogue(modelevoiture, r, g, b)
			end
		end)
	end, function()
	end)

		if not RageUI.Visible(catalogue) and not RageUI.Visible(vehiclemenu) and not RageUI.Visible(vehiclemenuparam) then
			catalogue = RMenu:DeleteType("Catalogue", true)
		  end
	  end
  end

CreateThread(function()
	while true do
		local Timer = 500
		local plycrdjob = GetEntityCoords(PlayerPedId(), false)
		local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, fCatalogue.pos.voiture.position.x, fCatalogue.pos.voiture.position.y, fCatalogue.pos.voiture.position.z)
		if jobdist <= 10.0 then
			Timer = 0
			DrawMarker(20, fCatalogue.pos.voiture.position.x, fCatalogue.pos.voiture.position.y, fCatalogue.pos.voiture.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
			end
			if jobdist <= 1.0 then
				Timer = 0
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au menu", time_display = 1 })
					if IsControlJustPressed(1,51) then
						ESX.TriggerServerCallback('fellow_concess:recuperercategorievehicule', function(catevehi)
							fellow_conc.catevehi = catevehi
						end)
						fCatalogueMenu()
				end   
			end
	Wait(Timer)   
end
end)
----------------------------------------------------------
function fCatalogueMotoMenu()
	local cataloguemoto = RageUI.CreateMenu("Catalogue", "Moto")
	local motomenu = RageUI.CreateSubMenu(cataloguemoto, "Catalogue", "Catégorie moto")
	local motomenuparam = RageUI.CreateSubMenu(cataloguemoto, "Catalogue", "Permet d'essayer la moto 1 minutes")
	cataloguemoto:SetRectangleBanner(114, 99, 85)
	motomenu:SetRectangleBanner(114, 99, 85)
	motomenuparam:SetRectangleBanner(114, 99, 85)
RageUI.Visible(cataloguemoto, not RageUI.Visible(cataloguemoto))

while cataloguemoto do
	Wait(0)
	RageUI.IsVisible(cataloguemoto, true, true, true, function()

		
		for i = 1, #fellow_moto.catemoto, 1 do
		RageUI.ButtonWithStyle("Catégorie - "..fellow_moto.catemoto[i].label, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if (Selected) then
					nomcategorie = fellow_moto.catemoto[i].label
					categorievehi = fellow_moto.catemoto[i].name
					ESX.TriggerServerCallback('fellow_moto:recupererlistemoto', function(listevehi)
							fellow_moto.listecatemoto = listevehi
					end, categorievehi)
				end
			end, motomenu)
		end
	end, function()
	end)

	RageUI.IsVisible(motomenu, true, true, true, function()
	RageUI.Separator("↓ Catégorie : "..nomcategorie.." ↓")
            
	for i2 = 1, #fellow_moto.listecatemoto, 1 do
	RageUI.ButtonWithStyle(fellow_moto.listecatemoto[i2].name, nil, {RightLabel =  "→"},true, function(Hovered, Active, Selected)
	if (Selected) then
			local plyCoords = GetEntityCoords(PlayerPedId(), false)
			nomvoiture = fellow_moto.listecatemoto[i2].name
			modelevoiture = fellow_moto.listecatemoto[i2].model
		end
	end, motomenuparam)
	
	end
	end, function()
	end)

	RageUI.IsVisible(motomenuparam, true, true, true, function()

		RageUI.ButtonWithStyle("Essayer la moto", nil, {RightLabel =  "→"}, true, function(h, a, s)
			if s then
				rouge = fCatalogueKeyboardInput("Pourcentagem de rouge", "", 3)
				vert = fCatalogueKeyboardInput("Pourcentagem de vert", "", 3)
				bleu = fCatalogueKeyboardInput("Pourcentagem de bleu", "", 3)
				posessaie = GetEntityCoords(PlayerPedId())
				spawnuniCarCatalogue(modelevoiture, r, g, b)
			end
		end)
	end, function()
	end)

		if not RageUI.Visible(cataloguemoto) and not RageUI.Visible(motomenu) and not RageUI.Visible(motomenuparam) then
			cataloguemoto = RMenu:DeleteType("Catalogue", true)
		  end
	  end
  end

CreateThread(function()
	while true do
		local Timer = 500
		local plycrdjob = GetEntityCoords(PlayerPedId(), false)
		local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, fCatalogue.pos.moto.position.x, fCatalogue.pos.moto.position.y, fCatalogue.pos.moto.position.z)
		if jobdist <= 10.0 then
			Timer = 0
			DrawMarker(20, fCatalogue.pos.moto.position.x, fCatalogue.pos.moto.position.y, fCatalogue.pos.moto.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
			end
			if jobdist <= 1.0 then
				Timer = 0
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au menu", time_display = 1 })
					if IsControlJustPressed(1,51) then
						ESX.TriggerServerCallback('fellow_moto:recuperercategoriemoto', function(catemoto)
							fellow_moto.catemoto = catemoto
						end)
						fCatalogueMotoMenu()
				end   
			end
	Wait(Timer)   
end
end)
function spawnuniCarCatalogue(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -899.62, -3298.74, 13.94, 58.0, true, false)
	SetVehicleCustomPrimaryColour(vehicle, rouge, vert, bleu)
	SetVehicleCustomSecondaryColour(vehicle, rouge, vert, bleu)
    SetEntityAsMissionEntity(vehicle, true, true) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
	SetVehicleDoorsLocked(vehicle, 4)
	ESX.ShowNotification("Vous avez 30 secondes pour tester le véhicule.")
	local timer =30
	local breakable = false
	breakable = false
	while not breakable do
		Wait(1000)
		timer = timer - 1
		if timer == 15 then
			ESX.ShowNotification("Il vous reste plus que 15 secondes.")
		end
		if timer == 5 then
			ESX.ShowNotification("Il vous reste plus que 5 secondes.")
		end
		if timer <= 0 then
			local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
			DeleteEntity(vehicle)
			ESX.ShowNotification("~r~Vous avez terminé la période d'essai.")
			SetEntityCoords(PlayerPedId(), posessaie)
			breakable = true
			break
		end
	end
end

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function fCatalogueKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
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
