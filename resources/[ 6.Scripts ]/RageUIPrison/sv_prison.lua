ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterNetEvent('bnj:hasItem')
AddEventHandler('bnj:hasItem', function(coord)
    local amount = Config.ticketSortie
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('ticket').count >= amount then
        xPlayer.removeInventoryItem('ticket', amount)
        TriggerClientEvent('bnj:sortiePrison', source, coord)
        TriggerClientEvent('esx:showNotification', source, 'Vous êtes libre!')
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Retourne travailler !')
    end
end)


RegisterNetEvent('bnj:GivePrsnPain') 
AddEventHandler('bnj:GivePrsnPain', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local object = xPlayer.getInventoryItem('ticket').count
    if object >= 20 then
        xPlayer.removeInventoryItem('ticket', 20)
        xPlayer.addInventoryItem('bread', 1)
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheter du ~y~pain')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de tickets')
    end
end)

RegisterNetEvent('bnj:GivePrsnEau') 
AddEventHandler('bnj:GivePrsnEau', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local object = xPlayer.getInventoryItem('ticket').count
    if object >= 20 then
        xPlayer.removeInventoryItem('ticket', 20)
        xPlayer.addInventoryItem('water', 1)
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheter de ~b~l\'eau')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de tickets')
    end
end)

RegisterNetEvent('bnj:GivePrsnCouteau') 
AddEventHandler('bnj:GivePrsnCouteau', function(name, price)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local object = xPlayer.getInventoryItem('ticket').count
    --if xPlayer.hasWeapon(name) then
    if xPlayer.getInventoryItem(name).count >= 1 then    
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez déjà cet arme')
    else
        if object >= price then
            xPlayer.removeInventoryItem('ticket', price)
            --xPlayer.addWeapon(name, 1)
            xPlayer.addInventoryItem(name, 1)
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheter une ~b~arme blanche')
        else
            TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de tickets')
        end 
    end
end)
RegisterNetEvent('bnj:collectionner') 
AddEventHandler('bnj:collectionner', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local object = xPlayer.getInventoryItem('carparts').count
  --  if object < 40 then
    --if xPlayer.job.name == 'recycleur' then
        TriggerClientEvent('bnj:traitement2', _source)
        TriggerClientEvent('traitement', _source)
        TriggerClientEvent('bnj:craft', _source)
        TriggerClientEvent('bnj:craft2', _source)
        Wait(1000)
        local nombre = math.random(4)
        xPlayer.addInventoryItem('carparts', nombre)
        TriggerClientEvent('bnj:collecte', _source)

        TriggerClientEvent('esx:showNotification', _source, 'collectées ~y~'.. nombre .. ' objets')
   -- else
   -- TriggerClientEvent('bnj:notif', _source)
   -- TriggerClientEvent('esx:showNotification', _source, '~y~Vous n\'avez pas de place pour plus d\'objets!')   
   -- end 
end)
RegisterNetEvent('bnj:skup') 
AddEventHandler('bnj:skup', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local objet = xPlayer.getInventoryItem('carparts').count

    if objet >= 1 then 
        xPlayer.removeInventoryItem('carparts', ESX.Math.Round(objet / 4))
        TriggerClientEvent('bnj:vente', _source)
        Wait(3000)
        xPlayer.removeInventoryItem('carparts', ESX.Math.Round(objet / 4))
        TriggerClientEvent('bnj:vente', _source)
        Wait(3000)
        xPlayer.removeInventoryItem('carparts', ESX.Math.Round(objet / 4))
        TriggerClientEvent('bnj:vente', _source)
        Wait(3000)
        local objet2 = xPlayer.getInventoryItem('carparts').count
        xPlayer.removeInventoryItem('carparts', objet2)
        TriggerClientEvent('bnj:vente', _source)
        Wait(3000)
        xPlayer.addInventoryItem('ticket', 5)
        TriggerClientEvent('bnj:propa', _source)
    end 
end)
