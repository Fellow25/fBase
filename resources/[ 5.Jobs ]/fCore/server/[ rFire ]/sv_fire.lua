ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'pompier', 'alerte pompier', true, true)

TriggerEvent('esx_society:registerSociety', 'fire', 'fire', 'society_fire', 'society_fire', 'society_fire', {type = 'public'})

ESX.RegisterServerCallback('rFire:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fire', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('rFire:getStockItem')
AddEventHandler('rFire:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fire', function(inventory)
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

ESX.RegisterServerCallback('rFire:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('rFire:putStockItems')
AddEventHandler('rFire:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fire', function(inventory)
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

--- Annonce

RegisterNetEvent('rFire:Ouvert')
AddEventHandler('rFire:Ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sapeur-Pompier', '~r~Informations', 'Le Sapeur-Pompier est ouvert', 'CHAR_CALL911', 2)
	end
end)

RegisterNetEvent('rFire:Fermer')
AddEventHandler('rFire:Fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sapeur-Pompier', '~r~Informations', 'Le Sapeur-Pompier est fermé', 'CHAR_CALL911', 2)
	end
end)

RegisterNetEvent('rFire:Perso')
AddEventHandler('rFire:Perso', function(msg)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Sapeur-Pompier', '~r~Annonce', msg, 'CHAR_CALL911', 8)
    end
end)


---- Demande 


local demandeTable = {}

ESX.RegisterServerCallback('rFire:infoReport', function(source, cb)
    cb(demandeTable)
end)

RegisterNetEvent("rFire:fireAppel")
AddEventHandler("rFire:fireAppel", function()
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'fire' then
            TriggerClientEvent("rFire:envoielanotif", xPlayers[i])
        end
end
end)

RegisterNetEvent("rFire:CloseReport")
AddEventHandler("rFire:CloseReport", function(nom, raison)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'fire' then
            TriggerClientEvent("rFire:envoielanotifclose", xPlayers[i], nom)
        end
end
    table.remove(demandeTable, id, nom, args, gps)
end)


RegisterCommand(Fire.CommandName, function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuMec = xPlayer.getName()
    local idDuMec = source
	local coords = xPlayer.getCoords()
    table.insert(demandeTable, {
        id = idDuMec,
        nom = NomDuMec,
        args = "Appel Pompier",
        gps = coords
    })
	TriggerClientEvent('esx:showAdvancedNotification', source, 'Sapeur-Pompier', '~r~Informations', 'Ta demande a été envoyé à tous les pompiers en ville', 'CHAR_CALL911', 2)
	TriggerEvent('rFire:fireAppel')
end, false)
