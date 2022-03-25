ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(100)
	end
end)

--- Blips

CreateThread(function()
       local poleemploimap = AddBlipForCoord(rPoleEmploi.pos.blips.position.x, rPoleEmploi.pos.blips.position.y, rPoleEmploi.pos.blips.position.z)
       SetBlipSprite(poleemploimap, 590)
       SetBlipColour(poleemploimap, 38)
       SetBlipAsShortRange(poleemploimap, true)
       SetBlipScale(poleemploimap, 0.65)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("Pôle emploi")
       EndTextCommandSetBlipName(poleemploimap)
end)

---- Menu

function MenuPoleEmploi()
       local MenuPole = RageUI.CreateMenu("Pôle emploi", "Voici les métiers disponible")
       local MenuPoleSub = RageUI.CreateSubMenu(MenuPole, "Métiers libre", "Pôle emploi")
       local MenuPoleSub2 = RageUI.CreateSubMenu(MenuPole, "Métiers WhiteList", "Pôle emploi")
       MenuPole.Closed = function()
        ESX.ShowNotification('À bientôt '..GetPlayerName(PlayerId()))
       end
           RageUI.Visible(MenuPole, not RageUI.Visible(MenuPole))
               while MenuPole do
               Wait(0)
               RageUI.IsVisible(MenuPole, true, true, true, function()
   
                     RageUI.Separator("~b~Bienvenue Mr. "..GetPlayerName(PlayerId()))
   
                     RageUI.ButtonWithStyle("Métiers libre", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                     end, MenuPoleSub)
                     RageUI.ButtonWithStyle("Métiers WhiteList", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                     end, MenuPoleSub2)
                   end, function()
                   end)
                   RageUI.IsVisible(MenuPoleSub, true, true, true, function()
                    RageUI.Separator('~g~↓ Voici les métiers libre ↓')
                     for k,v in pairs(rPoleEmploi.jobfree) do
                     RageUI.ButtonWithStyle(v.Nom, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                            TriggerServerEvent('rPoleEmploi:setjob',v.setjob, v.Nom)
                            end
                        end)
                     end
              end, function()
              end)
              RageUI.IsVisible(MenuPoleSub2, true, true, true, function()
                RageUI.Separator('~o~↓ Voici les métiers whitelist ↓')
                     for k,v in pairs(rPoleEmploi.jobwhitelist) do
                            RageUI.ButtonWithStyle(v.Nom, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                                   if Selected then
                                   TriggerServerEvent('rPoleEmploi:jobwhitelist', v.Nom)
                                   end
                               end)
                            end
                     end, function()
                     end)
               if not RageUI.Visible(MenuPole) and not RageUI.Visible(MenuPoleSub) and not RageUI.Visible(MenuPoleSub2) then
               MenuPole = RMenu:DeleteType("Pôle emploi", true)
           end
       end
end


CreateThread(function()
       while true do
           local Timer = 500
           local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
           local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, rPoleEmploi.pos.Menu.position.x, rPoleEmploi.pos.Menu.position.y, rPoleEmploi.pos.Menu.position.z)
               if dist3 <= 3.0 then
               Timer = 0   
                   RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder au Pôle emploi", time_display = 1 })
                   if IsControlJustPressed(1,51) then
                    TriggerEvent('esx:showAdvancedNotification', "Pôle emploi", "Recherche" , 'Recherche de vos données...', 'CHAR_POLEEMPLOI', 9)
                    Wait(2500)
                    MenuPoleEmploi()
                   end   
               end
       Wait(Timer)
    end
end)

CreateThread(function()
    local hash = GetHashKey(rPoleEmploi.Peds)
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", rPoleEmploi.Peds, rPoleEmploi.pos.Peds.position.x, rPoleEmploi.pos.Peds.position.y, rPoleEmploi.pos.Peds.position.z, rPoleEmploi.pos.Peds.position.h, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, 1)
end)