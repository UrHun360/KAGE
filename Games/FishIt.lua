--==================================================
-- 🐟 Fish It Script (Clean Full Version)
-- Author : You
-- Purpose: Learning, testing, personal use
--==================================================

--================== SAFETY =========================
if game:GetAttribute("FISHIT_FULL_LOADED") then return end
game:SetAttribute("FISHIT_FULL_LOADED", true)

print("DEBUG: FishIt script STARTED")

--================== SERVICES =======================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

--================== PLAYER =========================
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

--================== CONFIG =========================
local Config = {
    Speed = 40,
    Jump = 80,
    AutoFarmDelay = 1.5
}

--================== STATES =========================
local State = {
    Speed = false,
    Jump = false,
    InfiniteJump = false,
    AutoFarm = false
}

--================== NOTIFY =========================
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Fish It Script",
        Text = "Loaded successfully",
        Duration = 4
    })
end)

--================== GUI ============================
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FishIt_GUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.25, 0.4)
frame.Position = UDim2.fromScale(0.05, 0.3)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.15, 0)
title.BackgroundTransparency = 1
title.Text = "🐟 Fish It Script"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

--================== BUTTON MAKER ===================
local function createButton(text, order, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0.13, 0)
    btn.Position = UDim2.new(0.05, 0, 0.17 + order * 0.14, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = text .. " [OFF]"

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.Text = text .. (on and " [ON]" or " [OFF]")
        btn.BackgroundColor3 = on and Color3.fromRGB(0,170,0) or Color3.fromRGB(50,50,50)
        callback(on)
    end)
end

--================== FEATURES =======================

-- Speed
createButton("Speed", 0, function(v)
    State.Speed = v
    humanoid.WalkSpeed = v and Config.Speed or 16
end)

-- Jump
createButton("Jump", 1, function(v)
    State.Jump = v
    humanoid.JumpPower = v and Config.Jump or 50
end)

-- Infinite Jump
createButton("Infinite Jump", 2, function(v)
    State.InfiniteJump = v
end)

UIS.JumpRequest:Connect(function()
    if State.InfiniteJump and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Auto Farm
createButton("Auto Farm", 3, function(v)
    State.AutoFarm = v
end)

--================== AUTO FARM CORE =================
-- ⚠️ EDIT THIS PART BASED ON REAL FISH IT STRUCTURE

local function findNearestTarget()
    if not workspace:FindFirstChild("Fish") then return end

    local closest, dist = nil, math.huge
    for _, obj in pairs(workspace.Fish:GetChildren()) do
        if obj:IsA("Model") and obj.PrimaryPart then
            local d = (obj.PrimaryPart.Position - hrp.Position).Magnitude
            if d < dist then
                dist = d
                closest = obj
            end
        end
    end
    return closest
end

local function useTool()
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
    end
end

task.spawn(function()
    while task.wait(Config.AutoFarmDelay) do
        if not State.AutoFarm then continue end

        local target = findNearestTarget()
        if target and target.PrimaryPart then
            hrp.CFrame = target.PrimaryPart.CFrame * CFrame.new(0,3,0)
            task.wait(0.3)
            useTool()
        end
    end
end)

--================== RESPAWN FIX ====================
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")

    if State.Speed then humanoid.WalkSpeed = Config.Speed end
    if State.Jump then humanoid.JumpPower = Config.Jump end
end)

print("🐟 Fish It full script loaded")
