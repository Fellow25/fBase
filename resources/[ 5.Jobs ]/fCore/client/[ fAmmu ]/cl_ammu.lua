ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

Arme = {
    {Label = "Couteau", Name = "knife", Price = 150},
    {Label = "Lampe Torche", Name = "flashlight", Price = 90},
    {Label = "Batte de baseball", Name = "bat", Price = 200},
    {Label = "Poing américain", Name = "knuckle", Price = 120}
}

function OpenAmmu()
  local Ammu = RageUI.CreateMenu("Armurerie", "Voici nos armes blanche")

  RageUI.Visible(Ammu, not RageUI.Visible(Ammu))

  while Ammu do
      Wait(0)
      RageUI.IsVisible(Ammu, true, true, true, function()
        for k,v in pairs(Arme) do
            RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = "~g~"..(v.Price).."€"}, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fellow:ammu', v.Name, v.Price)
                end
            end)
        end
    end)

      if not RageUI.Visible(Ammu) then
          Ammu = RMenu:DeleteType("Ammu", true)
        end
    end
end

local position = {
        {x = -3171.70, y = 1087.66, z = 19.83},
        {x = 2567.6, y = 294.3, z = 108.7},
        {x = 22.0, y = -1107.2, z = 29.8},
        {x = 252.3, y = -50.0, z = 69.9},
        {x = -330.2, y = 6083.8, z  =31.4},
        {x = 1693.4, y = 3759.5, z = 34.7},
        {x = -662.1, y = -935.3, z = 21.8}
    }    

CreateThread(function()
    for k, v in pairs(position) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 110)
		SetBlipScale (blip, 0.6)
		SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Armurerie')
        EndTextCommandSetBlipName(blip)
    end
end)    
    
 CreateThread(function()
    while true do
        local sleep = 500
            for k in pairs(position) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                    if dist <= 1.0 then
                    sleep = 0
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour acheter des armes", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        OpenAmmu()
                    end
                end
            end
        Wait(sleep)
    end
end)