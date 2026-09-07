--[[
  ╭━━━┳━━━┳━━━┳━━━┳━━━╮
  ╰━━━┻━━━┻━━━┻━━━┻━━━╯
  Rayfield Interface Suite
  by Sirius
  _____________
  shlex        | Designing + Programming
  iRay         | Programming
  TheWildKaden | Spear Spin-off
  ╭━━━┳━━━┳━━━┳━━━┳━━━╮
  ╰━━━┻━━━┻━━━┻━━━┻━━━╯
]]



local Release = "Beta 8"
local NotificationDuration = 6.5
local RayfieldFolder = "Rayfield"
local ConfigurationFolder = RayfieldFolder .. "/Configurations"
local ConfigurationExtension = ".rfld"



local RayfieldLibrary = {
    Flags = {},
    Theme = {
        Default = {
			TextFont = "Default", -- Default will use the various font faces used across Rayfield
			TextColor = Color3.fromRGB(240, 240, 240),

			Background = Color3.fromRGB(25, 25, 25),
			Topbar = Color3.fromRGB(34, 34, 34),
			Shadow = Color3.fromRGB(20, 20, 20),

			NotificationBackground = Color3.fromRGB(20, 20, 20),
			NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

			TabBackground = Color3.fromRGB(80, 80, 80),
			TabStroke = Color3.fromRGB(85, 85, 85),
			TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
			TabTextColor = Color3.fromRGB(240, 240, 240),
			SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

			ElementBackground = Color3.fromRGB(35, 35, 35),
			ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
			SecondaryElementBackground = Color3.fromRGB(25, 25, 25), -- For labels and paragraphs
			ElementStroke = Color3.fromRGB(50, 50, 50),
			SecondaryElementStroke = Color3.fromRGB(40, 40, 40), -- For labels and paragraphs

			SliderBackground = Color3.fromRGB(43, 105, 159),
			SliderProgress = Color3.fromRGB(43, 105, 159),
			SliderStroke = Color3.fromRGB(48, 119, 177),

			ToggleBackground = Color3.fromRGB(30, 30, 30),
			ToggleEnabled = Color3.fromRGB(0, 146, 214),
			ToggleDisabled = Color3.fromRGB(100, 100, 100),
			ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
			ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
			ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
			ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

			InputBackground = Color3.fromRGB(30, 30, 30),
			InputStroke = Color3.fromRGB(65, 65, 65),
			PlaceholderColor = Color3.fromRGB(178, 178, 178)
        },
        Light = {
            TextFont = "Gotham",                    -- Default will use the various font faces used across Rayfield
            TextColor = Color3.fromRGB(50, 50, 50), -- i need to make all text 240, 240, 240 and base gray on transparency not color to do this

            Background = Color3.fromRGB(255, 255, 255),
            Topbar = Color3.fromRGB(217, 217, 217),
            Shadow = Color3.fromRGB(223, 223, 223),

            NotificationBackground = Color3.fromRGB(20, 20, 20),
            NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

            TabBackground = Color3.fromRGB(220, 220, 220),
            TabStroke = Color3.fromRGB(112, 112, 112),
            TabBackgroundSelected = Color3.fromRGB(0, 142, 208),
            TabTextColor = Color3.fromRGB(240, 240, 240),
            SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

            ElementBackground = Color3.fromRGB(198, 198, 198),
            ElementBackgroundHover = Color3.fromRGB(230, 230, 230),
            SecondaryElementBackground = Color3.fromRGB(136, 136, 136), -- For labels and paragraphs
            ElementStroke = Color3.fromRGB(180, 199, 97),
            SecondaryElementStroke = Color3.fromRGB(40, 40, 40),        -- For labels and paragraphs

            SliderBackground = Color3.fromRGB(31, 159, 71),
            SliderProgress = Color3.fromRGB(31, 159, 71),
            SliderStroke = Color3.fromRGB(42, 216, 94),

            ToggleBackground = Color3.fromRGB(170, 203, 60),
            ToggleEnabled = Color3.fromRGB(32, 214, 29),
            ToggleDisabled = Color3.fromRGB(100, 22, 23),
            ToggleEnabledStroke = Color3.fromRGB(17, 255, 0),
            ToggleDisabledStroke = Color3.fromRGB(65, 8, 8),
            ToggleEnabledOuterStroke = Color3.fromRGB(0, 170, 0),
            ToggleDisabledOuterStroke = Color3.fromRGB(170, 0, 0),

            InputBackground = Color3.fromRGB(31, 159, 71),
            InputStroke = Color3.fromRGB(19, 65, 31),
            PlaceholderColor = Color3.fromRGB(178, 178, 178)
        }
    }
}



-- Services

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Interface Management
local Rayfield = game:GetObjects("rbxassetid://10804731440")[1]

Rayfield.Enabled = false


if gethui then
    Rayfield.Parent = gethui()
elseif syn.protect_gui then
    syn.protect_gui(Rayfield)
    Rayfield.Parent = CoreGui
elseif CoreGui:FindFirstChild("RobloxGui") then
    Rayfield.Parent = CoreGui:FindFirstChild("RobloxGui")
else
    Rayfield.Parent = CoreGui
end

if gethui then
    for _, Interface in ipairs(gethui():GetChildren()) do
        if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
            Interface.Enabled = false
            Interface.Name = "Rayfield-Old"
        end
    end
else
    for _, Interface in ipairs(CoreGui:GetChildren()) do
        if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
            Interface.Enabled = false
            Interface.Name = "Rayfield-Old"
        end
    end
end

-- Object Variables

local Camera = workspace.CurrentCamera
local Main = Rayfield.Main
local Topbar = Main.Topbar
local Elements = Main.Elements
local LoadingFrame = Main.LoadingFrame
local TabList = Main.TabList

Rayfield.DisplayOrder = 100
LoadingFrame.Version.Text = Release


-- Variables

local request = (syn and syn.request) or (http and http.request) or http_request
local CFileName = nil
local CEnabled = false
local Minimised = false
local Hidden = false
local Debounce = false
local Notifications = Rayfield.Notifications

local SelectedTheme = RayfieldLibrary.Theme.Default

function ChangeTheme(ThemeName)
	SelectedTheme = RayfieldLibrary.Theme[ThemeName]
	for _, obj in ipairs(Rayfield:GetDescendants()) do
		if obj.ClassName == "TextLabel" or obj.ClassName == "TextBox" or obj.ClassName == "TextButton" then
			if SelectedTheme.TextFont ~= "Default" then 
				obj.TextColor3 = SelectedTheme.TextColor
				obj.Font = SelectedTheme.TextFont
			end
		end
	end

	Rayfield.Main.BackgroundColor3 = SelectedTheme.Background
	Rayfield.Main.Topbar.BackgroundColor3 = SelectedTheme.Topbar
	Rayfield.Main.Topbar.CornerRepair.BackgroundColor3 = SelectedTheme.Topbar
	Rayfield.Main.Shadow.Image.ImageColor3 = SelectedTheme.Shadow

	Rayfield.Main.Topbar.ChangeSize.ImageColor3 = SelectedTheme.TextColor
	Rayfield.Main.Topbar.Hide.ImageColor3 = SelectedTheme.TextColor
	Rayfield.Main.Topbar.Theme.ImageColor3 = SelectedTheme.TextColor

	for _, TabPage in ipairs(Elements:GetChildren()) do
		for _, Element in ipairs(TabPage:GetChildren()) do
			if Element.ClassName == "Frame" and Element.Name ~= "Placeholder" and Element.Name ~= "SectionSpacing" and Element.Name ~= "SectionTitle"  then
				Element.BackgroundColor3 = SelectedTheme.ElementBackground
				Element.UIStroke.Color = SelectedTheme.ElementStroke
			end
		end
	end

end

local function AddDraggingFunctionality(DragPoint, Main)
    pcall(function()
        local Dragging, DragInput, MousePos, FramePos = false
        DragPoint.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
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
        DragPoint.InputChanged:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                DragInput = Input
            end
        end)
        UserInputService.InputChanged:Connect(function(Input)
            if Input == DragInput and Dragging then
                local Delta = Input.Position - MousePos
                TweenService:Create(Main, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                    {
                        Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale,
                            FramePos.Y.Offset + Delta.Y)
                    }):Play()
            end
        end)
    end)
end

local function PackColor(Color)
    return { R = Color.R * 255, G = Color.G * 255, B = Color.B * 255 }
end

local function UnpackColor(Color)
    return Color3.fromRGB(Color.R, Color.G, Color.B)
end

local function LoadConfiguration(Configuration)
    local Data = HttpService:JSONDecode(Configuration)
    for FlagName, FlagValue in next, Data do
        if RayfieldLibrary.Flags[FlagName] then
            spawn(function()
                if RayfieldLibrary.Flags[FlagName].Type == "ColorPicker" then
                    RayfieldLibrary.Flags[FlagName]:Set(UnpackColor(FlagValue))
                else
                    if RayfieldLibrary.Flags[FlagName].CurrentValue or RayfieldLibrary.Flags[FlagName].CurrentKeybind or RayfieldLibrary.Flags[FlagName].CurrentOption or RayfieldLibrary.Flags[FlagName].Color ~= FlagValue then
                        RayfieldLibrary.Flags[FlagName]:Set(FlagValue)
                    end
                end
            end)
        else
            RayfieldLibrary:Notify({
                Title = "Flag Error",
                Content = "Rayfield was unable to find '" ..
                    FlagName .. "'' in the current script"
            })
        end
    end
end

local function SaveConfiguration()
    if not CEnabled then return end
    local Data = {}
    for i, v in pairs(RayfieldLibrary.Flags) do
        if v.Type == "ColorPicker" then
            Data[i] = PackColor(v.Color)
        else
            Data[i] = v.CurrentValue or v.CurrentKeybind or v.CurrentOption or v.Color
        end
    end
    writefile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
end

