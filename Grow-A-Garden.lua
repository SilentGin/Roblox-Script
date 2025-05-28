--[[
    Z2 Hub - Roblox Script Hub
    Author: Zenz_Z2
    Description: A professional, modular script hub featuring
                 auto farming, teleportation, egg opening,
                 and other premium features.
--]]

local TARGET_PLACE_ID = 126884695634066

-- Wait for the game to fully load before continuing
local function waitForGameLoad()
    if not game:IsLoaded() then
        print("[Z2 Hub] Waiting for the game to fully load...")
        game.Loaded:Wait()
        print("[Z2 Hub] Game has finished loading.")
    end
end

-- Verify executor compatibility by checking thread context
local function checkExecutorCompatibility()
    local threadContext = getthreadcontext()
    if threadContext >= 7 or threadContext == 2 or threadContext == 3 then
        print(string.format("[Z2 Hub] ✅ Executor supported (ThreadContext: %d)", threadContext))
    else
        error("[Z2 Hub] ❌ Unsupported executor!\n" ..
              "This script requires thread context 7+, or 2/3 (Delta).\n" ..
              "Please use executors like Swift, Volcano, or Delta.")
    end
end

-- Send a notification on successful script load, except for the target place
local function sendLoadNotification()
    if game.PlaceId ~= TARGET_PLACE_ID then
        Fluent:Notify({
            Title = "Z2 Hub",
            Content = "Script successfully loaded!",
            Duration = 8
        })
        print("[Z2 Hub] ✅ Notification sent: Script successfully loaded!")
    else
        print(string.format("[Z2 Hub] ℹ️ Notification suppressed (PlaceId: %d)", TARGET_PLACE_ID))
    end
end

-- Execute pre-load checks
waitForGameLoad()
checkExecutorCompatibility()

-- Load Fluent UI library and related managers
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

sendLoadNotification()

-- Create main window for the hub
local Window = Fluent:CreateWindow({
    Title = "Z2 Hub",
    SubTitle = "Made by Zenz_Z2",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Define tabs for the hub
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Farm = Window:AddTab({ Title = "AutoFarm", Icon = "tree-deciduous" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Egg = Window:AddTab({ Title = "Egg", Icon = "egg" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Main Tab: Welcome message and Discord invite button
Tabs.Main:AddParagraph({
    Title = "Welcome to Z2 Hub!",
    Content = [[
This hub was developed by Zenz_Z2.

Enjoy premium features like auto farming, teleporting, egg opening, and more.
Join our community for updates and support!
]]
})

Tabs.Main:AddButton({
    Title = "Join Discord Server",
    Description = "Click to copy the invite link to your clipboard.",
    Callback = function()
        setclipboard("https://discord.gg/yourinvitecode") -- Replace with your actual invite link
        Fluent:Notify({
            Title = "Z2 Hub",
            Content = "Discord invite link copied to clipboard!",
            Icon = "copy",
            Duration = 5
        })
    end
})

-- Teleport Tab: Organized sections with teleport buttons
local teleportSection = Tabs.Teleport:AddSection("📍 Teleports")

local function teleportToPosition(position)
    local character = game.Players.LocalPlayer.Character
    if character then
        character:PivotTo(CFrame.new(position))
    else
        Fluent:Notify({
            Title = "Z2 Hub",
            Content = "Character not found! Teleport failed.",
            Icon = "alert-circle",
            Duration = 4
        })
    end
end

-- Add teleport buttons with precise locations
teleportSection:AddButton({
    Title = "🛍️ Shop",
    Description = "Teleport to the main shop for purchasing seeds.",
    Callback = function()
        teleportToPosition(Vector3.new(86.5855, 3.0, -27.004))
    end
})

teleportSection:AddButton({
    Title = "💰 Sell",
    Description = "Teleport to the selling area to exchange items for currency.",
    Callback = function()
        teleportToPosition(Vector3.new(86.5882, 3.0, 0.4268))
    end
})

teleportSection:AddButton({
    Title = "🦉 Owl",
    Description = "Teleport to the Owl area.",
    Callback = function()
        teleportToPosition(Vector3.new(-99.7944, 4.4, -7.1279))
    end
})

teleportSection:AddButton({
    Title = "🥚 Egg",
    Description = "Teleport to the Egg Shop.",
    Callback = function()
        teleportToPosition(Vector3.new(-284.605, 3.0, -2.141))
    end
})

teleportSection:AddButton({
    Title = "🎨 Cosmetics",
    Description = "Teleport to the Cosmetics Shop.",
    Callback = function()
        teleportToPosition(Vector3.new(-284.605, 3.0, -14.141))
    end
})

teleportSection:AddButton({
    Title = "⚙️ Gear",
    Description = "Teleport to the Gear Shop.",
    Callback = function()
        teleportToPosition(Vector3.new(-284.605, 3.0, -12.141))
    end
})

-- Setup SaveManager and InterfaceManager with Fluent library
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Exclude theme settings from being saved (optional)
SaveManager:IgnoreThemeSettings()

-- Add any GUI element indexes to ignore during saving (currently empty)
SaveManager:SetIgnoreIndexes({})

-- Set folders for saving configs and interfaces
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

-- Build interface and config sections in Settings tab
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- Select default tab on load
Window:SelectTab(1)

-- Notify user of successful script load
Fluent:Notify({
    Title = "Z2 Hub",
    Content = "Successfully loaded!",
    Icon = "check-circle",
    Duration = 5,
    CloseButton = true
})

-- Optionally load autoload config if available
SaveManager:LoadAutoloadConfig()
