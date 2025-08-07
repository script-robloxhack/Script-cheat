-- LocalScript trong StarterPlayerScripts hoặc StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local currentWalkSpeed = 16
local currentJumpPower = 50

local function applyWalkSpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = currentWalkSpeed
	end
end

local function applyJumpPower()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.JumpPower = currentJumpPower
	end
end

local function applyAll()
	applyWalkSpeed()
	applyJumpPower()
end

player.CharacterAdded:Connect(function()
	task.wait(0.5)
	applyAll()
end)

-- Giao diện GUI đơn giản
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SpeedJumpGUI"
gui.ResetOnSpawn = false

-- Nút mở/tắt
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 120, 0, 35)
toggle.Position = UDim2.new(0, 10, 0, 10)
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.Text = "⚙ Speed Menu"
toggle.TextSize = 14
toggle.Parent = gui

-- Khung chính
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0, 10, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = false
frame.Parent = gui

-- Cho phép kéo khung
local drag = Instance.new("UITextSizeConstraint")
drag.Parent = frame
frame.Active = true
frame.Draggable = true

-- Ô nhập WalkSpeed
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 180, 0, 30)
speedBox.Position = UDim2.new(0, 10, 0, 10)
speedBox.PlaceholderText = "Nhập WalkSpeed (0 - 1000)"
speedBox.Text = tostring(currentWalkSpeed)
speedBox.Parent = frame

-- Nút áp dụng WalkSpeed
local walkBtn = Instance.new("TextButton")
walkBtn.Size = UDim2.new(0, 90, 0, 30)
walkBtn.Position = UDim2.new(0, 200, 0, 10)
walkBtn.Text = "Áp dụng WalkSpeed"
walkBtn.Parent = frame

-- Ô nhập JumpPower
local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0, 180, 0, 30)
jumpBox.Position = UDim2.new(0, 10, 0, 60)
jumpBox.PlaceholderText = "Nhập JumpPower (0 - 1000)"
jumpBox.Text = tostring(currentJumpPower)
jumpBox.Parent = frame

-- Nút áp dụng JumpPower
local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(0, 90, 0, 30)
jumpBtn.Position = UDim2.new(0, 200, 0, 60)
jumpBtn.Text = "Áp dụng JumpPower"
jumpBtn.Parent = frame

-- Nút Reset
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0, 280, 0, 30)
resetBtn.Position = UDim2.new(0, 10, 0, 110)
resetBtn.Text = "🔄 Reset về mặc định"
resetBtn.Parent = frame

-- Xử lý nút mở/tắt
toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Xử lý WalkSpeed
walkBtn.MouseButton1Click:Connect(function()
	local val = tonumber(speedBox.Text)
	if val and val >= 0 and val <= 1000 then
		currentWalkSpeed = val
		applyWalkSpeed()
		walkBtn.Text = "✅ WalkSpeed OK"
	else
		walkBtn.Text = "❌ Nhập sai (0–1000)"
	end
	task.wait(1.5)
	walkBtn.Text = "Áp dụng WalkSpeed"
end)

-- Xử lý JumpPower
jumpBtn.MouseButton1Click:Connect(function()
	local val = tonumber(jumpBox.Text)
	if val and val >= 0 and val <= 1000 then
		currentJumpPower = val
		applyJumpPower()
		jumpBtn.Text = "✅ JumpPower OK"
	else
		jumpBtn.Text = "❌ Nhập sai (0–1000)"
	end
	task.wait(1.5)
	jumpBtn.Text = "Áp dụng JumpPower"
end)

-- Reset
resetBtn.MouseButton1Click:Connect(function()
	currentWalkSpeed = 16
	currentJumpPower = 50
	speedBox.Text = "16"
	jumpBox.Text = "50"
	applyAll()
	resetBtn.Text = "✅ Đã reset"
	task.wait(1.5)
	resetBtn.Text = "🔄 Reset về mặc định"
end)

-- Tự áp dụng lúc bắt đầu
applyAll()
