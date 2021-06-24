-- LUA FUNCTIONS
local clamp = math.clamp
local round = math.round
local abs = math.abs
local random = math.random
local floor = math.floor
local ceil = math.ceil

local u2 = UDim2.new
local v2 = Vector2.new
local new = Instance.new
local RGB = Color3.fromRGB
local HSV = Color3.fromHSV
local tween = TweenInfo.new
local sub = string.sub
local inst = table.insert

local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

local ColorModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/Miscellaneous/main/ColorModule.lua"))()

local function MouseIn(obj)
    if (Mouse.X < obj.AbsolutePosition.X or Mouse.X > obj.AbsolutePosition.X + obj.AbsoluteSize.X) or (Mouse.Y < obj.AbsolutePosition.Y or Mouse.Y > obj.AbsolutePosition.Y + obj.AbsoluteSize.Y) then
        return false
    end
    return true
end

local Library = {}

Library.NewWindow = function(project_name, scalable, exit_func)

    local DESTROY_GUI = false

    local RCX = new("ScreenGui")
    local Main_Window = new("Frame")
    local Pages = new("Frame")
    local Top_Bar = new("Frame")
    local Top_Bar_Border = new("Frame")
    local Top_Bar_Title = new("TextLabel")
    local Close_Button = new("TextButton")
    local Minimize_Button = new("TextButton")
    local Page_Selector = new("TextButton")
    local Page_Selector_Arrow = new("ImageLabel")
    local Page_Container = new("Frame")
    local Page_Selector_List_Layout = new("UIListLayout")

    RCX.Name = project_name
    RCX.Parent = game.CoreGui
    RCX.ZIndexBehavior = Enum.ZIndexBehavior.Global
    RCX.ResetOnSpawn = false

    Main_Window.Name = "Main_Window"
    Main_Window.Parent = RCX
    Main_Window.BackgroundColor3 = RGB(25, 26, 36)
    Main_Window.BorderColor3 = RGB(255, 255, 255)
    Main_Window.BorderSizePixel = 0
    Main_Window.ClipsDescendants = true
    Main_Window.Position = u2(0, 550, 0, 200)
    Main_Window.Size = u2(0, 500, 0, 340)
    Main_Window.Active = true
    Main_Window.Draggable = true

    Pages.Name = "Pages"
    Pages.Parent = Main_Window
    Pages.BackgroundColor3 = RGB(30, 32, 44)
    Pages.BorderColor3 = RGB(26, 28, 40)
    Pages.BorderSizePixel = 5
    Pages.ClipsDescendants = true
    Pages.Position = u2(0, 10, 0, 40)
    Pages.Size = u2(1, -20, 1, -50)
    Pages.ZIndex = 2

    Top_Bar.Name = "Top_Bar"
    Top_Bar.Parent = Main_Window
    Top_Bar.BackgroundColor3 = RGB(25, 26, 36)
    Top_Bar.BorderColor3 = RGB(255, 255, 255)
    Top_Bar.BorderSizePixel = 0
    Top_Bar.Size = u2(1, 0, 0, 30)
    Top_Bar.ZIndex = 10000

    Top_Bar_Border.Name = "Top_Bar_Border"
    Top_Bar_Border.Parent = Top_Bar
    Top_Bar_Border.BackgroundColor3 = RGB(58, 58, 85)
    Top_Bar_Border.BorderColor3 = RGB(255, 255, 255)
    Top_Bar_Border.BorderSizePixel = 0
    Top_Bar_Border.Position = u2(0, 0, 1, 0)
    Top_Bar_Border.Size = u2(1, 0, 0, 1)
    Top_Bar_Border.ZIndex = 10001

    Top_Bar_Title.Name = "Top_Bar_Title"
    Top_Bar_Title.Parent = Top_Bar
    Top_Bar_Title.BackgroundColor3 = RGB(255, 255, 255)
    Top_Bar_Title.BackgroundTransparency = 1.000
    Top_Bar_Title.BorderSizePixel = 0
    Top_Bar_Title.Position = u2(0, 10, 0, 0)
    Top_Bar_Title.Size = u2(0, 1, 1, 0)
    Top_Bar_Title.ZIndex = 10001
    Top_Bar_Title.Font = Enum.Font.SourceSans
    Top_Bar_Title.Text = project_name
    Top_Bar_Title.TextColor3 = RGB(207, 207, 222)
    Top_Bar_Title.TextSize = 15.000
    Top_Bar_Title.TextXAlignment = Enum.TextXAlignment.Left

    Close_Button.Name = "Close_Button"
    Close_Button.Parent = Top_Bar
    Close_Button.BackgroundColor3 = RGB(255, 255, 255)
    Close_Button.BackgroundTransparency = 1.000
    Close_Button.BorderSizePixel = 0
    Close_Button.Position = u2(1, -20, 0, 10)
    Close_Button.Size = u2(0, 10, 0, 10)
    Close_Button.ZIndex = 10001
    Close_Button.Font = Enum.Font.Arial
    Close_Button.Text = "X"
    Close_Button.TextColor3 = RGB(207, 207, 222)
    Close_Button.TextSize = 12.000

    Minimize_Button.Name = "Minimize_Button"
    Minimize_Button.Parent = Top_Bar
    Minimize_Button.BackgroundColor3 = RGB(255, 255, 255)
    Minimize_Button.BackgroundTransparency = 1.000
    Minimize_Button.BorderSizePixel = 0
    Minimize_Button.Position = u2(1, -35, 0, 10)
    Minimize_Button.Size = u2(0, 10, 0, 10)
    Minimize_Button.ZIndex = 10001
    Minimize_Button.Font = Enum.Font.Code
    Minimize_Button.Text = "-"
    Minimize_Button.TextColor3 = RGB(207, 207, 222)
    Minimize_Button.TextSize = 17.000

    Page_Selector.Name = "Page_Selector"
    Page_Selector.Parent = Top_Bar
    Page_Selector.BackgroundColor3 = RGB(25, 26, 36)
    Page_Selector.BorderColor3 = RGB(58, 58, 85)
    Page_Selector.Position = u2(0.5, -75, 0, 4)
    Page_Selector.Size = u2(0, 150, 0, 22)
    Page_Selector.ZIndex = 10003
    Page_Selector.AutoButtonColor = false
    Page_Selector.Font = Enum.Font.SourceSans
    Page_Selector.Text = "None"
    Page_Selector.TextColor3 = RGB(207, 207, 222)
    Page_Selector.TextSize = 14.000

    Page_Selector_Arrow.Name = "Page_Selector_Arrow"
    Page_Selector_Arrow.Parent = Page_Selector
    Page_Selector_Arrow.BackgroundColor3 = RGB(255, 255, 255)
    Page_Selector_Arrow.BackgroundTransparency = 1.000
    Page_Selector_Arrow.Position = u2(1, -15, 0.5, -3)
    Page_Selector_Arrow.Size = u2(0, 10, 0, 6)
    Page_Selector_Arrow.ZIndex = 10004
    Page_Selector_Arrow.Image = "rbxassetid://6820979846"
    Page_Selector_Arrow.ImageColor3 = RGB(207, 207, 222)

    Page_Container.Name = "Page_Container"
    Page_Container.Parent = Page_Selector
    Page_Container.BackgroundColor3 = RGB(255, 255, 255)
    Page_Container.BackgroundTransparency = 1.000
    Page_Container.Position = u2(0, 0, 1, 1)
    Page_Container.Size = u2(1, 0, 1, 0)
    Page_Container.Visible = false
    Page_Container.ZIndex = 10002

    Page_Selector_List_Layout.Name = "Page_Selector_List_Layout"
    Page_Selector_List_Layout.Parent = Page_Container
    Page_Selector_List_Layout.SortOrder = Enum.SortOrder.LayoutOrder

    local structurer = {}

    -- TOGGLE UI
    local UI_Toggled = false

    local UI_Previous_Y = 340
    local function TOGGLE_UI()
        UI_Toggled = not UI_Toggled
        if UI_Toggled then
            Minimize_Button.Text = "+"
            UI_Previous_Y = Main_Window.AbsoluteSize.Y
            TS:Create(Main_Window, tween(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = u2(0, Main_Window.AbsoluteSize.X, 0, 30)}):Play()
        else 
            Minimize_Button.Text = "-"
            TS:Create(Main_Window, tween(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = u2(0, Main_Window.AbsoluteSize.X, 0, UI_Previous_Y)}):Play()
        end
    end

    Minimize_Button.MouseButton1Click:Connect(function()
        TOGGLE_UI()
    end)

    structurer.Toggle = function()
        TOGGLE_UI()
    end

    -- CLOSE UI
    local function CLOSE_UI()
        RCX:Destroy()
        DESTROY_GUI = true
        exit_func()
    end

    Close_Button.MouseButton1Click:Connect(function()
        CLOSE_UI()
    end)

    structurer.Close = function()
        CLOSE_UI()
    end

    -- HIDE UI

    local UI_Hid = false
    structurer.Hide = function()
        UI_Hid = not UI_Hid
        RCX.Enabled = not UI_Hid
    end

    -- PAGE SELECTOR 
    Page_Selector.MouseButton1Click:Connect(function()
        Page_Container.Visible = not Page_Container.Visible
        if Page_Container.Visible then
            Page_Selector_Arrow.Rotation = 90
        else
            Page_Selector_Arrow.Rotation = 0
        end
    end)

    Page_Selector.MouseEnter:Connect(function()
        TS:Create(Page_Selector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(20, 21, 31)}):Play()
    end)

    Page_Selector.MouseLeave:Connect(function()
        TS:Create(Page_Selector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(25, 26, 36)}):Play()
    end)

    local Page_Container_Connection 
    Page_Container_Connection = UIS.InputBegan:Connect(function(input)
        if DESTROY_GUI then
            Page_Container_Connection:Disconnect()
        elseif (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and Page_Container.Visible and MouseIn(Page_Selector) == false and MouseIn(Page_Container) == false then
            local inside_selector = true
            local p_table = Pages:GetChildren()
            for i = 1, #p_table do
                local v = p_table[i]
                if not v:IsA("UIListLayout") then
                    if MouseIn(v) then
                        inside_selector = true
                        break
                    else
                        inside_selector = false
                    end
                end
            end  
            if inside_selector == false then
                Page_Container.Visible = false
                Page_Selector_Arrow.Rotation = 0
            end
        end
    end)

    -- WINDOW SCALING

    if scalable then
        local ScalingSideX = new("TextButton")
        local ScalingSideY = new("TextButton")

        ScalingSideY.Name = "ScalingSideX"
        ScalingSideY.Parent = Main_Window
        ScalingSideY.BackgroundColor3 = RGB(58, 58, 85)
        ScalingSideY.BackgroundTransparency = 1
        ScalingSideY.BorderSizePixel = 0
        ScalingSideY.Position = u2(0, 0, 1, -5)
        ScalingSideY.Size = u2(1, 0, 0, 10)
        ScalingSideY.AutoButtonColor = false
        ScalingSideY.Font = Enum.Font.SourceSans
        ScalingSideY.TextColor3 = RGB(0, 0, 0)
        ScalingSideY.Text = ""
        ScalingSideY.TextSize = 14.000

        ScalingSideX.Name = "ScalingSideY"
        ScalingSideX.Parent = Main_Window
        ScalingSideX.BackgroundColor3 = RGB(58, 58, 85)
        ScalingSideX.BackgroundTransparency = 1
        ScalingSideX.BorderSizePixel = 0
        ScalingSideX.Position = u2(1, -5, 0, 0)
        ScalingSideX.Size = u2(0, 10, 1, 0)
        ScalingSideX.Font = Enum.Font.SourceSans
        ScalingSideX.AutoButtonColor = false
        ScalingSideX.Text = ""
        ScalingSideX.TextColor3 = RGB(0, 0, 0)
        ScalingSideX.TextSize = 14.000

        local Mouse_Scaling_X = false
        local Mouse_Scaling_Y = false

        ScalingSideX.MouseButton1Down:Connect(function()
            Mouse_Scaling_X = true
            ScalingSideX.BackgroundTransparency = 0
            ScalingSideY.BackgroundTransparency = 1
        end)

        ScalingSideY.MouseButton1Down:Connect(function()
            Mouse_Scaling_Y = true
            ScalingSideY.BackgroundTransparency = 0
            ScalingSideX.BackgroundTransparency = 1
        end)

        local limit = Top_Bar_Title.TextBounds.X+8 + 40 + 200

        local Mouse_Connection
        Mouse_Connection = UIS.InputEnded:Connect(function(input)
            if DESTROY_GUI then
                Mouse_Connection:Disconnect()
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                Mouse_Scaling_X = false
                Mouse_Scaling_Y = false
                ScalingSideY.BackgroundTransparency = 0
                ScalingSideX.BackgroundTransparency = 0
            end
        end)

        local Scaling_Connection
        Scaling_Connection = RS.RenderStepped:Connect(function()
            if DESTROY_GUI then
                Scaling_Connection:Disconnect()
            elseif UI_Toggled == false and Mouse_Scaling_X then
                local offset_mouse = Mouse.X - Main_Window.AbsolutePosition.X

                Main_Window.Size = u2(0, clamp(offset_mouse, limit, math.huge), 0, Main_Window.AbsoluteSize.Y)
            elseif UI_Toggled == false and Mouse_Scaling_Y then
                local offset_mouse = Mouse.Y - Main_Window.AbsolutePosition.Y

                Main_Window.Size = u2(0, Main_Window.AbsoluteSize.X, 0, clamp(offset_mouse, 100, math.huge))
            else
                if UI_Toggled then
                    ScalingSideY.Visible = false
                    ScalingSideX.Visible = false
                else
                    ScalingSideY.Visible = true
                    ScalingSideX.Visible = true
                end
            end
        end)
    end

    local Notifications = new("Frame")
    local Notifications_List = new("UIListLayout")

    Notifications.Name = "Notifications"
    Notifications.Parent = RCX
    Notifications.BackgroundColor3 = RGB(255, 255, 255)
    Notifications.BackgroundTransparency = 1.000
    Notifications.Position = u2(1, -280, 0, -40)
    Notifications.Size = u2(0, 260, 1, 0)

    Notifications_List.Name = "Notifications_List"
    Notifications_List.Parent = Notifications
    Notifications_List.SortOrder = Enum.SortOrder.LayoutOrder
    Notifications_List.Padding = UDim.new(0, 10)
    Notifications_List.VerticalAlignment = Enum.VerticalAlignment.Bottom

    structurer.Notification = function(notification_name, CallBack, info, Refuse_CallBack)
        if CallBack ~= nil and info ~= nil then else return end

        local Notification = new("Frame")
        local Notif_Title = new("TextLabel")
        local Notif_Bar_Border = new("Frame")
        local Notif_Body = new("TextLabel")
        local Check = new("ImageButton")

        Notification.Name = notification_name
        Notification.Parent = Notifications
        Notification.BackgroundColor3 = RGB(25, 26, 36)
        Notification.BorderSizePixel = 0
        Notification.Size = u2(1, 0, 0, 100)
        Notification.ZIndex = 100000

        Notif_Title.Name = "Notif_Title"
        Notif_Title.Parent = Notification
        Notif_Title.BackgroundColor3 = RGB(255, 255, 255)
        Notif_Title.BackgroundTransparency = 1.000
        Notif_Title.Position = u2(0, 5, 0, 3)
        Notif_Title.Size = u2(0, 1, 0, 20)
        Notif_Title.ZIndex = 100001
        Notif_Title.Font = Enum.Font.SourceSans
        Notif_Title.Text = notification_name
        Notif_Title.TextColor3 = RGB(255, 255, 255)
        Notif_Title.TextSize = 16.000
        Notif_Title.TextXAlignment = Enum.TextXAlignment.Left

        Notif_Bar_Border.Name = "Notif_Bar_Border"
        Notif_Bar_Border.Parent = Notification
        Notif_Bar_Border.BackgroundColor3 = RGB(58, 58, 85)
        Notif_Bar_Border.BorderColor3 = RGB(255, 255, 255)
        Notif_Bar_Border.BorderSizePixel = 0
        Notif_Bar_Border.Position = u2(0, 0, 0, 25)
        Notif_Bar_Border.Size = u2(1, 0, 0, 1)
        Notif_Bar_Border.ZIndex = 100002

        Notif_Body.Name = "Notif_Body"
        Notif_Body.Parent = Notification
        Notif_Body.BackgroundColor3 = RGB(255, 255, 255)
        Notif_Body.BackgroundTransparency = 1.000
        Notif_Body.Position = u2(0, 5, 0, 30)
        Notif_Body.Size = u2(1, -10, 1, -35)
        Notif_Body.ZIndex = 100001
        Notif_Body.Font = Enum.Font.SourceSans
        Notif_Body.Text = info.body or ""
        Notif_Body.TextColor3 = RGB(238, 238, 255)
        Notif_Body.TextSize = 14.000
        Notif_Body.TextWrapped = true
        Notif_Body.TextXAlignment = Enum.TextXAlignment.Left
        Notif_Body.TextYAlignment = Enum.TextYAlignment.Top

        Check.Name = "Check"
        Check.Parent = Notification
        Check.BackgroundColor3 = RGB(255, 255, 255)
        Check.BackgroundTransparency = 1.000
        Check.Position = u2(1, -18, 0, 5)
        Check.Size = u2(0, 13, 0, 14)
        Check.ZIndex = 100002
        Check.AutoButtonColor = false
        Check.Image = "rbxassetid://6993419180"

        Check.MouseEnter:Connect(function()
            TS:Create(Check, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0.15}):Play()
        end)
    
        Check.MouseLeave:Connect(function()
            TS:Create(Check, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
        end)

        Check.MouseButton1Click:Connect(function()
            CallBack()
            Notification:Destroy()
        end)

        if Refuse_CallBack ~= nil and type(Refuse_CallBack) == "function" then
            local Refuse = new("ImageButton")

            Refuse.Name = "Refuse"
            Refuse.Parent = Notification
            Refuse.BackgroundColor3 = RGB(255, 255, 255)
            Refuse.BackgroundTransparency = 1.000
            Refuse.Position = u2(1, -34, 0, 6)
            Refuse.Size = u2(0, 12, 0, 12)
            Refuse.ZIndex = 100002
            Refuse.AutoButtonColor = false
            Refuse.Image = "rbxassetid://6993384643"

            Refuse.MouseEnter:Connect(function()
                TS:Create(Check, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0.15}):Play()
            end)
        
            Refuse.MouseLeave:Connect(function()
                TS:Create(Check, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
            end)
    
            Refuse.MouseButton1Click:Connect(function()
                Refuse_CallBack()
                Notification:Destroy()
            end)
        end
    end

    structurer.NewPage = function(page_name)
        -- SELECTOR APPEARANCE
        local Page_Option = new("TextButton")

        Page_Option.Name = page_name
        Page_Option.Parent = Page_Container
        Page_Option.BackgroundColor3 = RGB(25, 26, 36)
        Page_Option.BorderColor3 = RGB(58, 58, 85)
        Page_Option.Size = u2(0, 150, 0, 22)
        Page_Option.ZIndex = 10001
        Page_Option.AutoButtonColor = false
        Page_Option.Font = Enum.Font.SourceSans
        Page_Option.Text = page_name
        Page_Option.TextColor3 = RGB(207, 207, 222)
        Page_Option.TextSize = 13.000

        -- REAL PAGE
        local Page_Real = new("ScrollingFrame")
        local Page_ListLayout = new("UIListLayout")

        Page_Real.Name = page_name
        Page_Real.Parent = Pages
        Page_Real.Active = false
        Page_Real.Visible = false
        Page_Real.BackgroundColor3 = RGB(255, 255, 255)
        Page_Real.BackgroundTransparency = 1.000
        Page_Real.BorderSizePixel = 0
        Page_Real.Size = u2(1, 0, 1, 0)
        Page_Real.ZIndex = 3
        Page_Real.CanvasSize = u2(0, 0, 5, 0)
        Page_Real.ScrollBarThickness = 2
        Page_Real.ScrollBarImageColor3 = RGB(207, 207, 222)

        Page_ListLayout.Name = page_name.."_ListLayout"
        Page_ListLayout.Parent = Page_Real
        Page_ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        Page_Option.MouseEnter:Connect(function()
            TS:Create(Page_Option, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(20, 21, 31)}):Play()
        end)
    
        Page_Option.MouseLeave:Connect(function()
            TS:Create(Page_Option, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(25, 26, 36)}):Play()
        end)

        local function SELECT_PAGE()
            Page_Selector.Text = page_name
            Page_Container.Visible = not Page_Container.Visible
            Page_Selector_Arrow.Rotation = 0
            local t2 = Pages:GetChildren()
            for i2 = 1, #t2 do
                local v = t2[i2]
                if v.Name == Page_Option.Name then
                    v.Visible = true
                else
                    v.Visible = false
                end
            end
        end

        Page_Option.MouseButton1Click:Connect(function()
            SELECT_PAGE()
        end)

        local page_funcs = {}

        page_funcs.Select = function()
            SELECT_PAGE()
            Page_Container.Visible = false
        end

        page_funcs.NewCategory = function(category_name)
            local Category = new("Frame")
            local Category_Background = new("Frame")
            local Options_Holder = new("Frame")
            local Options_List_Layout = new("UIListLayout")
            local Category_Dropdown = new("TextButton")
            local Category_Dropdown_Arrow = new("ImageLabel")

            Category.Name = category_name
            Category.Parent = Page_Real
            Category.BackgroundColor3 = RGB(255, 255, 255)
            Category.BackgroundTransparency = 1.000
            Category.Size = u2(1, 0, 0, 30)
            Category.ZIndex = 4

            Category_Background.Name = "Category_Background"
            Category_Background.Parent = Category
            Category_Background.BackgroundColor3 = RGB(34, 36, 50)
            Category_Background.BorderSizePixel = 0
            Category_Background.Position = u2(0, 9, 0, 30)
            Category_Background.Size = u2(1, -18, 0, 0)
            Category_Background.ZIndex = 3

            Options_Holder.Name = "Options_Holder"
            Options_Holder.Parent = Category_Background
            Options_Holder.BackgroundColor3 = RGB(255, 255, 255)
            Options_Holder.Position = u2(0, 0, 0, 5)
            Options_Holder.Size = u2(1, 0, 1, -5)

            Options_List_Layout.Name = "Options_List_Layout"
            Options_List_Layout.Parent = Options_Holder
            Options_List_Layout.SortOrder = Enum.SortOrder.LayoutOrder

            Category_Dropdown.Name = "Category_Dropdown"
            Category_Dropdown.Parent = Category
            Category_Dropdown.BackgroundColor3 = RGB(25, 26, 36)
            Category_Dropdown.BorderColor3 = RGB(58, 58, 85)
            Category_Dropdown.Position = u2(0, 10, 0, 10)
            Category_Dropdown.Size = u2(0, 200, 0, 20)
            Category_Dropdown.ZIndex = 4
            Category_Dropdown.AutoButtonColor = false
            Category_Dropdown.Font = Enum.Font.SourceSans
            Category_Dropdown.Text = category_name
            Category_Dropdown.TextColor3 = RGB(207, 207, 222)
            Category_Dropdown.TextSize = 13.000

            Category_Dropdown_Arrow.Name = "Category_Dropdown_Arrow"
            Category_Dropdown_Arrow.Parent = Category_Dropdown
            Category_Dropdown_Arrow.BackgroundColor3 = RGB(255, 255, 255)
            Category_Dropdown_Arrow.BackgroundTransparency = 1.000
            Category_Dropdown_Arrow.Position = u2(1, -15, 0.5, -3)
            Category_Dropdown_Arrow.Size = u2(0, 10, 0, 6)
            Category_Dropdown_Arrow.ZIndex = 4
            Category_Dropdown_Arrow.Image = "rbxassetid://6820979846"
            Category_Dropdown_Arrow.ImageColor3 = RGB(207, 207, 222)

            Category_Dropdown.MouseEnter:Connect(function()
                TS:Create(Category_Dropdown, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(20, 21, 31)}):Play()
            end)
        
            Category_Dropdown.MouseLeave:Connect(function()
                TS:Create(Category_Dropdown, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(25, 26, 36)}):Play()
            end)

            local Category_Toggle = false
            local previous_size_1 = 0
            local previous_size_2 = 0

            local function TOGGLE_CATEGORY()
                Category_Toggle = not Category_Toggle

                Category_Background.Visible = Category_Toggle
                if Category_Toggle then
                    Category_Background.Size = u2(1, -18, 0, previous_size_1)
                    Category.Size = u2(1, 0, 0, previous_size_2)
                    Category_Dropdown_Arrow.Rotation = 90
                else
                    Category_Dropdown_Arrow.Rotation = 0
                    if Options_List_Layout.AbsoluteContentSize.Y > 0 then
                        previous_size_1 = Options_List_Layout.AbsoluteContentSize.Y+10
                        previous_size_2 = Options_List_Layout.AbsoluteContentSize.Y+40
                    else
                        previous_size_1 = 0
                        previous_size_2 = 30
                    end
                    Category_Background.Size = u2(1, -18, 0, 0)
                    Category.Size = u2(1, 0, 0, 30)
                end
            end

            TOGGLE_CATEGORY()

            Category_Dropdown.MouseButton1Click:Connect(function()
                TOGGLE_CATEGORY()
            end)

            Options_List_Layout.Changed:Connect(function(newproperty)
                if tostring(newproperty) == "AbsoluteContentSize"  then
                    if Options_List_Layout.AbsoluteContentSize.Y > 0 then
                        Category_Background.Size = u2(1, -18, 0, Options_List_Layout.AbsoluteContentSize.Y+10)
                        if Category_Toggle then
                            Category.Size = u2(1, 0, 0, Options_List_Layout.AbsoluteContentSize.Y+40)
                        end
                    else 
                        Category_Background.Size = u2(1, -18, 0, 0)
                        if Category_Toggle == false then
                            Category.Size = u2(1, 0, 0, 30)
                        end
                    end
                end
            end)

            local cat_funcs = {}

            cat_funcs.Toggle = function()
                TOGGLE_CATEGORY()
            end

            cat_funcs.NewToggle = function(toggle_name, CallBack, info)
                if CallBack ~= nil and info ~= nil then else return end

                local current_state = info.default or false

                local Toggle = new("Frame")
                local Toggle_Title = new("TextLabel")
                local Detector = new("TextButton")
                local UICorner_Detector = new("UICorner")
                local Toggle_Bob = new("Frame")
                local UICorner_Bob = new("UICorner")

                Toggle.Name = toggle_name
                Toggle.Parent = Options_Holder
                Toggle.BackgroundColor3 = RGB(255, 255, 255)
                Toggle.BackgroundTransparency = 1
                Toggle.Size = u2(1, 0, 0, 25)
                Toggle.ZIndex = 4

                Toggle_Title.Name = "Toggle_Title"
                Toggle_Title.Parent = Toggle
                Toggle_Title.BackgroundColor3 = RGB(255, 255, 255)
                Toggle_Title.BackgroundTransparency = 1.000
                Toggle_Title.Position = u2(0, 10, 0, 0)
                Toggle_Title.Size = u2(0, 1, 1, 0)
                Toggle_Title.ZIndex = 5
                Toggle_Title.Font = Enum.Font.SourceSans
                Toggle_Title.Text = toggle_name
                Toggle_Title.TextColor3 = RGB(207, 207, 222)
                Toggle_Title.TextSize = 14
                Toggle_Title.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = Toggle
                Detector.BorderSizePixel = 0
                Detector.Position = u2(1, -40, 0.5, -5)
                Detector.Size = u2(0, 30, 0, 10)
                Detector.ZIndex = 5
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.Text = ""
                Detector.TextColor3 = RGB(0, 0, 0)
                Detector.TextSize = 14.000

                UICorner_Detector.Name = "UICorner_Detector"
                UICorner_Detector.Parent = Detector
                UICorner_Detector.CornerRadius = UDim.new(0, 4)

                Toggle_Bob.Name = "Toggle_Bob"
                Toggle_Bob.Parent = Detector
                Toggle_Bob.BorderSizePixel = 0
                Toggle_Bob.Size = u2(0, 14, 0, 14)
                Toggle_Bob.ZIndex = 5

                UICorner_Bob.Name = "UICorner_Bob"
                UICorner_Bob.Parent = Toggle_Bob
                UICorner_Bob.CornerRadius = UDim.new(0, 7)

                local function Place_Colors()
                    if current_state then
                        TS:Create(Detector, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(190, 190, 203)}):Play()
                        TS:Create(Toggle_Bob, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(238, 238, 255)}):Play()
                        TS:Create(Toggle_Title, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = RGB(255, 255, 255)}):Play()

                        TS:Create(Toggle_Bob, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = u2(1, -14, 0, -2)}):Play()
                    else
                        TS:Create(Detector, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(118, 122, 145)}):Play()
                        TS:Create(Toggle_Bob, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(143, 147, 171)}):Play()
                        TS:Create(Toggle_Title, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = RGB(207, 207, 222)}):Play()

                        TS:Create(Toggle_Bob, tween(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = u2(0, 0, 0, -2)}):Play()
                    end
                end

                Place_Colors()

                local function TOGGLE_TOGGLE()
                    current_state = not current_state
                    CallBack(current_state)
                    Place_Colors()
                end

                Detector.MouseButton1Click:Connect(function()
                    TOGGLE_TOGGLE()
                end)

                local toggle_funcs = {}

                toggle_funcs.Toggle = function()
                    TOGGLE_TOGGLE()
                end

                return toggle_funcs
            end

            cat_funcs.NewSlider = function(slider_name, CallBack, info)
                if CallBack ~= nil and info ~= nil then else return end

                local decimals = info.decimals or 1
                local suffix = info.suffix or ""
                local current_value = info.default or ((info.min + info.max)/2)

                local Slider = new("Frame")
                local Slider_Title = new("TextLabel")
                local Detector = new("TextButton")
                local Bar = new("Frame")
                local Filled = new("Frame")
                local Slider_Value = new("TextLabel")

                Slider.Name = slider_name
                Slider.Parent = Options_Holder
                Slider.BackgroundColor3 = RGB(255, 255, 255)
                Slider.BackgroundTransparency = 1.000
                Slider.Size = u2(1, 0, 0, 25)
                Slider.ZIndex = 4

                Slider_Title.Name = "Slider_Title"
                Slider_Title.Parent = Slider
                Slider_Title.BackgroundColor3 = RGB(255, 255, 255)
                Slider_Title.BackgroundTransparency = 1.000
                Slider_Title.Position = u2(0, 10, 0, 0)
                Slider_Title.Size = u2(0, 1, 1, 0)
                Slider_Title.ZIndex = 5
                Slider_Title.Font = Enum.Font.SourceSans
                Slider_Title.Text = slider_name
                Slider_Title.TextColor3 = RGB(255, 255, 255)
                Slider_Title.TextSize = 14
                Slider_Title.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = Slider
                Detector.BackgroundColor3 = RGB(118, 122, 145)
                Detector.BackgroundTransparency = 1.000
                Detector.BorderSizePixel = 0
                Detector.Position = u2(0.699999988, -10, 0.5, -4)
                Detector.Size = u2(0.300000012, 0, 0, 8)
                Detector.ZIndex = 5
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.Text = ""
                Detector.TextColor3 = RGB(0, 0, 0)
                Detector.TextSize = 14.000

                Bar.Name = "Bar"
                Bar.Parent = Detector
                Bar.BackgroundColor3 = RGB(118, 122, 145)
                Bar.BorderSizePixel = 0
                Bar.Position = u2(0, 0, 0.5, -2)
                Bar.Size = u2(1, 0, 0, 4)
                Bar.ZIndex = 5

                Filled.Name = "Filled"
                Filled.Parent = Bar
                Filled.BackgroundColor3 = RGB(210, 210, 225)
                Filled.BorderSizePixel = 0
                Filled.Position = u2(0, 0, 0.5, -2)
                Filled.Size = u2(0, 100, 0, 4)
                Filled.ZIndex = 6

                Slider_Value.Name = "Slider_Value"
                Slider_Value.Parent = Slider
                Slider_Value.BackgroundColor3 = RGB(255, 255, 255)
                Slider_Value.BackgroundTransparency = 1.000
                Slider_Value.Position = u2(0.699999988, -20, 0, 0)
                Slider_Value.Size = u2(0, 1, 1, 0)
                Slider_Value.ZIndex = 5
                Slider_Value.Font = Enum.Font.SourceSans
                
                if decimals > 1 then
                    local str = "1"
                    for i = 1, decimals do 
                        str = str.."0"
                    end
                    Slider_Value.Text = round(info.default * tonumber(str))/tonumber(str)..tostring(suffix)
                else 
                    Slider_Value.Text = info.default..tostring(suffix)  
                end

                Slider_Value.TextColor3 = RGB(238, 238, 255)
                Slider_Value.TextSize = 14.000
                Slider_Value.TextXAlignment = Enum.TextXAlignment.Right

                local Dragging = false
                Detector.MouseButton1Down:Connect(function()
                    Dragging = true
                end)
                local connection
                connection = UIS.InputEnded:Connect(function(input)
                    if DESTROY_GUI then
                        connection:Disconnect()
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                    end
                end)

                local min = info.min or 0
                local max = info.max or 100
                local difference = max - min
                local function Place(val)
                    val = clamp(val, min, max)
                    local offset = val*Bar.AbsoluteSize.X/difference
                    Filled.Size = u2(0, clamp(offset, 0, Bar.AbsoluteSize.X+1), 0, 4)
                end

                Place(current_value)

                local previous_value = nil
                local slider_connection 
                slider_connection = RS.RenderStepped:Connect(function()
                    if DESTROY_GUI then
                        slider_connection:Disconnect()
                    elseif Dragging then
                        -- PLACING
                        local offset = Mouse.X - Bar.AbsolutePosition.X
                        Filled.Size = u2(0, clamp(offset, 0, Bar.AbsoluteSize.X+1), 0, 4)
                        
                        -- CALCULATIONS
                        local outcome = nil
                        outcome = clamp(round(Filled.AbsoluteSize.X * difference / Bar.AbsoluteSize.X), min, max)
                        if decimals >= 1 then
                            local str = "1"
                            for i = 1, decimals do 
                                str = str.."0"
                            end
                            outcome = clamp(round((Filled.AbsoluteSize.X * difference / Bar.AbsoluteSize.X) * tonumber(str))/tonumber(str), min, max)
                        end
                        current_value = outcome
                        Slider_Value.Text = tostring(outcome)..tostring(suffix)
                        if previous_value ~= outcome then
                            CallBack(outcome)
                            previous_value = outcome
                        end
                        Place(current_value)
                    else 
                        Place(current_value)
                    end
                end)
                local slider_funcs = {}

                slider_funcs.SetValue = function(val)
                    CallBack(clamp(val, min, max))
                    current_value = clamp(val, min, max)
                    Slider_Value.Text = tostring(current_value)..tostring(suffix)
                    Place(current_value)
                end
                return slider_funcs
            end

            cat_funcs.NewKeybind = function(keybind_name, CallBack, KeyCallBack, info)
                if CallBack ~= nil and info ~= nil then else return end

                local Current_Keybind = info.default or Enum.KeyCode.Q

                local Keybind = new("Frame")
                local Keybind_Title = new("TextLabel")
                local Detector = new("TextButton")

                Keybind.Name = keybind_name
                Keybind.Parent = Options_Holder
                Keybind.BackgroundColor3 = RGB(255, 255, 255)
                Keybind.BackgroundTransparency = 1.000
                Keybind.Size = u2(1, 0, 0, 25)
                Keybind.ZIndex = 4

                Keybind_Title.Name = "Keybind_Title"
                Keybind_Title.Parent = Keybind
                Keybind_Title.BackgroundColor3 = RGB(255, 255, 255)
                Keybind_Title.BackgroundTransparency = 1.000
                Keybind_Title.Position = u2(0, 10, 0, 0)
                Keybind_Title.Size = u2(0, 1, 1, 0)
                Keybind_Title.ZIndex = 5
                Keybind_Title.Font = Enum.Font.SourceSans
                Keybind_Title.Text = keybind_name
                Keybind_Title.TextColor3 = RGB(255, 255, 255)
                Keybind_Title.TextSize = 14
                Keybind_Title.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = Keybind
                Detector.BackgroundColor3 = RGB(25, 26, 36)
                Detector.BackgroundTransparency = 0
                Detector.BorderColor3 = RGB(58, 58, 85)
                Detector.Position = u2(1, -30, 0.5, -10)
                Detector.Size = u2(0, 20, 0, 20)
                Detector.ZIndex = 5
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.TextSize = 13
                Detector.Text = sub(tostring(Current_Keybind), 14, #tostring(Current_Keybind)) 
                Detector.TextColor3 = RGB(238, 238, 255)

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(20, 21, 31)}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(25, 26, 36)}):Play()
                end)

                local function SCALE()
                    local newsize = Detector.TextBounds.X+8
                    Detector.Size = u2(0, newsize, 0, 20)
                    Detector.Position = u2(1, -newsize-10, 0.5, -10)
                end
                SCALE()

                local Selecting = false
                Detector.MouseButton1Click:Connect(function()
                    Selecting = true
                    Detector.Text = ""
                    local connection
                    local connection2

                    connection = UIS.InputBegan:Connect(function(input)
                        if DESTROY_GUI then
                            connection:Disconnect()
                        elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.Backspace then
                            local newkey = false
                            if Current_Keybind ~= input.KeyCode then
                                newkey = true
                            end
                            Current_Keybind = input.KeyCode
                            Detector.Text = sub(tostring(Current_Keybind), 14, #tostring(Current_Keybind))
                            if newkey then
                                SCALE()
                                KeyCallBack(Current_Keybind)
                            end
                            connection:Disconnect()
                            wait()
                            Selecting = false
                        end
                    end)
                    connection2 = UIS.InputBegan:Connect(function(input)
                        if DESTROY_GUI then
                            connection2:Disconnect()
                        elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Backspace then
                            Detector.Text = "None"
                            SCALE()
                            Current_Keybind = nil
                            KeyCallBack(Current_Keybind)
                            connection:Disconnect()
                            connection2:Disconnect()
                            wait()
                            Selecting = false
                        end
                    end)
                end)

                local c
                c = UIS.InputBegan:Connect(function(input)
                    if DESTROY_GUI then
                        c:Disconnect()
                    elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Current_Keybind and Selecting == false then
                        CallBack()
                    end
                end)

                local keybind_funcs = {}

                keybind_funcs.SetKeybind = function(newbind)
                    if newbind ~= Enum.KeyCode.Backspace and Enum.KeyCode[sub(tostring(newbind), 14, #tostring(newbind))] ~= nil then
                        Current_Keybind = newbind
                        Detector.Text = sub(tostring(Current_Keybind), 14, #tostring(Current_Keybind))
                        SCALE()
                        KeyCallBack(Current_Keybind)
                    end
                end

                return keybind_funcs
            end

            cat_funcs.NewColorpicker = function(picker_name, CallBack, info)
                if CallBack ~= nil and info ~= nil then else return end

                local ColorPicker = new("Frame")
                local Picker_Title = new("TextLabel")
                local Detector = new("TextButton")
                local Detector_Gradient = new("UIGradient")
                local PickerFrame = new("Frame")
                local HSVBox = new("ImageButton")
                local Cursor = new("Frame")
                local HUEPicker = new("ImageButton")
                local HUEGradient = new("UIGradient")
                local Indicator = new("Frame")
                local Value1 = new("TextBox")
                local Value2 = new("TextBox")
                local Value3 = new("TextBox")
                local CopyValues = new("TextButton")

                ColorPicker.Name = picker_name
                ColorPicker.Parent = Options_Holder
                ColorPicker.BackgroundColor3 = RGB(255, 255, 255)
                ColorPicker.BackgroundTransparency = 1.000
                ColorPicker.Size = u2(1, 0, 0, 25)
                ColorPicker.ZIndex = 4

                Picker_Title.Name = "Picker_Title"
                Picker_Title.Parent = ColorPicker
                Picker_Title.BackgroundColor3 = RGB(255, 255, 255)
                Picker_Title.BackgroundTransparency = 1.000
                Picker_Title.Position = u2(0, 10, 0, 0)
                Picker_Title.Size = u2(0, 1, 1, 0)
                Picker_Title.ZIndex = 5
                Picker_Title.Font = Enum.Font.SourceSans
                Picker_Title.Text = picker_name
                Picker_Title.TextColor3 = RGB(255, 255, 255)
                Picker_Title.TextSize = 14
                Picker_Title.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = ColorPicker
                Detector.BackgroundColor3 = RGB(255, 0, 4)
                Detector.BorderColor3 = RGB(58, 58, 85)
                Detector.BorderSizePixel = 2
                Detector.BorderMode = Enum.BorderMode.Inset
                Detector.Position = u2(1, -35, 0.5, -8)
                Detector.Size = u2(0, 25, 0, 16)
                Detector.ZIndex = 5
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.Text = ""
                Detector.TextColor3 = RGB(238, 238, 255)
                Detector.TextSize = 14.000

                Detector_Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, RGB(255, 255, 255)), ColorSequenceKeypoint.new(0.54, RGB(225, 225, 225)), ColorSequenceKeypoint.new(1.00, RGB(112, 112, 112))}
                Detector_Gradient.Rotation = 90
                Detector_Gradient.Name = "Detector_Gradient"
                Detector_Gradient.Parent = Detector

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end)

                PickerFrame.Name = "PickerFrame"
                PickerFrame.Parent = ColorPicker
                PickerFrame.BackgroundColor3 = RGB(25, 26, 36)
                PickerFrame.BorderColor3 = RGB(58, 58, 85)
                PickerFrame.Position = u2(1, -131, 1, 2)
                PickerFrame.Visible = false
                PickerFrame.Size = u2(0, 120, 0, 158)
                PickerFrame.ZIndex = 10

                HSVBox.Name = "HSVBox"
                HSVBox.Parent = PickerFrame
                HSVBox.BackgroundColor3 = RGB(255, 255, 255)
                HSVBox.BorderColor3 = RGB(58, 58, 85)
                HSVBox.Position = u2(0, 4, 0, 4)
                HSVBox.Size = u2(0, 98, 0, 98)
                HSVBox.ZIndex = 10
                HSVBox.AutoButtonColor = false
                HSVBox.Image = "rbxassetid://4155801252"

                Cursor.Name = "Cursor"
                Cursor.Parent = HSVBox
                Cursor.BackgroundColor3 = RGB(255, 255, 255)
                Cursor.BorderColor3 = RGB(0, 0, 0)
                Cursor.Size = u2(0, 2, 0, 2)
                Cursor.ZIndex = 11

                HUEPicker.Name = "HUEPicker"
                HUEPicker.Parent = PickerFrame
                HUEPicker.BackgroundColor3 = RGB(255, 255, 255)
                HUEPicker.BorderColor3 = RGB(58, 58, 85)
                HUEPicker.Position = u2(0, 106, 0, 4)
                HUEPicker.Size = u2(0, 10, 0, 98)
                HUEPicker.ZIndex = 10
                HUEPicker.AutoButtonColor = false
                HUEPicker.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

                HUEGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, RGB(255, 0, 4)), ColorSequenceKeypoint.new(0.10, RGB(255, 0, 200)), ColorSequenceKeypoint.new(0.20, RGB(153, 0, 255)), ColorSequenceKeypoint.new(0.30, RGB(0, 0, 255)), ColorSequenceKeypoint.new(0.40, RGB(0, 149, 255)), ColorSequenceKeypoint.new(0.50, RGB(0, 255, 209)), ColorSequenceKeypoint.new(0.60, RGB(0, 255, 55)), ColorSequenceKeypoint.new(0.70, RGB(98, 255, 0)), ColorSequenceKeypoint.new(0.80, RGB(251, 255, 0)), ColorSequenceKeypoint.new(0.90, RGB(255, 106, 0)), ColorSequenceKeypoint.new(1.00, RGB(255, 0, 0))}
                HUEGradient.Rotation = 90
                HUEGradient.Name = "HUEGradient"
                HUEGradient.Parent = HUEPicker

                Indicator.Name = "Indicator"
                Indicator.Parent = HUEPicker
                Indicator.BackgroundColor3 = RGB(255, 255, 255)
                Indicator.BorderColor3 = RGB(0, 0, 0)
                Indicator.Size = u2(1, 0, 0, 2)
                Indicator.ZIndex = 11

                Value1.Name = "Value1"
                Value1.Parent = PickerFrame
                Value1.BackgroundColor3 = RGB(25, 26, 36)
                Value1.BorderColor3 = RGB(58, 58, 85)
                Value1.Position = u2(0, 5, 0, 108)
                Value1.Size = u2(0, 32, 0, 20)
                Value1.ZIndex = 11
                Value1.Font = Enum.Font.SourceSans
                Value1.PlaceholderColor3 = RGB(178, 178, 178)
                Value1.PlaceholderText = "R"
                Value1.Text = ""
                Value1.TextColor3 = RGB(238, 238, 255)
                Value1.TextSize = 13.000

                Value2.Name = "Value2"
                Value2.Parent = PickerFrame
                Value2.BackgroundColor3 = RGB(25, 26, 36)
                Value2.BorderColor3 = RGB(58, 58, 85)
                Value2.Position = u2(0, 44, 0, 108)
                Value2.Size = u2(0, 32, 0, 20)
                Value2.ZIndex = 11
                Value2.Font = Enum.Font.SourceSans
                Value2.PlaceholderText = "G"
                Value2.Text = ""
                Value2.TextColor3 = RGB(238, 238, 255)
                Value2.TextSize = 13.000

                Value3.Name = "Value3"
                Value3.Parent = PickerFrame
                Value3.BackgroundColor3 = RGB(25, 26, 36)
                Value3.BorderColor3 = RGB(58, 58, 85)
                Value3.Position = u2(0, 83, 0, 108)
                Value3.Size = u2(0, 32, 0, 20)
                Value3.ZIndex = 11
                Value3.Font = Enum.Font.SourceSans
                Value3.PlaceholderText = "B"
                Value3.Text = ""
                Value3.TextColor3 = RGB(238, 238, 255)
                Value3.TextSize = 13.000

                CopyValues.Name = "CopyValues"
                CopyValues.Parent = PickerFrame
                CopyValues.BackgroundColor3 = RGB(25, 26, 36)
                CopyValues.BorderColor3 = RGB(58, 58, 85)
                CopyValues.Position = u2(0, 4, 0, 134)
                CopyValues.Size = u2(1, -8, 0, 20)
                CopyValues.ZIndex = 11
                CopyValues.AutoButtonColor = false
                CopyValues.Font = Enum.Font.SourceSans
                CopyValues.Text = "Copy Values"
                CopyValues.TextColor3 = RGB(238, 238, 255)
                CopyValues.TextSize = 13.000

                CopyValues.MouseEnter:Connect(function()
                    TS:Create(CopyValues, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(20, 21, 31)}):Play()
                end)
            
                CopyValues.MouseLeave:Connect(function()
                    TS:Create(CopyValues, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(25, 26, 36)}):Play()
                end)

                CopyValues.MouseButton1Click:Connect(function()
                    setclipboard(Value1.Text..", "..Value2.Text..", "..Value3.Text)
                end)

                if info.default ~= nil then
                    Value1.Text = round(info.default.r*255)
                    Value2.Text = round(info.default.g*255)
                    Value3.Text = round(info.default.b*255)
                else
                    Value1.Text = "255"
                    Value2.Text = "255"
                    Value3.Text = "255"
                end

                Detector.MouseButton1Click:Connect(function()
                    PickerFrame.Visible = not PickerFrame.Visible
                end)

                local detect_inside
                detect_inside = UIS.InputBegan:Connect(function(input)
                    if DESTROY_GUI then
                        detect_inside:Disconnect()
                    elseif input.UserInputType == Enum.UserInputType.MouseButton2 and PickerFrame.Visible == true and MouseIn(PickerFrame) == false then
                        PickerFrame.Visible = false
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 and PickerFrame.Visible == true and MouseIn(Detector) == false and MouseIn(PickerFrame) == false then
                        PickerFrame.Visible = false
                    end
                end)

                local previous = nil

                local function PlaceColor(col) -- RGB Color
                    local h, s, v = ColorModule:rgbToHsv(col.r*255, col.g*255, col.b*255)

                    Indicator.Position = u2(0, 0, 0, HUEPicker.AbsoluteSize.Y - HUEPicker.AbsoluteSize.Y * h)
                    Cursor.Position = u2(0, HSVBox.AbsoluteSize.X * s - Cursor.AbsoluteSize.X/2, 0, HSVBox.AbsoluteSize.Y - HSVBox.AbsoluteSize.Y * v - Cursor.AbsoluteSize.Y/2)

                    Detector.BackgroundColor3 = col

                    HSVBox.BackgroundColor3 = HSV(h, 1, 1)
                    if col ~= previous then
                        previous = col
                        CallBack(col)
                    end
                end

                local function PlaceColorHSV(hsv) -- HSV Color
                    local h = hsv.h
                    local s = hsv.s
                    local v = hsv.v
                    HSVBox.BackgroundColor3 = HSV(h, 1, 1)
                    local newh, news, newv = ColorModule:hsvToRgb(h, s, v)
                    Value1.Text = round(newh)
                    Value2.Text = round(news)
                    Value3.Text = round(newv)
                    Detector.BackgroundColor3 = RGB(round(newh), round(news), round(newv))

                    local col = RGB(newh, news, newv)
                    if col ~= previous then
                        previous = col
                        CallBack(col)
                    end
                end

                if info.default ~= nil then
                    PlaceColor(info.default)
                else
                    PlaceColor(RGB(255, 255, 255))
                end

                local SelectingHUE = false
                local SelectingHSV = false

                local prev1
                Value1.Changed:Connect(function(property)
                    if (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and tonumber(Value1.Text) then
                        Value1.Text = clamp(tonumber(Value1.Text), 0, 255)
                        PlaceColor(RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text)))
                        Detector.BackgroundColor3 = RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text))
                        prev1 = tonumber(Value1.Text)
                    elseif (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and Value1.Text == " " then
                        Value1.Text = prev1
                    end
                end)

                local prev2
                Value2.Changed:Connect(function(property)
                    if (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and tonumber(Value2.Text) then
                        Value2.Text = clamp(tonumber(Value2.Text), 0, 255)
                        PlaceColor(RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text)))
                        Detector.BackgroundColor3 = RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text))
                        prev2 = tonumber(Value2.Text)
                    elseif (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and Value2.Text == " " then
                        Value2.Text = prev2
                    end
                end)

                local prev3
                Value3.Changed:Connect(function(property)
                    if (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and tonumber(Value3.Text) then
                        Value3.Text = clamp(tonumber(Value3.Text), 0, 255)
                        PlaceColor(RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text)))
                        Detector.BackgroundColor3 = RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text))
                        prev3 = tonumber(Value3.Text)
                    elseif (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and Value3.Text == " " then
                        Value3.Text = prev3
                    end
                end)

                HUEPicker.MouseButton1Down:Connect(function()
                    SelectingHUE = true
                end)
                HSVBox.MouseButton1Down:Connect(function()
                    SelectingHSV = true
                end)

                local selecting_c
                selecting_c = UIS.InputEnded:Connect(function(input)
                    if DESTROY_GUI then
                        selecting_c:Disconnect()
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        SelectingHUE = false
                        SelectingHSV = false
                    end
                end)
                
                local colorpicker_c
                colorpicker_c = RS.RenderStepped:Connect(function()
                    if DESTROY_GUI then
                        colorpicker_c:Disconnect()
                    else
                        if SelectingHUE then
                            Indicator.Position = u2(0, 0, 0, clamp(Mouse.Y - HUEPicker.AbsolutePosition.Y, 0, HUEPicker.AbsoluteSize.Y))
                            local h1 = (HUEPicker.AbsoluteSize.Y - (Indicator.AbsolutePosition.Y - HUEPicker.AbsolutePosition.Y)) / HUEPicker.AbsoluteSize.Y
                            local s1 = (Cursor.AbsolutePosition.X - HSVBox.AbsolutePosition.X) / HSVBox.AbsoluteSize.X
                            local v1 = (HSVBox.AbsoluteSize.Y - (Cursor.AbsolutePosition.Y - HSVBox.AbsolutePosition.Y)) / HSVBox.AbsoluteSize.Y
                            PlaceColorHSV({h = h1, s = s1, v = v1})
                        end
                        if SelectingHSV then
                            Cursor.Position = u2(0, clamp(Mouse.X - HSVBox.AbsolutePosition.X, 0, HSVBox.AbsoluteSize.X), 0, clamp(Mouse.Y - HSVBox.AbsolutePosition.Y, 0, HSVBox.AbsoluteSize.Y))
                            local h1 = (HUEPicker.AbsoluteSize.Y - (Indicator.AbsolutePosition.Y - HUEPicker.AbsolutePosition.Y)) / HUEPicker.AbsoluteSize.Y
                            local s1 = (Cursor.AbsolutePosition.X - HSVBox.AbsolutePosition.X) / HSVBox.AbsoluteSize.X
                            local v1 = (HSVBox.AbsoluteSize.Y - (Cursor.AbsolutePosition.Y - HSVBox.AbsolutePosition.Y)) / HSVBox.AbsoluteSize.Y
                            Cursor.Position = u2(0, clamp(Mouse.X - HSVBox.AbsolutePosition.X, Cursor.AbsoluteSize.X/2, HSVBox.AbsoluteSize.X - Cursor.AbsoluteSize.X), 0, clamp(Mouse.Y - HSVBox.AbsolutePosition.Y, Cursor.AbsoluteSize.Y/2, HSVBox.AbsoluteSize.Y - Cursor.AbsoluteSize.Y))
                            PlaceColorHSV({h = h1, s = s1, v = v1})
                        end
                    end
                end)

                local color_picker_funcs = {}

                color_picker_funcs.SetColor = function(newcol)
                    PlaceColor(newcol)
                end

                return color_picker_funcs
            end

            cat_funcs.NewDropdown = function(dropdown_name, CallBack, info)
                if CallBack ~= nil and info ~= nil then else return end

                local current_option = info.options[info.default] or info.options[1]

                local Dropdown = new("Frame")
                local Dropdown_Title = new("TextLabel")
                local Detector = new("TextButton")
                local Dropdown_Arrow = new("ImageLabel")
                local Options_Container = new("Frame")
                local Dropdown_List_Layout = new("UIListLayout")
              
                Dropdown.Name = dropdown_name
                Dropdown.Parent = Options_Holder
                Dropdown.BackgroundColor3 = RGB(255, 255, 255)
                Dropdown.BackgroundTransparency = 1.000
                Dropdown.Size = u2(1, 0, 0, 25)
                Dropdown.ZIndex = 4

                Dropdown_Title.Name = "Dropdown_Title"
                Dropdown_Title.Parent = Dropdown
                Dropdown_Title.BackgroundColor3 = RGB(255, 255, 255)
                Dropdown_Title.BackgroundTransparency = 1.000
                Dropdown_Title.Position = u2(0, 10, 0, 0)
                Dropdown_Title.Size = u2(0, 1, 1, 0)
                Dropdown_Title.ZIndex = 5
                Dropdown_Title.Font = Enum.Font.SourceSans
                Dropdown_Title.Text = dropdown_name
                Dropdown_Title.TextColor3 = RGB(238, 238, 255)
                Dropdown_Title.TextSize = 14.000
                Dropdown_Title.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = Dropdown
                Detector.BackgroundColor3 = RGB(25, 26, 36)
                Detector.BorderColor3 = RGB(58, 58, 85)
                Detector.Position = u2(1, -110, 0.5, -10)
                Detector.Size = u2(0, 100, 0, 20)
                Detector.ZIndex = 5
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.Text = current_option
                Detector.TextColor3 = RGB(255, 255, 255)
                Detector.TextSize = 13.000

                Dropdown_Arrow.Name = "Dropdown_Arrow"
                Dropdown_Arrow.Parent = Detector
                Dropdown_Arrow.BackgroundColor3 = RGB(255, 255, 255)
                Dropdown_Arrow.BackgroundTransparency = 1.000
                Dropdown_Arrow.Position = u2(1, -15, 0.5, -2)
                Dropdown_Arrow.Size = u2(0, 10, 0, 6)
                Dropdown_Arrow.ZIndex = 5
                Dropdown_Arrow.Image = "rbxassetid://6820979846"
                Dropdown_Arrow.ImageColor3 = RGB(238, 238, 255)

                Options_Container.Name = "Options_Container"
                Options_Container.Parent = Detector
                Options_Container.BackgroundColor3 = RGB(255, 255, 255)
                Options_Container.BackgroundTransparency = 1.000
                Options_Container.Position = u2(0, 0, 1, 1)
                Options_Container.Size = u2(1, 0, 1, 0)
                Options_Container.Visible = false
                Options_Container.ZIndex = 15

                Dropdown_List_Layout.Name = "Dropdown_List_Layout"
                Dropdown_List_Layout.Parent = Options_Container
                Dropdown_List_Layout.SortOrder = Enum.SortOrder.LayoutOrder

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(20, 21, 31)}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(25, 26, 36)}):Play()
                end)

                Detector.MouseButton1Click:Connect(function()
                    Options_Container.Visible = not Options_Container.Visible
                    if Options_Container.Visible then
                        Dropdown_Arrow.Rotation = 90
                    else
                        Dropdown_Arrow.Rotation = 0
                    end
                end)

                local detect_inside_dropdown
                detect_inside_dropdown = UIS.InputBegan:Connect(function(input)
                    if DESTROY_GUI then
                        detect_inside_dropdown:Disconnect()
                    elseif (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and Options_Container.Visible and MouseIn(Detector) == false and MouseIn(Options_Container) == false then
                        local inside_selector = true
                        local d_table = Options_Container:GetChildren()
                        for i = 1, #d_table do
                            local v = d_table[i]
                            if not v:IsA("UIListLayout") then
                                if MouseIn(v) then
                                    inside_selector = true
                                    break
                                else
                                    inside_selector = false
                                end
                            end
                        end  
                        if inside_selector == false then
                            Options_Container.Visible = false
                            Dropdown_Arrow.Rotation = 0
                        end
                    end
                end)

                local function Select(option)
                    CallBack(option)
                    Options_Container.Visible = false
                    Dropdown_Arrow.Rotation = 0
                    Detector.Text = option
                end
                Select(current_option)

                local function ReMap()
                    for _,v in pairs(Options_Container:GetChildren()) do
                        if not v:IsA("UIListLayout") then
                            for u,x in pairs(getconnections(v.MouseEnter)) do
                                x:Disable()
                            end
                            for u,x in pairs(getconnections(v.MouseLeave)) do
                                x:Disable()
                            end
                            for u,x in pairs(getconnections(v.MouseButton1Click)) do
                                x:Disable()
                            end
                            v:Destroy()
                        end
                    end
                    for _,v in pairs(info.options) do
                        local Option = new("TextButton")

                        Option.Name = "Option"
                        Option.Parent = Options_Container
                        Option.BackgroundColor3 = RGB(25, 26, 36)
                        Option.BorderColor3 = RGB(58, 58, 85)
                        Option.Size = u2(1, 0, 0, 20)
                        Option.ZIndex = 16
                        Option.AutoButtonColor = false
                        Option.Font = Enum.Font.SourceSans
                        Option.Text = v
                        Option.TextColor3 = RGB(238, 238, 255)
                        Option.TextSize = 13.000
    
                        Option.MouseEnter:Connect(function()
                            TS:Create(Option, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(20, 21, 31)}):Play()
                        end)
                    
                        Option.MouseLeave:Connect(function()
                            TS:Create(Option, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(25, 26, 36)}):Play()
                        end)
    
                        Option.MouseButton1Click:Connect(function()
                            Select(v)
                        end)
                    end
                end
                ReMap()

                local dropdown_funcs = {}

                dropdown_funcs.SelectOption = function(op_name)
                    for _,v in pairs(info.options) do
                        if tostring(v) == tostring(op_name) then
                            Select(v)
                            break
                        end
                    end
                end

                dropdown_funcs.AddOption = function(op_name)
                    inst(info.options, op_name)
                    ReMap()
                end

                dropdown_funcs.RemoveOption = function(op_name)
                    local newtbl = {}
                    for _,v in pairs(info.options) do
                        if tostring(v) ~= tostring(op_name) then
                            inst(newtbl, v)
                        end
                    end
                    info.options = newtbl
                    ReMap()
                end

                return dropdown_funcs
            end

            return cat_funcs
        end
        return page_funcs
    end
    return structurer
end
return Library
