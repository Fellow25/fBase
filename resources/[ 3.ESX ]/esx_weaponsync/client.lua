ESX = nil

local Weapons = {}
local AmmoTypes = {}

local PlayerData = nil
local AmmoInClip = {}

local CurrentWeapon = nil

local IsShooting = false
local AmmoBefore = 0

for name,item in pairs(Config.Weapons) do
  Weapons[GetHashKey(name)] = item
end

for name,item in pairs(Config.AmmoTypes) do
  AmmoTypes[GetHashKey(name)] = item
end

CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(200)
  end
end)

function GetAmmoItemFromHash(hash)
  for name,item in pairs(Config.Weapons) do
    if hash == GetHashKey(item.name) then
      if item.ammo then
        return item.ammo
      else
        return nil
      end
    end
  end
  return nil
end

function GetInventoryItem(name)
  local inventory = PlayerData.inventory
  for i=1, #inventory, 1 do
    if inventory[i].name == name then
      return inventory[i]
    end
  end
  return nil
end

function RebuildLoadout()
  
  while not PlayerData do
    Wait(200)
  end
  
  local playerPed = PlayerPedId()

  for weaponHash,v in pairs(Weapons) do
    local item = GetInventoryItem(v.item)
    if item and item.count > 0 then
      local ammo = 0
      local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

      if ammoType and AmmoTypes[ammoType] then
        local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
        if ammoItem then
          ammo = ammoItem.count
        end
      end

      if item.name == "fireextinguisher" then
        ammo = 1000
      end
      
      if HasPedGotWeapon(playerPed, weaponHash, false) then
        if GetAmmoInPedWeapon(playerPed, weaponHash) ~= ammo then
          SetPedAmmo(playerPed, weaponHash, ammo)
        end
      else
        -- Weapon is missing, give it to the player
        GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
      end
    elseif HasPedGotWeapon(playerPed, weaponHash, false) then
      -- Weapon doesn't belong in loadout
      RemoveWeaponFromPed(playerPed, weaponHash)
    end
  end

end

function RemoveUsedAmmo()  
  local playerPed = PlayerPedId()
  local AmmoAfter = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
  local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
  
  if ammoType and ammoType.item then
    local ammoDiff = AmmoBefore - AmmoAfter
    if ammoDiff > 0 then
      TriggerServerEvent('esx:discardInventoryItem', ammoType.item, ammoDiff)
    end
  end

  return AmmoAfter
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  RebuildLoadout()
end)

RegisterNetEvent('esx:modelChanged')
AddEventHandler('esx:modelChanged', function()
  RebuildLoadout()
end)

AddEventHandler('playerSpawned', function()
  RebuildLoadout()
end)

AddEventHandler('skinchanger:modelLoaded', function()
  RebuildLoadout()
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(name, count)
  Wait(1) -- Wait a tick to make sure ESX has updated PlayerData
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
  if CurrentWeapon then
    AmmoBefore = GetAmmoInPedWeapon(PlayerPedId(), CurrentWeapon)
  end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(name, count)
  Wait(1) -- Wait a tick to make sure ESX has updated PlayerData
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
  if CurrentWeapon then
    AmmoBefore = GetAmmoInPedWeapon(PlayerPedId(), CurrentWeapon)
  end
end)

CreateThread(function()
  while true do
    Wait(200)
    
    local playerPed = PlayerPedId()

    if CurrentWeapon ~= GetSelectedPedWeapon(playerPed) then
      IsShooting = false
      RemoveUsedAmmo()
      CurrentWeapon = GetSelectedPedWeapon(playerPed)
      AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
    end

    if IsPedShooting(playerPed) and not IsShooting then
      IsShooting = true
    elseif IsShooting and IsControlJustReleased(0, 24) then
      IsShooting = false
      AmmoBefore = RemoveUsedAmmo()
    elseif not IsShooting and IsControlJustPressed(0, 45) then
      AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
    end
  end
end)