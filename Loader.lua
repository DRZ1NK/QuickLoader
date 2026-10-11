local hui = gethui()

local ScreenGui_1 = Instance.new("ScreenGui")
local Main_1 = Instance.new("Frame")
local Name_1 = Instance.new("TextLabel")
local UIPadding_1 = Instance.new("UIPadding")
local UIDragDetector_1 = Instance.new("UIDragDetector")
local Close_1 = Instance.new("TextButton")
local UIStroke_1 = Instance.new("UIStroke")
local UIStroke_2 = Instance.new("UIStroke")
local Minimize_1 = Instance.new("TextButton")
local UIStroke_3 = Instance.new("UIStroke")
local Canvas_1 = Instance.new("CanvasGroup")
local ScrollFrame_1 = Instance.new("ScrollingFrame")
local UIListLayout_1 = Instance.new("UIListLayout")
local UIStroke_5 = Instance.new("UIStroke")

local function randomString(length)
	local string = ""
	for i = 1, length do
		string = string .. string.char(math.random(97, 122))
	end
	return string
end

ScreenGui_1.Parent = hui
ScreenGui_1.Name = randomString(15)

Main_1.AnchorPoint = Vector2.new(0.5, 0.5)
Main_1.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
Main_1.Name = "Main"
Main_1.Parent = ScreenGui_1
Main_1.Position = UDim2.new(0.49960845708847046, 0, 0.3198757767677307, 0)
Main_1.Size = UDim2.new(0, 185, 0, 20)
Main_1.ZIndex = 0
Main_1.Selectable = false

Name_1.BackgroundTransparency = 1
Name_1.Name = "Name"
Name_1.Parent = Main_1
Name_1.Position = UDim2.new(0, 0, -0.007936508394777775, 0)
Name_1.Size = UDim2.new(0, 145, 0, 22)
Name_1.Selectable = false
Name_1.Text = "Quick Loader"
Name_1.TextScaled = true
Name_1.TextSize = 14
Name_1.TextWrapped = true

UIPadding_1.Parent = Name_1
UIPadding_1.PaddingBottom = UDim.new(0, 3)

UIDragDetector_1.Parent = Main_1

Close_1.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
Close_1.Name = "Close"
Close_1.Parent = Main_1
Close_1.Position = UDim2.new(0.8918918967247009, 0, 0, 0)
Close_1.Size = UDim2.new(0, 20, 0, 20)
Close_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Close_1.Text = "X"
Close_1.TextSize = 14

UIStroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_1.Parent = Close_1

UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_2.Parent = Main_1

Minimize_1.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
Minimize_1.Name = "Minimize"
Minimize_1.Parent = Main_1
Minimize_1.Position = UDim2.new(0.7837837934494019, 0, 0, 0)
Minimize_1.Size = UDim2.new(0, 20, 0, 20)
Minimize_1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Minimize_1.Text = "-"
Minimize_1.TextScaled = true
Minimize_1.TextSize = 30
Minimize_1.TextWrapped = true

UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_3.Parent = Minimize_1

Canvas_1.Parent = Main_1
Canvas_1.Name = "Canvas"
Canvas_1.Size = UDim2.new(0, 185, 0, 239)
Canvas_1.Position = UDim2.new(0, 0, 1, 0)
Canvas_1.BackgroundTransparency = 1
Canvas_1.ClipsDescendants = true

ScrollFrame_1.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
ScrollFrame_1.Name = "ScrollFrame"
ScrollFrame_1.Parent = Canvas_1
ScrollFrame_1.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame_1.ScrollBarImageTransparency = 1
ScrollFrame_1.ScrollBarThickness = 0

UIListLayout_1.Padding = UDim.new(0, 1)
UIListLayout_1.Parent = ScrollFrame_1
UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_5.Parent = Canvas_1

for _, descendant in ipairs(ScreenGui_1:GetDescendants()) do
	if descendant:IsA("UIStroke") then
		descendant.Color = Color3.fromRGB(0, 0, 0)
	elseif descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
		descendant.TextColor3 = Color3.fromRGB(0, 0, 0)
	end
end

local function sendNotis(title, text, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = title or "No Text",
		Text = text or "No Text",
		Duration = duration or 2
	})
end

local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local open = true

Close_1.MouseButton1Click:Connect(function()
	ScreenGui_1:Destroy()
end)

Minimize_1.MouseButton1Click:Connect(function()
	if open then
		TweenService:Create(Canvas_1, tweenInfo, {Size = UDim2.new(0, 185, 0, 0), GroupTransparency = 1}):Play()
		TweenService:Create(UIStroke_5, tweenInfo, {Transparency = 1}):Play()
		open = false
	else
		TweenService:Create(Canvas_1, tweenInfo, {Size = UDim2.new(0, 185, 0, 239), GroupTransparency = 0}):Play()
		TweenService:Create(UIStroke_5, tweenInfo, {Transparency = 0}):Play()
		open = true
	end
end)

local function CreateBtn(Name, Text, URL)
	local button = Instance.new("TextButton")
	button.Name = Name
	button.Size = UDim2.new(0, 186, 0, 26)
	button.Parent = ScrollFrame_1
	button.Text = Text
	button.TextScaled = true
	button.BackgroundTransparency = 0.8
	button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	
	local stroke = Instance.new("UIStroke")
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.Parent = button

	button.MouseButton1Click:Connect(function()
		if URL ~= nil and URL ~= "" then
			local success, err = pcall(function()
				loadstring(game:HttpGet(URL))()
			end)
			if not success then
				sendNotis("Error", "Failed to run script: " .. tostring(err), 3)
			end
		else
			sendNotis("Error", "URL not found or incorrect", 2)
		end
	end)
end

getgenv().AddButton = CreateBtn
