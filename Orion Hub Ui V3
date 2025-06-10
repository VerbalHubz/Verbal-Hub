--feather icons https://github.com/evoincorp/lucideblox/tree/master/src/modules/util
--more icons here https://icon-sets.iconify.design/material-symbols/?icon-filter=note
--more icons here https://www.svgrepo.com/vectors/gui/2
--made by itjose4 Dc

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
if not getgenv then
	getgenv = function() return _G end
end
if not game then
	game = {
		CoreGui = {},
		GetService = function(_, name)
			return {}
		end
	}
end
getgenv().gethui = function() return game.CoreGui end

local OrionLib = {
	Elements = {},
	ThemeObjects = {},
	Connections = {},
	Flags = {},
	Themes = {
			Default = {
			Main = Color3.fromRGB(25, 25, 25),
			Second = Color3.fromRGB(32, 32, 32),
			Stroke = Color3.fromRGB(60, 60, 60),
			Divider = Color3.fromRGB(60, 60, 60),
			Text = Color3.fromRGB(240, 240, 240),
			TextDark = Color3.fromRGB(150, 150, 150)
		}
	},
	SelectedTheme = "Default",
	Folder = nil,
	SaveCfg = false
}

local Icons = {}

local Success, Response = pcall(function()
	Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json")).icons
end)

if not Success then
end	

local function GetIcon(IconName)
	if Icons[IconName] ~= nil then
		return Icons[IconName]
	else
		return nil
	end
end	

local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
if syn then
	pcall(function() syn.protect_gui(Orion) end)
	Orion.Parent = game.CoreGui
else
	Orion.Parent = gethui() or game.CoreGui
end

if gethui then
	for _, Interface in ipairs(gethui():GetChildren()) do
		if Interface.Name == Orion.Name and Interface ~= Orion then
			pcall(function() Interface:Destroy() end)
		end
	end
else
	for _, Interface in ipairs(game.CoreGui:GetChildren()) do
		if Interface.Name == Orion.Name and Interface ~= Orion then
			pcall(function() Interface:Destroy() end)
		end
	end
end

function OrionLib:IsRunning()
	if gethui then
		return Orion.Parent == gethui()
	else
		return Orion.Parent == game:GetService("CoreGui")
	end
end

local function AddConnection(Signal, Function)
	if (not OrionLib:IsRunning()) then
		return
	end
	local SafeFunction = function(...)
		local s, e = pcall(Function, ...)
		if not s then
		end
	end
	local SignalConnect = Signal:Connect(SafeFunction)
	table.insert(OrionLib.Connections, SignalConnect)
	return SignalConnect
end

task.spawn(function()
	local s, e = pcall(function()
		while (OrionLib:IsRunning()) do
			wait()
		end

		for _, Connection in next, OrionLib.Connections do
			if Connection then pcall(function() Connection:Disconnect() end) end
		end
	end)
	if not s then
	end
end)

local function MakeDraggable(DragPoint, Main)	
	local s, e = pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false
		AddConnection(DragPoint.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		AddConnection(DragPoint.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				DragInput = Input
			end
		end)
		AddConnection(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				Main.Position	= UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
			end
		end)
	end)
	if not s then
	end
end	

local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in next, Properties or {} do
		Object[i] = v
	end
	for i, v in next, Children or {} do
		v.Parent = Object
	end
	return Object
end

local function CreateElement(ElementName, ElementFunction)
	OrionLib.Elements[ElementName] = function(...)
		return ElementFunction(...)
	end
end

local function MakeElement(ElementName, ...)
	local NewElement = OrionLib.Elements[ElementName](...)
	return NewElement
end

local function SetProps(Element, Props)
	table.foreach(Props, function(Property, Value)
		Element[Property] = Value
	end)
	return Element
end

local function SetChildren(Element, Children)
	table.foreach(Children, function(_, Child)
		Child.Parent = Element
	end)
	return Element
end

local function Round(Number, Factor)
	local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
	if Result < 0 then Result = Result + Factor end
	return Result
end

local function ReturnProperty(Object)
	if Object:IsA("Frame") or Object:IsA("TextButton") then
		return "BackgroundColor3"
	end	
	if Object:IsA("ScrollingFrame") then
		return "ScrollBarImageColor3"
	end	
	if Object:IsA("UIStroke") then
		return "Color"
	end	
	if Object:IsA("TextLabel") or Object:IsA("TextBox") then
		return "TextColor3"
	end	
	if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
		return "ImageColor3"
	end	
end

local function AddThemeObject(Object, Type)
	if not OrionLib.ThemeObjects[Type] then
		OrionLib.ThemeObjects[Type] = {}
	end	
	table.insert(OrionLib.ThemeObjects[Type], Object)
	Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Type]
	return Object
end	

local function SetTheme()
	for Name, Type in pairs(OrionLib.ThemeObjects) do
		for _, Object in pairs(Type) do
			pcall(function() Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Name] end)
		end	
	end	
end

local function PackColor(Color)
	return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end	

local function UnpackColor(Color)
	return Color3.fromRGB(Color.R, Color.G, Color.B)
end

local function LoadCfg(Config)
	local s, Data = pcall(HttpService.JSONDecode, HttpService, Config)
	if not s or not Data then return end
	table.foreach(Data, function(a,b)
		if OrionLib.Flags[a] then
			task.spawn(function()	
				local s,e = pcall(function()
					if OrionLib.Flags[a].Type == "Colorpicker" then
						OrionLib.Flags[a]:Set(UnpackColor(b))
					elseif OrionLib.Flags[a].Type == "Textbox" then
						OrionLib.Flags[a]:Set(b, true) 
					else
						OrionLib.Flags[a]:Set(b)
					end	
				end)
				if not s then
				end
			end)
		else
		end
	end)
end

local function SaveCfg(Name)
	if not (writefile and OrionLib.Folder and Name) then return end	
	local Data = {}
	for i,v in pairs(OrionLib.Flags) do
		if v.Save then
			if v.Type == "Colorpicker" then
				Data[i] = PackColor(v.Value)
			else
				Data[i] = v.Value
			end
		end	
	end
	pcall(writefile, OrionLib.Folder .. "/" .. Name .. ".txt", tostring(HttpService:JSONEncode(Data)))
end

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3,Enum.UserInputType.Touch}
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

local function CheckKey(Table, Key)
	for _, v in next, Table do
		if v == Key then
			return true
		end
	end
end

CreateElement("Corner", function(Scale, Offset)
	local Corner = Create("UICorner", {
		CornerRadius = UDim.new(Scale or 0, Offset or 10)
	})
	return Corner
end)

CreateElement("Stroke", function(Color, Thickness)
	local Stroke = Create("UIStroke", {
		Color = Color or Color3.fromRGB(255, 255, 255),
		Thickness = Thickness or 1
	})
	return Stroke
end)

CreateElement("List", function(Scale, Offset)
	local List = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(Scale or 0, Offset or 0)
	})
	return List
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
	local Padding = Create("UIPadding", {
		PaddingBottom = UDim.new(0, Bottom or 4),
		PaddingLeft = UDim.new(0, Left or 4),
		PaddingRight = UDim.new(0, Right or 4),
		PaddingTop = UDim.new(0, Top or 4)
	})
	return Padding
end)

CreateElement("TFrame", function()
	local TFrame = Create("Frame", {
		BackgroundTransparency = 1
	})
	return TFrame
end)

