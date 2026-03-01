local library = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/0x"))()
local w1 = library:Window("Blade Spin")

--// Settings
getgenv().opautofarm = false
getgenv().upgradeall = false

--// RemoteLocations
local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteLocation = replicatedStorage.ReplicatedStorageHolders.Events
local startLocation = replicatedStorage.ReplicatedStorageHolders.Remotes

local upgrades = {
    "AmountOfBlades",
    "CoinBoost",
    "Damage",
    "Health",
    "MovementSpeed",
    "SpinSpeed"
}

w1:Label("Main Controls")
w1:Toggle("Auto Farm XP & Coins", "autofarmEnabled", false,
    function(toggled)
        getgenv().opautofarm = toggled
        if toggled then
            task.spawn(function()
                while getgenv().opautofarm do
                    pcall(function()
                        startLocation.SetInRound:FireServer(true)
                        task.wait()
                        remoteLocation.AddXP:FireServer(100000)
                        remoteLocation.AddCoins:FireServer(1e6)
                    end)
                    task.wait()
                end
            end)
        end
    end
)

w1:Toggle(
    "Auto Upgrade All Stats", "autoupgrade", false,
    function(toggled)
        getgenv().upgradeall = toggled
        if toggled then
            task.spawn(function()
                while getgenv().upgradeall do
                    for _, upgrade in ipairs(upgrades) do 
                        pcall(function()
                            remoteLocation.UpgradeCap:FireServer(upgrade)
                        end)
                        task.wait(0.1)
                    end
                    task.wait()
                end
            end)
            task.spawn(function()
                while getgenv().upgradeall do
                    for _, upgrade in pairs(upgrades) do 
                        pcall(function()
                            remoteLocation.UpgradeStat:FireServer(upgrade)
                        end)
                        task.wait(0.1)
                    end
                    task.wait()
                end
            end)
        end
    end
)
