-- Remade & Enhanced by ChatGPT + tibe0124
-- Subscribe tibe_D4RK :>

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI setup
local ShiftLockScreenGui = Instance.new("ScreenGui")
local ShiftLockButton = Instance.new("ImageButton")
local ShiftlockCursor = Instance.new("ImageLabel")
local ClickSound = Instance.new("Sound")

local States = {
	Off = "rbxasset://textures/ui/mouseLock_off@2x.png",
	On = "rbxasset://textures/ui/mouseLock_on@2x.png",
	Lock = "rbxasset://textures/MouseLockedCursor.png"
}

local ShiftLockEnabled = false
local ActiveConnection
local MaxLength = 999999

-- GUI properties
ShiftLockScreenGui.Name = "ShiftlockGUI"
ShiftLockScreenGui.Parent = CoreGui
ShiftLockScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShiftLockScreenGui.ResetOnSpawn = false

ShiftLockButton.Parent = ShiftLockScreenGui
ShiftLockButton.BackgroundTransparency = 1
ShiftLockButton.Position = UDim2.new(0.73, 0, 0.75, 0)
ShiftLockButton.Size = UDim2.new(0.065, 0, 0.065, 0)
ShiftLockButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftLockButton.Image = States.Off

ShiftlockCursor.Parent = ShiftLockScreenGui
ShiftlockCursor.Image = States.Lock
ShiftlockCursor.Size = UDim2.new(0.03, 0, 0.03, 0)
ShiftlockCursor.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftlockCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
ShiftlockCursor.BackgroundTransparency = 1
ShiftlockCursor.Visible = false

ClickSound.Parent = ShiftLockButton
ClickSound.SoundId = "rbxassetid://12222142" -- Suara klik lembut
ClickSound.Volume = 0.6
ClickSound.PlaybackSpeed = 1.1

-- Animasi efek klik
local function AnimateButton(button)
	local tweenIn = TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.07, 0, 0.07, 0)})
	local tweenOut = TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.065, 0, 0.065, 0)})
	tweenIn:Play()
	task.wait(0.15)
	tweenOut:Play()
end

-- Toggle utama ShiftLock
local function ToggleShiftLock()
	if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
		return
	end

	ShiftLockEnabled = not ShiftLockEnabled
	ClickSound:Play()
	AnimateButton(ShiftLockButton)

	if ShiftLockEnabled then
		Player.Character.Humanoid.AutoRotate = false
		ShiftLockButton.Image = States.On
		ShiftlockCursor.Visible = true

		ActiveConnection = RunService.RenderStepped:Connect(function()
			local root = Player.Character:FindFirstChild("HumanoidRootPart")
			if root then
				local look = Camera.CFrame.LookVector
				root.CFrame = CFrame.new(root.Position, Vector3.new(look.X * MaxLength, root.Position.Y, look.Z * MaxLength))
			end
		end)
	else
		Player.Character.Humanoid.AutoRotate = true
		ShiftLockButton.Image = States.Off
		ShiftlockCursor.Visible = false
		if ActiveConnection then
			ActiveConnection:Disconnect()
			ActiveConnection = nil
		end
	end
end

-- Klik tombol
ShiftLockButton.MouseButton1Click:Connect(ToggleShiftLock)

-- Tekan tombol [LeftShift] untuk toggle
ContextActionService:BindAction(
	"ShiftLockToggle",
	function(_, state)
		if state == Enum.UserInputState.Begin then
			ToggleShiftLock()
		end
	end,
	false,
	Enum.KeyCode.LeftShift
)

-- Efek hover
ShiftLockButton.MouseEnter:Connect(function()
	TweenService:Create(ShiftLockButton, TweenInfo.new(0.2), {ImageTransparency = 0.1}):Play()
end)
ShiftLockButton.MouseLeave:Connect(function()
	TweenService:Create(ShiftLockButton, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
end)

print("✅ Modern Shift Lock GUI Loaded with Animation & Sound!")