local neon = (function()
    local module = {}

    local function IsNotNaN(x)
        return x == x
    end

    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")

    local continued = IsNotNaN(Camera:ScreenPointToRay(0, 0).Origin.X)
    while not continued do
        RunService.RenderStepped:Wait()
        continued = IsNotNaN(Camera:ScreenPointToRay(0, 0).Origin.X)
    end

    local RootParent = Camera

    if getgenv().SecureMode == nil then
        RootParent = Camera
    elseif not getgenv().SecureMode then
        RootParent = Camera
    else
        RootParent = nil
    end

    if not RootParent then
        return module
    end

    local binds = {}
    local root = Instance.new("Folder")
    root.Name = "neon"
    root.Parent = RootParent

    local GenUid
    do
        local id = 0
        function GenUid()
            id += 1
            return "neon::" .. tostring(id)
        end
    end

    local function CreatePart()
        local part = Instance.new("Part")
        part.FormFactor = Enum.FormFactor.Custom
        part.TopSurface = Enum.SurfaceType.Smooth
        part.BottomSurface = Enum.SurfaceType.Smooth
        part.Anchored = true
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
        part.CastShadow = false
        part.Material = Enum.Material.Neon
        part.Size = Vector3.new(0.2, 0.2, 0.2)

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.Wedge
        mesh.Name = "WedgeMesh"
        mesh.Parent = part

        return part
    end

    local function DrawTriangle(v1, v2, v3, p0, p1)
        local acos = math.acos
        local sqrt = math.sqrt
        local pi = math.pi

        local s1 = (v1 - v2).Magnitude
        local s2 = (v2 - v3).Magnitude
        local s3 = (v3 - v1).Magnitude
        local smax = math.max(s1, s2, s3)

        local A, B, C

        if s1 == smax then
            A, B, C = v1, v2, v3
        elseif s2 == smax then
            A, B, C = v2, v3, v1
        else
            A, B, C = v3, v1, v2
        end

        local AB = B - A
        local AC = C - A
        local length = AB.Magnitude

        local para = AB:Dot(AC) / length
        local perp = sqrt(math.max(0, AC:Dot(AC) - para ^ 2))
        local difPara = length - para

        local st = CFrame.new(B, A)
        local za = CFrame.Angles(pi / 2, 0, 0)
        local cf0 = st
        local topLook = (cf0 * za).LookVector
        local mid = A + CFrame.new(A, B).LookVector * para
        local neededLook = CFrame.new(mid, C).LookVector
        local dot = math.clamp(topLook:Dot(neededLook), -1, 1)
        local angle = acos(dot)

        cf0 *= CFrame.Angles(0, 0, angle)

        if ((cf0 * za).LookVector - neededLook).Magnitude > 0.01 then
            cf0 *= CFrame.Angles(0, 0, -2 * angle)
        end

        cf0 *= CFrame.new(0, perp / 2, -(difPara + para / 2))

        local cf1 = st * CFrame.Angles(0, 0, angle) * CFrame.Angles(0, pi, 0)

        if ((cf1 * za).LookVector - neededLook).Magnitude > 0.01 then
            cf1 *= CFrame.Angles(0, 0, 2 * angle)
        end

        cf1 *= CFrame.new(0, perp / 2, difPara / 2)

        if not p0 then
            p0 = CreatePart()
        end

        if not p1 then
            p1 = CreatePart()
        end

        p0.WedgeMesh.Scale = Vector3.new(0, perp / 0.2, para / 0.2)
        p0.CFrame = cf0

        p1.WedgeMesh.Scale = Vector3.new(0, perp / 0.2, difPara / 0.2)
        p1.CFrame = cf1

        return p0, p1
    end

    local function DrawQuad(v1, v2, v3, v4, parts)
        parts[1], parts[2] = DrawTriangle(v1, v2, v3, parts[1], parts[2])
        parts[3], parts[4] = DrawTriangle(v3, v2, v4, parts[3], parts[4])
    end

    function module:BindFrame(frame, properties)
        if RootParent == nil then
            return
        end

        if binds[frame] then
            return binds[frame].parts
        end

        local uid = GenUid()
        local parts = {}
        local folder = Instance.new("Folder")
        folder.Name = frame.Name
        folder.Parent = root

        local parents = {}

        local function add(child)
            if child and child:IsA("GuiObject") then
                parents[#parents + 1] = child
                if child.Parent then
                    add(child.Parent)
                end
            end
        end

        add(frame)

        local function UpdateOrientation(fetchProps)
            if not frame.Parent then
                module:UnbindFrame(frame)
                return
            end

            local zIndex = 1 - 0.05 * frame.ZIndex
            local tl = frame.AbsolutePosition
            local br = frame.AbsolutePosition + frame.AbsoluteSize
            local tr = Vector2.new(br.X, tl.Y)
            local bl = Vector2.new(tl.X, br.Y)

            local rotation = 0

            for _, v in ipairs(parents) do
                rotation += v.Rotation
            end

            if rotation ~= 0 and rotation % 180 ~= 0 then
                local mid = tl:Lerp(br, 0.5)
                local s = math.sin(math.rad(rotation))
                local c = math.cos(math.rad(rotation))

                local function Rotate(point)
                    return Vector2.new(c * (point.X - mid.X) - s * (point.Y - mid.Y), s * (point.X - mid.X) +
                    c * (point.Y - mid.Y)) + mid
                end

                tl = Rotate(tl)
                tr = Rotate(tr)
                bl = Rotate(bl)
                br = Rotate(br)
            end

            DrawQuad(
                Camera:ScreenPointToRay(tl.X, tl.Y, zIndex).Origin,
                Camera:ScreenPointToRay(tr.X, tr.Y, zIndex).Origin,
                Camera:ScreenPointToRay(bl.X, bl.Y, zIndex).Origin,
                Camera:ScreenPointToRay(br.X, br.Y, zIndex).Origin,
                parts
            )

            if fetchProps then
                for _, pt in pairs(parts) do
                    pt.Parent = folder
                end

                for propName, propValue in pairs(properties or {}) do
                    for _, pt in pairs(parts) do
                        pt[propName] = propValue
                    end
                end
            end
        end

        UpdateOrientation(true)
        RunService:BindToRenderStep(uid, 2000, UpdateOrientation)

        binds[frame] = {
            uid = uid,
            parts = parts,
            folder = folder
        }

        return binds[frame].parts
    end

    function module:Modify(frame, properties)
        local parts = module:GetBoundParts(frame)

        if parts then
            for propName, propValue in pairs(properties) do
                for _, pt in pairs(parts) do
                    pt[propName] = propValue
                end
            end
        end
    end

    function module:UnbindFrame(frame)
        if RootParent == nil then
            return
        end

        local cb = binds[frame]

        if cb then
            RunService:UnbindFromRenderStep(cb.uid)

            for _, v in pairs(cb.parts) do
                v:Destroy()
            end

            if cb.folder then
                cb.folder:Destroy()
            end

            binds[frame] = nil
        end
    end

    function module:HasBinding(frame)
        return binds[frame] ~= nil
    end

    function module:GetBoundParts(frame)
        return binds[frame] and binds[frame].parts
    end

    return module
end)()

function RayfieldLibrary:Notify(NotificationSettings)
    task.spawn(function()
        local ActionCompleted = true

        local Notification = Notifications.Template:Clone()
        Notification.Name = NotificationSettings.Title or "Notification"
        Notification.Parent = Notifications
        Notification.Visible = true

        local Background = SelectedTheme.Background
        local TextColor = SelectedTheme.TextColor
        local AccentColor = SelectedTheme.Accent or SelectedTheme.TextColor
        local ActionBackground = SelectedTheme.NotificationActionsBackground or SelectedTheme.Background
        local Secondary = TextColor:Lerp(Background, 0.4)
        local BorderColor = TextColor:Lerp(Background, 0.75)

        local Title = Notification.Title
        local Description = Notification.Description
        local Icon = Notification.Icon
        local Actions = Notification.Actions

        Notification.BackgroundColor3 = Background
        Notification.BackgroundTransparency = 1
        Notification.Size = UDim2.fromOffset(330, 78)
        Notification.AnchorPoint = Vector2.new(1, 1)
        Notification.Position = UDim2.new(1, 350, 1, -24)

        local Corner = Notification:FindFirstChildOfClass("UICorner")
        if Corner then
            Corner.CornerRadius = UDim.new(0, 4)
        end

        local Stroke = Notification:FindFirstChildOfClass("UIStroke")
        if not Stroke then
            Stroke = Instance.new("UIStroke")
            Stroke.Parent = Notification
        end

        Stroke.Color = BorderColor
        Stroke.Thickness = 1
        Stroke.Transparency = 1

        local AccentBar = Notification:FindFirstChild("AccentBar")
        if not AccentBar then
            AccentBar = Instance.new("Frame")
            AccentBar.Name = "AccentBar"
            AccentBar.BorderSizePixel = 0
            AccentBar.Parent = Notification
        end

        AccentBar.BackgroundColor3 = AccentColor
        AccentBar.BackgroundTransparency = 1
        AccentBar.Position = UDim2.fromOffset(0, 0)
        AccentBar.Size = UDim2.new(0, 3, 1, 0)

        local AccentGlow = Notification:FindFirstChild("AccentGlow")
        if not AccentGlow then
            AccentGlow = AccentBar:Clone()
            AccentGlow.Name = "AccentGlow"
            AccentGlow.Parent = Notification
        end

        AccentGlow.BackgroundColor3 = AccentColor
        AccentGlow.BackgroundTransparency = 0.85
        AccentGlow.Position = UDim2.fromOffset(-2, 0)
        AccentGlow.Size = UDim2.new(0, 8, 1, 0)
        AccentGlow.ZIndex = AccentBar.ZIndex - 1

        local TopLine = Notification:FindFirstChild("TopLine")
        if not TopLine then
            TopLine = Instance.new("Frame")
            TopLine.Name = "TopLine"
            TopLine.BorderSizePixel = 0
            TopLine.Parent = Notification
        end

        TopLine.BackgroundColor3 = AccentColor
        TopLine.BackgroundTransparency = 1
        TopLine.Position = UDim2.fromOffset(3, 0)
        TopLine.Size = UDim2.new(0, 0, 0, 1)

        Actions.Template.Visible = false

        if NotificationSettings.Actions then
            for _, Action in pairs(NotificationSettings.Actions) do
                ActionCompleted = false

                local NewAction = Actions.Template:Clone()
                NewAction.Name = Action.Name
                NewAction.Text = Action.Name
                NewAction.Visible = true
                NewAction.Parent = Actions
                NewAction.BackgroundColor3 = ActionBackground
                NewAction.BackgroundTransparency = 1
                NewAction.TextColor3 = TextColor
                NewAction.TextTransparency = 1
                NewAction.Size = UDim2.fromOffset(0, 28)

                local ActionCorner = NewAction:FindFirstChildOfClass("UICorner")
                if ActionCorner then
                    ActionCorner.CornerRadius = UDim.new(0, 3)
                end

                local ActionStroke = NewAction:FindFirstChildOfClass("UIStroke")
                if not ActionStroke then
                    ActionStroke = Instance.new("UIStroke")
                    ActionStroke.Parent = NewAction
                end

                ActionStroke.Color = BorderColor
                ActionStroke.Transparency = 1

                task.defer(function()
                    NewAction.Size = UDim2.fromOffset(NewAction.TextBounds.X + 22, 28)
                end)

                NewAction.MouseButton1Click:Connect(function()
                    local Success, Response = pcall(Action.Callback)
                    if not Success then
                        warn("Rayfield | Action: " .. Action.Name .. " Callback Error " .. tostring(Response))
                    end
                    ActionCompleted = true
                end)
            end
        end

        Title.Text = NotificationSettings.Title or "Notification"
        Title.TextColor3 = TextColor
        Title.TextTransparency = 1
        Title.Font = Enum.Font.GothamMedium
        Title.TextSize = 14
        Title.Position = UDim2.fromOffset(20, 12)

        Description.Text = NotificationSettings.Content or ""
        Description.TextColor3 = Secondary
        Description.TextTransparency = 1
        Description.Font = Enum.Font.Gotham
        Description.TextSize = 12
        Description.Position = UDim2.fromOffset(20, 35)

        Icon.ImageColor3 = AccentColor
        Icon.ImageTransparency = 1
        Icon.Position = UDim2.fromOffset(12, 25)
        Icon.Size = UDim2.fromOffset(18, 18)

        if NotificationSettings.Image then
            Icon.Image = "rbxassetid://" .. tostring(NotificationSettings.Image)
        else
            Icon.Image = "rbxassetid://3944680095"
        end

        local Progress = Notification:FindFirstChild("Progress")
        if not Progress then
            Progress = Instance.new("Frame")
            Progress.Name = "Progress"
            Progress.BorderSizePixel = 0
            Progress.Parent = Notification
        end

        Progress.BackgroundColor3 = AccentColor
        Progress.BackgroundTransparency = 0.15
        Progress.Position = UDim2.new(0, 3, 1, -2)
        Progress.Size = UDim2.new(1, -3, 0, 2)

        local Duration = NotificationSettings.Duration or NotificationDuration

        TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -24, 1, -24),
            BackgroundTransparency = 0
        }):Play()

        TweenService:Create(Stroke, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
            Transparency = 0
        }):Play()

        TweenService:Create(AccentBar, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 0
        }):Play()

        TweenService:Create(AccentGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 0.8
        }):Play()

        TweenService:Create(TopLine, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, -3, 0, 1),
            BackgroundTransparency = 0.15
        }):Play()

        task.wait(0.1)

        TweenService:Create(Icon, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            ImageTransparency = 0
        }):Play()

        TweenService:Create(Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            TextTransparency = 0
        }):Play()

        TweenService:Create(Description, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
            TextTransparency = 0
        }):Play()

        task.wait(0.2)

        if not NotificationSettings.Actions then
            TweenService:Create(Progress, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
                Size = UDim2.new(0, 0, 0, 2)
            }):Play()

            task.wait(Duration)
        else
            task.wait(0.4)

            TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(330, 112)
            }):Play()

            task.wait(0.25)

            for _, Action in ipairs(Actions:GetChildren()) do
                if Action:IsA("TextButton") and Action.Name ~= "Template" then
                    TweenService:Create(Action, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                        BackgroundTransparency = 0
                    }):Play()

                    TweenService:Create(Action, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                        TextTransparency = 0
                    }):Play()

                    local ActionStroke = Action:FindFirstChildOfClass("UIStroke")
                    if ActionStroke then
                        TweenService:Create(ActionStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                            Transparency = 0
                        }):Play()
                    end
                end
            end

            repeat
                task.wait()
            until ActionCompleted
        end

        for _, Action in ipairs(Actions:GetChildren()) do
            if Action:IsA("TextButton") and Action.Name ~= "Template" then
                TweenService:Create(Action, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                    BackgroundTransparency = 1,
                    TextTransparency = 1
                }):Play()

                local ActionStroke = Action:FindFirstChildOfClass("UIStroke")
                if ActionStroke then
                    TweenService:Create(ActionStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                        Transparency = 1
                    }):Play()
                end
            end
        end

        TweenService:Create(Notification, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 350, 1, -24),
            BackgroundTransparency = 1
        }):Play()

        TweenService:Create(Stroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            Transparency = 1
        }):Play()

        TweenService:Create(AccentBar, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 1
        }):Play()

        TweenService:Create(AccentGlow, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 1
        }):Play()

        TweenService:Create(TopLine, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 0, 0, 1),
            BackgroundTransparency = 1
        }):Play()

        TweenService:Create(Icon, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
            ImageTransparency = 1
        }):Play()

        TweenService:Create(Title, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
            TextTransparency = 1
        }):Play()

        TweenService:Create(Description, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
            TextTransparency = 1
        }):Play()

        task.wait(0.4)
        Notification:Destroy()
    end)
