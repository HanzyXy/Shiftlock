-- ShiftLock Custom (Stable + Cursor Fix)
-- Dibuat agar shiftlock berfungsi seperti Roblox default, tapi pakai tombol sendiri
-- Cursor tidak bergerak saat kamera digerakkan

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

-- GUI utama
local ShiftLockGui = Instance.new("ScreenGui")
ShiftLockGui.Name = "ShiftLockGui"
ShiftLockGui.ResetOnSpawn = false
ShiftLockGui.Parent = PlayerGui

-- Tombol ShiftLock
local ShiftLockButton = Instance.new("ImageButton")
ShiftLockButton.Name = "ShiftLockButton"
ShiftLockButton.Parent = ShiftLockGui
ShiftLockButton.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftLockButton.Size = UDim2.new(0, 70, 0, 70)
ShiftLockButton.Position = UDim2.new(0.95, 0, 0.5, 0) -- kanan tengah
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.BackgroundTransparency = 0.2
ShiftLockButton.AutoButtonColor = true
ShiftLockButton.Image = "rbxassetid://3926307971"
ShiftLockButton.ImageRectOffset = Vector2.new(4, 204)
ShiftLockButton.ImageRectSize = Vector2.new(36, 36)
ShiftLockButton.ImageColor3 = Color3.fromRGB(0, 0, 0)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ShiftLockButton

-- Cursor tengah layar (tidak ikut kamera)
local Cursor = Instance.new("ImageLabel")
Cursor.Name = "ShiftLockCursor"
Cursor.Parent = ShiftLockGui
Cursor.AnchorPoint = Vector2.new(0.5, 0.5)
Cursor.Size = UDim2.new(0, 25, 0, 25)
Cursor.Position = UDim2.new(0.5, 0, 0.5, 0)
Cursor.BackgroundTransparency = 1
Cursor.Image = "rbxassetid://7072718362"
Cursor.Visible = false

-- Popup Loaded
local Popup = Instance.new("TextLabel")
Popup.Parent = ShiftLockGui
Popup.Size = UDim2.new(0, 250, 0, 50)
Popup.Position = UDim2.new(0.5, -125, 0.8, 0)
Popup.BackgroundTransparency = 0.3
Popup.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
Popup.Text = "✅ Loaded Script Successfully!"
Popup.TextColor3 = Color3.new(1, 1, 1)
Popup.Font = Enum.Font.SourceSansBold
Popup.TextScaled = true
task.delay(3, function()
	Popup:Destroy()
end)

-- Status
local shiftLockEnabled = false

local function enableShiftLock()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	-- Kamera mengikuti humanoid
	camera.CameraSubject = humanoid
	camera.CameraType = Enum.CameraType.Custom

	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = false
	Cursor.Visible = true
	ShiftLockButton.ImageColor3 = Color3.fromRGB(0, 255, 127)
	shiftLockEnabled = true
end

local function disableShiftLock()
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = true
	Cursor.Visible = false
	ShiftLockButton.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shiftLockEnabled = false
end

ShiftLockButton.MouseButton1Click:Connect(function()
	if shiftLockEnabled then
		disableShiftLock()
	else
		enableShiftLock()
	end
end)

-- Pastikan cursor tetap di tengah layar (tidak bergerak)
RunService.RenderStepped:Connect(function()
	if shiftLockEnabled then
		Cursor.Position = UDim2.new(0.5, 0, 0.5, 0)
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	end
end)

print("✅ ShiftLock Script Loaded Successfully!")
