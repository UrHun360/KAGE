--==================================================
-- FishIt Script
-- Author : UrHun
-- Version: 0.1
--==================================================

----------------------
-- DEBUG SYSTEM
----------------------
local DEBUG = true

local function log(...)
    if DEBUG then
        print("[FishIt DEBUG]", ...)
    end
end

log("Script loaded")

----------------------
-- SERVICES
----------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

----------------------
-- PLAYER
----------------------
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

log("Player:", player.Name)
log("Character ready")

----------------------
-- CONFIG
----------------------
local Settings = {
    AutoFish = true,
    WalkSpeed = 16,
    JumpPower = 50,
}

----------------------
-- UTILITY FUNCTIONS
----------------------
local function getTool()
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        log("Tool:", tool.Name)
    end
    return tool
end

local function setWalkSpeed(speed)
    if humanoid then
        humanoid.WalkSpeed = speed
        log("WalkSpeed set to", speed)
    end
end

local function setJumpPower(power)
    if humanoid then
        humanoid.JumpPower = power
        log("JumpPower set to", power)
    end
end

local function useTool()
    local tool = getTool()
    if not tool then
        log("No tool to use")
        return
    end
    
----------------------
-- FEATURE FUNCTIONS
----------------------
local function autoFishStep()
    if not Settings.AutoFish then return end

    useTool()
end

----------------------
-- MAIN LOOPS
----------------------
-- AutoFish loop
task.spawn(function()
    while task.wait(2) do
        autoFishStep()
    end
end)

-- Player mods loop
RunService.Heartbeat:Connect(function()
    if Settings.WalkSpeed ~= humanoid.WalkSpeed then
        humanoid.WalkSpeed = Settings.WalkSpeed
    end
end)

log("All systems initialized")