end

function Hide()
    if Debounce then return end

    Debounce = true

    RayfieldLibrary:Notify({
        Title = "Interface Hidden",
        Content = "The interface has been hidden. Press K to show it again.",
        Duration = 7
    })

    local Info = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local Fast = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    local TargetSize = UDim2.new(0, 470, 0, 400)

    TweenService:Create(Main, Info, {
        Size = TargetSize,
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(Main.Topbar, Info, {
        Size = UDim2.new(0, 470, 0, 45),
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(Main.Topbar.Divider, Fast, {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(Main.Topbar.CornerRepair, Fast, {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(Main.Topbar.Title, Info, {
        TextTransparency = 1
    }):Play()

    TweenService:Create(Main.Shadow.Image, Info, {
        ImageTransparency = 1
    }):Play()

    TweenService:Create(Topbar.UIStroke, Info, {
        Transparency = 1
    }):Play()

    for _, TopbarButton in ipairs(Topbar:GetChildren()) do
        if TopbarButton:IsA("ImageButton") then
            TweenService:Create(TopbarButton, Fast, {
                ImageTransparency = 1
            }):Play()
        elseif TopbarButton:IsA("TextButton") then
            TweenService:Create(TopbarButton, Fast, {
                TextTransparency = 1,
                BackgroundTransparency = 1
            }):Play()
        end
    end

    for _, tabbtn in ipairs(TabList:GetChildren()) do
        if tabbtn:IsA("Frame") and tabbtn.Name ~= "Placeholder" then
            TweenService:Create(tabbtn, Fast, {
                BackgroundTransparency = 1
            }):Play()

            local Title = tabbtn:FindFirstChild("Title")
            if Title then
                TweenService:Create(Title, Fast, {
                    TextTransparency = 1
                }):Play()
            end

            local Image = tabbtn:FindFirstChild("Image")
            if Image then
                TweenService:Create(Image, Fast, {
                    ImageTransparency = 1
                }):Play()
            end

            local Shadow = tabbtn:FindFirstChild("Shadow")
            if Shadow and Shadow:IsA("ImageLabel") then
                TweenService:Create(Shadow, Fast, {
                    ImageTransparency = 1
                }):Play()
            end

            local Stroke = tabbtn:FindFirstChildOfClass("UIStroke")
            if Stroke then
                TweenService:Create(Stroke, Fast, {
                    Transparency = 1
                }):Play()
            end
        end
    end

    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab:IsA("ScrollingFrame") and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element:IsA("Frame") and element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" then
                    if element.Name == "SectionTitle" then
                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 1
                            }):Play()
                        end
                    else
                        TweenService:Create(element, Fast, {
                            BackgroundTransparency = 1
                        }):Play()

                        local Stroke = element:FindFirstChildOfClass("UIStroke")
                        if Stroke then
                            TweenService:Create(Stroke, Fast, {
                                Transparency = 1
                            }):Play()
                        end

                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 1
                            }):Play()
                        end
                    end

                    for _, child in ipairs(element:GetChildren()) do
                        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("ImageButton") or child:IsA("ImageLabel") then
                            child.Visible = false
                        end
                    end
                end
            end
        end
    end

    task.wait(0.45)

    Main.Visible = false
    Debounce = false
end

function Unhide()
    if Debounce then return end

    Debounce = true

    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 470, 0, 400)
    Main.Visible = true

    local Info = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local Fast = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    TweenService:Create(Main, Info, {
        Size = UDim2.new(0, 500, 0, 475),
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(Main.Topbar, Info, {
        Size = UDim2.new(0, 500, 0, 45),
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ImageTransparency = 0.4
    }):Play()

    TweenService:Create(Main.Topbar.Divider, Fast, {
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(Main.Topbar.CornerRepair, Fast, {
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(Main.Topbar.Title, Fast, {
        TextTransparency = 0
    }):Play()

    if Minimised then
        task.spawn(Maximise)
    end

    for _, TopbarButton in ipairs(Topbar:GetChildren()) do
        if TopbarButton:IsA("ImageButton") then
            TweenService:Create(TopbarButton, Fast, {
                ImageTransparency = 0.8
            }):Play()
        elseif TopbarButton:IsA("TextButton") then
            TweenService:Create(TopbarButton, Fast, {
                TextTransparency = 0,
                BackgroundTransparency = 0
            }):Play()
        end
    end

    for _, tabbtn in ipairs(TabList:GetChildren()) do
        if tabbtn:IsA("Frame") and tabbtn.Name ~= "Placeholder" then
            local Selected = tostring(Elements.UIPageLayout.CurrentPage) == tabbtn.Title.Text
            local Title = tabbtn:FindFirstChild("Title")
            local Image = tabbtn:FindFirstChild("Image")
            local Shadow = tabbtn:FindFirstChild("Shadow")
            local Stroke = tabbtn:FindFirstChildOfClass("UIStroke")

            if Selected then
                TweenService:Create(tabbtn, Fast, {
                    BackgroundTransparency = 0
                }):Play()

                if Title then
                    TweenService:Create(Title, Fast, {
                        TextTransparency = 0
                    }):Play()
                end

                if Image then
                    TweenService:Create(Image, Fast, {
                        ImageTransparency = 0
                    }):Play()
                end

                if Shadow then
                    TweenService:Create(Shadow, Fast, {
                        ImageTransparency = 0.9
                    }):Play()
                end

                if Stroke then
                    TweenService:Create(Stroke, Fast, {
                        Transparency = 1
                    }):Play()
                end
            else
                TweenService:Create(tabbtn, Fast, {
                    BackgroundTransparency = 0.7
                }):Play()

                if Title then
                    TweenService:Create(Title, Fast, {
                        TextTransparency = 0.2
                    }):Play()
                end

                if Image then
                    TweenService:Create(Image, Fast, {
                        ImageTransparency = 0.2
                    }):Play()
                end

                if Shadow then
                    TweenService:Create(Shadow, Fast, {
                        ImageTransparency = 0.7
                    }):Play()
                end

                if Stroke then
                    TweenService:Create(Stroke, Fast, {
                        Transparency = 0
                    }):Play()
                end
            end
        end
    end

    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab:IsA("ScrollingFrame") and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element:IsA("Frame") and element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" then
                    if element.Name == "SectionTitle" then
                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 0
                            }):Play()
                        end
                    else
                        TweenService:Create(element, Fast, {
                            BackgroundTransparency = 0
                        }):Play()

                        local Stroke = element:FindFirstChildOfClass("UIStroke")
                        if Stroke then
                            TweenService:Create(Stroke, Fast, {
                                Transparency = 0
                            }):Play()
                        end

                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 0
                            }):Play()
                        end
                    end

                    for _, child in ipairs(element:GetChildren()) do
                        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("ImageButton") or child:IsA("ImageLabel") then
                            child.Visible = true
                        end
                    end
                end
            end
        end
    end

    task.wait(0.45)

    Minimised = false
    Debounce = false
end

function Maximise()
    if Debounce then return end

    Debounce = true

    Topbar.ChangeSize.Image = "rbxassetid://10137941941"

    local Info = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local Fast = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    TweenService:Create(Topbar.UIStroke, Info, {
        Transparency = 1
    }):Play()

    TweenService:Create(Main.Shadow.Image, Info, {
        ImageTransparency = 0.4
    }):Play()

    TweenService:Create(Topbar.CornerRepair, Info, {
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(Topbar.Divider, Info, {
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(Main, Info, {
        Size = UDim2.new(0, 500, 0, 475)
    }):Play()

    TweenService:Create(Topbar, Info, {
        Size = UDim2.new(0, 500, 0, 45)
    }):Play()

    TabList.Visible = true

    task.wait(0.15)

    Elements.Visible = true

    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab:IsA("ScrollingFrame") and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element:IsA("Frame") and element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" then
                    if element.Name == "SectionTitle" then
                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 0
                            }):Play()
                        end
                    else
                        TweenService:Create(element, Fast, {
                            BackgroundTransparency = 0
                        }):Play()

                        local Stroke = element:FindFirstChildOfClass("UIStroke")
                        if Stroke then
                            TweenService:Create(Stroke, Fast, {
                                Transparency = 0
                            }):Play()
                        end

                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 0
                            }):Play()
                        end
                    end

                    for _, child in ipairs(element:GetChildren()) do
                        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("ImageButton") or child:IsA("ImageLabel") then
                            child.Visible = true
                        end
                    end
                end
            end
        end
    end

    task.wait(0.1)

    for _, tabbtn in ipairs(TabList:GetChildren()) do
        if tabbtn:IsA("Frame") and tabbtn.Name ~= "Placeholder" then
            local Selected = tostring(Elements.UIPageLayout.CurrentPage) == tabbtn.Title.Text
            local Title = tabbtn:FindFirstChild("Title")
            local Image = tabbtn:FindFirstChild("Image")
            local Shadow = tabbtn:FindFirstChild("Shadow")
            local Stroke = tabbtn:FindFirstChildOfClass("UIStroke")

            if Selected then
                TweenService:Create(tabbtn, Fast, {
                    BackgroundTransparency = 0
                }):Play()

                if Image then
                    TweenService:Create(Image, Fast, {
                        ImageTransparency = 0
                    }):Play()
                end

                if Title then
                    TweenService:Create(Title, Fast, {
                        TextTransparency = 0
                    }):Play()
                end

                if Stroke then
                    TweenService:Create(Stroke, Fast, {
                        Transparency = 1
                    }):Play()
                end

                if Shadow then
                    TweenService:Create(Shadow, Fast, {
                        ImageTransparency = 0.9
                    }):Play()
                end
            else
                TweenService:Create(tabbtn, Fast, {
                    BackgroundTransparency = 0.7
                }):Play()

                if Shadow then
                    TweenService:Create(Shadow, Fast, {
                        ImageTransparency = 0.7
                    }):Play()
                end

                if Image then
                    TweenService:Create(Image, Fast, {
                        ImageTransparency = 0.2
                    }):Play()
                end

                if Title then
                    TweenService:Create(Title, Fast, {
                        TextTransparency = 0.2
                    }):Play()
                end

                if Stroke then
                    TweenService:Create(Stroke, Fast, {
                        Transparency = 0
                    }):Play()
                end
            end
        end
    end

    task.wait(0.45)

    Minimised = false
    Debounce = false
end

function Minimise()
    if Debounce then return end

    Debounce = true

    Topbar.ChangeSize.Image = "rbxassetid://11036884234"

    local Info = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local Fast = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    for _, tabbtn in ipairs(TabList:GetChildren()) do
        if tabbtn:IsA("Frame") and tabbtn.Name ~= "Placeholder" then
            TweenService:Create(tabbtn, Fast, {
                BackgroundTransparency = 1
            }):Play()

            local Image = tabbtn:FindFirstChild("Image")
            local Title = tabbtn:FindFirstChild("Title")
            local Shadow = tabbtn:FindFirstChild("Shadow")
            local Stroke = tabbtn:FindFirstChildOfClass("UIStroke")

            if Image then
                TweenService:Create(Image, Fast, {
                    ImageTransparency = 1
                }):Play()
            end

            if Title then
                TweenService:Create(Title, Fast, {
                    TextTransparency = 1
                }):Play()
            end

            if Shadow then
                TweenService:Create(Shadow, Fast, {
                    ImageTransparency = 1
                }):Play()
            end

            if Stroke then
                TweenService:Create(Stroke, Fast, {
                    Transparency = 1
                }):Play()
            end
        end
    end

    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab:IsA("ScrollingFrame") and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element:IsA("Frame") and element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" then
                    if element.Name == "SectionTitle" then
                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 1
                            }):Play()
                        end
                    else
                        TweenService:Create(element, Fast, {
                            BackgroundTransparency = 1
                        }):Play()

                        local Stroke = element:FindFirstChildOfClass("UIStroke")
                        if Stroke then
                            TweenService:Create(Stroke, Fast, {
                                Transparency = 1
                            }):Play()
                        end

                        local Title = element:FindFirstChild("Title")
                        if Title then
                            TweenService:Create(Title, Fast, {
                                TextTransparency = 1
                            }):Play()
                        end
                    end

                    for _, child in ipairs(element:GetChildren()) do
                        if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("ImageButton") or child:IsA("ImageLabel") then
                            child.Visible = false
                        end
                    end
                end
            end
        end
    end

    task.wait(0.15)

    TweenService:Create(Topbar.UIStroke, Info, {
        Transparency = 0
    }):Play()

    TweenService:Create(Main.Shadow.Image, Info, {
        ImageTransparency = 1
    }):Play()

    TweenService:Create(Topbar.CornerRepair, Info, {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(Topbar.Divider, Info, {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(Main, Info, {
        Size = UDim2.new(0, 495, 0, 45)
    }):Play()

    TweenService:Create(Topbar, Info, {
        Size = UDim2.new(0, 495, 0, 45)
    }):Play()

    task.wait(0.4)

    Elements.Visible = false
    TabList.Visible = false

    Debounce = false
end

function RayfieldLibrary:CreateWindow(Settings)
    local Passthrough = false
    Topbar.Title.Text = Settings.Name
    Main.Size = UDim2.new(0, 450, 0, 260)
    Main.Visible = true
    Main.BackgroundTransparency = 1
    LoadingFrame.Title.TextTransparency = 1
    LoadingFrame.Subtitle.TextTransparency = 1
    Main.Shadow.Image.ImageTransparency = 1
    LoadingFrame.Version.TextTransparency = 1
    LoadingFrame.Title.Text = Settings.LoadingTitle or "Rayfield Interface Suite"
    LoadingFrame.Subtitle.Text = Settings.LoadingSubtitle or "by Sirius"
    if Settings.LoadingTitle ~= "Rayfield Interface Suite" then
        LoadingFrame.Version.Text = "Rayfield UI"
    end
    Topbar.Visible = false
    Elements.Visible = false
    LoadingFrame.Visible = true


    pcall(function()
        if not Settings.ConfigurationSaving.FileName then
            Settings.ConfigurationSaving.FileName = tostring(game.PlaceId)
        end
        if not isfolder(RayfieldFolder .. "/" .. "Configuration Folders") then

        end
        if Settings.ConfigurationSaving.Enabled == nil then
            Settings.ConfigurationSaving.Enabled = false
        end
        CFileName = Settings.ConfigurationSaving.FileName
        ConfigurationFolder = Settings.ConfigurationSaving.FolderName or ConfigurationFolder
        CEnabled = Settings.ConfigurationSaving.Enabled

        if Settings.ConfigurationSaving.Enabled then
            if not isfolder(ConfigurationFolder) then
                makefolder(ConfigurationFolder)
            end
        end
    end)

    AddDraggingFunctionality(Topbar, Main)

    for _, TabButton in ipairs(TabList:GetChildren()) do
        if TabButton.ClassName == "Frame" and TabButton.Name ~= "Placeholder" then
            TabButton.BackgroundTransparency = 1
            TabButton.Title.TextTransparency = 1
            TabButton.Shadow.ImageTransparency = 1
            TabButton.Image.ImageTransparency = 1
            TabButton.UIStroke.Transparency = 1
        end
    end

    if Settings.Discord then
        if not isfolder(RayfieldFolder .. "/Discord Invites") then
            makefolder(RayfieldFolder .. "/Discord Invites")
        end
        if not isfile(RayfieldFolder .. "/Discord Invites" .. "/" .. Settings.Discord.Invite .. ConfigurationExtension) then
            if request then
                request({
                    Url = 'http://127.0.0.1:6463/rpc?v=1',
                    Method = 'POST',
                    Headers = {
                        ['Content-Type'] = 'application/json',
                        Origin = 'https://discord.com'
                    },
                    Body = HttpService:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = HttpService:GenerateGUID(false),
                        args = { code = Settings.Discord.Invite }
                    })
                })
            end

            if Settings.Discord.RememberJoins then -- We do logic this way so if the developer changes this setting, the user still won't be prompted, only new users
                writefile(RayfieldFolder .. "/Discord Invites" .. "/" .. Settings.Discord.Invite ..
                    ConfigurationExtension,
                    "Rayfield RememberJoins is true for this invite, this invite will not ask you to join again")
            end
        else

        end
    end

    if Settings.KeySystem then
        if not Settings.KeySettings then
            Passthrough = true
            return
        end

        if not isfolder(RayfieldFolder .. "/Key System") then
            makefolder(RayfieldFolder .. "/Key System")
        end

        if typeof(Settings.KeySettings.Key) == "string" then Settings.KeySettings.Key = { Settings.KeySettings.Key } end

        if Settings.KeySettings.GrabKeyFromSite then
            for i, Key in ipairs(Settings.KeySettings.Key) do
                local Success, Response = pcall(function()
                    Settings.KeySettings.Key[i] = tostring(game:HttpGet(Key):gsub("[\n\r]", " "))
                    Settings.KeySettings.Key[i] = string.gsub(Settings.KeySettings.Key[i], " ", "")
                end)
                if not Success then
                    print("Rayfield | " .. Key .. " Error " .. tostring(Response))
                end
            end
        end

        if not Settings.KeySettings.FileName then
            Settings.KeySettings.FileName = "No file name specified"
        end

        if isfile(RayfieldFolder .. "/Key System" .. "/" .. Settings.KeySettings.FileName .. ConfigurationExtension) then
            for _, MKey in ipairs(Settings.KeySettings.Key) do
                if string.find(readfile(RayfieldFolder .. "/Key System" .. "/" .. Settings.KeySettings.FileName .. ConfigurationExtension), MKey) then
                    Passthrough = true
                end
            end
        end

        if not Passthrough then
            local AttemptsRemaining = math.random(2, 6)
            Rayfield.Enabled = false
            local KeyUI = game:GetObjects("rbxassetid://11380036235")[1]

            if gethui then
                KeyUI.Parent = gethui()
            elseif syn.protect_gui then
                syn.protect_gui(Rayfield)
                KeyUI.Parent = CoreGui
            else
                KeyUI.Parent = CoreGui
            end

            if gethui then
                for _, Interface in ipairs(gethui():GetChildren()) do
                    if Interface.Name == KeyUI.Name and Interface ~= KeyUI then
                        Interface.Enabled = false
                        Interface.Name = "KeyUI-Old"
                    end
                end
            else
                for _, Interface in ipairs(CoreGui:GetChildren()) do
                    if Interface.Name == KeyUI.Name and Interface ~= KeyUI then
                        Interface.Enabled = false
                        Interface.Name = "KeyUI-Old"
                    end
                end
            end

            local KeyMain = KeyUI.Main
            KeyMain.Title.Text = Settings.KeySettings.Title or Settings.Name
            KeyMain.Subtitle.Text = Settings.KeySettings.Subtitle or "Key System"
            KeyMain.NoteMessage.Text = Settings.KeySettings.Note or "No instructions"

            KeyMain.Size = UDim2.new(0, 467, 0, 175)
            KeyMain.BackgroundTransparency = 1
            KeyMain.Shadow.Image.ImageTransparency = 1
            KeyMain.Title.TextTransparency = 1
            KeyMain.Subtitle.TextTransparency = 1
            KeyMain.KeyNote.TextTransparency = 1
            KeyMain.Input.BackgroundTransparency = 1
            KeyMain.Input.UIStroke.Transparency = 1
            KeyMain.Input.InputBox.TextTransparency = 1
            KeyMain.NoteTitle.TextTransparency = 1
            KeyMain.NoteMessage.TextTransparency = 1
            KeyMain.Hide.ImageTransparency = 1

            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
                :Play()
            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 500, 0, 187) })
                :Play()
            TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                { ImageTransparency = 0.5 }):Play()
            wait(0.05)
            TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
            TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
            wait(0.05)
            TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
            TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
                :Play()
            TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Transparency = 0 })
                :Play()
            TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                { TextTransparency = 0 }):Play()
            wait(0.05)
            TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
            TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
            wait(0.15)
            TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { ImageTransparency = 0.3 })
                :Play()


            KeyUI.Main.Input.InputBox.FocusLost:Connect(function()
                if #KeyUI.Main.Input.InputBox.Text == 0 then return end
                local KeyFound = false
                local FoundKey = ''
                for _, MKey in ipairs(Settings.KeySettings.Key) do
                    if string.find(KeyMain.Input.InputBox.Text, MKey) then
                        KeyFound = true
                        FoundKey = MKey
                    end
                end
                if KeyFound then
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundTransparency = 1 })
                        :Play()
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 467, 0, 175) }):Play()
                    TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { ImageTransparency = 1 }):Play()
                    TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 })
                        :Play()
                    TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 }):Play()
                    TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 }):Play()
                    TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { BackgroundTransparency = 1 }):Play()
                    TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { Transparency = 1 }):Play()
                    TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 }):Play()
                    TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 }):Play()
                    TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 }):Play()
                    TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                        { ImageTransparency = 1 })
                        :Play()
                    wait(0.51)
                    Passthrough = true
                    if Settings.KeySettings.SaveKey then
                        if writefile then
                            writefile(
                                RayfieldFolder .. "/Key System" .. "/" ..
                                Settings.KeySettings.FileName .. ConfigurationExtension, FoundKey)
                        end
                        RayfieldLibrary:Notify({
                            Title = "Key System",
                            Content =
                            "The key for this script has been saved successfully"
                        })
                    end
                else
                    if AttemptsRemaining == 0 then
                        TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                            { BackgroundTransparency = 1 }):Play()
                        TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                            { Size = UDim2.new(0, 467, 0, 175) }):Play()
                        TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                            { ImageTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                            { TextTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                            { TextTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                            { TextTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                            { BackgroundTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                            { Transparency = 1 }):Play()
                        TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                            { TextTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                            { TextTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                            { TextTransparency = 1 }):Play()
                        TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                            { ImageTransparency = 1 }):Play()
                        wait(0.45)
                        game.Players.LocalPlayer:Kick("No Attempts Remaining")
                        game:Shutdown()
                    end
                    KeyMain.Input.InputBox.Text = ""
                    AttemptsRemaining = AttemptsRemaining - 1
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 467, 0, 175) }):Play()
                    TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic),
                        { Position = UDim2.new(0.495, 0, 0.5, 0) }):Play()
                    wait(0.1)
                    TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic),
                        { Position = UDim2.new(0.505, 0, 0.5, 0) }):Play()
                    wait(0.1)
                    TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                        { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 500, 0, 187) }):Play()
                end
            end)

            KeyMain.Hide.MouseButton1Click:Connect(function()
                TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { BackgroundTransparency = 1 })
                    :Play()
                TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 467, 0, 175) }):Play()
                TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                    { ImageTransparency = 1 }):Play()
                TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { TextTransparency = 1 })
                    :Play()
                TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                    { TextTransparency = 1 })
                    :Play()
                TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 1 })
                    :Play()
                TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                    { BackgroundTransparency = 1 }):Play()
                TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                    { Transparency = 1 }):Play()
                TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                    { TextTransparency = 1 }):Play()
                TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                    { TextTransparency = 1 })
                    :Play()
                TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                    { TextTransparency = 1 }):Play()
                TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { ImageTransparency = 1 })
                    :Play()
                wait(0.51)
                RayfieldLibrary:Destroy()
                KeyUI:Destroy()
            end)
        else
            Passthrough = true
        end
    end
    if Settings.KeySystem then
        repeat wait() until Passthrough
    end

    Notifications.Template.Visible = false
    Notifications.Visible = true
    Rayfield.Enabled = true
    wait(0.5)
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.55 })
        :Play()
    wait(0.1)
    TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()
    wait(0.05)
    TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
        :Play()
    wait(0.05)
    TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()

    Elements.Template.LayoutOrder = 100000
    Elements.Template.Visible = false

    Elements.UIPageLayout.FillDirection = Enum.FillDirection.Horizontal
    TabList.Template.Visible = false

    -- Tab
    local FirstTab = false
    local Window = {}
    function Window:CreateTab(Name, Image)
        local SDone = false
        local TabButton = TabList.Template:Clone()
        TabButton.Name = Name
        TabButton.Title.Text = Name
        TabButton.Parent = TabList
        TabButton.Title.TextWrapped = false
        TabButton.Size = UDim2.new(0, TabButton.Title.TextBounds.X + 30, 0, 30)

        if Image then
            TabButton.Title.AnchorPoint = Vector2.new(0, 0.5)
            TabButton.Title.Position = UDim2.new(0, 37, 0.5, 0)
            TabButton.Image.Image = "rbxassetid://" .. Image
            TabButton.Image.Visible = true
            TabButton.Title.TextXAlignment = Enum.TextXAlignment.Left
            TabButton.Size = UDim2.new(0, TabButton.Title.TextBounds.X + 46, 0, 30)
        end

        TabButton.BackgroundTransparency = 1
        TabButton.Title.TextTransparency = 1
        TabButton.Shadow.ImageTransparency = 1
        TabButton.Image.ImageTransparency = 1
        TabButton.UIStroke.Transparency = 1

        TabButton.Visible = true

        -- Create Elements Page
        local TabPage = Elements.Template:Clone()
        TabPage.Name = Name
        TabPage.Visible = true

        TabPage.LayoutOrder = #Elements:GetChildren()

        for _, TemplateElement in ipairs(TabPage:GetChildren()) do
            if TemplateElement.ClassName == "Frame" and TemplateElement.Name ~= "Placeholder" then
                TemplateElement:Destroy()
            end
        end

        TabPage.Parent = Elements
        if not FirstTab then
            Elements.UIPageLayout.Animated = false
            Elements.UIPageLayout:JumpTo(TabPage)
            Elements.UIPageLayout.Animated = true
        end

        if SelectedTheme ~= RayfieldLibrary.Theme.Default then
            TabButton.Shadow.Visible = false
        end
        TabButton.UIStroke.Color = SelectedTheme.TabStroke
        -- Animate
        wait(0.1)
        if FirstTab then
            TabButton.BackgroundColor3 = SelectedTheme.TabBackground
            TabButton.Image.ImageColor3 = SelectedTheme.TabTextColor
            TabButton.Title.TextColor3 = SelectedTheme.TabTextColor
            TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0.7 })
                :Play()
            TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0.2 })
                :Play()
            TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.2 })
                :Play()
            TweenService:Create(TabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 })
                :Play()

            TweenService:Create(TabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { ImageTransparency = 0.7 })
                :Play()
        else
            FirstTab = Name
            TabButton.BackgroundColor3 = SelectedTheme.TabBackgroundSelected
            TabButton.Image.ImageColor3 = SelectedTheme.SelectedTabTextColor
            TabButton.Title.TextColor3 = SelectedTheme.SelectedTabTextColor
            TweenService:Create(TabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { ImageTransparency = 0.9 })
                :Play()
            TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0 })
                :Play()
            TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
                :Play()
            TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
        end


        TabButton.Interact.MouseButton1Click:Connect(function()
            if Minimised then return end
            TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
                :Play()
            TweenService:Create(TabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 1 })
                :Play()
            TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
            TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0 })
                :Play()
            TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                { BackgroundColor3 = SelectedTheme.TabBackgroundSelected }):Play()
            TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                { TextColor3 = SelectedTheme.SelectedTabTextColor }):Play()
            TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                { ImageColor3 = SelectedTheme.SelectedTabTextColor }):Play()
            TweenService:Create(TabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { ImageTransparency = 0.9 })
                :Play()

            for _, OtherTabButton in ipairs(TabList:GetChildren()) do
                if OtherTabButton.Name ~= "Template" and OtherTabButton.ClassName == "Frame" and OtherTabButton ~= TabButton and OtherTabButton.Name ~= "Placeholder" then
                    TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.TabBackground }):Play()
                    TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                        { TextColor3 = SelectedTheme.TabTextColor }):Play()
                    TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                        { ImageColor3 = SelectedTheme.TabTextColor }):Play()
                    TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                        { BackgroundTransparency = 0.7 }):Play()
                    TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                        { TextTransparency = 0.2 }):Play()
                    TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                        { ImageTransparency = 0.2 }):Play()
                    TweenService:Create(OtherTabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                        { ImageTransparency = 0.7 }):Play()
                    TweenService:Create(OtherTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                        { Transparency = 0 }):Play()
                end
            end
            if Elements.UIPageLayout.CurrentPage ~= TabPage then
                TweenService:Create(Elements, TweenInfo.new(1, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 460, 0, 330) })
                    :Play()
                Elements.UIPageLayout:JumpTo(TabPage)
                wait(0.2)
                TweenService:Create(Elements, TweenInfo.new(0.8, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 475, 0, 366) }):Play()
            end
        end)

        local Tab = {}

        -- Button
        function Tab:CreateButton(ButtonSettings)
            local ButtonValue = {}

            local Button = Elements.Template.Button:Clone()
            Button.Name = ButtonSettings.Name
            Button.Title.Text = ButtonSettings.Name
            Button.Visible = true
            Button.Parent = TabPage

            Button.BackgroundTransparency = 1
            Button.UIStroke.Transparency = 1
            Button.Title.TextTransparency = 1

            TweenService:Create(Button, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
            TweenService:Create(Button.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
            TweenService:Create(Button.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()


            Button.Interact.MouseButton1Click:Connect(function()
                local Success, Response = pcall(ButtonSettings.Callback)
                if not Success then
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 }):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    Button.Title.Text = "Callback Error"
                    print("Rayfield | " .. ButtonSettings.Name .. " Callback Error " .. tostring(Response))
                    wait(0.5)
                    Button.Title.Text = ButtonSettings.Name
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { TextTransparency = 0.9 }):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                else
                    SaveConfiguration()
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { TextTransparency = 1 }):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    wait(0.2)
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { TextTransparency = 0.9 }):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                end
            end)

            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { TextTransparency = 0.7 }):Play()
            end)

            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { TextTransparency = 0.9 }):Play()
            end)

            function ButtonValue:Set(NewButton)
                Button.Title.Text = NewButton
                Button.Name = NewButton
            end

            return ButtonValue
        end

        -- ColorPicker
        function Tab:CreateColorPicker(ColorPickerSettings) -- by Throit
            ColorPickerSettings.Type = "ColorPicker"
            local ColorPicker = Elements.Template.ColorPicker:Clone()
            local Background = ColorPicker.CPBackground
            local Display = Background.Display
            local Main = Background.MainCP
            local Slider = ColorPicker.ColorSlider
            ColorPicker.ClipsDescendants = true
            ColorPicker.Name = ColorPickerSettings.Name
            ColorPicker.Title.Text = ColorPickerSettings.Name
            ColorPicker.Visible = true
            ColorPicker.Parent = TabPage
            ColorPicker.Size = UDim2.new(1, -10, 0.028, 35)
            Background.Size = UDim2.new(0, 39, 0, 22)
            Display.BackgroundTransparency = 0
            Main.MainPoint.ImageTransparency = 1
            ColorPicker.Interact.Size = UDim2.new(1, 0, 1, 0)
            ColorPicker.Interact.Position = UDim2.new(0.5, 0, 0.5, 0)
            ColorPicker.RGB.Position = UDim2.new(0, 17, 0, 70)
            ColorPicker.HexInput.Position = UDim2.new(0, 17, 0, 90)
            Main.ImageTransparency = 1
            Background.BackgroundTransparency = 1



            local opened = false
            local mouse = game.Players.LocalPlayer:GetMouse()
            Main.Image = "http://www.roblox.com/asset/?id=11415645739"
            local mainDragging = false
            local sliderDragging = false
            ColorPicker.Interact.MouseButton1Down:Connect(function()
                if not opened then
                    opened = true
                    TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(1, -10, 0.224, 40) }):Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 173, 0, 86) }):Play()
                    TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundTransparency = 1 })
                        :Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Position = UDim2.new(0.289, 0, 0.5, 0) }):Play()
                    TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.8, Enum.EasingStyle.Quint),
                        { Position = UDim2.new(0, 17, 0, 40) }):Play()
                    TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { Position = UDim2.new(0, 17, 0, 73) }):Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0.574, 0, 1, 0) }):Play()
                    TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint),
                        { ImageTransparency = 0 }):Play()
                    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), { ImageTransparency = 0.1 })
                        :Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundTransparency = 0 }):Play()
                else
                    opened = false
                    TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(1, -10, 0.028, 35) }):Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 39, 0, 22) }):Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(1, 0, 1, 0) }):Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
                    TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Position = UDim2.new(0, 17, 0, 70) }):Play()
                    TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { Position = UDim2.new(0, 17, 0, 90) }):Play()
                    TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundTransparency = 0 })
                        :Play()
                    TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint),
                        { ImageTransparency = 1 }):Play()
                    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), { ImageTransparency = 1 })
                        :Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundTransparency = 1 }):Play()
                end
            end)

            game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessed)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    mainDragging = false
                    sliderDragging = false
                end
            end)
            Main.MouseButton1Down:Connect(function()
                if opened then
                    mainDragging = true
                end
            end)
            Main.MainPoint.MouseButton1Down:Connect(function()
                if opened then
                    mainDragging = true
                end
            end)
            Slider.MouseButton1Down:Connect(function()
                sliderDragging = true
            end)
            Slider.SliderPoint.MouseButton1Down:Connect(function()
                sliderDragging = true
            end)
            local h, s, v = ColorPickerSettings.Color:ToHSV()
            local color = Color3.fromHSV(h, s, v)
            local hex = string.format("#%02X%02X%02X", color.R * 0xFF, color.G * 0xFF, color.B * 0xFF)
            ColorPicker.HexInput.InputBox.Text = hex
            local function setDisplay()
                --Main
                Main.MainPoint.Position = UDim2.new(s, -Main.MainPoint.AbsoluteSize.X / 2, 1 - v,
                    -Main.MainPoint.AbsoluteSize.Y / 2)
                Main.MainPoint.ImageColor3 = Color3.fromHSV(h, s, v)
                Background.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                Display.BackgroundColor3 = Color3.fromHSV(h, s, v)
                --Slider
                local x = h * Slider.AbsoluteSize.X
                Slider.SliderPoint.Position = UDim2.new(0, x - Slider.SliderPoint.AbsoluteSize.X / 2, 0.5, 0)
                Slider.SliderPoint.ImageColor3 = Color3.fromHSV(h, 1, 1)
                local color = Color3.fromHSV(h, s, v)
                local r, g, b = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5),
                    math.floor((color.B * 255) + 0.5)
                ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                hex = string.format("#%02X%02X%02X", color.R * 0xFF, color.G * 0xFF, color.B * 0xFF)
                ColorPicker.HexInput.InputBox.Text = hex
            end
            setDisplay()
            ColorPicker.HexInput.InputBox.FocusLost:Connect(function()
                if not pcall(function()
                        local r, g, b = string.match(ColorPicker.HexInput.InputBox.Text, "^#?(%w%w)(%w%w)(%w%w)$")
                        local rgbColor = Color3.fromRGB(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))
                        h, s, v = rgbColor:ToHSV()
                        hex = ColorPicker.HexInput.InputBox.Text
                        setDisplay()
                        ColorPickerSettings.Color = rgbColor
                    end)
                then
                    ColorPicker.HexInput.InputBox.Text = hex
                end
                pcall(function() ColorPickerSettings.Callback(Color3.fromHSV(h, s, v)) end)
                local r, g, b = math.floor((h * 255) + 0.5), math.floor((s * 255) + 0.5), math.floor((v * 255) + 0.5)
                ColorPickerSettings.Color = Color3.fromRGB(r, g, b)
                SaveConfiguration()
            end)
            --RGB
            local function rgbBoxes(box, toChange)
                local value = tonumber(box.Text)
                local color = Color3.fromHSV(h, s, v)
                local oldR, oldG, oldB = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5),
                    math.floor((color.B * 255) + 0.5)
                local save
                if toChange == "R" then
                    save = oldR; oldR = value
                elseif toChange == "G" then
                    save = oldG; oldG = value
                else
                    save = oldB; oldB = value
                end
                if value then
                    value = math.clamp(value, 0, 255)
                    h, s, v = Color3.fromRGB(oldR, oldG, oldB):ToHSV()

                    setDisplay()
                else
                    box.Text = tostring(save)
                end
                local r, g, b = math.floor((h * 255) + 0.5), math.floor((s * 255) + 0.5), math.floor((v * 255) + 0.5)
                ColorPickerSettings.Color = Color3.fromRGB(r, g, b)
                SaveConfiguration()
            end
            ColorPicker.RGB.RInput.InputBox.FocusLost:connect(function()
                rgbBoxes(ColorPicker.RGB.RInput.InputBox, "R")
                pcall(function() ColorPickerSettings.Callback(Color3.fromHSV(h, s, v)) end)
            end)
            ColorPicker.RGB.GInput.InputBox.FocusLost:connect(function()
                rgbBoxes(ColorPicker.RGB.GInput.InputBox, "G")
                pcall(function() ColorPickerSettings.Callback(Color3.fromHSV(h, s, v)) end)
            end)
            ColorPicker.RGB.BInput.InputBox.FocusLost:connect(function()
                rgbBoxes(ColorPicker.RGB.BInput.InputBox, "B")
                pcall(function() ColorPickerSettings.Callback(Color3.fromHSV(h, s, v)) end)
            end)

            game:GetService("RunService").RenderStepped:connect(function()
                if mainDragging then
                    local localX = math.clamp(mouse.X - Main.AbsolutePosition.X, 0, Main.AbsoluteSize.X)
                    local localY = math.clamp(mouse.Y - Main.AbsolutePosition.Y, 0, Main.AbsoluteSize.Y)
                    Main.MainPoint.Position = UDim2.new(0, localX - Main.MainPoint.AbsoluteSize.X / 2, 0,
                        localY - Main.MainPoint.AbsoluteSize.Y / 2)
                    s = localX / Main.AbsoluteSize.X
                    v = 1 - (localY / Main.AbsoluteSize.Y)
                    Display.BackgroundColor3 = Color3.fromHSV(h, s, v)
                    Main.MainPoint.ImageColor3 = Color3.fromHSV(h, s, v)
                    Background.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    local color = Color3.fromHSV(h, s, v)
                    local r, g, b = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5),
                        math.floor((color.B * 255) + 0.5)
                    ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                    ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                    ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                    ColorPicker.HexInput.InputBox.Text = string.format("#%02X%02X%02X", color.R * 0xFF, color.G * 0xFF,
                        color.B * 0xFF)
                    pcall(function() ColorPickerSettings.Callback(Color3.fromHSV(h, s, v)) end)
                    ColorPickerSettings.Color = Color3.fromRGB(r, g, b)
                    SaveConfiguration()
                end
                if sliderDragging then
                    local localX = math.clamp(mouse.X - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X)
                    h = localX / Slider.AbsoluteSize.X
                    Display.BackgroundColor3 = Color3.fromHSV(h, s, v)
                    Slider.SliderPoint.Position = UDim2.new(0, localX - Slider.SliderPoint.AbsoluteSize.X / 2, 0.5, 0)
                    Slider.SliderPoint.ImageColor3 = Color3.fromHSV(h, 1, 1)
                    Background.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    Main.MainPoint.ImageColor3 = Color3.fromHSV(h, s, v)
                    local color = Color3.fromHSV(h, s, v)
                    local r, g, b = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5),
                        math.floor((color.B * 255) + 0.5)
                    ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                    ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                    ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                    ColorPicker.HexInput.InputBox.Text = string.format("#%02X%02X%02X", color.R * 0xFF, color.G * 0xFF,
                        color.B * 0xFF)
                    pcall(function() ColorPickerSettings.Callback(Color3.fromHSV(h, s, v)) end)
                    ColorPickerSettings.Color = Color3.fromRGB(r, g, b)
                    SaveConfiguration()
                end
            end)

            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and ColorPickerSettings.Flag then
                    RayfieldLibrary.Flags[ColorPickerSettings.Flag] = ColorPickerSettings
                end
            end

            function ColorPickerSettings:Set(RGBColor)
                ColorPickerSettings.Color = RGBColor
                h, s, v = ColorPickerSettings.Color:ToHSV()
                color = Color3.fromHSV(h, s, v)
                setDisplay()
            end

            return ColorPickerSettings
        end

        -- Section
        function Tab:CreateSection(SectionName)
            local SectionValue = {}

            if SDone then
                local SectionSpace = Elements.Template.SectionSpacing:Clone()
                SectionSpace.Visible = true
                SectionSpace.Parent = TabPage
            end

            local Section = Elements.Template.SectionTitle:Clone()
            Section.Title.Text = SectionName
            Section.Visible = true
            Section.Parent = TabPage

            Section.Title.TextTransparency = 1
            TweenService:Create(Section.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()

            function SectionValue:Set(NewSection)
                Section.Title.Text = NewSection
            end

            SDone = true

            return SectionValue
        end

        -- Label
        function Tab:CreateLabel(LabelText)
            local LabelValue = {}

            local Label = Elements.Template.Label:Clone()
            Label.Title.Text = LabelText
            Label.Visible = true
            Label.Parent = TabPage

            Label.BackgroundTransparency = 1
            Label.UIStroke.Transparency = 1
            Label.Title.TextTransparency = 1

            Label.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
            Label.UIStroke.Color = SelectedTheme.SecondaryElementStroke

            TweenService:Create(Label, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
            TweenService:Create(Label.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
            TweenService:Create(Label.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()

            function LabelValue:Set(NewLabel)
                Label.Title.Text = NewLabel
            end

            return LabelValue
        end

        -- Paragraph
        function Tab:CreateParagraph(ParagraphSettings)
            local ParagraphValue = {}

            local Paragraph = Elements.Template.Paragraph:Clone()
            Paragraph.Title.Text = ParagraphSettings.Title
            Paragraph.Content.Text = ParagraphSettings.Content
            Paragraph.Visible = true
            Paragraph.Parent = TabPage

            Paragraph.Content.Size = UDim2.new(0, 438, 0, Paragraph.Content.TextBounds.Y)
            Paragraph.Content.Position = UDim2.new(1, -10, 0.575, 0)
            Paragraph.Size = UDim2.new(1, -10, 0, Paragraph.Content.TextBounds.Y + 40)

            Paragraph.BackgroundTransparency = 1
            Paragraph.UIStroke.Transparency = 1
            Paragraph.Title.TextTransparency = 1
            Paragraph.Content.TextTransparency = 1

            Paragraph.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
            Paragraph.UIStroke.Color = SelectedTheme.SecondaryElementStroke

            TweenService:Create(Paragraph, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
                :Play()
            TweenService:Create(Paragraph.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 })
                :Play()
            TweenService:Create(Paragraph.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()
            TweenService:Create(Paragraph.Content, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()

            function ParagraphValue:Set(NewParagraphSettings)
                Paragraph.Title.Text = NewParagraphSettings.Title
                Paragraph.Content.Text = NewParagraphSettings.Content
            end

            return ParagraphValue
        end

        -- Input
        function Tab:CreateInput(InputSettings)
            local Input = Elements.Template.Input:Clone()
            Input.Name = InputSettings.Name
            Input.Title.Text = InputSettings.Name
            Input.Visible = true
            Input.Parent = TabPage

            Input.BackgroundTransparency = 1
            Input.UIStroke.Transparency = 1
            Input.Title.TextTransparency = 1

            Input.InputFrame.BackgroundColor3 = SelectedTheme.InputBackground
            Input.InputFrame.UIStroke.Color = SelectedTheme.InputStroke

            TweenService:Create(Input, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
            TweenService:Create(Input.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
            TweenService:Create(Input.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()

            Input.InputFrame.InputBox.PlaceholderText = InputSettings.PlaceholderText
            Input.InputFrame.Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)

            Input.InputFrame.InputBox.FocusLost:Connect(function()
                local Success, Response = pcall(function()
                    InputSettings.Callback(Input.InputFrame.InputBox.Text)
                end)
                if not Success then
                    TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                    TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    Input.Title.Text = "Callback Error"
                    print("Spear | " .. InputSettings.Name .. " Callback Error " .. tostring(Response))
                    wait(0.5)
                    Input.Title.Text = InputSettings.Name
                    TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                end

                if InputSettings.RemoveTextAfterFocusLost then
                    Input.InputFrame.InputBox.Text = ""
                end
                SaveConfiguration()
            end)

            Input.MouseEnter:Connect(function()
                TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
            end)

            Input.MouseLeave:Connect(function()
                TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
            end)

            Input.InputFrame.InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                TweenService:Create(Input.InputFrame,
                    TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                    { Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30) }):Play()
            end)

            local InputSettings = {}
            function InputSettings:Set(text) --Doesnt fire the event
                Input.InputFrame.InputBox.Text = text
            end

            return InputSettings
        end

        -- Dropdown
        function Tab:CreateDropdown(DropdownSettings)
            local Dropdown = Elements.Template.Dropdown:Clone()
            if string.find(DropdownSettings.Name, "closed") then
                Dropdown.Name = "Dropdown"
            else
                Dropdown.Name = DropdownSettings.Name
            end
            Dropdown.Title.Text = DropdownSettings.Name
            Dropdown.Visible = true
            Dropdown.Parent = TabPage

            Dropdown.List.Visible = false

            if typeof(DropdownSettings.CurrentOption) == "string" then
                DropdownSettings.CurrentOption = { DropdownSettings.CurrentOption }
            end

            if not DropdownSettings.MultipleOptions then
                DropdownSettings.CurrentOption = { DropdownSettings.CurrentOption[1] }
            end

            if DropdownSettings.MultipleOptions then
                if #DropdownSettings.CurrentOption == 1 then
                    Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                elseif #DropdownSettings.CurrentOption == 0 then
                    Dropdown.Selected.Text = "None"
                else
                    Dropdown.Selected.Text = "Various"
                end
            else
                Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
            end


            Dropdown.BackgroundTransparency = 1
            Dropdown.UIStroke.Transparency = 1
            Dropdown.Title.TextTransparency = 1

            Dropdown.Size = UDim2.new(1, -10, 0, 45)

            TweenService:Create(Dropdown, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
                :Play()
            TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 })
                :Play()
            TweenService:Create(Dropdown.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()

            for _, ununusedoption in ipairs(Dropdown.List:GetChildren()) do
                if ununusedoption.ClassName == "Frame" and ununusedoption.Name ~= "Placeholder" then
                    ununusedoption:Destroy()
                end
            end

            Dropdown.Toggle.Rotation = 180

            Dropdown.Interact.MouseButton1Click:Connect(function()
                TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { Transparency = 1 })
                    :Play()
                wait(0.1)
                TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { Transparency = 0 })
                    :Play()
                if Debounce then return end
                if Dropdown.List.Visible then
                    Debounce = true
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(1, -10, 0, 45) }):Play()
                    for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
                        if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "Placeholder" then
                            TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { BackgroundTransparency = 1 }):Play()
                            TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { Transparency = 1 }):Play()
                            TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { TextTransparency = 1 }):Play()
                        end
                    end
                    TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                        { ScrollBarImageTransparency = 1 }):Play()
                    TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Rotation = 180 })
                        :Play()
                    wait(0.35)
                    Dropdown.List.Visible = false
                    Debounce = false
                else
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(1, -10, 0, 180) }):Play()
                    Dropdown.List.Visible = true
                    TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                        { ScrollBarImageTransparency = 0.7 }):Play()
                    TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Rotation = 0 })
                        :Play()
                    for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
                        if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "Placeholder" then
                            TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { BackgroundTransparency = 0 }):Play()
                            TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { Transparency = 0 }):Play()
                            TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { TextTransparency = 0 }):Play()
                        end
                    end
                end
            end)

            Dropdown.MouseEnter:Connect(function()
                if not Dropdown.List.Visible then
                    TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                end
            end)

            Dropdown.MouseLeave:Connect(function()
                TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
            end)

            for _, Option in ipairs(DropdownSettings.Options) do
                local DropdownOption = Elements.Template.Dropdown.List.Template:Clone()
                DropdownOption.Name = Option
                DropdownOption.Title.Text = Option
                DropdownOption.Parent = Dropdown.List
                DropdownOption.Visible = true

                if DropdownSettings.CurrentOption == Option then
                    DropdownOption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                end

                DropdownOption.BackgroundTransparency = 1
                DropdownOption.UIStroke.Transparency = 1
                DropdownOption.Title.TextTransparency = 1

                --local Dropdown = Tab:CreateDropdown({
                --	Name = "Dropdown Example",
                --	Options = {"Option 1","Option 2"},
                --	CurrentOption = {"Option 1"},
                --  MultipleOptions = true,
                --	Flag = "Dropdown1",
                --	Callback = function(TableOfOptions)

                --	end,
                --})


                DropdownOption.Interact.ZIndex = 50
                DropdownOption.Interact.MouseButton1Click:Connect(function()
                    if not DropdownSettings.MultipleOptions and table.find(DropdownSettings.CurrentOption, Option) then
                        return
                    end

                    if table.find(DropdownSettings.CurrentOption, Option) then
                        table.remove(DropdownSettings.CurrentOption, table.find(DropdownSettings.CurrentOption, Option))
                        if DropdownSettings.MultipleOptions then
                            if #DropdownSettings.CurrentOption == 1 then
                                Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                            elseif #DropdownSettings.CurrentOption == 0 then
                                Dropdown.Selected.Text = "None"
                            else
                                Dropdown.Selected.Text = "Various"
                            end
                        else
                            Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                        end
                    else
                        if not DropdownSettings.MultipleOptions then
                            table.clear(DropdownSettings.CurrentOption)
                        end
                        table.insert(DropdownSettings.CurrentOption, Option)
                        if DropdownSettings.MultipleOptions then
                            if #DropdownSettings.CurrentOption == 1 then
                                Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                            elseif #DropdownSettings.CurrentOption == 0 then
                                Dropdown.Selected.Text = "None"
                            else
                                Dropdown.Selected.Text = "Various"
                            end
                        else
                            Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                        end
                        TweenService:Create(DropdownOption.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                            { Transparency = 1 }):Play()
                        TweenService:Create(DropdownOption, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                            { BackgroundColor3 = Color3.fromRGB(40, 40, 40) }):Play()
                        Debounce = true
                        wait(0.2)
                        TweenService:Create(DropdownOption.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                            { Transparency = 0 }):Play()
                    end


                    local Success, Response = pcall(function()
                        DropdownSettings.Callback(DropdownSettings.CurrentOption)
                    end)

                    if not Success then
                        TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                            { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                        TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                            { Transparency = 1 }):Play()
                        Dropdown.Title.Text = "Callback Error"
                        print("Spear | " .. DropdownSettings.Name .. " Callback Error " .. tostring(Response))
                        wait(0.5)
                        Dropdown.Title.Text = DropdownSettings.Name
                        TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                            { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                        TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                            { Transparency = 0 }):Play()
                    end

                    for _, droption in ipairs(Dropdown.List:GetChildren()) do
                        if droption.ClassName == "Frame" and droption.Name ~= "Placeholder" and not table.find(DropdownSettings.CurrentOption, droption.Name) then
                            TweenService:Create(droption, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { BackgroundColor3 = Color3.fromRGB(30, 30, 30) }):Play()
                        end
                    end
                    if not DropdownSettings.MultipleOptions then
                        wait(0.1)
                        TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                            { Size = UDim2.new(1, -10, 0, 45) }):Play()
                        for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
                            if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "Placeholder" then
                                TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { BackgroundTransparency = 1 }):Play()
                                TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { Transparency = 1 }):Play()
                                TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { TextTransparency = 1 }):Play()
                            end
                        end
                        TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                            { ScrollBarImageTransparency = 1 }):Play()
                        TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint),
                            { Rotation = 180 })
                            :Play()
                        wait(0.35)
                        Dropdown.List.Visible = false
                    end
                    Debounce = false
                    SaveConfiguration()
                end)
            end

            for _, droption in ipairs(Dropdown.List:GetChildren()) do
                if droption.ClassName == "Frame" and droption.Name ~= "Placeholder" then
                    if not table.find(DropdownSettings.CurrentOption, droption.Name) then
                        droption.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    else
                        droption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    end
                end
            end

            function DropdownSettings:Set(NewOption)
                DropdownSettings.CurrentOption = NewOption

                if typeof(DropdownSettings.CurrentOption) == "string" then
                    DropdownSettings.CurrentOption = { DropdownSettings.CurrentOption }
                end

                if not DropdownSettings.MultipleOptions then
                    DropdownSettings.CurrentOption = { DropdownSettings.CurrentOption[1] }
                end

                if DropdownSettings.MultipleOptions then
                    if #DropdownSettings.CurrentOption == 1 then
                        Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                    elseif #DropdownSettings.CurrentOption == 0 then
                        Dropdown.Selected.Text = "None"
                    else
                        Dropdown.Selected.Text = "Various"
                    end
                else
                    Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                end


                local Success, Response = pcall(function()
                    DropdownSettings.Callback(NewOption)
                end)
                if not Success then
                    TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                    TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Transparency = 1 })
                        :Play()
                    Dropdown.Title.Text = "Callback Error"
                    print("Spear | " .. DropdownSettings.Name .. " Callback Error " .. tostring(Response))
                    wait(0.5)
                    Dropdown.Title.Text = DropdownSettings.Name
                    TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { Transparency = 0 })
                        :Play()
                end

                for _, droption in ipairs(Dropdown.List:GetChildren()) do
                    if droption.ClassName == "Frame" and droption.Name ~= "Placeholder" then
                        if not table.find(DropdownSettings.CurrentOption, droption.Name) then
                            droption.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        else
                            droption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        end
                    end
                end
                --SaveConfiguration()
            end

            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and DropdownSettings.Flag then
                    RayfieldLibrary.Flags[DropdownSettings.Flag] = DropdownSettings
                end
            end

            return DropdownSettings
        end

        -- Keybind
        function Tab:CreateKeybind(KeybindSettings)
            local CheckingForKey = false
            local Keybind = Elements.Template.Keybind:Clone()
            Keybind.Name = KeybindSettings.Name
            Keybind.Title.Text = KeybindSettings.Name
            Keybind.Visible = true
            Keybind.Parent = TabPage

            Keybind.BackgroundTransparency = 1
            Keybind.UIStroke.Transparency = 1
            Keybind.Title.TextTransparency = 1

            Keybind.KeybindFrame.BackgroundColor3 = SelectedTheme.InputBackground
            Keybind.KeybindFrame.UIStroke.Color = SelectedTheme.InputStroke

            TweenService:Create(Keybind, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
                :Play()
            TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
            TweenService:Create(Keybind.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()

            Keybind.KeybindFrame.KeybindBox.Text = KeybindSettings.CurrentKeybind
            Keybind.KeybindFrame.Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30)

            Keybind.KeybindFrame.KeybindBox.Focused:Connect(function()
                CheckingForKey = true
                Keybind.KeybindFrame.KeybindBox.Text = ""
            end)
            Keybind.KeybindFrame.KeybindBox.FocusLost:Connect(function()
                CheckingForKey = false
                if Keybind.KeybindFrame.KeybindBox.Text == nil or "" then
                    Keybind.KeybindFrame.KeybindBox.Text = KeybindSettings.CurrentKeybind
                    SaveConfiguration()
                end
            end)

            Keybind.MouseEnter:Connect(function()
                TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
            end)

            Keybind.MouseLeave:Connect(function()
                TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
            end)

            UserInputService.InputBegan:Connect(function(input, processed)
                if CheckingForKey then
                    if input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode ~= Enum.KeyCode.K then
                        local SplitMessage = string.split(tostring(input.KeyCode), ".")
                        local NewKeyNoEnum = SplitMessage[3]
                        Keybind.KeybindFrame.KeybindBox.Text = tostring(NewKeyNoEnum)
                        KeybindSettings.CurrentKeybind = tostring(NewKeyNoEnum)
                        Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
                        SaveConfiguration()
                    end
                elseif KeybindSettings.CurrentKeybind ~= nil and (input.KeyCode == Enum.KeyCode[KeybindSettings.CurrentKeybind] and not processed) then -- Test
                    local Held = true
                    local Connection
                    Connection = input.Changed:Connect(function(prop)
                        if prop == "UserInputState" then
                            Connection:Disconnect()
                            Held = false
                        end
                    end)

                    if not KeybindSettings.HoldToInteract then
                        local Success, Response = pcall(KeybindSettings.Callback)
                        if not Success then
                            TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                            TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                { Transparency = 1 }):Play()
                            Keybind.Title.Text = "Callback Error"
                            print("Spear | " .. KeybindSettings.Name .. " Callback Error " .. tostring(Response))
                            wait(0.5)
                            Keybind.Title.Text = KeybindSettings.Name
                            TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                            TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                { Transparency = 0 }):Play()
                        end
                    else
                        wait(0.25)
                        if Held then
                            local Loop; Loop = RunService.Stepped:Connect(function()
                                if not Held then
                                    KeybindSettings.Callback(false) -- maybe pcall this
                                    Loop:Disconnect()
                                else
                                    KeybindSettings.Callback(true) -- maybe pcall this
                                end
                            end)
                        end
                    end
                end
            end)

            Keybind.KeybindFrame.KeybindBox:GetPropertyChangedSignal("Text"):Connect(function()
                TweenService:Create(Keybind.KeybindFrame,
                    TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                    { Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30) }):Play()
            end)

            function KeybindSettings:Set(NewKeybind)
                Keybind.KeybindFrame.KeybindBox.Text = tostring(NewKeybind)
                KeybindSettings.CurrentKeybind = tostring(NewKeybind)
                Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
                SaveConfiguration()
            end

            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and KeybindSettings.Flag then
                    RayfieldLibrary.Flags[KeybindSettings.Flag] = KeybindSettings
                end
            end
            return KeybindSettings
        end

        -- Toggle
        function Tab:CreateToggle(ToggleSettings)
            local ToggleValue = {}

            local Toggle = Elements.Template.Toggle:Clone()
            Toggle.Name = ToggleSettings.Name
            Toggle.Title.Text = ToggleSettings.Name
            Toggle.Visible = true
            Toggle.Parent = TabPage

            Toggle.BackgroundTransparency = 1
            Toggle.UIStroke.Transparency = 1
            Toggle.Title.TextTransparency = 1
            Toggle.Switch.BackgroundColor3 = SelectedTheme.ToggleBackground

            if SelectedTheme ~= RayfieldLibrary.Theme.Default then
                Toggle.Switch.Shadow.Visible = false
            end

            TweenService:Create(Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
            TweenService:Create(Toggle.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()

            if not ToggleSettings.CurrentValue then
                Toggle.Switch.Indicator.Position = UDim2.new(1, -40, 0.5, 0)
                Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleDisabledStroke
                Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleDisabled
                Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleDisabledOuterStroke
            else
                Toggle.Switch.Indicator.Position = UDim2.new(1, -20, 0.5, 0)
                Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleEnabledStroke
                Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleEnabled
                Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleEnabledOuterStroke
            end

            Toggle.MouseEnter:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
            end)

            Toggle.MouseLeave:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
            end)

            Toggle.Interact.MouseButton1Click:Connect(function()
                if ToggleSettings.CurrentValue then
                    ToggleSettings.CurrentValue = false
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Position = UDim2.new(1, -40, 0.5, 0) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 12, 0, 12) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = SelectedTheme.ToggleDisabledStroke }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { BackgroundColor3 = SelectedTheme.ToggleDisabled }):Play()
                    TweenService:Create(Toggle.Switch.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = SelectedTheme.ToggleDisabledOuterStroke }):Play()
                    wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 17, 0, 17) }):Play()
                    wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                else
                    ToggleSettings.CurrentValue = true
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Position = UDim2.new(1, -20, 0.5, 0) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 12, 0, 12) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = SelectedTheme.ToggleEnabledStroke }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { BackgroundColor3 = SelectedTheme.ToggleEnabled }):Play()
                    TweenService:Create(Toggle.Switch.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = SelectedTheme.ToggleEnabledOuterStroke }):Play()
                    wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 17, 0, 17) }):Play()
                    wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                end

                local Success, Response = pcall(function()
                    ToggleSettings.Callback(ToggleSettings.CurrentValue)
                end)
                if not Success then
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    Toggle.Title.Text = "Callback Error"
                    print("Spear | " .. ToggleSettings.Name .. " Callback Error " .. tostring(Response))
                    wait(0.5)
                    Toggle.Title.Text = ToggleSettings.Name
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                end


                SaveConfiguration()
            end)

            function ToggleSettings:Set(NewToggleValue)
                if NewToggleValue then
                    ToggleSettings.CurrentValue = true
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Position = UDim2.new(1, -20, 0.5, 0) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 12, 0, 12) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = SelectedTheme.ToggleEnabledStroke }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { BackgroundColor3 = SelectedTheme.ToggleEnabled }):Play()
                    TweenService:Create(Toggle.Switch.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = Color3.fromRGB(100, 100, 100) }):Play()
                    wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 17, 0, 17) }):Play()
                    wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                else
                    ToggleSettings.CurrentValue = false
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Position = UDim2.new(1, -40, 0.5, 0) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 12, 0, 12) }):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = SelectedTheme.ToggleDisabledStroke }):Play()
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { BackgroundColor3 = SelectedTheme.ToggleDisabled }):Play()
                    TweenService:Create(Toggle.Switch.UIStroke,
                        TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                        { Color = Color3.fromRGB(65, 65, 65) }):Play()
                    wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        { Size = UDim2.new(0, 17, 0, 17) }):Play()
                    wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                end
                local Success, Response = pcall(function()
                    ToggleSettings.Callback(ToggleSettings.CurrentValue)
                end)
                if not Success then
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    Toggle.Title.Text = "Callback Error"
                    print("Spear | " .. ToggleSettings.Name .. " Callback Error " .. tostring(Response))
                    wait(0.5)
                    Toggle.Title.Text = ToggleSettings.Name
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                end
                SaveConfiguration()
            end

            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and ToggleSettings.Flag then
                    RayfieldLibrary.Flags[ToggleSettings.Flag] = ToggleSettings
                end
            end

            return ToggleSettings
        end

        -- Slider
        function Tab:CreateSlider(SliderSettings)
            local Dragging = false
            local Slider = Elements.Template.Slider:Clone()
            Slider.Name = SliderSettings.Name
            Slider.Title.Text = SliderSettings.Name
            Slider.Visible = true
            Slider.Parent = TabPage

            Slider.BackgroundTransparency = 1
            Slider.UIStroke.Transparency = 1
            Slider.Title.TextTransparency = 1

            if SelectedTheme ~= RayfieldLibrary.Theme.Default then
                Slider.Main.Shadow.Visible = false
            end

            Slider.Main.BackgroundColor3 = SelectedTheme.SliderBackground
            Slider.Main.UIStroke.Color = SelectedTheme.SliderStroke
            Slider.Main.Progress.BackgroundColor3 = SelectedTheme.SliderProgress

            TweenService:Create(Slider, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
            TweenService:Create(Slider.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Transparency = 0 }):Play()
            TweenService:Create(Slider.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()

            Slider.Main.Progress.Size = UDim2.new(0,
                Slider.Main.AbsoluteSize.X *
                ((SliderSettings.CurrentValue + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) >
                5 and
                Slider.Main.AbsoluteSize.X *
                (SliderSettings.CurrentValue / (SliderSettings.Range[2] - SliderSettings.Range[1])) or 5, 1, 0)

            if not SliderSettings.Suffix then
                Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue)
            else
                Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue) .. " " .. SliderSettings.Suffix
            end


            Slider.MouseEnter:Connect(function()
                TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackgroundHover }):Play()
            end)

            Slider.MouseLeave:Connect(function()
                TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
            end)

            Slider.Main.Interact.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = true
                end
            end)
            Slider.Main.Interact.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end)

            Slider.Main.Interact.MouseButton1Down:Connect(function(X)
                local Current = Slider.Main.Progress.AbsolutePosition.X + Slider.Main.Progress.AbsoluteSize.X
                local Start = Current
                local Location = X
                local Loop; Loop = RunService.Stepped:Connect(function()
                    if Dragging then
                        Location = UserInputService:GetMouseLocation().X
                        Current = Current + 0.025 * (Location - Start)

                        if Location < Slider.Main.AbsolutePosition.X then
                            Location = Slider.Main.AbsolutePosition.X
                        elseif Location > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
                            Location = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
                        end

                        if Current < Slider.Main.AbsolutePosition.X + 5 then
                            Current = Slider.Main.AbsolutePosition.X + 5
                        elseif Current > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
                            Current = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
                        end

                        if Current <= Location and (Location - Start) < 0 then
                            Start = Location
                        elseif Current >= Location and (Location - Start) > 0 then
                            Start = Location
                        end
                        TweenService:Create(Slider.Main.Progress,
                            TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                            { Size = UDim2.new(0, Current - Slider.Main.AbsolutePosition.X, 1, 0) }):Play()
                        local NewValue = SliderSettings.Range[1] +
                            (Location - Slider.Main.AbsolutePosition.X) / Slider.Main.AbsoluteSize.X *
                            (SliderSettings.Range[2] - SliderSettings.Range[1])

                        NewValue = math.floor(NewValue / SliderSettings.Increment + 0.5) *
                            (SliderSettings.Increment * 10000000) / 10000000
                        if not SliderSettings.Suffix then
                            Slider.Main.Information.Text = tostring(NewValue)
                        else
                            Slider.Main.Information.Text = tostring(NewValue) .. " " .. SliderSettings.Suffix
                        end

                        if SliderSettings.CurrentValue ~= NewValue then
                            local Success, Response = pcall(function()
                                SliderSettings.Callback(NewValue)
                            end)
                            if not Success then
                                TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                    { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                                TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                    { Transparency = 1 }):Play()
                                Slider.Title.Text = "Callback Error"
                                print("Spear | " .. SliderSettings.Name .. " Callback Error " .. tostring(Response))
                                wait(0.5)
                                Slider.Title.Text = SliderSettings.Name
                                TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                    { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                                TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                                    { Transparency = 0 }):Play()
                            end

                            SliderSettings.CurrentValue = NewValue
                            SaveConfiguration()
                        end
                    else
                        TweenService:Create(Slider.Main.Progress,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                            {
                                Size = UDim2.new(0,
                                    Location - Slider.Main.AbsolutePosition.X > 5 and
                                    Location - Slider.Main.AbsolutePosition.X or 5, 1, 0)
                            }):Play()
                        Loop:Disconnect()
                    end
                end)
            end)

            function SliderSettings:Set(NewVal)
                TweenService:Create(Slider.Main.Progress,
                    TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                    {
                        Size = UDim2.new(0,
                            Slider.Main.AbsoluteSize.X *
                            ((NewVal + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) >
                            5 and
                            Slider.Main.AbsoluteSize.X * (NewVal / (SliderSettings.Range[2] - SliderSettings.Range[1])) or
                            5,
                            1, 0)
                    }):Play()
                Slider.Main.Information.Text = tostring(NewVal) .. " " .. SliderSettings.Suffix
                local Success, Response = pcall(function()
                    SliderSettings.Callback(NewVal)
                end)
                if not Success then
                    TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = Color3.fromRGB(85, 0, 0) }):Play()
                    TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 1 })
                        :Play()
                    Slider.Title.Text = "Callback Error"
                    print("Spear | " .. SliderSettings.Name .. " Callback Error " .. tostring(Response))
                    wait(0.5)
                    Slider.Title.Text = SliderSettings.Name
                    TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint),
                        { BackgroundColor3 = SelectedTheme.ElementBackground }):Play()
                    TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), { Transparency = 0 })
                        :Play()
                end
                SliderSettings.CurrentValue = NewVal
                SaveConfiguration()
            end

            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and SliderSettings.Flag then
                    RayfieldLibrary.Flags[SliderSettings.Flag] = SliderSettings
                end
            end
            return SliderSettings
        end

        return Tab
    end

    Elements.Visible = true

    wait(0.7)
    TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
    TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 1 })
        :Play()
    TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
    wait(0.2)
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 500, 0, 475) }):Play()
    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.4 }):Play()

    Topbar.BackgroundTransparency = 1
    Topbar.Divider.Size = UDim2.new(0, 0, 0, 1)
    Topbar.CornerRepair.BackgroundTransparency = 1
    Topbar.Title.TextTransparency = 1
    Topbar.Theme.ImageTransparency = 1
    Topbar.ChangeSize.ImageTransparency = 1
    Topbar.Hide.ImageTransparency = 1

    wait(0.5)
    Topbar.Visible = true
    TweenService:Create(Topbar, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
        :Play()
    wait(0.1)
    TweenService:Create(Topbar.Divider, TweenInfo.new(1, Enum.EasingStyle.Quint), { Size = UDim2.new(1, 0, 0, 1) }):Play()
    wait(0.1)
    TweenService:Create(Topbar.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()
    wait(0.1)
    TweenService:Create(Topbar.Theme, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.8 }):Play()
    wait(0.1)
    TweenService:Create(Topbar.ChangeSize, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.8 }):Play()
    wait(0.1)
    TweenService:Create(Topbar.Hide, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.8 }):Play()
    wait(0.3)

    return Window