CreateElement("Frame", function(Color)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	})
	return Frame
end)

CreateElement("RoundFrame", function(Color, Scale, Offset)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	}, {
		Create("UICorner", {
			CornerRadius = UDim.new(Scale, Offset)
		})
	})
	return Frame
end)

CreateElement("Button", function()
	local Button = Create("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	})
	return Button
end)

CreateElement("ScrollFrame", function(Color, Width)
	local ScrollFrame = Create("ScrollingFrame", {
		BackgroundTransparency = 1,
		MidImage = "rbxassetid://7445543667",
		BottomImage = "rbxassetid://7445543667",
		TopImage = "rbxassetid://7445543667",
		ScrollBarImageColor3 = Color,
		BorderSizePixel = 0,
		ScrollBarThickness = Width,
		CanvasSize = UDim2.new(0, 0, 0, 0)
	})
	return ScrollFrame
end)

CreateElement("Image", function(ImageID)
	local ImageNew = Create("ImageLabel", {
		Image = ImageID,
		BackgroundTransparency = 1
	})

	if GetIcon(ImageID) ~= nil then
		ImageNew.Image = GetIcon(ImageID)
	end	

	return ImageNew
end)

CreateElement("ImageButton", function(ImageID)
	local Image = Create("ImageButton", {
		Image = ImageID,
		BackgroundTransparency = 1
	})
	return Image
end)

CreateElement("Label", function(Text, TextSize, Transparency)
	local Label = Create("TextLabel", {
		Text = Text or "",
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = Transparency or 0,
		TextSize = TextSize or 15,
		Font = Enum.Font.Roboto,
		RichText = true,
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	return Label
end)

local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {
	SetProps(MakeElement("List"), {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		Padding = UDim.new(0, 5)
	})
}), {
	Position = UDim2.new(1, -25, 1, -25),
	Size = UDim2.new(0, 300, 1, -25),
	AnchorPoint = Vector2.new(1, 1),
	Parent = Orion
})

function OrionLib:MakeNotification(NotificationConfig)
	task.spawn(function()
		local s, e = pcall(function()
			NotificationConfig.Name = NotificationConfig.Name or "Notification"
			NotificationConfig.Content = NotificationConfig.Content or "Test"
			NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532"
			NotificationConfig.Time = NotificationConfig.Time or 15

			local NotificationParent = SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				Parent = NotificationHolder
			})

			local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 10), {
				Parent = NotificationParent,	
				Size = UDim2.new(1, 0, 0, 0),
				Position = UDim2.new(1, -55, 0, 0),
				BackgroundTransparency = 0,
				AutomaticSize = Enum.AutomaticSize.Y
			}), {
				MakeElement("Stroke", Color3.fromRGB(93, 93, 93), 1.2),
				MakeElement("Padding", 12, 12, 12, 12),
				SetProps(MakeElement("Image", NotificationConfig.Image), {
					Size = UDim2.new(0, 20, 0, 20),
					ImageColor3 = Color3.fromRGB(240, 240, 240),
					Name = "Icon"
				}),
				SetProps(MakeElement("Label", NotificationConfig.Name, 15), {
					Size = UDim2.new(1, -30, 0, 20),
					Position = UDim2.new(0, 30, 0, 0),
					Font = Enum.Font.GothamBold,
					Name = "Title"
				}),
				SetProps(MakeElement("Label", NotificationConfig.Content, 14), {
					Size = UDim2.new(1, 0, 0, 0),
					Position = UDim2.new(0, 0, 0, 25),
					Font = Enum.Font.GothamSemibold,
					Name = "Content",
					AutomaticSize = Enum.AutomaticSize.Y,
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextWrapped = true
				})
			})

			TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()

			wait(NotificationConfig.Time - 0.88)
			TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
			TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()
			wait(0.3)
			TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0.9}):Play()
			TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
			TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
			wait(0.05)

			NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0),'In','Quint',0.8,true)
			wait(1.35)
			if NotificationFrame and NotificationFrame.Parent then NotificationFrame:Destroy() end
		end)
		if not s then
		end
	end)
end	

