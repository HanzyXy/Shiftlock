-- Remade by tibe0124
-- Subscribe: tibe_D4RK

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local ContextActionService = game:GetService("ContextActionService")
local Player = Players.LocalPlayer

local MaxLength = 900000
local EnabledOffset = CFrame.new(1.7, 0, 0)
local DisabledOffset = CFrame.new(-1.7, 0, 0)
local Active

-- 🖼️ UI SETUP
local Gui = Instance.new("ScreenGui")
Gui.Name = "Shiftlock (CoreGui)"
Gui.Parent = CoreGui
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 🔘 SHIFTLOCK BUTTON
local Button = Instance.new("ImageButton")
Button.Parent = Gui
Button.BackgroundColor3 = Color3.fromRGB(255, 160, 200)
Button.BackgroundTransparency = 0.1
Button.Position = UDim2.new(0.02, 0, 0.5, -35)
Button.Size = UDim2.new(0, 70, 0, 70)
Button.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
Button.AutoButtonColor = false
Button.ClipsDescendants = true

-- 🔵 Bulat sempurna
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1, 0)
Corner.Parent = Button

-- 🌀 Efek bayangan lembut
local Shadow = Instance.new("UIStroke")
Shadow.Color = Color3.fromRGB(255, 255, 255)
Shadow.Thickness = 2
Shadow.Transparency = 0.3
Shadow.Parent = Button

-- 🎯 CURSOR SHIFTLOCK
local Cursor = Instance.new("ImageLabel")
Cursor.Parent = Gui
Cursor.Image = "rbxasset://textures/MouseLockedCursor.png"
Cursor.Size = UDim2.new(0, 36, 0, 36)
Cursor.Position = UDim2.new(0.5, 0, 0.5, 0)
Cursor.AnchorPoint = Vector2.new(0.5, 0.5)
Cursor.BackgroundTransparency = 1
Cursor.Visible = false

-- 🔊 SOUND EFFECT
local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://9118823101" -- Suara klik lembut
ClickSound.Volume = 1
ClickSound.Parent = Button

-- 💬 Popup loading info
local Popup = Instance.new("TextLabel")
Popup.Parent = Gui
Popup.Text = "✅ Shiftlock System Loaded"
Popup.Font = Enum.Font.GothamBold
Popup.TextSize = 20
Popup.TextColor3 = Color3.fromRGB(255, 255, 255)
Popup.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Popup.BackgroundTransparency = 0.3
Popup.Size = UDim2.new(0, 280, 0, 35)
Popup.Position = UDim2.new(0.5, -140, 0.07, 0)
Popup.AnchorPoint = Vector2.new(0.5, 0)
Popup.Visible = true

local popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0, 10)
popupCorner.Parent = Popup

-- Fade-out popup
task.spawn(function()
	for i = 1, 60 do
		task.wait(0.03)
		Popup.TextTransparency = i / 60
		Popup.BackgroundTransparency = 0.3 + (i / 60)
	end
	Popup.Visible = false
end)

-- ⚙️ SHIFTLOCK SYSTEM
local Connection

local function ToggleShiftLock()
	if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
	
	ClickSound:Play() -- 🔊 mainkan suara klik

	if not Active then
		Active = true
		Button.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
		Button.BackgroundColor3 = Color3.fromRGB(255, 100, 180)
		Cursor.Visible = true
		Player.Character.Humanoid.AutoRotate = false

		Connection = RunService.RenderStepped:Connect(function()
			local Root = Player.Character:FindFirstChild("HumanoidRootPart")
			if not Root then return end

			Root.CFrame = CFrame.new(
				Root.Position,
				Vector3.new(
					workspace.CurrentCamera.CFrame.LookVector.X * MaxLength,
					Root.Position.Y,
					workspace.CurrentCamera.CFrame.LookVector.Z * MaxLength
				)
			)
			workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * EnabledOffset
			workspace.CurrentCamera.Focus = CFrame.new(Root.Position)
		end)

	else
		Active = false
		Button.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
		Button.BackgroundColor3 = Color3.fromRGB(255, 160, 200)
		Cursor.Visible = false
		Player.Character.Humanoid.AutoRotate = true
		workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * DisabledOffset
		if Connection then
			Connection:Disconnect()
			Connection = nil
		end
	end
end

-- 🔘 Klik tombol aktifkan Shiftlock
Button.MouseButton1Click:Connect(ToggleShiftLock)
