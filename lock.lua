-- Remade by Xeunze
-- Subscribe XeunzeXPP :>

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "CustomShiftLock"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local btn = Instance.new("ImageButton")
btn.Name = "ShiftLockButton"
btn.Parent = gui
btn.Size = UDim2.new(0, 60, 0, 60)
btn.Position = UDim2.new(0.85, 0, 0.8, 0)
btn.BackgroundTransparency = 1
btn.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"

local cursor = Instance.new("ImageLabel")
cursor.Name = "ShiftLockCursor"
cursor.Parent = gui
cursor.Image = "rbxasset://textures/MouseLockedCursor.png"
cursor.Size = UDim2.new(0, 40, 0, 40)
cursor.AnchorPoint = Vector2.new(0.5, 0.5)
cursor.Position = UDim2.new(0.5, 0, 0.5, 0)
cursor.BackgroundTransparency = 1
cursor.Visible = false

-- Variables
local enabled = false
local connection = nil
local offset = CFrame.new(1.7, 0, 0)
local maxlen = 999999

-- Fungsi Toggle ShiftLock
local function toggleShiftLock()
	local char = Player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if not enabled then
		enabled = true
		hum.AutoRotate = false
		cursor.Visible = true
		btn.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"

		connection = RunService.RenderStepped:Connect(function()
			if not char or not hrp then return end
			local look = Camera.CFrame.LookVector
			hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(look.X, 0, look.Z))
			Camera.CFrame = Camera.CFrame * offset
		end)
	else
		enabled = false
		btn.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
		cursor.Visible = false
		hum.AutoRotate = true
		if connection then
			connection:Disconnect()
			connection = nil
		end
	end
end

-- Tombol Klik GUI
btn.MouseButton1Click:Connect(toggleShiftLock)

-- Tombol Keyboard SHIFT
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.LeftShift then
		toggleShiftLock()
	end
end)

print("[✅] Custom Shift Lock GUI Loaded")