function OrionLib:Init()
	if OrionLib.SaveCfg then	
		local s, e = pcall(function()
			if isfile and isfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt") then
				if readfile then LoadCfg(readfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt")) end
				OrionLib:MakeNotification({
					Name = "Configuration",
					Content = "Auto-loaded configuration for the game " .. game.GameId .. ".",
					Time = 5
				})
			end
		end)	
		if not s then
		end	
	end	
end	

function OrionLib:MakeWindow(WindowConfig)
	local FirstTab = true
	local Minimized = false
	local Loaded = false
	local UIHidden = false

	WindowConfig = WindowConfig or {}
	WindowConfig.Name = WindowConfig.Name or "Orion Library"
	WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
	WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
	WindowConfig.HidePremium = WindowConfig.HidePremium or false
	if WindowConfig.IntroEnabled == nil then
		WindowConfig.IntroEnabled = true
	end
	WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library"
	WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
	WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
	WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://8834748103"
	WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://8834748103"
	WindowConfig.SearchBar = WindowConfig.SearchBar or nil	
	OrionLib.Folder = WindowConfig.ConfigFolder
	OrionLib.SaveCfg = WindowConfig.SaveConfig

	if WindowConfig.SaveConfig then
		local s, e = pcall(function()
			if (isfolder and makefolder) and not isfolder(WindowConfig.ConfigFolder) then	
				makefolder(WindowConfig.ConfigFolder)
			elseif not (isfolder and isfolder(WindowConfig.ConfigFolder)) then	
				if makefolder then makefolder(WindowConfig.ConfigFolder) end
			end	
		end)
		if not s then
		end
	end

	local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4),
	WindowConfig.SearchBar and {
		Size = UDim2.new(1, 0, 1, -90),
		Position = UDim2.new(0, 0, 0, 40)
	} or {
		Size = UDim2.new(1, 0, 1, -50)
	}),
	{
		MakeElement("List"),
		MakeElement("Padding", 8, 0, 0, 8)
	}), "Divider")


	AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		if TabHolder and TabHolder.UIListLayout then
			TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16)
		end
	end)

	local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		BackgroundTransparency = 1
	}), {
		AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {
			Position = UDim2.new(0, 9, 0, 6),
			Size = UDim2.new(0, 18, 0, 18)
		}), "Text")
	})

	local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
		Size = UDim2.new(0.5, 0, 1, 0),
		BackgroundTransparency = 1
	}), {
		AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {
			Position = UDim2.new(0, 9, 0, 6),
			Size = UDim2.new(0, 18, 0, 18),
			Name = "Ico"
		}), "Text")
	})

	local DragPoint = SetProps(MakeElement("TFrame"), {
		Size = UDim2.new(1, 0, 0, 50)
	})

	local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
		Size = UDim2.new(0, 150, 1, -50),
		Position = UDim2.new(0, 0, 0, 50)
	}), {
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 10),
			Position = UDim2.new(0, 0, 0, 0)
		}), "Second"),	
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 10, 1, 0),
			Position = UDim2.new(1, -10, 0, 0)
		}), "Second"),	
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(1, -1, 0, 0)
		}), "Stroke"),	
		TabHolder,
		SetChildren(SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 50),
			Position = UDim2.new(0, 0, 1, -50)
		}), {
			AddThemeObject(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(1, 0, 0, 1)
			}), "Stroke"),	
			AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 32, 0, 32),
				Position = UDim2.new(0, 10, 0.5, 0)
			}), {
				SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"), {
					Size = UDim2.new(1, 0, 1, 0)
				}),
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4031889928"), {
					Size = UDim2.new(1, 0, 1, 0),
				}), "Second"),
				MakeElement("Corner", 1)
			}), "Divider"),
			SetChildren(SetProps(MakeElement("TFrame"), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 32, 0, 32),
				Position = UDim2.new(0, 10, 0.5, 0)
			}), {
				AddThemeObject(MakeElement("Stroke"), "Stroke"),
				MakeElement("Corner", 1)
			}),
			AddThemeObject(SetProps(MakeElement("Label", LocalPlayer.DisplayName, WindowConfig.HidePremium and 14 or 13), {
				Size = UDim2.new(1, -60, 0, 13),
				Position = WindowConfig.HidePremium and UDim2.new(0, 50, 0, 19) or UDim2.new(0, 50, 0, 12),
				Font = Enum.Font.GothamBold,
				ClipsDescendants = true
			}), "Text"),
			AddThemeObject(SetProps(MakeElement("Label", "", 12), {
				Size = UDim2.new(1, -60, 0, 12),
				Position = UDim2.new(0, 50, 1, -25),
				Visible = not WindowConfig.HidePremium
			}), "TextDark")
		}),
	}), "Second")

	local Tabs = {};	

	if WindowConfig.SearchBar then
		local SearchBox = Create("TextBox", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			PlaceholderColor3 = Color3.fromRGB(210,210,210),
			PlaceholderText = (type(WindowConfig.SearchBar) == "table" and WindowConfig.SearchBar.Default) or "🔍 Search",	
			Font = Enum.Font.GothamBold,
			TextWrapped = true,
			Text = '',
			TextXAlignment = Enum.TextXAlignment.Center,
			TextSize = 14,
			ClearTextOnFocus = (type(WindowConfig.SearchBar) == "table" and WindowConfig.SearchBar.ClearTextOnFocus ~= nil and WindowConfig.SearchBar.ClearTextOnFocus) or true	
		})

		local TextboxActual = AddThemeObject(SearchBox, "Text")

		local SearchBar = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 6), {
			Parent = WindowStuff,
			Size = UDim2.new(0, 130, 0, 24),
			Position = UDim2.new(1.013, -12, 0.075, 0),	
			AnchorPoint = Vector2.new(1, 0.5)	
		}), {
			AddThemeObject(MakeElement("Stroke"), "Stroke"),
			TextboxActual
		}), "Main")

		local function SearchHandle()
			local s, e = pcall(function()
				local Text = string.lower(SearchBox.Text);
				if not TabHolder or not TabHolder:IsA("GuiObject") then return end

				for i,v in pairs(Tabs) do
					if v and v:IsA('TextButton') then	
						if Text == "" or string.find(string.lower(i), Text) then	
							v.Visible = true
						else
							v.Visible = false
						end
					end
				end
			end)
			if not s then
			end
		end
		AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), SearchHandle);
	end

	local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
		Size = UDim2.new(1, -30, 2, 0),
		Position = UDim2.new(0, 25, 0, -24),
		Font = Enum.Font.GothamBlack,
		TextSize = 20
	}), "Text")

	local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1)
	}), "Stroke")

	local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
		Parent = Orion,
		Position = UDim2.new(0.5, -307, 0.5, -172),
		Size = UDim2.new(0, 615, 0, 344),
		ClipsDescendants = true
	}), {
		SetChildren(SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 50),
			Name = "TopBar"
		}), {
			WindowName,
			WindowTopBarLine,
			AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
				Size = UDim2.new(0, 70, 0, 30),
				Position = UDim2.new(1, -90, 0, 10)
			}), {
				AddThemeObject(MakeElement("Stroke"), "Stroke"),
				AddThemeObject(SetProps(MakeElement("Frame"), {
					Size = UDim2.new(0, 1, 1, 0),
					Position = UDim2.new(0.5, 0, 0, 0)
				}), "Stroke"),	
				CloseBtn,
				MinimizeBtn
			}), "Second"),	
		}),
		DragPoint,
		WindowStuff
	}), "Main")

	if WindowConfig.ShowIcon then
		WindowName.Position = UDim2.new(0, 50, 0, -24)
		local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {
			Size = UDim2.new(0, 20, 0, 20),
			Position = UDim2.new(0, 25, 0, 15)
		})
		WindowIcon.Parent = MainWindow.TopBar
	end	

	MakeDraggable(DragPoint, MainWindow)	

	local function MakeDraggableLocal(Frame, Button)	
		local s, e = pcall(function()
			local dragging = false
			local dragInput, mousePos, framePos

			Button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					mousePos = input.Position
					framePos = Frame.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			Button.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					dragInput = input
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					local delta = input.Position - mousePos
					Frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
				end
			end)
		end)
		if not s then
		end
	end


	local MobileReopenButton = SetChildren(SetProps(MakeElement("Button"), {
		Parent = Orion,
		Size = UDim2.new(0, 40, 0, 40),
		Position = UDim2.new(0.5, -20, 0, 20),	
		BackgroundTransparency = 0,
		BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Main,
		Visible = false,
		AnchorPoint = Vector2.new(0.5, 0.5)
	}), {
		AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://80995426799129"), {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0.7, 0, 0.7, 0)
		}), "Text"),
		MakeElement("Corner", 1)
	})

	local function MakeDraggableMobile(button)	
		local s, e = pcall(function()
			local dragging
			local dragStart
			local startPos

			local function update(input)
				local delta = input.Position - dragStart
				local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				TweenService:Create(button, TweenInfo.new(0.2), {Position = newPosition}):Play()
			end

			button.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = button.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					update(input)
				end
			end)
		end)
		if not s then
		end
	end

	MakeDraggableMobile(MobileReopenButton)	


	AddConnection(CloseBtn.MouseButton1Up, function()
		MainWindow.Visible = false
		MobileReopenButton.Visible = true
		UIHidden = true
		OrionLib:MakeNotification({
			Name = "Interface Hidden",
			Content = "Tap the open button to reopen the interface. Or Press Key M To Close Or Open",
			Time = 5
		})
		pcall(WindowConfig.CloseCallback)
	end)

	AddConnection(UserInputService.InputBegan, function(Input)
		if Input.KeyCode == Enum.KeyCode.M then
			if UIHidden then
				MainWindow.Visible = true
				MobileReopenButton.Visible = false
				UIHidden = false
			else
				MainWindow.Visible = false
				MobileReopenButton.Visible = true
				UIHidden = true
			end
		end
	end)

	AddConnection(MobileReopenButton.Activated, function()
		MainWindow.Visible = true
		MobileReopenButton.Visible = false
	end)


	AddConnection(MinimizeBtn.MouseButton1Up, function()
		if Minimized then
			TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
			MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
			wait(.02)
			MainWindow.ClipsDescendants = false
			WindowStuff.Visible = true
			WindowTopBarLine.Visible = true
		else
			MainWindow.ClipsDescendants = true
			WindowTopBarLine.Visible = false
			MinimizeBtn.Ico.Image = "rbxassetid://7072720870"

			TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
			wait(0.1)
			WindowStuff.Visible = false	
		end
		Minimized = not Minimized	
	end)

	local function LoadSequence()
		local s, e = pcall(function()
			MainWindow.Visible = false
			local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), {
				Parent = Orion,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.4, 0),
				Size = UDim2.new(0, 28, 0, 28),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				ImageTransparency = 1
			})

			local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 14), {
				Parent = Orion,
				Size = UDim2.new(1, 0, 1, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 19, 0.5, 0),
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.GothamBold,
				TextTransparency = 1
			})

			TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
			wait(0.8)
			TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(LoadSequenceText.TextBounds.X/2), 0.5, 0)}):Play()
			wait(0.3)
			TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			wait(2)
			TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			MainWindow.Visible = true
			if LoadSequenceLogo and LoadSequenceLogo.Parent then LoadSequenceLogo:Destroy() end
			if LoadSequenceText and LoadSequenceText.Parent then LoadSequenceText:Destroy() end
		end)
		if not s then
			MainWindow.Visible = true 
		end
	end	

	if WindowConfig.IntroEnabled then
		LoadSequence()
	else	
		MainWindow.Visible = true
	end	

	local TabFunction = {}
	function TabFunction:MakeTab(TabConfig)
		TabConfig = TabConfig or {}
		TabConfig.Name = TabConfig.Name or "Tab"
		TabConfig.Icon = TabConfig.Icon or ""
		TabConfig.PremiumOnly = TabConfig.PremiumOnly or false

		local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
			Size = UDim2.new(1, 0, 0, 30),
			Parent = TabHolder
		}), {
			AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 18, 0, 18),
				Position = UDim2.new(0, 10, 0.5, 0),
				ImageTransparency = 0.4,
				Name = "Ico"
			}), "Text"),
			AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
				Size = UDim2.new(1, -35, 1, 0),
				Position = UDim2.new(0, 35, 0, 0),
				Font = Enum.Font.GothamSemibold,
				TextTransparency = 0.4,
				Name = "Title"
			}), "Text")
		})

		if GetIcon(TabConfig.Icon) ~= nil then
			TabFrame.Ico.Image = GetIcon(TabConfig.Icon)
		end	

		if WindowConfig.SearchBar then
			Tabs[TabConfig.Name] = TabFrame	
		end


		local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
			Size = UDim2.new(1, -150, 1, -50),
			Position = UDim2.new(0, 150, 0, 50),
			Parent = MainWindow,
			Visible = false,
			Name = "ItemContainer"
		}), {
			MakeElement("List", 0, 6),
			MakeElement("Padding", 15, 10, 10, 15)
		}), "Divider")

		AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			if Container and Container.UIListLayout then
				Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30)
			end
		end)

		if FirstTab then
			FirstTab = false
			TabFrame.Ico.ImageTransparency = 0
			TabFrame.Title.TextTransparency = 0
			TabFrame.Title.Font = Enum.Font.GothamBlack
			Container.Visible = true
		end	

		AddConnection(TabFrame.MouseButton1Click, function()
			for _, Tab in next, TabHolder:GetChildren() do
				if Tab:IsA("TextButton") then	
					if Tab.Title and Tab.Ico then	
						Tab.Title.Font = Enum.Font.GothamSemibold
						TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.4}):Play()
						TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4}):Play()
					end
				end	
			end
			for _, ItemContainer in next, MainWindow:GetChildren() do
				if ItemContainer.Name == "ItemContainer" then
					ItemContainer.Visible = false
				end	
			end	
			if TabFrame.Ico and TabFrame.Title then	
				TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				TabFrame.Title.Font = Enum.Font.GothamBlack
			end
			Container.Visible = true	
		end)

		local function GetElements(ItemParent)
			local ElementFunction = {}
			function ElementFunction:AddLabel(Text)
				local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 0.7,
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Second")

				local LabelFunction = {}
				function LabelFunction:Set(ToChange)
					if LabelFrame and LabelFrame.Content then
						LabelFrame.Content.Text = ToChange
					end
				end
				return LabelFunction
			end
			function ElementFunction:AddParagraph(Text, Content)
				Text = Text or "Text"
				Content = Content or "Content"

				local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 0.7,
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 10),
						Font = Enum.Font.GothamBold,
						Name = "Title"
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Label", "", 13), {
						Size = UDim2.new(1, -24, 0, 0),
						Position = UDim2.new(0, 12, 0, 26),
						Font = Enum.Font.GothamSemibold,
						Name = "Content",
						TextWrapped = true
					}), "TextDark"),
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Second")

				AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
					if ParagraphFrame and ParagraphFrame.Content then
						ParagraphFrame.Content.Size = UDim2.new(1, -24, 0, ParagraphFrame.Content.TextBounds.Y)
						ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35)
					end
				end)

				ParagraphFrame.Content.Text = Content

				local ParagraphFunction = {}
				function ParagraphFunction:Set(ToChange)
					if ParagraphFrame and ParagraphFrame.Content then
						ParagraphFrame.Content.Text = ToChange
					end
				end
				return ParagraphFunction
			end	
			function ElementFunction:AddButton(ButtonConfig)
				ButtonConfig = ButtonConfig or {}
				ButtonConfig.Name = ButtonConfig.Name or "Button"
				ButtonConfig.Callback = ButtonConfig.Callback or function() end
				ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"

				local Button = {}

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 33),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), {
						Size = UDim2.new(0, 20, 0, 20),
						Position = UDim2.new(1, -30, 0, 7),
					}), "TextDark"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					Click
				}), "Second")

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					task.spawn(function() pcall(ButtonConfig.Callback) end)
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

				function Button:Set(ButtonText)
					if ButtonFrame and ButtonFrame.Content then
						ButtonFrame.Content.Text = ButtonText
					end
				end	

				return Button
			end	
			function ElementFunction:AddToggle(ToggleConfig)
				ToggleConfig = ToggleConfig or {}
				ToggleConfig.Name = ToggleConfig.Name or "Toggle"
				ToggleConfig.Default = ToggleConfig.Default or false
				ToggleConfig.Callback = ToggleConfig.Callback or function() end
				ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195)
				ToggleConfig.Flag = ToggleConfig.Flag or nil
				ToggleConfig.Save = ToggleConfig.Save or false

				local Toggle = {Value = ToggleConfig.Default, Save = ToggleConfig.Save, Type = "Toggle"}

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", ToggleConfig.Color, 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -24, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5)
				}), {
					SetProps(MakeElement("Stroke"), {
						Color = ToggleConfig.Color,
						Name = "Stroke",
						Transparency = 0.5
					}),
					SetProps(MakeElement("Image", "rbxassetid://3944680095"), {
						Size = UDim2.new(0, 20, 0, 20),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						ImageColor3 = Color3.fromRGB(255, 255, 255),
						Name = "Ico"
					}),
				})

				local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					ToggleBox,
					Click
				}), "Second")

				function Toggle:Set(Value)
					Toggle.Value = Value
					TweenService:Create(ToggleBox, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Toggle.Value and ToggleConfig.Color or OrionLib.Themes.Default.Divider}):Play()
					TweenService:Create(ToggleBox.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Toggle.Value and ToggleConfig.Color or OrionLib.Themes.Default.Stroke}):Play()
					TweenService:Create(ToggleBox.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = Toggle.Value and 0 or 1, Size = Toggle.Value and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 8, 0, 8)}):Play()
					pcall(ToggleConfig.Callback, Toggle.Value)
				end	

				Toggle:Set(Toggle.Value)

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					if OrionLib.SaveCfg and ToggleConfig.Save then pcall(SaveCfg, game.GameId) end
					Toggle:Set(not Toggle.Value)
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

				if ToggleConfig.Flag then
					OrionLib.Flags[ToggleConfig.Flag] = Toggle
				end	
				return Toggle
			end	
			function ElementFunction:AddSlider(SliderConfig)	
				SliderConfig = SliderConfig or {}
				SliderConfig.Name = SliderConfig.Name or "Slider"
				SliderConfig.Min = SliderConfig.Min or 0
				SliderConfig.Max = SliderConfig.Max or 100
				SliderConfig.Increment = SliderConfig.Increment or 1
				SliderConfig.Default = SliderConfig.Default or 50
				SliderConfig.Callback = SliderConfig.Callback or function() end
				SliderConfig.ValueName = SliderConfig.ValueName or ""
				SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98)
				SliderConfig.Flag = SliderConfig.Flag or nil
				SliderConfig.Save = SliderConfig.Save or false

				local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save, Type = "Slider"}
				local Dragging = false
				local SliderKnob	
				local KnobValueText	
				local FillValueTextLabel	

				FillValueTextLabel = SetProps(MakeElement("Label", "", 12), {
					Name = "FillValueText",
					Size = UDim2.new(1, -10, 1, 0),	
					Position = UDim2.new(0, 5, 0, 0),	
					Font = Enum.Font.GothamSemibold,	
					TextXAlignment = Enum.TextXAlignment.Left,	
					TextYAlignment = Enum.TextYAlignment.Center,
					BackgroundTransparency = 1,
				})
				AddThemeObject(FillValueTextLabel, "Text")	
				FillValueTextLabel.TextTransparency = 0	

				local SliderDrag = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {	
					Name = "SliderDrag",
					Size = UDim2.new(0, 0, 1, 0),	
					BackgroundTransparency = 0.3,	
					ClipsDescendants = true,
					ZIndex = 2	
				}), {
					FillValueTextLabel	
				})
				
				local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {
					Name = "SliderBar",
					Size = UDim2.new(1, -24, 0, 26),	
					Position = UDim2.new(0, 12, 0, 30),
					BackgroundTransparency = 0.9,	
					ZIndex = 1
				}), {
					SetProps(MakeElement("Stroke"), {	
						Color = SliderConfig.Color,
						Transparency = 0.5	
					}),
					SliderDrag	
				})
				
				SliderKnob = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", nil, 0, 6), {	
					Name = "SliderKnob",
					Size = UDim2.new(0, 12, 0, 22),	
					BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,	
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0,0,0.5,0),	
					ZIndex = SliderBar.ZIndex + 2,	
					Parent = SliderBar,
				}),{
					AddThemeObject(MakeElement("Stroke", nil, 1.5), "Stroke")	
				}), "Text")	

				KnobValueText = AddThemeObject(SetProps(MakeElement("Label", "", 12), {	
					Name = "KnobValueText",
					Size = UDim2.new(0, 60, 0, 16),	
					AnchorPoint = Vector2.new(0.5, 1),	
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Bottom,	
					Font = Enum.Font.GothamBold,
					ZIndex = SliderBar.ZIndex + 3,	
					BackgroundTransparency = 1,
					Parent = SliderBar	
				}), "Text")
				KnobValueText.TextTransparency = 0	


				local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(1, 0, 0, 65),	
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 10),	
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					SliderBar	
				}), "Second")

				local knobOriginalSize = SliderKnob.Size
				local knobPressedSize = UDim2.new(knobOriginalSize.X.Scale, knobOriginalSize.X.Offset + 2, knobOriginalSize.Y.Scale, knobOriginalSize.Y.Offset + 2)


				AddConnection(SliderBar.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then	
						Dragging = true	
						TweenService:Create(SliderKnob, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = knobPressedSize}):Play()	
						
						local interactionPos = Input.Position	
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then
							interactionPos = UserInputService:GetMouseLocation()	
						end
						local relativeX = interactionPos.X - SliderBar.AbsolutePosition.X
						local SizeScale = math.clamp(relativeX / SliderBar.AbsoluteSize.X, 0, 1)
						Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale))
						if OrionLib.SaveCfg and SliderConfig.Save then pcall(SaveCfg, game.GameId) end
					end	
				end)
				AddConnection(SliderBar.InputEnded, function(Input)	
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then	
						Dragging = false	
						TweenService:Create(SliderKnob, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = knobOriginalSize}):Play()	
						if OrionLib.SaveCfg and SliderConfig.Save then pcall(SaveCfg, game.GameId) end	
					end	
				end)

				AddConnection(UserInputService.InputChanged, function(Input)
					if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then	
						local interactionPos = Input.Position	
						if Input.UserInputType == Enum.UserInputType.MouseMovement then
							interactionPos = UserInputService:GetMouseLocation()
						end
						local SizeScale = math.clamp((interactionPos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
						Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale))	
					end
				end)

				function Slider:Set(Value)
					self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)
					local percentage = (self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min)
					if SliderConfig.Max == SliderConfig.Min then percentage = 0 end	

					local tweenInfo = TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

					TweenService:Create(SliderDrag, tweenInfo, {Size = UDim2.fromScale(percentage, 1)}):Play()
					if SliderKnob then
						TweenService:Create(SliderKnob, tweenInfo, {Position = UDim2.new(percentage, 0, 0.5, 0)}):Play()
					end

					local displayValue = tostring(self.Value) .. (SliderConfig.ValueName and " " .. SliderConfig.ValueName or "")
					
					if KnobValueText then
						KnobValueText.Text = displayValue
						KnobValueText.Position = UDim2.new(percentage, 0, 0, -5)	
					end
					
					if FillValueTextLabel then	
						FillValueTextLabel.Text = displayValue
					end
					
					pcall(SliderConfig.Callback, self.Value)
				end	 	

				Slider:Set(Slider.Value)	
				if SliderConfig.Flag then				
					OrionLib.Flags[SliderConfig.Flag] = Slider
				end
				return Slider
			end	
			function ElementFunction:AddDropdown(DropdownConfig)
				DropdownConfig = DropdownConfig or {}
				DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
				DropdownConfig.Options = DropdownConfig.Options or {}
				DropdownConfig.Default = DropdownConfig.Default or ""
				DropdownConfig.Callback = DropdownConfig.Callback or function() end
				DropdownConfig.Flag = DropdownConfig.Flag or nil
				DropdownConfig.Save = DropdownConfig.Save or false

				local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save}
				local MaxElements = 5

				if not table.find(Dropdown.Options, Dropdown.Value) then
					if #Dropdown.Options > 0 then
						Dropdown.Value = Dropdown.Options[1]	
					else
						Dropdown.Value = "..."
					end
				end

				local DropdownList = MakeElement("List")

				local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
					DropdownList
				}), {
					Position = UDim2.new(0, 0, 0, 38),
					Size = UDim2.new(1, 0, 1, -38),
					ClipsDescendants = true
				}), "Divider")
				
				if DropdownContainer and not DropdownContainer:FindFirstChild("UIPadding") then
					local padding = MakeElement("Padding", 4,4,4,4)
					padding.Parent = DropdownContainer
				end


				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent,
					ClipsDescendants = true
				}), {
					DropdownContainer,
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
							Size = UDim2.new(0, 20, 0, 20),
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(1, -30, 0.5, 0),
							ImageColor3 = Color3.fromRGB(240, 240, 240),
							Name = "Ico"
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {
							Size = UDim2.new(1, -40, 1, 0),
							Font = Enum.Font.Gotham,
							Name = "Selected",
							TextXAlignment = Enum.TextXAlignment.Right
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"),	
						Click
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					MakeElement("Corner")
				}), "Second")
				
				DropdownContainer.Parent = DropdownFrame


				AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					if DropdownContainer and DropdownList then
						DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
					end
				end)	

				local function AddOptions(Options)
					for _, Option in pairs(Options) do
						local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
							MakeElement("Corner", 0, 6),
							AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, -8, 1, 0),
								Name = "Title"
							}), "Text")
						}), {
							Parent = DropdownContainer,
							Size = UDim2.new(1, 0, 0, 28),
							BackgroundTransparency = 1,
							ClipsDescendants = true
						}), "Divider")

						AddConnection(OptionBtn.MouseButton1Click, function()
							Dropdown:Set(Option)
							if OrionLib.SaveCfg and DropdownConfig.Save then pcall(SaveCfg, game.GameId) end
						end)

						Dropdown.Buttons[Option] = OptionBtn
					end
				end	

				function Dropdown:Refresh(Options, Delete)
					if Delete then
						for _,v in pairs(Dropdown.Buttons) do
							if v and v.Parent then pcall(function() v:Destroy() end) end
						end	
						table.clear(Dropdown.Options)
						table.clear(Dropdown.Buttons)
					end
					Dropdown.Options = Options or {}
					AddOptions(Dropdown.Options)
				end	

				function Dropdown:Set(Value)
					if not table.find(Dropdown.Options, Value) then
						if #Dropdown.Options > 0 then
							Dropdown.Value = Dropdown.Options[1]
						else
							Dropdown.Value = "..."
						end
						if DropdownFrame and DropdownFrame.F and DropdownFrame.F.Selected then
							DropdownFrame.F.Selected.Text = Dropdown.Value
						end
						for optKey, optButton in pairs(Dropdown.Buttons) do
							if optButton and optButton.Parent then
								TweenService:Create(optButton,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
								if optButton.Title then TweenService:Create(optButton.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play() end
							end
						end	
						return pcall(DropdownConfig.Callback, Dropdown.Value)	
					end

					Dropdown.Value = Value
					if DropdownFrame and DropdownFrame.F and DropdownFrame.F.Selected then
						DropdownFrame.F.Selected.Text = Dropdown.Value
					end

					for optKey, optButton in pairs(Dropdown.Buttons) do
						if optButton and optButton.Parent then
							TweenService:Create(optButton,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
							if optButton.Title then TweenService:Create(optButton.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play() end
						end
					end	
					if Dropdown.Buttons[Value] and Dropdown.Buttons[Value].Parent then
						TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
						if Dropdown.Buttons[Value].Title then TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0}):Play() end
					end
					return pcall(DropdownConfig.Callback, Dropdown.Value)
				end

				AddConnection(Click.MouseButton1Click, function()
					Dropdown.Toggled = not Dropdown.Toggled
					if DropdownFrame and DropdownFrame.F and DropdownFrame.F.Line then
						DropdownFrame.F.Line.Visible = Dropdown.Toggled
					end
					if DropdownFrame and DropdownFrame.F and DropdownFrame.F.Ico then
						TweenService:Create(DropdownFrame.F.Ico,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = Dropdown.Toggled and 180 or 0}):Play()
					end
					
					local targetHeight
					if Dropdown.Toggled then
						local contentHeight = 0
						if DropdownList and DropdownList.AbsoluteContentSize then contentHeight = DropdownList.AbsoluteContentSize.Y end
						
						local paddingOffset = 0
						if DropdownContainer and DropdownContainer:FindFirstChildOfClass("UIPadding") then
							paddingOffset = DropdownContainer.UIPadding.PaddingTop.Offset + DropdownContainer.UIPadding.PaddingBottom.Offset
						else 
							paddingOffset = 8 
						end


						if #Dropdown.Options > MaxElements then
							targetHeight = 38 + (MaxElements * 28) + paddingOffset
						else
							targetHeight = 38 + contentHeight + paddingOffset
						end
						if #Dropdown.Options == 0 then targetHeight = 38 end	
					else
						targetHeight = 38
					end
					if DropdownFrame then
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
					end
				end)

				Dropdown:Refresh(Dropdown.Options, false)
				Dropdown:Set(Dropdown.Value)
				if DropdownConfig.Flag then				
					OrionLib.Flags[DropdownConfig.Flag] = Dropdown
				end
				return Dropdown
			end
			function ElementFunction:AddBind(BindConfig)
				BindConfig.Name = BindConfig.Name or "Bind"
				BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
				BindConfig.Hold = BindConfig.Hold or false
				BindConfig.Callback = BindConfig.Callback or function() end
				BindConfig.Flag = BindConfig.Flag or nil
				BindConfig.Save = BindConfig.Save or false

				local Bind = {Value = BindConfig.Default, Binding = false, Type = "Bind", Save = BindConfig.Save}
				local Holding = false

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					AddThemeObject(SetProps(MakeElement("Label", "", 14), {	
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.GothamBold,
						TextXAlignment = Enum.TextXAlignment.Center,
						Name = "Value"
					}), "Text")
				}), "Main")

				local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					BindBox,
					Click
				}), "Second")

				AddConnection(BindBox.Value:GetPropertyChangedSignal("TextBounds"), function()	
					if BindBox and BindBox.Value then
						TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play()
					end
				end)

				AddConnection(Click.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						if Bind.Binding then return end
						Bind.Binding = true
						if BindBox and BindBox.Value then BindBox.Value.Text = "..." end
					end
				end)
				
				local CurrentInputBeganConnection
				AddConnection(UserInputService.InputBegan, function(Input)
					if UserInputService:GetFocusedTextBox() then return end
					
					local keyName = Input.KeyCode ~= Enum.KeyCode.Unknown and Input.KeyCode.Name or Input.UserInputType.Name
					
					if keyName == Bind.Value and not Bind.Binding then
						if BindConfig.Hold then
							Holding = true
							pcall(BindConfig.Callback, Holding)
						else
							pcall(BindConfig.Callback)
						end
					elseif Bind.Binding then
						local CapturedKey
						if not CheckKey(BlacklistedKeys, Input.KeyCode) and Input.KeyCode ~= Enum.KeyCode.Unknown then
							CapturedKey = Input.KeyCode.Name
						elseif CheckKey(WhitelistedMouse, Input.UserInputType) then
							CapturedKey = Input.UserInputType.Name
						end

						if CapturedKey then
							Bind:Set(CapturedKey)
							if OrionLib.SaveCfg and BindConfig.Save then pcall(SaveCfg, game.GameId) end
						else	
							Bind:Set(Bind.Value)	
						end
						Bind.Binding = false	
					end
				end)

				AddConnection(UserInputService.InputEnded, function(Input)
					local keyName = Input.KeyCode ~= Enum.KeyCode.Unknown and Input.KeyCode.Name or Input.UserInputType.Name
					if keyName == Bind.Value then
						if BindConfig.Hold and Holding then
							Holding = false
							pcall(BindConfig.Callback, Holding)
						end
					end
				end)


				AddConnection(Click.MouseEnter, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()	
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

				function Bind:Set(Key)
					Bind.Binding = false	
					Bind.Value = (type(Key) == "EnumItem" and Key.Name) or (type(Key) == "string" and Key) or "None"
					if BindBox and BindBox.Value then BindBox.Value.Text = Bind.Value end
					task.wait()	
					if BindBox and BindBox.Value and BindBox.Value.TextBounds.X > 0 then	
						TweenService:Create(BindBox, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play()
					end
				end
				
				Bind:Set(BindConfig.Default)	
				if BindConfig.Flag then				
					OrionLib.Flags[BindConfig.Flag] = Bind
				end
				return Bind
			end	
			function ElementFunction:AddTextbox(TextboxConfig)
				TextboxConfig = TextboxConfig or {}
				TextboxConfig.Name = TextboxConfig.Name or "Textbox"
				TextboxConfig.Default = TextboxConfig.Default or ""
				TextboxConfig.ClearTextOnFocus = TextboxConfig.ClearTextOnFocus 
				TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false
				TextboxConfig.Callback = TextboxConfig.Callback or function() end
				TextboxConfig.Numeric = TextboxConfig.Numeric or false
				TextboxConfig.Flag = TextboxConfig.Flag or nil
				TextboxConfig.Save = TextboxConfig.Save or false
			
				local initialValue
				if TextboxConfig.Numeric then
					initialValue = tonumber(TextboxConfig.Default) or 0
				else
					initialValue = TextboxConfig.Default
				end
			
				local Textbox = {Value = initialValue, Save = TextboxConfig.Save, Type = "Textbox"}
				local previousText = tostring(Textbox.Value) 
			
				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})
			
				local TextboxActual = AddThemeObject(Create("TextBox", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					PlaceholderColor3 = Color3.fromRGB(210,210,210),
					PlaceholderText = "Input",
					Font = Enum.Font.GothamSemibold,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextSize = 14,
					Text = previousText,
					ClearTextOnFocus = TextboxConfig.ClearTextOnFocus or false
				}), "Text")
			
				local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					TextboxActual
				}), "Main")
			
				local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					TextContainer,
					Click
				}), "Second")
			
				AddConnection(TextboxActual.FocusLost, function(enterPressed)
					local currentText = TextboxActual.Text
					local processedValue
					local isValid = false
			
					if TextboxConfig.Numeric then
						local num = tonumber(currentText)
						if num ~= nil then
							processedValue = num
							Textbox.Value = num
							previousText = currentText 
							isValid = true
						else
							TextboxActual.Text = previousText 
							processedValue = Textbox.Value 
						end
					else
						processedValue = currentText
						Textbox.Value = currentText
						isValid = true
					end
			
					if isValid then
						pcall(TextboxConfig.Callback, Textbox.Value, enterPressed)
					end
			
					if TextboxConfig.TextDisappear and isValid then
						TextboxActual.Text = ""
					end
			
					if OrionLib.SaveCfg and Textbox.Save and isValid then
						pcall(SaveCfg, game.GameId)
					end
				end)
			
				AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()
					if TextboxConfig.Numeric then
						if TextboxActual.Text ~= "" and not tonumber(TextboxActual.Text) then
							if not (TextboxActual.Text == "-" or string.match(TextboxActual.Text, "^%-?%.?$") or string.match(TextboxActual.Text, "^%-?[0-9]*%.?[0-9]*$")) then
								local pos = TextboxActual.CursorPosition
								TextboxActual.Text = previousText
								TextboxActual.CursorPosition = pos - 1 
							end
						else
							
						end
					end
					if TextContainer and TextboxActual and TextboxActual.TextBounds.X > 0 then
						TweenService:Create(TextContainer, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)}):Play()
					elseif TextContainer then 
						TweenService:Create(TextContainer, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 24, 0, 24)}):Play() 
					end
				end)
			
				task.wait()
				if TextboxActual and TextContainer and TextboxActual.TextBounds.X > 0 then
					TextContainer.Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)
				elseif TextContainer then
					TextContainer.Size = UDim2.new(0, 24, 0, 24)
				end
			
				AddConnection(Click.MouseEnter, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)
			
				AddConnection(Click.MouseLeave, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)
			
				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					TextboxActual:CaptureFocus()
				end)
			
				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)
			
				function Textbox:Set(value, suppressCallback)
					local textForDisplay
					if TextboxConfig.Numeric then
						local num = tonumber(value)
						if num ~= nil then
							self.Value = num
							textForDisplay = tostring(num)
							previousText = textForDisplay
						else
							textForDisplay = previousText 
						end
					else
						self.Value = value
						textForDisplay = tostring(value)
					end
					TextboxActual.Text = textForDisplay
			
					if not suppressCallback then
						pcall(TextboxConfig.Callback, self.Value, false)
					end
			
					if OrionLib.SaveCfg and self.Save then
						pcall(SaveCfg, game.GameId)
					end
				end
			
				if TextboxConfig.Flag then				
					OrionLib.Flags[TextboxConfig.Flag] = Textbox
				end
				return Textbox
			end	
			function ElementFunction:AddColorpicker(ColorpickerConfig)	
				ColorpickerConfig = ColorpickerConfig or {}
				ColorpickerConfig.Name = ColorpickerConfig.Name or "Colorpicker"
				ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255,255,255)
				ColorpickerConfig.Callback = ColorpickerConfig.Callback or function() end
				ColorpickerConfig.Flag = ColorpickerConfig.Flag or nil
				ColorpickerConfig.Save = ColorpickerConfig.Save or false
			
				local ColorH, ColorS, ColorV	
				local Colorpicker = {Value = ColorpickerConfig.Default, Toggled = false, Type = "Colorpicker", Save = ColorpickerConfig.Save}
			
				local h_init, s_init, v_init = Color3.toHSV(ColorpickerConfig.Default)
				ColorH, ColorS, ColorV = h_init, s_init, v_init
			
				local ColorSelection = Create("ImageLabel", {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(ColorS, 0, 1 - ColorV, 0),
					ScaleType = Enum.ScaleType.Fit,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000",
					ZIndex = 3
				})
			
				local HueSelection = Create("ImageLabel", {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0.5, 0, ColorH, 0),	
					ScaleType = Enum.ScaleType.Fit,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000",
					ZIndex = 3
				})
			
				local ColorImageDisplay = Create("ImageLabel", {
					Name = "ColorImageDisplay",
					Size = UDim2.new(1, -25, 1, 0),
					Visible = false,
					Image = "rbxassetid://4155801252",
					BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1),	
					ZIndex = 2
				}, {
					Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
					ColorSelection
				})
			
				local HueBarDisplay = Create("Frame", {
					Name = "HueBarDisplay",
					Size = UDim2.new(0, 20, 1, 0),
					Position = UDim2.new(1, -20, 0, 0),
					Visible = false,
					ZIndex = 2
				}, {
					Create("UIGradient", {Rotation = 270, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),ColorSequenceKeypoint.new(0.16,Color3.fromRGB(255,255,0)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))},}),
					Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
					HueSelection
				})
			
				local ColorpickerContainer = Create("Frame", {
					Position = UDim2.new(0, 0, 0, 32),
					Size = UDim2.new(1, 0, 1, -32),
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					ZIndex = 1
				}, {
					HueBarDisplay,
					ColorImageDisplay,
					Create("UIPadding", {
						PaddingLeft = UDim.new(0, 35),
						PaddingRight = UDim.new(0, 35),
						PaddingBottom = UDim.new(0, 10),
						PaddingTop = UDim.new(0, 17)
					})
				})
			
				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})
			
				local ColorpickerBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", ColorpickerConfig.Default, 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Main")
				ColorpickerBox.BackgroundColor3 = ColorpickerConfig.Default
			
				local ColorpickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent,
					ClipsDescendants = true
				}), {
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", ColorpickerConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						ColorpickerBox,
						Click,
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"),	
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					ColorpickerContainer,
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
				}), "Second")
			
				AddConnection(Click.MouseButton1Click, function()
					Colorpicker.Toggled = not Colorpicker.Toggled
					TweenService:Create(ColorpickerFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Colorpicker.Toggled and UDim2.new(1, 0, 0, 148) or UDim2.new(1, 0, 0, 38)}):Play()
					ColorImageDisplay.Visible = Colorpicker.Toggled
					HueBarDisplay.Visible = Colorpicker.Toggled
					ColorpickerFrame.F.Line.Visible = Colorpicker.Toggled
				end)
				
				local ColorInputConn, HueInputConn
			
				local function UpdateColorPicker()
					local newColor = Color3.fromHSV(ColorH, ColorS, ColorV)
					ColorpickerBox.BackgroundColor3 = newColor
					ColorImageDisplay.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)	
					
					if Colorpicker.Value ~= newColor then
						Colorpicker:Set(newColor, true)	
					end
				end
				
				AddConnection(ColorImageDisplay.InputBegan, function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if ColorInputConn then pcall(function() ColorInputConn:Disconnect() end) end
						ColorInputConn = AddConnection(RunService.RenderStepped, function()
							local interactionPos = input.UserInputType == Enum.UserInputType.Touch and input.Position or Vector2.new(Mouse.X, Mouse.Y)
							local ColorX = math.clamp((interactionPos.X - ColorImageDisplay.AbsolutePosition.X) / ColorImageDisplay.AbsoluteSize.X, 0, 1)
							local ColorY = math.clamp((interactionPos.Y - ColorImageDisplay.AbsolutePosition.Y) / ColorImageDisplay.AbsoluteSize.Y, 0, 1)
							ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
							ColorS = ColorX
							ColorV = 1 - ColorY	
							UpdateColorPicker()
						end)
					end
				end)
			
				AddConnection(HueBarDisplay.InputBegan, function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if HueInputConn then pcall(function() HueInputConn:Disconnect() end) end;
						HueInputConn = AddConnection(RunService.RenderStepped, function()
							local interactionPos = input.UserInputType == Enum.UserInputType.Touch and input.Position or Vector2.new(Mouse.X, Mouse.Y)
							local HueY = math.clamp((interactionPos.Y - HueBarDisplay.AbsolutePosition.Y) / HueBarDisplay.AbsoluteSize.Y, 0, 1)
							HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
							ColorH = HueY	
							UpdateColorPicker()
						end)
					end
				end)

				local function DisconnectInputs()
					if ColorInputConn then pcall(function() ColorInputConn:Disconnect() end); ColorInputConn = nil; end
					if HueInputConn then pcall(function() HueInputConn:Disconnect() end); HueInputConn = nil; end
				end

				AddConnection(UserInputService.InputEnded, function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						DisconnectInputs()
						if OrionLib.SaveCfg and Colorpicker.Save then pcall(SaveCfg, game.GameId) end
					end
				end)
				AddConnection(ColorImageDisplay.MouseLeave, DisconnectInputs)
				AddConnection(HueBarDisplay.MouseLeave, DisconnectInputs)

				function Colorpicker:Set(Value, internalCall)
					Colorpicker.Value = Value
					if not internalCall then	
						local h,s,v = Color3.toHSV(Value)
						ColorH, ColorS, ColorV = h,s,v
						ColorImageDisplay.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
						ColorSelection.Position = UDim2.new(ColorS,0,1-ColorV,0)
						HueSelection.Position = UDim2.new(0.5,0,ColorH,0)
					end
					ColorpickerBox.BackgroundColor3 = Colorpicker.Value	
					pcall(ColorpickerConfig.Callback, Colorpicker.Value)
					if OrionLib.SaveCfg and self.Save and not internalCall then pcall(SaveCfg, game.GameId) end
				end
			
				Colorpicker:Set(ColorpickerConfig.Default)	
				if ColorpickerConfig.Flag then				
					OrionLib.Flags[ColorpickerConfig.Flag] = Colorpicker
				end
				return Colorpicker
			end	
			return ElementFunction	
		end	

		local ElementFunction = {}

		function ElementFunction:AddSection(SectionConfig)
			SectionConfig.Name = SectionConfig.Name or "Section"

			local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 26),
				Parent = Container
			}), {
				AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
					Size = UDim2.new(1, -12, 0, 16),
					Position = UDim2.new(0, 0, 0, 3),
					Font = Enum.Font.GothamSemibold
				}), "TextDark"),
				SetChildren(SetProps(MakeElement("TFrame"), {
					AnchorPoint = Vector2.new(0, 0),
					Size = UDim2.new(1, 0, 1, -24),
					Position = UDim2.new(0, 0, 0, 23),
					Name = "Holder"
				}), {
					MakeElement("List", 0, 6)
				}),
			})

			AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				if SectionFrame and SectionFrame.Parent and SectionFrame.Holder and SectionFrame.Holder.Parent and SectionFrame.Holder.UIListLayout then
					SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
					SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
				end
			end)

			local SectionFunction = {}
			for i, v in next, GetElements(SectionFrame.Holder) do
				SectionFunction[i] = v	
			end
			return SectionFunction
		end	

		for i, v in next, GetElements(Container) do
			ElementFunction[i] = v	
		end

		if TabConfig.PremiumOnly then
			for i, v in next, ElementFunction do
				ElementFunction[i] = function() end
			end	
			if Container:FindFirstChild("UIListLayout") then pcall(function() Container:FindFirstChild("UIListLayout"):Destroy() end) end
			if Container:FindFirstChild("UIPadding") then pcall(function() Container:FindFirstChild("UIPadding"):Destroy() end) end
			
			SetChildren(SetProps(MakeElement("TFrame"), {	
				Size = UDim2.new(1, 0, 1, 0),
				Parent = Container	
			}), {
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0, 15, 0, 15),
					ImageTransparency = 0.4
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "Unauthorised Access", 14), {
					Size = UDim2.new(1, -38, 0, 14),
					Position = UDim2.new(0, 38, 0, 18),
					TextTransparency = 0.4
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4483345875"), {
					Size = UDim2.new(0, 56, 0, 56),
					Position = UDim2.new(0, 84, 0, 110),
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "Premium Features", 14), {
					Size = UDim2.new(1, -150, 0, 14),
					Position = UDim2.new(0, 150, 0, 112),
					Font = Enum.Font.GothamBold
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "This part of the script is locked to Sirius Premium users. Purchase Premium in the Discord server (discord.gg/sirius)", 12), {
					Size = UDim2.new(1, -200, 0, 14),
					Position = UDim2.new(0, 150, 0, 138),
					TextWrapped = true,
					TextTransparency = 0.4
				}), "Text")
			})
		end
		return ElementFunction	
	end	
	
	return TabFunction
end	

function OrionLib:Destroy()
	if Orion and Orion.Parent then pcall(function() Orion:Destroy() end) end
end

return OrionLib
