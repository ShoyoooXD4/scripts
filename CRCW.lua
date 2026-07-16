--// UI Lib
local Library = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/bloodwall/-back-ups-for-libs/main/0x"))()
local Window1 = Library:Window("Classic Retro Craftwars")

--// Services
local Players = game:GetService("Players").LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Character = Players.Character or Players.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local KillAll = false

--// Respawn Handler
Players.CharacterAdded:Connect(function(newchar)
	Character = newchar
	Humanoid = newchar:WaitForChild("Humanoid")
end)

local function GetRemoteFunction()
	local Tool = Character:FindFirstChildOfClass("Tool")
	if not Tool then return end
	for _, obj in Tool:GetChildren() do
		if obj:IsA("RemoteFunction") then
			return obj
		end
	end
end

--// Functions
Window1:Slider(
	"Change Speed",
	"Ws",
	16,
	300,
	function(value)
		Humanoid.WalkSpeed = value
	end
)

Window1:Slider(
	"Change Jump",
	"Jp",
	50,
	300,
	function(value)
		Humanoid.JumpPower = value
	end
)

Window1:Toggle(
	"Kill All",
	"Ka",
	false,
	function(toggled)
		KillAll = toggled
		RunService.Heartbeat:Connect(function()
			if not KillAll then return end
			for _, obj in Workspace:GetDescendants() do
				if obj ~= Character then continue end
				local Humanoid = obj:FindFirstChildOfClass("Humanoid")
				if obj:IsA("Model") and Humanoid and Humanoid.Health > 0 then
					local DamageEvent = GetRemoteFunction()
					if DamageEvent then
						DamageEvent:InvokeServer("hit", {Humanoid, 60000})
					end
				end
			end
		end)
	end
)

Window1:Button(
	"Destroy GUI",
	function()
		for _, obj in CoreGui:GetChildren() do
			if obj:FindFirstChild("Top") then
				obj:Destroy()
			end
		end
	end
)
