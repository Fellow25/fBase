ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'fourriere', 'alerte fourriere', true, true)

TriggerEvent('esx_society:registerSociety', 'fourriere', 'fourriere', 'society_fourriere', 'society_fourriere', 'society_fourriere', {type = 'public'})

ESX.RegisterServerCallback('gfourriere:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fourriere', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('gfourriere:getStockItem')
AddEventHandler('gfourriere:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fourriere', function(inventory)
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

ESX.RegisterServerCallback('gfourriere:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('gfourriere:putStockItems')
AddEventHandler('gfourriere:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fourriere', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification('vous avez déposé ', count, inventoryItem.name)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback("gfourriere:listevehiculefourriere", function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicules = {}

    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE `stored` = @stored", {['@stored'] = false}, function(data)
        for _, v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            local ownerCharname = GetCharName(v.owner)
            table.insert(vehicules, { vehicle = vehicle, etat = v.etat, plate = v.plate, Nomdumec = ownerCharname})
        end
        cb(vehicules)
    end)
end)


function GetCharName(identifier)
  local doing = true

  MySQL.Async.fetchAll(
  'SELECT firstname, lastname FROM users WHERE identifier = @identifier LIMIT 1',
  {
    ['@identifier'] = identifier,
  },
    function(res)
      if res[1] then
      charname = res[1].firstname .. ' ' .. res[1].lastname
      doing = false
      else
      charname = "Inconnu"
      doing = false
    end
  end
  )

  while doing do
      Wait(0)
  end

  return charname
end

local function getDate()
    return os.date("*t", os.time()).day.."/"..os.date("*t", os.time()).month.."/"..os.date("*t", os.time()).year.." à "..os.date("*t", os.time()).hour.."h"..os.date("*t", os.time()).min
end

RegisterNetEvent('gfourriere:ajoutreport')
AddEventHandler('gfourriere:ajoutreport', function(motif, agent, plaque, numeroreport, nomvoituretexte)
    MySQL.Async.execute('INSERT INTO fourriere_report (motif, agent, numeroreport, plaque, date, vehicle) VALUES (@motif, @agent, @numeroreport, @plaque, @date, @vehicle)', {
        ['@motif'] = motif,
        ['@agent'] = agent,
		['@numeroreport'] = numeroreport,
        ['@plaque'] = plaque,
		['@date'] = getDate(),
		['@vehicle'] = nomvoituretexte
    })
end)


ESX.RegisterServerCallback('gfourriere:affichereport', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local keys = {}

    MySQL.Async.fetchAll('SELECT * FROM fourriere_report', {}, 
        function(result)
        for numreport = 1, #result, 1 do
            table.insert(keys, {
                id = result[numreport].id,
                agent = result[numreport].agent,
                plaque = result[numreport].plaque,
				numeroreport = result[numreport].numeroreport,
                date = result[numreport].date,
                motif = result[numreport].motif,
                vehicle = result[numreport].vehicle
            })
        end
        cb(keys)

    end)
end)

RegisterNetEvent('gfourriere:supprimereport')
AddEventHandler('gfourriere:supprimereport', function(supprimer)
    MySQL.Async.execute('DELETE FROM fourriere_report WHERE id = @id', {
            ['@id'] = supprimer
    })
end)

RegisterNetEvent('gfourriere:ouvert')
AddEventHandler('gfourriere:ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Fourrière', '~g~Annonce', 'La fourrière est désormais ouverte', 'CHAR_FOURRIERE', 8)
	end
end)

RegisterNetEvent('gfourriere:ferme')
AddEventHandler('gfourriere:ferme', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Fourrière', '~r~Annonce', 'La fourrière est désormais fermé à plus tard!', 'CHAR_FOURRIERE', 8)
	end
end)