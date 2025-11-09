-- Premium ShiftLock System by Hanzyy & tibe0124
-- Optimized and Enhanced Edition (v2.5)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local SoundService = game:GetService("SoundService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI SETUP
local ShiftLockScreenGui = Instance.new("ScreenGui")
ShiftLockScreenGui.Name = "ShiftLockPremium"
ShiftLockScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShiftLockScreenGui.ResetOnSpawn = false
ShiftLockScreenGui.Parent = CoreGui

-- BUTTON
local ShiftLockButton = Instance.new("ImageButton")
ShiftLockButton.Parent = ShiftLockScreenGui
ShiftLockButton.BackgroundTransparency = 1
ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
ShiftLockButton.Position = UDim2.new(0.05, 0, 0.45, 0) -- kiri tengah
ShiftLockButton.Size = UDim2.new(0.07, 0, 0.07, 0)
ShiftLockButton.SizeConstraint = Enum.SizeConstraint.RelativeXX

-- CURSOR
local ShiftlockCursor = Instance.new("ImageLabel")
ShiftlockCursor.Name = "ShiftLockCursor"
ShiftlockCursor.Parent = ShiftLockScreenGui
ShiftlockCursor.Image = "rbxasset://textures/MouseLockedCursor.png"
ShiftlockCursor.BackgroundTransparency = 1
ShiftlockCursor.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftlockCursor.Size = UDim2.new(0.03, 0, 0.03, 0)
ShiftlockCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
ShiftlockCursor.Visible = false

-- SOUND
local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://9118823107" -- suara klik premium
ClickSound.Volume = 1.3
ClickSound.Parent = SoundService

-- SHIFTLOCK STATE
local Active = false

local function EnableShiftLock()
	if not Player.Character or not Player.Character:FindFirstChild("Humanoid") then return end
	local Humanoid = Player.Character:FindFirstChild("Humanoid")

	Active = true
	Humanoid.AutoRotate = false
	ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
	ShiftlockCursor.Visible = true
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = false
end

local function DisableShiftLock()
	if not Player.Character or not Player.Character:FindFirstChild("Humanoid") then return end
	local Humanoid = Player.Character:FindFirstChild("Humanoid")

	Active = false
	Humanoid.AutoRotate = true
	ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
	ShiftlockCursor.Visible = false
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = true
end

ShiftLockButton.MouseButton1Click:Connect(function()
	ClickSound:Play()
	if Active then
		DisableShiftLock()
	else
		EnableShiftLock()
	end
end)

-- SUPPORT RELOAD (KARAKTER MATI)
Player.CharacterAdded:Connect(function(char)
	repeat task.wait() until char:FindFirstChild("Humanoid")
	DisableShiftLock()
end)

print("✅ ShiftLock Premium Loaded Successfully")