end

function RayfieldLibrary:Destroy()
    Rayfield:Destroy()
end

Topbar.ChangeSize.MouseButton1Click:Connect(function()
    if Debounce then return end
    if Minimised then
        Minimised = false
        Maximise()
    else
        Minimised = true
        Minimise()
    end
end)

Topbar.Hide.MouseButton1Click:Connect(function()
    if Debounce then return end
    if Hidden then
        Hidden = false
        Minimised = false
        Unhide()
    else
        Hidden = true
        Hide()
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if (input.KeyCode == Enum.KeyCode.K and not processed) then
        if Debounce then return end
        if Hidden then
            Hidden = false
            Unhide()
        else
            Hidden = true
            Hide()
        end
    end
end)

for _, TopbarButton in ipairs(Topbar:GetChildren()) do
    if TopbarButton.ClassName == "ImageButton" then
        TopbarButton.MouseEnter:Connect(function()
            TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0 })
                :Play()
        end)

        TopbarButton.MouseLeave:Connect(function()
            TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.8 })
                :Play()
        end)

        TopbarButton.MouseButton1Click:Connect(function()
            TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.8 })
                :Play()
        end)
    end
end


function RayfieldLibrary:LoadConfiguration()
    if CEnabled then
        pcall(function()
            if isfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension) then
                LoadConfiguration(readfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension))
                RayfieldLibrary:Notify({
                    Title = "Configuration Loaded",
                    Content =
                    "The configuration file for this script has been loaded from a previous session"
                })
            end
        end)
    end
end

task.delay(3.5, RayfieldLibrary.LoadConfiguration, RayfieldLibrary)
if Rayfield:FindFirstChild("Notice") then
    Rayfield.Notice.Visible = true
    Rayfield.Notice.Interact.MouseButton1Click:Connect(function()
        Rayfield.Notice.Visible = false
    end)
end

return RayfieldLibrary
