-- LocalScript trong StarterPlayerScripts hoặc StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local currentWalkSpeed = 16
local currentAnimSpeed = 1

local function applyWalkSpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = currentWalkSpeed
end

local function applyAnimationSpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			track:AdjustSpeed(currentAnimSpeed)
		end
	end
end

local function applyAll()
	applyWalkSpeed()
	applyAnimationSpeed()
end

player.CharacterAdded:Connect(function()
	task.wait(0.2)
	applyAll()
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedAnimGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Toggle button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 120, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Text = "⚙ Mở Speed GUI"
toggleBtn.Parent = gui

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0, 10, 0, 55)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "⚡ Điều chỉnh tốc độ"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

-- WALK SPEED SECTION
local walkLabel = Instance.new("TextLabel")
walkLabel.Size = UDim2.new(1, -20, 0, 20)
walkLabel.Position = UDim2.new(0, 10, 0, 40)
walkLabel.BackgroundTransparency = 1
walkLabel.Text = "🏃 WalkSpeed (0–1000):"
walkLabel.TextColor3 = Color3.new(1, 1, 1)
walkLabel.Font = Enum.Font.Gotham
walkLabel.TextSize = 14
walkLabel.TextXAlignment = Enum.TextXAlignment.Left
walkLabel.Parent = frame

local walkBox = Instance.new("TextBox")
walkBox.Size = UDim2.new(0.8, 0, 0, 30)
walkBox.Position = UDim2.new(0.1, 0, 0, 65)
walkBox.PlaceholderText = "Nhập WalkSpeed"
walkBox.Text = ""
walkBox.Font = Enum.Font.Gotham
walkBox.TextSize = 14
walkBox.TextColor3 = Color3.new(0, 0, 0)
walkBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
walkBox.ClearTextOnFocus = false
walkBox.Parent = frame

local walkBtn = Instance.new("TextButton")
walkBtn.Size = UDim2.new(0.8, 0, 0, 30)
walkBtn.Position = UDim2.new(0.1, 0, 0, 100)
walkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
walkBtn.TextColor3 = Color3.new(1, 1, 1)
walkBtn.Font = Enum.Font.GothamBold
walkBtn.TextSize = 14
walkBtn.Text = "Áp dụng WalkSpeed"
walkBtn.Parent = frame

-- ANIMATION SPEED SECTION
local animLabel = Instance.new("TextLabel")
animLabel.Size = UDim2.new(1, -20, 0, 20)
animLabel.Position = UDim2.new(0, 10, 0, 140)
animLabel.BackgroundTransparency = 1
animLabel.Text = "🎞 AnimationSpeed (0–1000):"
animLabel.TextColor3 = Color3.new(1, 1, 1)
animLabel.Font = Enum.Font.Gotham
animLabel.TextSize = 14
animLabel.TextXAlignment = Enum.TextXAlignment.Left
animLabel.Parent = frame

local animBox = Instance.new("TextBox")
animBox.Size = UDim2.new(0.8, 0, 0, 30)
animBox.Position = UDim2.new(0.1, 0, 0, 165)
animBox.PlaceholderText = "Nhập AnimationSpeed"
animBox.Text = ""
animBox.Font = Enum.Font.Gotham
animBox.TextSize = 14
animBox.TextColor3 = Color3.new(0, 0, 0)
animBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
animBox.ClearTextOnFocus = false
animBox.Parent = frame

local animBtn = Instance.new("TextButton")
animBtn.Size = UDim2.new(0.8, 0, 0, 30)
animBtn.Position = UDim2.new(0.1, 0, 0, 200)
animBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
animBtn.TextColor3 = Color3.new(1, 1, 1)
animBtn.Font = Enum.Font.GothamBold
animBtn.TextSize = 14
animBtn.Text = "Áp dụng AnimationSpeed"
animBtn.Parent = frame

-- RESET BUTTON
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.8, 0, 0, 25)
resetBtn.Position = UDim2.new(0.1, 0, 1, -30)
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetBtn.TextColor3 = Color3.new(1, 1, 1)
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 14
resetBtn.Text = "🔁 Reset"
resetBtn.Parent = frame

-- Toggle GUI
toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- WalkSpeed apply
walkBtn.MouseButton1Click:Connect(function()
	local val = tonumber(walkBox.Text)
	if val and val >= 0 and val <= 1000 then
		currentWalkSpeed = val
		applyWalkSpeed()
		walkBtn.Text = "✅ Walk OK"
	else
		walkBtn.Text = "❌ Sai (0-1000)"
	end
	task.wait(1.5)
	walkBtn.Text = "Áp dụng WalkSpeed"
end)

-- AnimSpeed apply
animBtn.MouseButton1Click:Connect(function()
	local val = tonumber(animBox.Text)
	if val and val >= 0 and val <= 1000 then
		currentAnimSpeed = val
		applyAnimationSpeed()
		animBtn.Text = "✅ Anim OK"
	else
		animBtn.Text = "❌ Sai (0-1000)"
	end
	task.wait(1.5)
	animBtn.Text = "Áp dụng AnimationSpeed"
end)

-- Reset button
resetBtn.MouseButton1Click:Connect(function()
	currentWalkSpeed = 16
	currentAnimSpeed = 1
	applyAll()
	walkBox.Text = ""
	animBox.Text = ""
	resetBtn.Text = "🔁 Đã Reset!"
	task.wait(1.5)
	resetBtn.Text = "🔁 Reset"
end)
