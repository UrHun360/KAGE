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
    AutoFish = false,
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

----------------------
-- FEATURE FUNCTIONS
----------------------
local function autoFishStep()
    if not Settings.AutoFish then return end

    local tool = getTool()
    if not tool then return end

    -- sementara cuma debug
    log("AutoFish tick")
end

----------------------
-- MAIN LOOPS
----------------------
-- AutoFish loop
task.spawn(function()
    while task.wait(1) do
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
