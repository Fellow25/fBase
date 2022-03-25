ESX = nil
position = {}

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)



RegisterNetEvent("barbershop:pay")
AddEventHandler("barbershop:pay", function(source, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if (price > 0) then
        xPlayer.removeMoney(price)
        xPlayer.showNotification(_U('paid', price))
    end
end)


ESX.RegisterServerCallback('barbershop:checkposition', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        cb(false)
    else
        table.insert(position, identifier)
        cb(true)
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        if identifier == position[1] then
            table.remove(position, 1)
        end
    end
end)

RegisterNetEvent('barbershop:removeposition')
AddEventHandler('barbershop:removeposition', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        if identifier == position[1] then
            table.remove(position, 1)
        end
    end
end)