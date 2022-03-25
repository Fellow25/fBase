Cfg_Coffre.ESXLoaded = nil
Cfg_Coffre.InSide(Cfg_Coffre.ESXEvent, function(esxEvent) Cfg_Coffre.ESXLoaded = esxEvent end)

Cfg_Coffre.GetCoffreWeight = function(inv, loadout, money)
    local vWeight = 0
    for k,v in pairs(inv) do
        local itemWeight = Cfg_Coffre.defaultWeight
        if Cfg_Coffre.itemsWeight[k] ~= nil then
            itemWeight = Cfg_Coffre.itemsWeight[k]
        end
        vWeight = vWeight + (itemWeight * v.count)
    end
    for k,v in pairs(loadout) do
        local itemWeight = Cfg_Coffre.defaultWeight
        if Cfg_Coffre.itemsWeight[k] ~= nil then
            itemWeight = Cfg_Coffre.itemsWeight[k]
        end
        vWeight = vWeight + (itemWeight * v.count)
    end
    for k,v in pairs(money) do
        local itemWeight = Cfg_Coffre.defaultWeight
        if Cfg_Coffre.itemsWeight[k] ~= nil then
            itemWeight = Cfg_Coffre.itemsWeight[k]
        end
        vWeight = vWeight + (itemWeight * v.count)
    end
    return vWeight
end

RegisterNetEvent(Cfg_Coffre.Prefix..":takeVehiculeInfos")
AddEventHandler(Cfg_Coffre.Prefix..":takeVehiculeInfos",function(vPlate)
    local source = source
    local pPed = Cfg_Coffre.ESXLoaded.GetPlayerFromId(source)
    local vInfos = {
        vPlate = nil,
    }
    local pInventory = {pInventory = pPed.inventory, pLoadout = pPed.loadout, pMoney = pPed.getAccount("black_money").money} 
    MySQL.Async.fetchAll("SELECT * FROM vcoffre", {}, function(vResult)
        if vResult[1] then
            for k,v in pairs(vResult) do
                vInfos[v.vPlate] = {vPlate = v.Plate, vInventory = json.decode(v.vInventory), vLoadout = json.decode(v.vLoadout), vMoney = json.decode(v.vMoney)}
            end
        end
        if not vInfos[vPlate] then
            MySQL.Async.execute("INSERT INTO vcoffre (vPlate) VALUES (@vPlate)", {
                ["@vPlate"] = vPlate,
            })
            Cfg_Coffre.ClientSide(Cfg_Coffre.Prefix..":openCoffre", source, vInfos, vPlate, pInventory, 0)
        else
            Cfg_Coffre.ClientSide(Cfg_Coffre.Prefix..":openCoffre", source, vInfos, vPlate, pInventory, Cfg_Coffre.GetCoffreWeight(vInfos[vPlate].vInventory, vInfos[vPlate].vLoadout, vInfos[vPlate].vMoney))
        end
    end)
end)

RegisterNetEvent(Cfg_Coffre.Prefix..":putInCoffre")
AddEventHandler(Cfg_Coffre.Prefix..":putInCoffre",function(vPlate, item, label, count, type, ammo)
    local source = source
    local pPed = Cfg_Coffre.ESXLoaded.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM vcoffre WHERE vPlate = @vPlate", {["@vPlate"] = vPlate}, function(vResult)
        if vResult[1] then
            local vInventory = json.decode(vResult[1].vInventory)
            local vLoadout = json.decode(vResult[1].vLoadout)
            local vMoney = json.decode(vResult[1].vMoney)
            if type == "item" then            
                if vInventory[item] == nil then 
                    vInventory[item] = {count = count, label = label}
                else 
                    vInventory[item] = {count = vInventory[item].count + count, label = label} 
                end
            elseif type == "weapon" then
                if vLoadout[item] == nil then 
                    vLoadout[item] = {count = count, label = label}
                else 
                    vLoadout[item] = {count = vLoadout[item].count + count, label = label, ammo = ammo} 
                end
            else
                if vMoney[item] == nil then 
                    vMoney[item] = {count = 1, money = count, label = label}
                else 
                    vMoney[item] = {count = 1, money = vMoney[item].money + count, label = label} 
                end
            end
            MySQL.Async.fetchAll('UPDATE vcoffre SET vInventory=@vInventory, vLoadout=@vLoadout, vMoney=@vMoney WHERE vPlate=@vPlate', {
                ["@vPlate"] = vPlate,
                ["@vInventory"] = json.encode(vInventory), 
                ["@vLoadout"] = json.encode(vLoadout),
                ["@vMoney"] = json.encode(vMoney),
            }, function()
                if type == "item" then
                    pPed.removeInventoryItem(item, count)
                elseif type == "weapon" then
                    pPed.removeWeapon(item)
                else
                    pPed.removeAccountMoney(item, count)
                end
                local vInfos = {}
                MySQL.Async.fetchAll("SELECT * FROM vcoffre", {}, function(vResult)
                    if vResult[1] then
                        for k,v in pairs(vResult) do
                            vInfos[v.vPlate] = {vPlate = v.Plate, vInventory = json.decode(v.vInventory), vLoadout = json.decode(v.vLoadout), vMoney = json.decode(v.vMoney)}
                        end
                    end
                    local pPed = Cfg_Coffre.ESXLoaded.GetPlayerFromId(source)
                    local pInventory = {pInventory = pPed.inventory, pLoadout = pPed.loadout, pMoney = pPed.getAccount("black_money").money} 
                    Cfg_Coffre.ClientSide(Cfg_Coffre.Prefix..":refreshAll", source, vInfos, vPlate, pInventory, Cfg_Coffre.GetCoffreWeight(vInfos[vPlate].vInventory, vInfos[vPlate].vLoadout, vInfos[vPlate].vMoney))
                end)
            end)
        end
    end)
