local hasAlreadyEnteredMarker, CurrentActionData = false, {}
local CurrentAction, CurrentActionMsg, LastZone


function OpenRealestateAgentMenu()
    local MRealestateAgent = RageUI.CreateMenu("Agent Immobilier", " ")
        RageUI.Visible(MRealestateAgent, not RageUI.Visible(MRealestateAgent))
            while MRealestateAgent do
            Wait(0)
            RageUI.IsVisible(MRealestateAgent, true, true, true, function()

                    RageUI.ButtonWithStyle(_U('properties'), nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            OpenPropertyMenu()
                            RageUI.CloseAll()
                        end
                    end)

					RageUI.ButtonWithStyle(_U('clients'), nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            OpenCustomersMenu()
                            RageUI.CloseAll()
                        end
                    end)

				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'realestateagent' and ESX.PlayerData.job.grade_name == 'boss' then
					RageUI.ButtonWithStyle(_U('boss_action'), nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            MenuBossAgentImmo()
                            RageUI.CloseAll()
                        end
                    end)
				end

                end, function()
                end)
            if not RageUI.Visible(MRealestateAgent) then
            MRealestateAgent = RMenu:DeleteType("MRealestateAgent", true)
        end
    end
end

function MenuBossAgentImmo()
    TriggerEvent('esx_society:openBossMenu', 'realestateagent', function(data, menu)
        menu.close()
    end, {wash = false})
end

--[[function OpenRealestateAgentMenu()
	local elements = {
		{label = _U('properties'), value = 'properties'},
		{label = _U('clients'),    value = 'customers'},
	}

	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'realestateagent' and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {
			label = _U('boss_action'),
			value = 'boss_actions'
		})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'realestateagent', {
		title    = _U('realtor'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'properties' then
			OpenPropertyMenu()
		elseif data.current.value == 'customers' then
			OpenCustomersMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'realestateagent', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'realestateagent_menu'
		CurrentActionMsg  = _U('press_to_access')
		CurrentActionData = {}
	end)
end]]--

