ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'ballas', 'alerte ballas', true, true)

TriggerEvent('esx_society:registerSociety', 'ballas', 'ballas', 'society_ballas', 'society_ballas', 'society_ballas', {type = 'public'})


ESX.RegisterServerCallback('fFouille:getOtherPlayerData', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            job2 = xPlayer.job2.label,
            grade2 = xPlayer.job2.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout(),
            height = xPlayer.get('height'),
            dob = xPlayer.get('dateofbirth')
        }

            --data.dob = xPlayer.get('dateofbirth')
            --data.height = xPlayer.get('height')
            if xPlayer.get('sex') == 'm' then data.sex = 'Homme' else data.sex = 'Femme' end

            TriggerEvent('esx_license:getLicenses', target, function(licenses)
                data.licenses = licenses
        cb(data)
        end)
    end
end)


function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end


RegisterNetEvent('fellow:handcuff')
AddEventHandler('fellow:handcuff', function(target)
  TriggerClientEvent('fellow:handcuff', target)
end)

RegisterNetEvent('fellow:drag')
AddEventHandler('fellow:drag', function(target)
  local _source = source
  TriggerClientEvent('fellow:drag', target, _source)
end)

RegisterNetEvent('fellow:putInVehicle')
AddEventHandler('fellow:putInVehicle', function(target)
  TriggerClientEvent('fellow:putInVehicle', target)
end)

RegisterNetEvent('fellow:OutVehicle')
AddEventHandler('fellow:OutVehicle', function(target)
    TriggerClientEvent('fellow:OutVehicle', target)
end)

-------------------------------- Fouiller

RegisterNetEvent('fellow:confiscatePlayerItem')
AddEventHandler('fellow:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
        else
			--TriggerClientEvent("esx:showNotification", source, "~r~Quantidade inválida")
		end
        
    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        
    end
end)

ESX.RegisterServerCallback('fellow:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~r~~Quelqu'un vous fouille")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)




