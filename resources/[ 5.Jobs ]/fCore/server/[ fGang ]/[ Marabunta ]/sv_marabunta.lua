ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'marabunta', 'alerte marabunta', true, true)

TriggerEvent('esx_society:registerSociety', 'marabunta', 'marabunta', 'society_marabunta', 'society_marabunta', 'society_marabunta', 'society_marabunta_black', {type = 'public'})

ESX.RegisterServerCallback('marabunta:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_marabunta', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('marabunta:getStockItem')
AddEventHandler('marabunta:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_marabunta', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification("Vous avez retiré "..count.." "..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('marabunta:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('marabunta:putStockItems')
AddEventHandler('marabunta:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_marabunta', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification("Vous avez déposé "..count.." "..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('marabunta:getPlayerInventoryBlack', function(source, cb)
	local _source = source
	local xPlayer    = ESX.GetPlayerFromId(_source)
	local blackMoney = xPlayer.getAccount('black_money').money
  
	cb({
	  blackMoney = blackMoney
	})
  end)

RegisterNetEvent('marabunta:putblackmoney')
AddEventHandler('marabunta:putblackmoney', function(type, item, count)

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then

      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_marabunta_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end
end)


  ESX.RegisterServerCallback('marabunta:getBlackMoneySociety', function(source, cb)
    local _source = source
    local xPlayer    = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_marabunta_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

  RegisterNetEvent('marabunta:getItem')
  AddEventHandler('marabunta:getItem', function(type, item, count)
  
    local _source      = source
    local xPlayer      = ESX.GetPlayerFromId(_source)
  
    if type == 'item_account' then
  
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_marabunta_black', function(account)
  
        local roomAccountMoney = account.money
  
        if roomAccountMoney >= count then
          account.removeMoney(count)
          xPlayer.addAccountMoney(item, count)
        else
          TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end
  
      end)
    end
end)