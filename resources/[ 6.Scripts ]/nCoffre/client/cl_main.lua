CreateThread(function()
    Cfg_Coffre.prt(Cfg_Coffre.Credit)
    while Cfg_Coffre.ESXLoaded == nil do
		Cfg_Coffre.InSide(Cfg_Coffre.ESXEvent, function(esxEvent) Cfg_Coffre.ESXLoaded = esxEvent end)
		Wait(0)
    end
    RegisterNetEvent(Cfg_Coffre.Prefix..":refreshAll")
    AddEventHandler(Cfg_Coffre.Prefix..":refreshAll", function(vInfos, vPlate, pInventory, vWeight, pMoney)
        Cfg_Coffre.vInfos = vInfos
        Cfg_Coffre.vPlate = vPlate
        Cfg_Coffre.pInventory = pInventory
        Cfg_Coffre.vWeight = vWeight
    end)
    RegisterNetEvent(Cfg_Coffre.Prefix..":openCoffre")
    AddEventHandler(Cfg_Coffre.Prefix..":openCoffre", function(vInfos, vPlate, pInventory, vWeight)
        RMenu.Add("nCoffre", "main_menu", RageUI.CreateMenu("Coffre véhicule","INTÉRACTIONS"))
        RMenu.Add("nCoffre", "menu_put", RageUI.CreateSubMenu(RMenu:Get("nCoffre", "main_menu"), "Coffre | Déposer", "INTÉRACTIONS"))
        RMenu.Add("nCoffre", "menu_take", RageUI.CreateSubMenu(RMenu:Get("nCoffre", "main_menu"), "Coffre | Retirer", "INTÉRACTIONS"))
        RMenu:Get("nCoffre", "main_menu").Closed = function()
            Cfg_Coffre.main_Menu.menuIsOpen = false 
        end
        if Cfg_Coffre.main_Menu.menuIsOpen then
            RageUI.CloseAll()
            Cfg_Coffre.main_Menu.menuIsOpen = false
        else
            Cfg_Coffre.main_Menu.menuIsOpen = true
            RageUI.Visible(RMenu:Get("nCoffre", "main_menu"), true)
            CreateThread(function()
                if Cfg_Coffre.vClass == nil then Cfg_Coffre.vClass = 0 end
                Cfg_Coffre.vInfos = vInfos
                Cfg_Coffre.vPlate = vPlate
                Cfg_Coffre.pInventory = pInventory
                Cfg_Coffre.vWeight = vWeight
                Cfg_Coffre.changeColorIndex()
                while Cfg_Coffre.main_Menu.menuIsOpen do
                    Wait(0)
                    RageUI.IsVisible(RMenu:Get("nCoffre", "main_menu"), function()
                        if Cfg_Coffre.main_Menu.Colors ~= nil then
                            RageUI.Separator("Poids du coffre : "..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors]..Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.vWeight/1000, 1).."~s~/"..Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.maxWeight[Cfg_Coffre.vClass]/1000, 1)..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors].." - KG")
                            RageUI.Separator("Plaque du véhicule : "..Cfg_Coffre.main_Menu.Colors[Cfg_Coffre.main_Menu.MainColors]..Cfg_Coffre.vPlate)
                            RageUI.Button(Cfg_Coffre.main_Menu.Colors[Cfg_Coffre.main_Menu.MainColors].." →→ ~s~ Déposer dans le coffre", nil, {}, true, {
                                onSelected = function()
                                    Cfg_Coffre.main_Menu.totalCount = 0
                                end
                            }, RMenu:Get("nCoffre", "menu_put"))
                            RageUI.Button(Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors].." →→ ~s~ Retirer dans le coffre", nil, {}, true, {
                                onSelected = function()
                                    Cfg_Coffre.main_Menu.totalCount = 0
                                end
                            }, RMenu:Get("nCoffre", "menu_take"))
                        end
                    end)
                    RageUI.IsVisible(RMenu:Get("nCoffre", "menu_put"), function()
                        RageUI.List("Trier votre inventaire", {"Objet", "Argent"}, Cfg_Coffre.main_Menu.trIndex, nil, {}, true, {
                            onListChange = function(Index, Items)
                                Cfg_Coffre.main_Menu.trIndex = Index
                                Cfg_Coffre.main_Menu.totalCount = 0
                            end,
                            onSelected = function()
                            end,
                        })
                        if Cfg_Coffre.main_Menu.trIndex == 1 then
                            for k,v in pairs(Cfg_Coffre.pInventory.pInventory) do
                                if v.count > 0 then
                                    Cfg_Coffre.main_Menu.totalCount = Cfg_Coffre.main_Menu.totalCount+1
                                    local wItems = {}
                                    wItems[k] = Cfg_Coffre.defaultWeight
                                    if Cfg_Coffre.itemsWeight[v.name] ~= nil then
                                        wItems[k] = Cfg_Coffre.itemsWeight[v.name]
                                    end
                                    RageUI.Button("["..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors]..v.count.."~s~] - "..v.label, nil, {RightLabel = "→→"}, true, {
                                        onSelected = function()
                                            local countPut = Cfg_Coffre.KeyboardAmount()
                                            if countPut ~= nil then
                                                if countPut <= v.count then
                                                    if Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.vWeight/1000+wItems[k]*countPut/1000, 1) <= Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.maxWeight[Cfg_Coffre.vClass]/1000, 1) then
                                                        Cfg_Coffre.ServerSide(Cfg_Coffre.Prefix..":putInCoffre", Cfg_Coffre.vPlate, v.name, v.label, countPut, "item", nil)
                                                        Visual.Popup({message = "~b~COFFRE~s~\n- Vous avez déposé~b~ "..countPut.."~s~ - "..v.label.." dans le coffre du véhicule."})
                                                    else
                                                        Visual.Popup({message = "~b~COFFRE~s~\n- Votre coffre n'a pas ou a atteint les capacités nécessaires pour stocker cet objet."})
                                                    end
                                                else
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                                end
                                            else
                                                Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                            end
                                        end
                                    })
                                end
                            end
                        --[[elseif Cfg_Coffre.main_Menu.trIndex == 2 then
                            for k,v in pairs(Cfg_Coffre.pInventory.pLoadout) do
                                Cfg_Coffre.main_Menu.totalCount = Cfg_Coffre.main_Menu.totalCount+1
                                local wItems = {}
                                wItems[k] = Cfg_Coffre.defaultWeight
                                if Cfg_Coffre.itemsWeight[v.name] ~= nil then
                                    wItems[k] = Cfg_Coffre.itemsWeight[v.name]
                                end
                                RageUI.Button("["..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors]..k.."~s~] - "..v.label, nil, {RightLabel = "→→"}, true, {
                                    onSelected = function()
                                        local itemWeight = Cfg_Coffre.defaultWeight
                                        if Cfg_Coffre.itemsWeight[v.name] ~= nil then
                                            itemWeight = Cfg_Coffre.itemsWeight[v.name]
                                        end
                                        if Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.vWeight/1000+wItems[k]/1000, 1) <= Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.maxWeight[Cfg_Coffre.vClass]/1000, 1) then
                                            Cfg_Coffre.ServerSide(Cfg_Coffre.Prefix..":putInCoffre", Cfg_Coffre.vPlate, v.name, v.label, 1, "weapon", v.ammo)
                                            Visual.Popup({message = "~b~COFFRE~s~\n- Vous avez déposé~b~ 1~s~ - "..v.label.." dans le coffre du véhicule."})
                                        else
                                            Visual.Popup({message = "~b~COFFRE~s~\n- Votre coffre n'a pas ou a atteint les capacités nécessaires pour stocker cet objet."})
                                        end
                                    end
                                })
                            end]]
                        else
                            if tonumber(Cfg_Coffre.pInventory.pMoney) > 0 then
                                Cfg_Coffre.main_Menu.totalCount = Cfg_Coffre.main_Menu.totalCount+1
                                local wItems = {}
                                wItems["black_money"] = Cfg_Coffre.defaultWeight
                                if Cfg_Coffre.itemsWeight["black_money"] ~= nil then
                                    wItems["black_money"] = Cfg_Coffre.itemsWeight["black_money"]
                                end
                                RageUI.Button("["..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors]..tonumber(Cfg_Coffre.pInventory.pMoney).."$~s~] - Argent sale", nil, {RightLabel = "→→"}, true, {
                                    onSelected = function()
                                        local countPut = Cfg_Coffre.KeyboardAmount()
                                        if countPut ~= nil then
                                            if countPut <= tonumber(Cfg_Coffre.pInventory.pMoney) then
                                                local itemWeight = Cfg_Coffre.defaultWeight
                                                if Cfg_Coffre.itemsWeight["black_money"] ~= nil then
                                                    itemWeight = Cfg_Coffre.itemsWeight["black_money"]
                                                end
                                                if Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.vWeight/1000+wItems["black_money"]/1000, 1) <= Cfg_Coffre.ESXLoaded.Math.Round(Cfg_Coffre.maxWeight[Cfg_Coffre.vClass]/1000, 1) then
                                                    Cfg_Coffre.ServerSide(Cfg_Coffre.Prefix..":putInCoffre", Cfg_Coffre.vPlate, "black_money", "Argent sale", countPut, "money", nil)
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Vous avez déposé~b~ "..countPut.."$~s~ - d'argent sale dans le coffre du véhicule."})
                                                else
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Votre coffre n'a pas ou a atteint les capacités nécessaires pour stocker cet objet."})
                                                end
                                            else
                                                Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                            end
                                        else
                                            Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                        end
                                    end
                                })
                            end
                        end
                        if Cfg_Coffre.main_Menu.totalCount == 0 then
                            RageUI.Separator("")
                            RageUI.Separator(Cfg_Coffre.main_Menu.Colors[Cfg_Coffre.main_Menu.MainColors].."Cette partie de l'inventaire est vide !")
                            RageUI.Separator("") 
                        end
                    end)
                    RageUI.IsVisible(RMenu:Get("nCoffre", "menu_take"), function()
                        RageUI.List("Trier le coffre", {"Objet", "Arme", "Argent"}, Cfg_Coffre.main_Menu.trIndex, nil, {}, true, {
                            onListChange = function(Index, Items)
                                Cfg_Coffre.main_Menu.trIndex = Index
                                Cfg_Coffre.main_Menu.totalCount = 0
                            end,
                            onSelected = function()
                            end,
                        })
                        if Cfg_Coffre.vInfos[Cfg_Coffre.vPlate] ~= nil then
                            if Cfg_Coffre.main_Menu.trIndex == 1 then
                                for k,v in pairs(Cfg_Coffre.vInfos[Cfg_Coffre.vPlate].vInventory) do
                                    Cfg_Coffre.main_Menu.totalCount = Cfg_Coffre.main_Menu.totalCount+1
                                    local wItems = {}
                                    wItems[k] = Cfg_Coffre.defaultWeight
                                    if Cfg_Coffre.itemsWeight[v.name] ~= nil then
                                        wItems[k] = Cfg_Coffre.itemsWeight[v.name]
                                    end
                                    RageUI.Button("["..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors]..v.count.."~s~] - "..v.label.." || ~b~"..Cfg_Coffre.ESXLoaded.Math.Round(wItems[k]/1000*v.count, 1).."KG", nil, {RightLabel = "→→"}, true, {
                                        onSelected = function()
                                            local countPut = Cfg_Coffre.KeyboardAmount()
                                            if countPut ~= nil then
                                                if countPut <= v.count then
                                                    Cfg_Coffre.ServerSide(Cfg_Coffre.Prefix..":takeInCoffre", Cfg_Coffre.vPlate, k, v.label, countPut, "item")
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Vous avez retiré~b~ "..countPut.."~s~ - "..v.label.." dans le coffre du véhicule."})
                                                else
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                                end
                                            else
                                                Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                            end
                                        end
                                    })
                                end
                            elseif Cfg_Coffre.main_Menu.trIndex == 2 then
                                for k,v in pairs(Cfg_Coffre.vInfos[Cfg_Coffre.vPlate].vLoadout) do
                                    Cfg_Coffre.main_Menu.totalCount = Cfg_Coffre.main_Menu.totalCount+1
                                    local wItems = {}
                                    wItems[k] = Cfg_Coffre.defaultWeight
                                    if Cfg_Coffre.itemsWeight[v.name] ~= nil then
                                        wItems[k] = Cfg_Coffre.itemsWeight[v.name]
                                    end
                                    RageUI.Button("["..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors]..v.count.."~s~] - "..v.label.." || ~b~"..Cfg_Coffre.ESXLoaded.Math.Round(wItems[k]/1000*v.count, 1).."KG", nil, {RightLabel = "→→"}, true, {
                                        onSelected = function()
                                            local countPut = Cfg_Coffre.KeyboardAmount()
                                            if countPut ~= nil then
                                                if countPut <= v.count then
                                                    Cfg_Coffre.ServerSide(Cfg_Coffre.Prefix..":takeInCoffre", Cfg_Coffre.vPlate, k, v.label, countPut, "weapon")
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Vous avez retiré~b~ "..countPut.."~s~ - "..v.label.." dans le coffre du véhicule."})
                                                else
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                                end
                                            else
                                                Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                            end
                                        end
                                    })
                                end
                            else
                                for k,v in pairs(Cfg_Coffre.vInfos[Cfg_Coffre.vPlate].vMoney) do
                                    Cfg_Coffre.main_Menu.totalCount = Cfg_Coffre.main_Menu.totalCount+1
                                    local wItems = {}
                                    wItems["black_money"] = Cfg_Coffre.defaultWeight
                                    if Cfg_Coffre.itemsWeight["black_money"] ~= nil then
                                        wItems["black_money"] = Cfg_Coffre.itemsWeight["black_money"]
                                    end
                                    RageUI.Button("["..Cfg_Coffre.main_Menu.ColorsTwo[Cfg_Coffre.main_Menu.MainColors]..v.money.."$~s~] - "..v.label.." || ~b~"..Cfg_Coffre.ESXLoaded.Math.Round(wItems[k]/1000, 1).."KG", nil, {RightLabel = "→→"}, true, {
                                        onSelected = function()
                                            local countPut = Cfg_Coffre.KeyboardAmount()
                                            if countPut ~= nil then
                                                if countPut <= v.money then
                                                    Cfg_Coffre.ServerSide(Cfg_Coffre.Prefix..":takeInCoffre", Cfg_Coffre.vPlate, k, v.label, countPut, "money")
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Vous avez retiré~b~ "..countPut.."$~s~ - "..v.label.." dans le coffre du véhicule."})
                                                else
                                                    Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                                end
                                            else
                                                Visual.Popup({message = "~b~COFFRE~s~\n- Veuillez saisir une quantité valide !"})
                                            end
                                        end
                                    })
                                end
                            end
                        end
                        if Cfg_Coffre.main_Menu.totalCount == 0 then
                            RageUI.Separator("")
                            RageUI.Separator(Cfg_Coffre.main_Menu.Colors[Cfg_Coffre.main_Menu.MainColors].."Cette partie du coffre est vide !")
                            RageUI.Separator("") 
                        end
                    end)
                end
            end)
        end
    end)
    Cfg_Coffre.KeyboardAmount = function()
        local amount = nil
        AddTextEntry("CUSTOM_AMOUNT", "Montant")
        DisplayOnscreenKeyboard(1, "CUSTOM_AMOUNT", '', "", '', '', '', 15)
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Wait(0)
        end
        if UpdateOnscreenKeyboard() ~= 2 then
            amount = GetOnscreenKeyboardResult()
            Wait(1)
        else
            Wait(1)
        end
        return tonumber(amount)
    end
    Cfg_Coffre.changeColorIndex = function()
        CreateThread(function()
            Cfg_Coffre.main_Menu.Colors = {"~p~", "~r~","~o~","~y~","~c~","~g~","~b~"}
            Cfg_Coffre.main_Menu.ColorsTwo = {"~r~", "~p~","~y~","~o~","~g~","~c~","~b~"}
            Cfg_Coffre.main_Menu.MainColors = 1
            while Cfg_Coffre.main_Menu.menuIsOpen do 
                Wait(500)
                Cfg_Coffre.main_Menu.MainColors = Cfg_Coffre.main_Menu.MainColors + 1
                if Cfg_Coffre.main_Menu.MainColors > #Cfg_Coffre.main_Menu.Colors then Cfg_Coffre.main_Menu.MainColors = 1 end
            end
        end)
    end
    RegisterCommand("openCoffre", function()
        local pCoords = GetEntityCoords(PlayerPedId(), true)
        local pVehicule, vDistance = Cfg_Coffre.ESXLoaded.Game.GetClosestVehicle({x = pCoords.x, y = pCoords.y, z = pCoords.z})
        local vPlate = GetVehicleNumberPlateText(pVehicule)
        local vClass = GetVehicleClass(pVehicule)
        if IsPedInAnyVehicle(PlayerPedId(),  false) then return end
        if GetVehicleDoorLockStatus(pVehicule) ~= 2 then
            if vDistance < 2.5 then
                Cfg_Coffre.ServerSide(Cfg_Coffre.Prefix..":takeVehiculeInfos", vPlate)
                Cfg_Coffre.vClass = vClass
            else
                Visual.Popup({message = "~b~COFFRE~s~\n- Aucun véhicule à proximité !"})
            end
        else
            Visual.Popup({message = "~b~COFFRE~s~\n- Le coffre du véhicule est fermer !"})
            return
        end
    end)
    RegisterKeyMapping("openCoffre", "Coffre véhicule", "keyboard", "K")
end)