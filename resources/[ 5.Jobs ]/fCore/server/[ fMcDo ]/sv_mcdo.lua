ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_phone:registerNumber', 'mcdonalds', 'alerte mcdonalds', true, true)
TriggerEvent('esx_society:registerSociety', 'mcdonalds', 'mcdonalds', 'society_mcdonalds', 'society_mcdonalds', 'society_mcdonalds', {type = 'private'})


ESX.RegisterServerCallback('mcdonalds:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcdonalds', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('mcdonalds:getStockItem')
AddEventHandler('mcdonalds:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcdonalds', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('mcdonalds:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('mcdonalds:putStockItems')
AddEventHandler('mcdonalds:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcdonalds', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, inventoryItem.name))
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mcdonalds' then
			Wait(5000)
			TriggerClientEvent('esx_mcdonaldsjob:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('esx_mcdonaldsjob:spawned')
AddEventHandler('esx_mcdonaldsjob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mcdonalds' then
		Wait(5000)
		TriggerClientEvent('esx_mcdonaldsjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Wait(5000)
		TriggerClientEvent('esx_mcdonaldsjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'mcdonalds')
	end
end)

RegisterServerEvent('esx_mcdonaldsjob:message')
AddEventHandler('esx_mcdonaldsjob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterNetEvent('mcdonalds:frigo')
AddEventHandler('mcdonalds:frigo', function(ITEM,price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
		
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mcdonalds', function(account)
        societyAccount = account
    end)

    if price <= societyAccount.money then
        TriggerClientEvent('esx:showNotification', source, "~g~Achats~w~ effectué !")
        xPlayer.addInventoryItem(ITEM, 1)
        societyAccount.removeMoney(price)
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent sur l'entrprise")
    end
end)

RegisterServerEvent('AnnonceMcDonaldsOuvert')
AddEventHandler('AnnonceMcDonaldsOuvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'McDonald\'s', '~p~Annonce', 'Le McDonald\'s est désormais ~g~Ouvert~s~!', 'CHAR_MCDO', 8)
	end
end)

RegisterServerEvent('AnnonceMcDonaldsFermer')
AddEventHandler('AnnonceMcDonaldsFermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'McDonald\'s', '~p~Annonce', 'Le McDonald\'s est désormais ~r~Fermer~s~!', 'CHAR_MCDO', 8)
	end
end)

RegisterServerEvent('mcdonalds:prendreitems')
AddEventHandler('mcdonalds:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcdonalds', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('mcdonalds:stockitem')
AddEventHandler('mcdonalds:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcdonalds', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback('mcdonalds:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('mcdonalds:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcdonalds', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('mcdonalds:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_mcdonalds', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('mcdonalds:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_mcdonalds', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('mcdonalds:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_mcdonalds', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

RegisterNetEvent('craft:cheese')
AddEventHandler('craft:cheese', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local steak = xPlayer.getInventoryItem('steak').count
    local doublecheese = xPlayer.getInventoryItem('doublecheese').count

    if doublecheese > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif steak < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de steak pour cuisiner')
    else
        xPlayer.removeInventoryItem('steak', 1)
        xPlayer.addInventoryItem('doublecheese', 1)    
    end
end)

RegisterNetEvent('craft:nuggets')
AddEventHandler('craft:nuggets', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pouletdroifcongeler = xPlayer.getInventoryItem('pouletdroifcongeler').count
    local vingtnuggets = xPlayer.getInventoryItem('vingtnuggets').count

    if vingtnuggets > 60 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif pouletdroifcongeler < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de poulet pour cuisiner')
    else
        xPlayer.removeInventoryItem('pouletdroifcongeler', 1)
        xPlayer.addInventoryItem('vingtnuggets', 1)    
    end
end)

RegisterNetEvent('craft:galette')
AddEventHandler('craft:galette', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local ptwrap = xPlayer.getInventoryItem('ptwrap').count
    local ptitwrap = xPlayer.getInventoryItem('ptitwrap').count

    if ptitwrap > 60 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif ptwrap < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de galette pour cuisiner')
    else
        xPlayer.removeInventoryItem('ptwrap', 1)
        xPlayer.addInventoryItem('ptitwrap', 1)    
    end
end)

RegisterNetEvent('craft:potatos')
AddEventHandler('craft:potatos', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local potatoescru = xPlayer.getInventoryItem('potatoescru').count
    local potatoes = xPlayer.getInventoryItem('potatoes').count

    if potatoes > 60 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif potatoescru < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de potatoes surgelé pour cuisiner')
    else
        xPlayer.removeInventoryItem('potatoescru', 1)
        xPlayer.addInventoryItem('potatoes', 1)    
    end
end)

RegisterNetEvent('craft:frites')
AddEventHandler('craft:frites', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local fritesfritecru = xPlayer.getInventoryItem('fritesfritecru').count
    local frites = xPlayer.getInventoryItem('frites').count

    if frites > 60 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif fritesfritecru < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de frite surgelé pour cuisiner')
    else
        xPlayer.removeInventoryItem('fritesfritecru', 1)
        xPlayer.addInventoryItem('frites', 1)    
    end
end)

local commande = {}

ESX.RegisterServerCallback('fMcDo:infocommande', function(source, cb)
    cb(commande)
end)

RegisterServerEvent("fMcDo:nouvellecommande")
AddEventHandler("fMcDo:nouvellecommande", function()
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'mcdonalds' then
            TriggerClientEvent("fMcDo:envoielanotif", xPlayers[i])
        end
end
end)

RegisterServerEvent("fMcDo:closecommande")
AddEventHandler("fMcDo:closecommande", function(nom, raison)
    table.remove(commande, id, nom, args, detaillecommande)
end)


RegisterServerEvent("fMcDo:addcommande")
AddEventHandler("fMcDo:addcommande", function(lacommande)
	local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuMec = xPlayer.getName()
    local idDuMec = source
    table.insert(commande, {
        nom = NomDuMec,
		id = idDuMec,
        args = "Commande McDonalds Drive",
        detaillecommande = lacommande
    })
	TriggerClientEvent('esx:showAdvancedNotification', source, 'McDonalds', '~r~Commande', 'Votre commande a bien été envoyer!', 'CHAR_MCDO', 2)
	TriggerEvent('fMcDo:nouvellecommande')
end)
