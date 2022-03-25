ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_phone:registerNumber', 'tabac', 'alerte tabac', true, true)
TriggerEvent('esx_society:registerSociety', 'tabac', 'tabac', 'society_tabac', 'society_tabac', 'society_tabac', {type = 'private'})


ESX.RegisterServerCallback('ftabac:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('ftabac:getStockItem')
AddEventHandler('ftabac:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
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

ESX.RegisterServerCallback('ftabac:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('ftabac:putStockItems')
AddEventHandler('ftabac:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
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
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'tabac' then
			Wait(5000)
			TriggerClientEvent('esx_tabacjob:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('esx_tabacjob:spawned')
AddEventHandler('esx_tabacjob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'tabac' then
		Wait(5000)
		TriggerClientEvent('esx_tabacjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Wait(5000)
		TriggerClientEvent('esx_tabacjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'tabac')
	end
end)

RegisterServerEvent('esx_tabacjob:message')
AddEventHandler('esx_tabacjob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterServerEvent('AnnonceTabacOuvert')
AddEventHandler('AnnonceTabacOuvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Tabac', '~g~Annonce', 'Venez gouter les meilleurs cigarette de la ville!', 'HC_N_KAR', 8)
	end
end)

RegisterServerEvent('AnnonceTabacFermer')
AddEventHandler('AnnonceTabacFermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Tabac', '~g~Annonce', 'Le tabac est désormais fermé à plus tard!', 'HC_N_KAR', 8)
	end
end)

RegisterServerEvent('tabac:prendreitems')
AddEventHandler('tabac:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
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


RegisterNetEvent('tabac:stockitem')
AddEventHandler('tabac:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
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


ESX.RegisterServerCallback('tabac:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('tabac:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('tabac:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_tabac', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('tabac:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_tabac', function(store)
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

ESX.RegisterServerCallback('tabac:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_tabac', function(store)
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

RegisterNetEvent('tabac')
AddEventHandler('tabac', function()
    local item = "tabac"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tabacsec')
AddEventHandler('tabacsec', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local tabac = xPlayer.getInventoryItem('tabac').count
    local tabacsec = xPlayer.getInventoryItem('tabacsec').count

    if tabacsec > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de tabac sec...')
    elseif tabac < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de tabac pour traiter...')
    else
        xPlayer.removeInventoryItem('tabac', 1)
        xPlayer.addInventoryItem('tabacsec', 1)    
    end
end)

RegisterNetEvent('malboro')
AddEventHandler('malboro', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local tabacsec = xPlayer.getInventoryItem('tabacsec').count
    local malboro = xPlayer.getInventoryItem('malboro').count

    if malboro > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de malboro...')
    elseif tabacsec < 5 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de tabac sec pour traiter...')
    else
        xPlayer.removeInventoryItem('tabacsec', 5)
        xPlayer.addInventoryItem('malboro', 1)    
    end
end)

RegisterNetEvent('ventemalboro')
AddEventHandler('ventemalboro', function()

    local money = math.random(1000,2000)
    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil
    local malboro = 0

    if xPlayer.getInventoryItem('malboro').count <= 0 then
        malboro = 0
    else
        malboro = 1
    end

    if malboro == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de malboro pour vendre...')
        return
    elseif xPlayer.getInventoryItem('malboro').count <= 0 and argent == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de malboro pour vendre...')
        malboro = 0
        return
    elseif malboro == 1 then
            local money = math.random(tabac.ventemin,tabac.ventemax)
            xPlayer.removeInventoryItem('malboro', 1)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_tabac', function(account)
                societyAccount = account
            end)
            if societyAccount ~= nil then
                societyAccount.addMoney(money)
				xPlayer.addAccountMoney('money', tabac.argentjoueur)
                TriggerClientEvent('esx:showNotification', source, "~g~Vendue avec sucess...")
            end
        end
        end) 

ESX.RegisterUsableItem('malboro', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local smoke = xPlayer.getInventoryItem('malboro')

	xPlayer.removeInventoryItem('malboro', 1)
	TriggerClientEvent('f:startSmoke', source)
end)