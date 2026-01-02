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
    -- cek di character
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        log("Tool (character):", tool.Name)
        return tool
    end

    -- cek di backpack
    local backpack = player:WaitForChild("Backpack")
    tool = backpack:FindFirstChildOfClass("Tool")
    if tool then
        log("Tool (backpack):", tool.Name)
        tool.Parent = character -- auto equip
        return tool
    end

    log("No fishing tool found")
    return nil
end

local function useTool()
    local tool = getTool()
    if not tool then
        log("No tool to use")
        return
    end

    if typeof(tool.Activate) == "function" then
        tool:Activate()
        log("Tool activated via Activate()")
    else
        log("Tool has no Activate(), skipping")
    end
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

    useTool()
end

----------------------
-- MAIN LOOPS
----------------------
-- AutoFish loop
task.spawn(function()
    while task.wait(2) do
        if typeof(autoFishStep) == "function" then
            local ok, err = pcall(autoFishStep)
            if not ok then
                log("AutoFish error:", err)
            end
        else
            log("autoFishStep is nil")
        end
    end
end)

log("All systems initialized")
