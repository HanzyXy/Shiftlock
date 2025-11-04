-- Remade & fixed version by ChatGPT + tibe0124
-- Subscribe tibe_D4RK :>

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ShiftLockScreenGui = Instance.new("ScreenGui")
local ShiftLockButton = Instance.new("ImageButton")
local ShiftlockCursor = Instance.new("ImageLabel")

local States = {
    Off = "rbxasset://textures/ui/mouseLock_off@2x.png",
    On = "rbxasset://textures/ui/mouseLock_on@2x.png",
    Lock = "rbxasset://textures/MouseLockedCursor.png"
}

local MaxLength = 999999
local EnabledOffset = CFrame.new(1.7, 0, 0)
local DisabledOffset = CFrame.new(-1.7, 0, 0)
local ActiveConnection
local ShiftLockEnabled = false

-- GUI SETUP
ShiftLockScreenGui.Name = "Shiftlock (CoreGui)"
ShiftLockScreenGui.Parent = CoreGui
ShiftLockScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShiftLockScreenGui.ResetOnSpawn = false

ShiftLockButton.Parent = ShiftLockScreenGui
ShiftLockButton.BackgroundTransparency = 1
ShiftLockButton.Position = UDim2.new(0.7, 0, 0.75, 0)
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

-- Fungsi toggle utama
local function ToggleShiftLock()
	if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
		return
	end

	ShiftLockEnabled = not ShiftLockEnabled

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

-- Klik tombol UI
ShiftLockButton.MouseButton1Click:Connect(ToggleShiftLock)

-- Tekan tombol [LeftShift]
ContextActionService:BindAction("ShiftLockToggle", function(_, state)
	if state == Enum.UserInputState.Begin then
		ToggleShiftLock()
	end
end, false, Enum.KeyCode.LeftShift)

print("✅ Shiftlock script loaded successfully!")