function OpenPropertyMenu()
	TriggerEvent('esx_property:getProperties', function(properties)

		local elements = {
			head = {_U('property_name'), _U('property_actions')},
			rows = {}
		}

		for i=1, #properties, 1 do
			table.insert(elements.rows, {
				data = properties[i],
				cols = {
					properties[i].label,
					_U('property_actionbuttons')
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'properties', elements, function(data, menu)
			if data.value == 'sell' then
				menu.close()

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_property_amount', {
					title = _U('amount')
				}, function(data2, menu2)
					local amount = tonumber(data2.value)

					if amount == nil then
						ESX.ShowNotification(_U('invalid_amount'))
					else
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification(_U('no_play_near'))
							menu2.close()
						else
							TriggerServerEvent('esx_realestateagentjob:sell', GetPlayerServerId(closestPlayer), data.data.name, amount)
							menu2.close()
						end

						OpenPropertyMenu()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.value == 'rent' then
				menu.close()

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'rent_property_amount', {
					title = _U('amount')
				}, function(data2, menu2)
					local amount = tonumber(data2.value)

					if amount == nil then
						ESX.ShowNotification(_U('invalid_amount'))
					else
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification(_U('no_play_near'))
							menu2.close()
						else
							TriggerServerEvent('esx_realestateagentjob:rent', GetPlayerServerId(closestPlayer), data.data.name, amount)
							menu2.close()
						end

						OpenPropertyMenu()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			elseif data.value == 'gps' then
				TriggerEvent('esx_property:getProperty', data.data.name, function(property)
					if property.isSingle then
						SetNewWaypoint(property.entering.x, property.entering.y)
					else
						TriggerEvent('esx_property:getGateway', property, function(gateway)
							SetNewWaypoint(gateway.entering.x, gateway.entering.y)
						end)
					end
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenCustomersMenu()
	ESX.TriggerServerCallback('esx_realestateagentjob:getCustomers', function(customers)
		local elements = {
			head = {_U('customer_client'), _U('customer_property'), _U('customer_agreement'), _U('customer_actions')},
			rows = {}
		}

		for i=1, #customers, 1 do
			table.insert(elements.rows, {
				data = customers[i],
				cols = {
					customers[i].name,
					customers[i].propertyLabel,
					(customers[i].propertyRented and _U('customer_rent') or _U('customer_sell')),
					_U('customer_contractbuttons')
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'customers', elements, function(data, menu)
			if data.value == 'revoke' then
				TriggerServerEvent('esx_realestateagentjob:revoke', data.data.propertyName, data.data.propertyOwner)
				OpenCustomersMenu()
			elseif data.value == 'gps' then
				TriggerEvent('esx_property:getProperty', data.data.propertyName, function(property)
					if property.isSingle then
						SetNewWaypoint(property.entering.x, property.entering.y)
					else
						TriggerEvent('esx_property:getGateway', property, function(gateway)
							SetNewWaypoint(gateway.entering.x, gateway.entering.y)
						end)
					end
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true

	if ESX.PlayerData.job.name == 'realestateagent' then
		Config.Zones.OfficeActions.Type = 1
	else
		Config.Zones.OfficeActions.Type = -1
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	if ESX.PlayerData.job.name == 'realestateagent' then
		Config.Zones.OfficeActions.Type = 1
	else
		Config.Zones.OfficeActions.Type = -1
	end
end)

AddEventHandler('esx_realestateagentjob:hasEnteredMarker', function(zone)
	if zone == 'OfficeEnter' then
		local playerPed = PlayerPedId()
		SetEntityCoords(playerPed, Config.Zones.OfficeInside.Pos.x, Config.Zones.OfficeInside.Pos.y, Config.Zones.OfficeInside.Pos.z)
	elseif zone == 'OfficeExit' then
		local playerPed = PlayerPedId()
		SetEntityCoords(playerPed, Config.Zones.OfficeOutside.Pos.x, Config.Zones.OfficeOutside.Pos.y, Config.Zones.OfficeOutside.Pos.z)
	elseif zone == 'OfficeActions' and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'realestateagent' then
		CurrentAction     = 'realestateagent_menu'
		CurrentActionMsg  = _U('press_to_access')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_realestateagentjob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips
CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.OfficeEnter.Pos.x, Config.Zones.OfficeEnter.Pos.y, Config.Zones.OfficeEnter.Pos.z)

	SetBlipSprite (blip, 357)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 59)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('realtors'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
CreateThread(function()
	while true do
		Wait(0)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
CreateThread(function()
	while true do
		Wait(0)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not hasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_realestateagentjob:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_realestateagentjob:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
CreateThread(function()
	while true do
		Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'realestateagent_menu' then
					OpenRealestateAgentMenu()
				end

				CurrentAction = nil
			end
		else
			Wait(500)
		end
	end
end)

-- Load IPLS
CreateThread(function()
	RequestIpl('ex_dt1_02_office_02c')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('realtor'),
		number     = 'realestateagent',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAMAAABHPGVmAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAMAUExURQAAAAkuhgkvhwowhgowhwwxhwowiAwxiAwyiA0yiQ4zig80iQ40ihA0iRA0ihA1ixE2ixI3jBM4ixM4jBQ4jBQ4jRY6jRY6jhg7jhg7jxg8jRk8jhk8jxo+jxo+kBw/kB1AkB1AkR9Bkh9CkR9CkiBDkSBCkiFEkyNElCNGlCVGlCZIlSdIlihJlipKlilKlytMlyxLlyxNlytMmCxMmC5OmS9PmjBPmTBPmjFQmTBQmjNSmzNSnDRTnDVUmzVUnDdVnjZWnTdWnjhXnjpYnjxZnj1bnztaoD1aoD5coT9dokBdoUBdokFeokNgo0NgpERgo0RhpEVipEZipUdkpUdkpkhkpEhkpkpmpUpmpkpmp0xnpk5qp0xoqE5pqU5qqVBrqFBrqVFrqlJsqVJsqlJuqlNuq1RuqlRurFZwrFdyrVhxrllyrVhyrlt0r1x1r112r1x1sF12sF94sWF5sGB4sWF5smJ6smR8s2V9tGZ+tGd/tWl/tWh/tmmAtWmAtmuCtmqCt2yDt2yDuG6EuG+GuXGGuXGGunGIunSJunSJu3WKvHeMvXiNvHmOvnuQvnyQvn6SwICTwYCUwICUwYKWwoSWw4SYw4WYxIeaxIiaxIqcxoydx4yex46fyI+gyJGiyZGiypOkypSky5amzJeozZinzZmozZmpzpqqzpysz5+u0KCu0KGw0aKw0qWz06a01Ki11Ki21aq31qu41qy41q2616+72LC82LG+2bK+2rS/27XA2rbB3LfC3LjD3LrE3brF3rvG3rzG3r7I37/I4MHK4MPM4cTN4sXO4sbP5MfQ48fQ5MjQ5MnS5cvT5szT5s3U5s7W587W6NDX6NHY6NPa6dPa6tTa6tXc6tfd7Nnf7drg7dvg7tzh7t3i7t/k7+Dl8OLm8OPo8ePo8uTo8eTo8ubq8ufr9Ons9Oru9ezu9ezv9u3w9u/y9+/x+PDy+PL0+PP1+vP2+fT1+fX2+vb4+/f4/Pj5+/j5/Pn6/Pv8/fz8/fz8/v7+/gAAACSdcMIAAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAAC4iAAAuIgGq4t2SAAAAGHRFWHRTb2Z0d2FyZQBwYWludC5uZXQgNC4xLjb9TgnoAAAKNUlEQVRoQ92af1hV5R3Ax/HuXI5eb9fimguQUEN3CbFEW1i51l2PVCJg6qTYapGhm1iaYm6r3O7UciQWmOkonWyOpWJkTh3TJobilIbKlETvvNvAS9zG3YTlxcvp/fE9v3/cK3uePXv2+eue97zn++Gc9/2+P87hS/x/gf89SfmKp+fm5eTMLFiwEkqiI1rJy9nJnJWRsFiHps1dBScjEY1k6fgRHMRWYrHH3/cKVDIjsuThL0NIA+IWQUVjIkieSJQ/IwOGpC6F6gaYSuY6IEwkYhJfhEt0MZE8HwchoiHG9QZcpoOhpOw2C1wfJdztcKUWI8mT16nA3FgKF6vRl6y/NQYuvC4sd8P1KnQlK/TTIgqSIIISPUkuXDEQLMshiBwdyZ0DaA6J2MchjAytZDzUNiFhlEkCxTwDgSQ0krFQ1xjn8hMtjXs3PPd110g7FCkYNBtCiaglke7DEpdzqLcfEe7r9Z+t31m28H7XyGEcy8J5zKAHIZiASnIn1DPCUVDTjRUi4VBve9Nvq17/UWFWRqJoegrCAUpJboQ2H7X70zBEVxLqCfq9LfWV30sh9WKVaamQrCA1jGAnec5BTCP+UjWJuRknmQMiUuSS9aY5mLyuLQSxDAhszbTZv7snGdceBTEJcsmtJJgc1soKD5B9dNuRCx2f9Yb1n1d/f7Aux2bP3hv8K+mfMfIuJpM8qR6vrPeXbVxdnHdvCsfYbmZZK3dTxqPLXnunpv6MrwciiwQPzI+zZVf5+/vbaRLEroGwCElSpm70wWsvhfo+vxLwtVZzWcfqN88fi3sPaxuWMG6Se+GW43KRryiBZSo68F2ChImF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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

if ESX.PlayerLoaded and ESX.PlayerData.job.name == 'realestateagent' then
	Config.Zones.OfficeActions.Type = 1
else
	Config.Zones.OfficeActions.Type = -1
end

local name = ''
local exit = ''
local label = ''
local inside = ''
local outside = ''
local ipl = ''
local isRoom = ''
local roommenu = ''
local price = ''
local entering = ''
local entrer = ''
local isSingle = ''
local garage = ''
local price = 0 

local Menu = { 

    action = {
        'Motel',
        'Petit',
        'Middle',
        'Modern',
        'High',
        'Luxe',
        'Entrepot (grand)',
        'Entrepot (moyen)',
        'Entrepot (petit)'
    },  

    list = 1
}


local debug = false -- debug mode

local zones = { 
['AIRP'] = "Los Santos International Airport",
['ALAMO'] = "Alamo Sea", 
['ALTA'] = "Alta", 
['ARMYB'] = "Fort Zancudo", 
['BANHAMC'] = "Banham Canyon Dr", 
['BANNING'] = "Banning", 
['BEACH'] = "Vespucci Beach", 
['BHAMCA'] = "Banham Canyon", 
['BRADP'] = "Braddock Pass", 
['BRADT'] = "Braddock Tunnel", 
['BURTON'] = "Burton", 
['CALAFB'] = "Calafia Bridge", 
['CANNY'] = "Raton Canyon", 
['CCREAK'] = "Cassidy Creek", 
['CHAMH'] = "Chamberlain Hills", 
['CHIL'] = "Vinewood Hills", 
['CHU'] = "Chumash", 
['CMSW'] = "Chiliad Mountain State Wilderness", 
['CYPRE'] = "Cypress Flats", 
['DAVIS'] = "Davis", 
['DELBE'] = "Del Perro Beach", 
['DELPE'] = "Del Perro", 
['DELSOL'] = "La Puerta", 
['DESRT'] = "Grand Senora Desert", 
['DOWNT'] = "Downtown", 
['DTVINE'] = "Downtown Vinewood", 
['EAST_V'] = "East Vinewood", 
['EBURO'] = "El Burro Heights", 
['ELGORL'] = "El Gordo Lighthouse", 
['ELYSIAN'] = "Elysian Island", 
['GALFISH'] = "Galilee", 
['GOLF'] = "GWC and Golfing Society", 
['GRAPES'] = "Grapeseed", 
['GREATC'] = "Great Chaparral", 
['HARMO'] = "Harmony", 
['HAWICK'] = "Hawick", 
['HORS'] = "Vinewood Racetrack", 
['HUMLAB'] = "Humane Labs and Research", 
['JAIL'] = "Bolingbroke Penitentiary", 
['KOREAT'] = "Little Seoul", 
['LACT'] = "Land Act Reservoir", 
['LAGO'] = "Lago Zancudo", 
['LDAM'] = "Land Act Dam", 
['LEGSQU'] = "Legion Square", 
['LMESA'] = "La Mesa", 
['LOSPUER'] = "La Puerta", 
['MIRR'] = "Mirror Park", 
['MORN'] = "Morningwood", 
['MOVIE'] = "Richards Majestic", 
['MTCHIL'] = "Mount Chiliad", 
['MTGORDO'] = "Mount Gordo", 
['MTJOSE'] = "Mount Josiah", 
['MURRI'] = "Murrieta Heights", 
['NCHU'] = "North Chumash", 
['NOOSE'] = "N.O.O.S.E", 
['OCEANA'] = "Pacific Ocean", 
['PALCOV'] = "Paleto Cove", 
['PALETO'] = "Paleto Bay", 
['PALFOR'] = "Paleto Forest", 
['PALHIGH'] = "Palomino Highlands", 
['PALMPOW'] = "Palmer-Taylor Power Station", 
['PBLUFF'] = "Pacific Bluffs", 
['PBOX'] = "Pillbox Hill", 
['PROCOB'] = "Procopio Beach", 
['RANCHO'] = "Rancho", 
['RGLEN'] = "Richman Glen", 
['RICHM'] = "Richman", 
['ROCKF'] = "Rockford Hills", 
['RTRAK'] = "Redwood Lights Track", 
['SANAND'] = "San Andreas", 
['SANCHIA'] = "San Chianski Mountain Range", 
['SANDY'] = "Sandy Shores", 
['SKID'] = "Mission Row", 
['SLAB'] = "Stab City", 
['STAD'] = "Maze Bank Arena", 
['STRAW'] = "Strawberry", 
['TATAMO'] = "Tataviam Mountains", 
['TERMINA'] = "Terminal", 
['TEXTI'] = "Textile City", 
['TONGVAH'] = "Tongva Hills", 
['TONGVAV'] = "Tongva Valley", 
['VCANA'] = "Vespucci Canals", 
['VESP'] = "Vespucci", 
['VINE'] = "Vinewood",
['WINDF'] = "Ron Alternates Wind Farm", 
['WVINE'] = "West Vinewood",
['ZANCUDO'] = "Zancudo River",
['ZP_ORT'] = "Port of South Los Santos", 
['ZQ_UAR'] = "Davis Quartz" 
}


function MenuF6Immo()
    local rImmoF6 = RageUI.CreateMenu("Agent-Immo", "Interactions")
	rImmoF6:SetRectangleBanner(200, 0, 0, 254)
    RageUI.Visible(rImmoF6, not RageUI.Visible(rImmoF6))
    while rImmoF6 do
        Wait(0)
            RageUI.IsVisible(rImmoF6, true, true, true, function()

                RageUI.Separator("↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→→"}, true, function(_,_,s)
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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_realestateagent', ('Agent-Immo'), montant)
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

				RageUI.Separator('↓ Création Propriété ↓')

				RageUI.ButtonWithStyle("Commencer la création", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        aProperty()
                    end
                end)

                end, function() 
                end)
                if not RageUI.Visible(rImmoF6) then
                    rImmoF6 = RMenu:DeleteType("Agent-Immo", true)
        end
    end
end

function aProperty()
	RMenu.Add("Property", "create", RageUI.CreateMenu("Création Propriété"," "))
	RMenu:Get('Property', 'create'):SetRectangleBanner(200, 0, 0, 254)
	RMenu:Get('Property', 'create').Closed = function()
		Property = false
	end
    if not Property then 
        Property = true
		RageUI.Visible(RMenu:Get('Property', 'create'), true)

		CreateThread(function()
			while Property do
				RageUI.IsVisible(RMenu:Get("Property",'create'),true,true,true,function()
                    local pos = GetEntityCoords(PlayerPedId())
                    local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
                    local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
                        RageUI.Separator("↓ ~b~ Créer une nouvelle propriété~s~ ↓")

                        RageUI.ButtonWithStyle("Placer l'entrée de la propriété", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                            if (Selected) then
                                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}                          
                                local Out = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z+2, 4)}
                                
                                entering = json.encode(PlayerCoord)
                                outside  = json.encode(Out)
                
                                PedPosition = pos
                                DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
                                ESX.ShowNotification('position de la porte : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z.. '~w~, Adresse : ~b~'..current_zone.. '')
                                ESX.ShowNotification('position de la sortie : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z..'')
                            end
                        end)
           
                        RageUI.List('Choix d\'intérieurs :', Menu.action, Menu.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)
                            if Active then
                                if Index == 1 then             
                                    RenderSprite("RageUI", "Motel", 0, 486, 432, 250, 80)                                         
                                elseif Index == 2 then
                                    RenderSprite("RageUI", "Low", 0, 486, 432, 250, 80)                         
                                elseif Index == 3 then
                                    RenderSprite("RageUI", "Middle", 0, 486, 432, 250, 80)                                   
                                elseif Index == 4 then
                                    RenderSprite("RageUI", "Modern",0, 486, 432, 250, 80)               
                                elseif Index == 5 then
                                    RenderSprite("RageUI", "High", 0, 486, 432, 250, 80)  
                                elseif Index == 6 then
                                    RenderSprite("RageUI", "Luxe", 0, 486, 432, 250, 80)         
                                elseif Index == 7 then
                                    RenderSprite("RageUI", "Entrepot_grand", 0, 486, 432, 250, 80)             
                                elseif Index == 8 then
                                    RenderSprite("RageUI", "Entrepot_moyen", 0, 486, 432, 250, 80)  
                                elseif Index == 9 then
                                    RenderSprite("RageUI", "Entrepot_petit", 0, 486, 432, 250, 80)                                         
                                end
                            end                       
                            if (Selected) then
                                if Index == 1 then
                                    ipl = '["hei_hw1_blimp_interior_v_motel_mp_milo_"]'
                                    inside = '{"x":151.45,"y":-1007.57,"z":-98.9999}'
                                    exit = '{"x":151.3258,"y":-1007.7642,"z":-100.0000}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), 151.0994, -1007.8073, -98.9999)	

	
                                elseif Index == 2 then
                                    ipl = '[]'
                                    inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
                                    exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), 265.6031, -1002.9244, -99.0086)	

		                          
                                elseif Index == 3 then
                                    ipl = '[]'
                                    inside = '{"x":-612.16,"y":59.06,"z":97.2}'
                                    exit = '{"x":-603.4308,"y":58.9184,"z":97.2001}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), -616.8566, 59.3575, 98.2000)


                                elseif Index == 4 then
                                    ipl = '["apa_v_mp_h_01_a"]'
                                    inside = '{"x":-785.13,"y":315.79,"z":187.91}'
                                    exit = '{"x":-786.87,"y":315.7497,"z":186.91}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), -788.3881, 320.2430, 187.3132)

                               
                                elseif Index == 5 then
                                    ipl = '[]'
                                    inside = '{"x":-1459.17,"y":-520.58,"z":54.929}'
                                    exit = '{"x":-1451.6394,"y":-523.5562,"z":55.9290}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), -1459.1700, -520.5855, 56.9247) 

                                elseif Index == 6 then
                                    ipl = '[]'
                                    inside = '{"x":-680.6088,"y":590.5321,"z":145.39}'
                                    exit = '{"x":-681.6273,"y":591.9663,"z":144.3930}'				
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), -674.4503, 595.6156, 145.3796)
                                elseif Index == 7 then
                                    ipl = '[]'
                                    inside = '{"x":1026.5056,"y":-3099.8320,"z":-38.9998}'
                                    exit   = '{"x":998.1795"y":-3091.9169,"z":-39.9999}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), 1026.8707, -3099.8710, -38.9998)	
                                elseif Index == 8 then
                                    ipl = '[]'
                                    inside = '{"x":1048.5067,"y":-3097.0817,"z":-38.9999}'
                                    exit   = '{"x":1072.5505,"y":-3102.5522,"z":-39.9999}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), 1072.8447, -3100.0390, -38.9999)	
                                elseif Index == 9 then
                                    ipl = '[]'
                                    inside = '{"x":1088.1834,"y":-3099.3547,"z":-38.9999}'
                                    exit   = '{"x":1104.6102,"y":-3099.4333,"z":-39.9999}'
                                    isSingle = 1
                                    isRoom = 1
                                    isGateway = 0
                                    SetEntityCoords(PlayerPedId(), 1104.7231, -3100.0690, -38.9999)	

                                end
                            end
                            Menu.list = Index;
                        end)

                        RageUI.ButtonWithStyle("Placer l'endroit du coffre", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                            if (Selected) then
     
                                local CoffreCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 
                                roommenu = json.encode(CoffreCoord)
                                ESX.ShowNotification('Position du coffre :~b~'..CoffreCoord.x..' , '..CoffreCoord.y..' , '..CoffreCoord.z.. '')
                                DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
                            end
                        end)

                        RageUI.ButtonWithStyle("Nommé la propriété :~b~", nil, {RightLabel = name},true, function(Hovered, Active, Selected)
                            if (Selected) then
                                name  =  OpenKeyboard('name', 'Entrer un nom sans éspace !')
                            end
                        end)

                        RageUI.ButtonWithStyle("Label propriété :~b~", nil, {RightLabel = label},true, function(Hovered, Active, Selected)
                            if (Selected) then
                                label = OpenKeyboard('label', 'Entrer un label !')
                            end
                        end)

                        RageUI.ButtonWithStyle("Prix de vente :~b~", nil, {RightLabel = price},true, function(Hovered, Active, Selected)
                            if (Selected) then
                                price = OpenKeyboard('price', 'Entrer un prix')
                            end
                        end)
                        
                        RageUI.ButtonWithStyle('~r~Annuler' , nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
                            if (Selected) then
							if name == '' then 
								ESX.ShowNotification('~r~Vous n\'avez aucun nom assigné !')
							else
		    	            SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)		    	              
		    	            RageUI.CloseAll()
		    	            ESX.ShowNotification('~r~Annulation')
                            end
                        end
                        end)

                        RageUI.ButtonWithStyle('~g~Validé et créer la propriété' , nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
                            if (Selected) then
                                if tonumber(price) == nil or tonumber(price) == 0 then
                                    ESX.ShowNotification('~r~Vous n\'avez aucun prix assigné !')
                                else 
                                    if name == '' then 
                                        ESX.ShowNotification('~r~Vous n\'avez aucun nom assigné !')
                                    else 	
                                       TriggerServerEvent('mrw_prop:Save', name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, price)

                                       Wait(15)
                                       SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)
                                    end
                                end  
                            end
                        end)

            end, function()    
            end, 1)
            Wait(1)
        end
    Wait(0)
    Property = false
    end)
end
end

local function noSpace(str)
    local normalisedString = string.gsub(str, "%s+", "")
    return normalisedString
 end

function OpenKeyboard(type, labelText)
    AddTextEntry('FMMC_KEY_TIP1', labelText)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 25)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Wait(500) 
		blockinput = false 
		if type == "name" then 
			ESX.ShowNotification("Nom assigné : ~b~"..noSpace(result))
		    return noSpace(result) 
		elseif type == "label" then 
			ESX.ShowNotification("Label assigné : ~b~"..result)
			return result
		else 
		    if tonumber(result) == nil then 
		       ESX.ShowNotification("Vous devez entré un ~r~prix")
		       return
		    end	
		    ESX.ShowNotification("Prix assigné : ~b~"..tonumber(result).."~w~ $")
		    return tonumber(result)
		end
	else
		Wait(500)
		blockinput = false 
		return nil
	end
end

CreateThread(function()
    while true do
        local Timer = 0
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'realestateagent' then
        if IsControlJustPressed(1,167) then
			MenuF6Immo()
        end
	end
        Wait(Timer)
    end
end)

local function AgentImmoKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

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

local NomLabel = ''
local Pos = {
	x = '',
	y = '',
	z = ''
}
local ModelHouse = ''


function MenuDpropriete()
	local Dpropriete = RageUI.CreateMenu("Demande de propriété", " ")
	RageUI.Visible(Dpropriete, not RageUI.Visible(Dpropriete))
	while Dpropriete do
		Wait(0)
		RageUI.IsVisible(Dpropriete, true, true, true, function()
			local posped = GetEntityCoords(PlayerPedId())

			RageUI.ButtonWithStyle("Nom & Label", nil, {RightLabel = NomLabel}, true, function(Hovered, Active, Selected)
				if (Selected) then
					NomLabel = AgentImmoKeyboardInput("Veuillez indiquer le nom et le label de votre maison", "", 25)
				end
			end)

			RageUI.ButtonWithStyle("Placer le point d'entrée", "X : "..Pos.x.."\nY : "..Pos.y.."\nZ : "..Pos.z, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					Pos.x = posped.x
					Pos.y = posped.y
					Pos.z = posped.z
					ESX.ShowNotification('Position de la porte : ~b~'..Pos.x..' , '..Pos.y..' , '..Pos.z..'')
				end
			end)

			RageUI.List('Choix d\'intérieurs :', Menu.action, Menu.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)
                            if Active then
                                if Index == 1 then             
                                    RenderSprite("RageUI", "Motel", 0, 486, 432, 250, 80)                                         
                                elseif Index == 2 then
                                    RenderSprite("RageUI", "Low", 0, 486, 432, 250, 80)                         
                                elseif Index == 3 then
                                    RenderSprite("RageUI", "Middle", 0, 486, 432, 250, 80)                                   
                                elseif Index == 4 then
                                    RenderSprite("RageUI", "Modern",0, 486, 432, 250, 80)               
                                elseif Index == 5 then
                                    RenderSprite("RageUI", "High", 0, 486, 432, 250, 80)  
                                elseif Index == 6 then
                                    RenderSprite("RageUI", "Luxe", 0, 486, 432, 250, 80)         
                                elseif Index == 7 then
                                    RenderSprite("RageUI", "Entrepot_grand", 0, 486, 432, 250, 80)             
                                elseif Index == 8 then
                                    RenderSprite("RageUI", "Entrepot_moyen", 0, 486, 432, 250, 80)  
                                elseif Index == 9 then
                                    RenderSprite("RageUI", "Entrepot_petit", 0, 486, 432, 250, 80)                                         
                                end
                            end                       
                            if (Selected) then
                                if Index == 1 then
								    ModelHouse = 'Motel'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 2 then
									ModelHouse = 'Petit'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 3 then
									ModelHouse = 'Middle'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 4 then
									ModelHouse = 'Modern'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 5 then
									ModelHouse = 'High'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 6 then
									ModelHouse = 'Luxe'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 7 then
									ModelHouse = 'Entrepot (grand)'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 8 then
									ModelHouse = 'Entrepot (moyen)'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                elseif Index == 9 then
									ModelHouse = 'Entrepot (petit)'
									ESX.ShowNotification('Intérieur défini sur '..ModelHouse)
                                end
                            end
                            Menu.list = Index;
                        end)


						RageUI.ButtonWithStyle('~r~Annuler' , nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
                            if (Selected) then
							NomLabel = ''
							Pos.x = ''
							Pos.y = ''
							Pos.z = ''
							ModelHouse = ''
		    	            RageUI.CloseAll()
		    	            ESX.ShowNotification('~r~Annulation')
                        end
                    end)

					RageUI.ButtonWithStyle('~g~Validé' , nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then
							if NomLabel == '' or Pos.x == '' or ModelHouse == '' then
								ESX.ShowNotification('~r~Un ou plusieurs champs n\'ont pas été défini !')
							else
							TriggerServerEvent("Rayan:createhouse", NomLabel, Pos.x, Pos.y, Pos.z, ModelHouse)
						end
					end
				end)
		end, function() 
		end)

		if not RageUI.Visible(Dpropriete) then
			Dpropriete = RMenu:DeleteType("Dpropriete", true)
		  end
	  end
end

RegisterCommand('newpropriete', function(source, args, rawCommand)
	MenuDpropriete()
end, false)
