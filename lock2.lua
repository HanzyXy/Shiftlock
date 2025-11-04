-- 💗 Custom Shift Lock GUI Executor Version
-- Made by GPT-5 for tibe_D4RK style

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Destroy old gui if exists
if CoreGui:FindFirstChild("ExecutorShiftLock") then
	CoreGui.ExecutorShiftLock:Destroy()
end

-- GUI base
local gui = Instance.new("ScreenGui")
gui.Name = "ExecutorShiftLock"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

-- 🔘 Main circle logo
local mainLogo = Instance.new("ImageButton")
mainLogo.Parent = gui
mainLogo.Size = UDim2.new(0, 80, 0, 80)
mainLogo.Position = UDim2.new(0.9, 0, 0.85, 0)
mainLogo.BackgroundColor3 = Color3.fromRGB(255, 110, 180)
mainLogo.Image = "rbxassetid://7072718364" -- logo X aesthetic
mainLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
mainLogo.BorderSizePixel = 0
mainLogo.AutoButtonColor = true
mainLogo.Active = true
mainLogo.Draggable = true
mainLogo.BackgroundTransparency = 0.1
mainLogo.Name = "MainLogo"
mainLogo.AnchorPoint = Vector2.new(0.5, 0.5)
mainLogo.ClipsDescendants = true
mainLogo:SetAttribute("Open", false)
mainLogo.ZIndex = 2

local UICorner = Instance.new("UICorner", mainLogo)
UICorner.CornerRadius = UDim.new(1, 0)

-- ✨ Popup “Loaded Successfully!”
local popup = Instance.new("TextLabel")
popup.Parent = gui
popup.Size = UDim2.new(0, 220, 0, 40)
popup.Position = UDim2.new(0.5, -110, 0.45, 0)
popup.BackgroundColor3 = Color3.fromRGB(255, 120, 200)
popup.BackgroundTransparency = 0.1
popup.Text = "✅ Script Loaded Successfully!"
popup.TextColor3 = Color3.fromRGB(255, 255, 255)
popup.TextScaled = true
popup.Font = Enum.Font.GothamBold
popup.Visible = true
local popCorner = Instance.new("UICorner", popup)
popCorner.CornerRadius = UDim.new(0, 10)

task.spawn(function()
	popup.Visible = true
	wait(2.5)
	for i = 1, 10 do
		popup.BackgroundTransparency = i * 0.1
		popup.TextTransparency = i * 0.1
		wait(0.05)
	end
	popup.Visible = false
end)

-- 🌸 Panel menu
local panel = Instance.new("Frame")
panel.Parent = gui
panel.Size = UDim2.new(0, 230, 0, 130)
panel.Position = UDim2.new(0.75, 0, 0.6, 0)
panel.BackgroundColor3 = Color3.fromRGB(255, 190, 230)
panel.BorderSizePixel = 0
panel.Visible = false
local pcorner = Instance.new("UICorner", panel)
pcorner.CornerRadius = UDim.new(0, 20)

local border = Instance.new("UIStroke", panel)
border.Thickness = 2
border.Color = Color3.fromRGB(255, 90, 180)

-- 🌸 Button: Aktifkan Shift Lock
local button = Instance.new("TextButton")
button.Parent = panel
button.Size = UDim2.new(0.8, 0, 0.5, 0)
button.Position = UDim2.new(0.1, 0, 0.25, 0)
button.Text = "🎮 Aktifkan Shift Lock"
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.BackgroundColor3 = Color3.fromRGB(255, 150, 210)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
local bcorner = Instance.new("UICorner", button)
bcorner.CornerRadius = UDim.new(0, 12)
local bstroke = Instance.new("UIStroke", button)
bstroke.Color = Color3.fromRGB(255, 255, 255)
bstroke.Thickness = 1.5

-- Shift Lock variables
local enabled = false
local connection = nil
local offset = CFrame.new(1.7, 0, 0)

-- 🎯 Fungsi toggle shiftlock
local function toggleShiftLock()
	local char = Player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if not enabled then
		enabled = true
		button.Text = "🟢 Shift Lock Aktif"
		hum.AutoRotate = false

		connection = RunService.RenderStepped:Connect(function()
			local look = Camera.CFrame.LookVector
			hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(look.X, 0, look.Z))
			Camera.CFrame = Camera.CFrame * offset
		end)
	else
		enabled = false
		button.Text = "🎮 Aktifkan Shift Lock"
		hum.AutoRotate = true
		if connection then
			connection:Disconnect()
			connection = nil
		end
	end
end

-- Klik tombol untuk aktifkan
button.MouseButton1Click:Connect(toggleShiftLock)

-- Klik logo X untuk buka/tutup panel
mainLogo.MouseButton1Click:Connect(function()
	local open = not mainLogo:GetAttribute("Open")
	mainLogo:SetAttribute("Open", open)
	panel.Visible = open
end)

print("[✅] Executor Shift Lock GUI Loaded Successfully!")