end)

RegisterNetEvent(Cfg_Coffre.Prefix..":takeInCoffre")
AddEventHandler(Cfg_Coffre.Prefix..":takeInCoffre",function(vPlate, item, label, count, type, ammo)
    local source = source
    local pPed = Cfg_Coffre.ESXLoaded.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM vcoffre WHERE vPlate = @vPlate", {["@vPlate"] = vPlate}, function(vResult)
        if vResult[1] then
            local vInventory = json.decode(vResult[1].vInventory)
            local vLoadout = json.decode(vResult[1].vLoadout)
            local vMoney = json.decode(vResult[1].vMoney)
            if type == "item" then            
                if vInventory[item] == nil then 
                    vInventory[item] = nil
                elseif vInventory[item].count - count <= 0 then
                    vInventory[item] = nil
                else 
                    vInventory[item] = {count = vInventory[item].count - count, label = label} 
                end
            elseif type == "weapon" then
                if vLoadout[item] == nil then 
                    vLoadout[item] = nil
                elseif vLoadout[item].count - count <= 0 then
                    vLoadout[item] = nil
                else 
                    vLoadout[item] = {count = vLoadout[item].count - count, label = label, ammo = ammo} 
                end
            else
                if vMoney[item] == nil then 
                    vMoney[item] = nil
                elseif vMoney[item].money - count <= 0 then
                    vMoney[item] = nil
                else 
                    vMoney[item] = {count = 1, money = vMoney[item].money - count, label = label} 
                end
            end
            MySQL.Async.fetchAll('UPDATE vcoffre SET vInventory=@vInventory, vLoadout=@vLoadout, vMoney=@vMoney WHERE vPlate=@vPlate', {
                ["@vPlate"] = vPlate,
                ["@vInventory"] = json.encode(vInventory), 
                ["@vLoadout"] = json.encode(vLoadout),
                ["@vMoney"] = json.encode(vMoney),
            }, function()
                if type == "item" then
                    pPed.addInventoryItem(item, count)
                elseif type == "weapon" then
                    pPed.addWeapon(item)
                else
                    pPed.addAccountMoney(item, count)
                end
                local vInfos = {}
                MySQL.Async.fetchAll("SELECT * FROM vcoffre", {}, function(vResult)
                    if vResult[1] then
                        for k,v in pairs(vResult) do
                            vInfos[v.vPlate] = {vPlate = v.Plate, vInventory = json.decode(v.vInventory), vLoadout = json.decode(v.vLoadout), vMoney = json.decode(v.vMoney)}
                        end
                    end
                    local pPed = Cfg_Coffre.ESXLoaded.GetPlayerFromId(source)
                    local pInventory = {pInventory = pPed.inventory, pLoadout = pPed.loadout, pMoney = pPed.getAccount("black_money").money} 
                    Cfg_Coffre.ClientSide(Cfg_Coffre.Prefix..":refreshAll", source, vInfos, vPlate, pInventory, Cfg_Coffre.GetCoffreWeight(vInfos[vPlate].vInventory, vInfos[vPlate].vLoadout, vInfos[vPlate].vMoney))
                end)
            end)
        end
    end)
end)