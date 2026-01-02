-- FishIt Script by URHUN

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Anti re-execute
if game:GetAttribute("FISHIT_LOADED") then
    return
end
game:SetAttribute("FISHIT_LOADED", true)

-- Contoh fitur
print("FishIt script loaded for:", player.Name)

-- Example notification (kalau executor support)
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "FishIt",
        Text = "Script Loaded!",
        Duration = 5
    })
end)
