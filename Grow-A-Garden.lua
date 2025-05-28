local TARGET_PLACE_ID = 126884695634066

local function waitForGameLoad()
    if not game:IsLoaded() then
        print("[Z2 Hub] Waiting for the game to fully load...")
        game.Loaded:Wait()
        print("[Z2 Hub] Game has finished loading.")
    end
end

local function checkExecutorCompatibility()
    local threadContext = getthreadcontext()

    if threadContext >= 7 or threadContext == 2 or threadContext == 3 then
        print("[Z2 Hub] ✅ Executor is supported (ThreadContext: " .. threadContext .. ")")
    else
        error("[Z2 Hub] ❌ Unsupported executor!\n" ..
              "This script requires thread context 7+, or 2/3 (Delta).\n" ..
              "Please use executors like Swift, Volcano, or Delta.")
    end
end

local function sendLoadNotification()
    if game.PlaceId ~= TARGET_PLACE_ID then
        Fluent:Notify({
            Title = "Z2 Hub",
            Content = "Script successfully loaded!",
            Duration = 8
        })
        print("[Z2 Hub] ✅ Notification sent: Script successfully loaded!")
    else
        print("[Z2 Hub] ℹ️ Notification suppressed (PlaceId: " .. TARGET_PLACE_ID .. ")")
    end
end

-- Run logic
waitForGameLoad()
checkExecutorCompatibility()
sendLoadNotification()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Z2 Hub",
    SubTitle = "Made by Zenz_Z2",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Farm = Window:AddTab({ Title = "AutoFarm", Icon = "tree-deciduous" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Egg = Window:AddTab({ Title = "Egg", Icon = "egg" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Add a label/paragraph to Main tab
Tabs.Main:AddParagraph({
    Title = "Welcome to Z2 Hub!",
    Content = "This hub was made by Zenz_Z2.\n\nEnjoy premium features like autofarming, teleport, egg opening, and more. Join our community for updates and support!"
})

-- Add a Discord invite button
Tabs.Main:AddButton({
    Title = "Join Discord Server",
    Description = "Click to copy the invite link to your clipboard.",
    Callback = function()
        setclipboard("https://discord.gg/yourinvitecode") -- Replace with your actual invite
        Fluent:Notify({
            Title = "Z2 Hub",
            Content = "Discord invite link copied to clipboard!",
            Icon = "copy",
            Duration = 5
        })
    end
})

-- 📍 TELEPORT TAB: Organize into sections
local teleportSection = Tabs.Teleport:AddSection("📍Teleports")

teleportSection:AddButton({
    Title = "🛍️ Shop",
    Description = "Teleport to the main shop for purchasing seed.",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:PivotTo(CFrame.new(86.5854721, 2.99999976, -27.0039806)) -- Replace with actual Shop location
        end
    end
})

teleportSection:AddButton({
    Title = "💰 Sell",
    Description = "Teleport to the selling area to exchange items for currency.",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:PivotTo(CFrame.new(86.5882111, 2.99999976, 0.426788151)) -- Replace with actual Sell location
        end
    end
})

teleportSection:AddButton({
    Title = "🦉 Owl",
    Description = "Teleport to the Owl area.",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:PivotTo(CFrame.new(-99.7943726, 4.40001249, -7.12790489)) -- Replace with actual Owl area
        end
    end
})

teleportSection:AddButton({
    Title = "🥚 Egg ",
    Description = "Teleport to the Egg Shop.",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:PivotTo(CFrame.new(-284.60498, 2.99999976, -2.1411283)) -- Replace with actual Egg location
        end
    end
})

teleportSection:AddButton({
    Title = "🎨 Cosmetics",
    Description = "Teleport to the Cosmetics Shop.",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:PivotTo(CFrame.new(-284.60498, 2.99999976, -14.1411283)) -- Replace with actual Cosmetics location
        end
    end
})
teleportSection:AddButton({
    Title = "⚙️ Gear",
    Description = "Teleport to the Gear Shop.",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:PivotTo(CFrame.new(-284.60498, 2.99999976, -12.1411283)) -- Replace with actual Gear location
        end
    end
})
-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Z2 Hub",
    Content = "Successfully loaded!",
    Icon = "check-circle", -- or any Lucide icon
    Duration = 5,
    CloseButton = true
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
