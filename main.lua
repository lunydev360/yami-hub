local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local player = game:GetService("Players").LocalPlayer
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled


-- Load WindUI
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- [ Variables ]
local data = {
    config = {
        onwer = [1888426792,],
        moder = [],
        isban = [],
        killaura = {
            anticlan = ["HS"],
            antiuser = [],
            unanti=[]
        }
    },
    mgsglolbal ={
        time = 0,
        text ="",
        action=true,
        color = ""
    },
    glayer = {
        [0] ={
            name ="",
            namedisplay= "",
            desc = "",
            join =0,
            role =""
        }
    }
}

-- [ sarvis ]
local function LoadData()
    local response = HttpService:GetAsync(
        "https://server-yami-hub.onrender.com/recibir"
    )

    data = HttpService:JSONDecode(response)
end

local function SaveData()
    local jsonData = HttpService:JSONEncode(data)

    HttpService:PostAsync(
        "https://server-yami-hub.onrender.com/enviar",
        jsonData,
        Enum.HttpContentType.ApplicationJson
    )
end

SaveData()


--[Setting]
local Settings = {
    owners = {},
    UI = {
        Keybind = "L",
        Clans = {"HS","AL"},
        EnabledClanLoader = true ,
    },
    AuraKill = {
        Enabled = false,
    },
}

-- Themes
WindUI:AddTheme({
    Name = "default", -- theme name
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#130018"), -- Accent
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#a200ff"),
}) -- default

WindUI:AddTheme({
    Name = "naranjo", -- theme name
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#180e00"), -- Accent
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#ff7b00"),
}) -- naranja

WindUI:AddTheme({
    Name = "golden", -- theme name
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#181600"), -- Accent
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#fbff00"),
}) -- golden

-- Create WindUI Window
local Window = WindUI:CreateWindow({
    Title = "Yami Hub",
    Author = "by Dep0700",
    Folder = "YamiHub",
    Icon = "paw-print",
    Theme = "default",
    NewElements = true,
    HideSearchBar = false,
    
    OpenButton = {
        Title = "Abrir Yami Hub", -- can be changed
        CornerRadius = UDim.new(1,0), -- fully rounded
        StrokeThickness = 3, -- removing outline
        Enabled = true, -- enable or disable openbutton
        Draggable = true,
        OnlyMobile = false,
        Scale = 0.7,
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("#000000"), 
            Color3.fromHex("#f700ff")
        )
    }
}) -- golden

Window:SetToggleKey(Enum.KeyCode[Settings.UI.Keybind])

-- Tags
do
    Window:Tag({
        Title = "vBeta",
        Icon = "braces",
        Color = Color3.fromHex("#5a5a5a"),
    })
end


-- [ detalles del usuario ]
do
    local UserIfoTab = Window:Tab({Title = "info", Icon = "circle-user",IconShape = "Square",Border = true,})
    UserIfoTab:Select() -- Select Tab

    local UserIfoGroup1 = UserIfoTab:Group({})

    UserIfoGroup1:Paragraph({Title = player.DisplayName ,Thumbnail = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(player.UserId) .. "&w=150&h=150",ThumbnailSize = 150})
    UserIfoGroup1:Space()

    local executor = "Unknown"
    if identifyexecutor then
        executor = identifyexecutor()
    elseif syn then
        executor = "Synapse X"
    elseif KRNL_LOADED then
        executor = "Krnl"
    elseif fluxus then
        executor = "Fluxus"
    elseif is_sirhurt_closure then
        executor = "SirHurt"
    elseif OXYGEN then
        executor = "Oxygen U"
    end

    local EstatusText = "\n\n"
    local EstatusUser = player:FindFirstChild("leaderstats")
    if EstatusUser then
        for _,stat in ipairs(EstatusUser:GetChildren()) do
            EstatusText ..= stat.Name .. ": " .. tostring(stat.Value) .. "\n"
        end
    else
        EstatusText = ""
    end

    local ClanName = "sin clan"
    if Settings.UI.EnabledClanLoader then
        for _,c in ipairs(Settings.UI.Clans) do
            local ClanNamelower = c:lower()
            if player.DisplayName:lower():find(ClanNamelower) then
                ClanName = c
                Settings.UI.EnabledClanLoader = false
            end
        end
    end

    UserIfoGroup1:Section({
        Title = "Name:\n" .. player.Name .."\n\nExecutador:\n" .. executor .. EstatusText .. " \n\nClan:\n" .. ClanName,
        TextXAlignment = "Left",
        Box = true,
    })
    UserIfoTab:Space()


    local DescribeUser = tostring(data)
    
    UserIfoTab:Section({Title = "Descripcion:\n\n" .. DescribeUser ,TextXAlignment = "Left",Box = true,Color = Color3.fromHex("#23003a")
    })

end

Window:Divider()
-- [ Combat ]
do
    local CombatTab = Window:Tab({Title = "Combat",Icon = "swords",})
    local killAuraSection = CombatTab:Section({Title = "Kill Aura", Icon = "chevrons-left-right-ellipsis",})

    CombatTab:Keybind({
        Title = "tecla de KA",
        Desc = "activa y desactiva el kill aura",
        Value = "G",
        Callback = function(v)
            
        end
    })
    
    CombatTab:Input({
        Title = "selection objetive",
        Value = "",
        Placeholder = "Enter User...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })

    CombatTab:Toggle({
        Title = "activacion killAura",
        Value = false, -- default value
        Callback = function(state)

        end
    })

    CombatTab:Slider({
        Title = "velocidad de daño",
        Desc = "puedes modificarlo asta 1500",
        Step = 0.1,
        Value = {
            Min = 1,
            Max = 1500,
            Default = 15,
        },
        Callback = function(value)
            print(value)
        end
    })

    CombatTab:Slider({
        Title = "rango de alcance",
        Desc = "puedes modificarlo asta 250",
        Step = 0.1,
        Value = {
            Min = 1,
            Max = 250,
            Default = 100,
        },
        Callback = function(value)
            print(value)
        end
    })

    CombatTab:Slider({
        Title = "tamaño de hitbox",
        Desc = "puedes modificarlo asta 1500",
        Step = 0.1,
        Value = {
            Min = 1,
            Max = 100,
            Default = 25,
        },
        Callback = function(value)
            print(value)
        end
    })
    
    CombatTab:Space({})

    CombatTab:Toggle({
        Title = "Anti Ragdoll",
        Value = false, -- default value
        Callback = function(state)
        end
    })

end

-- Sripts
do
    local ScriptsTab = Window:Tab({Title = "Scripts", Icon = "folder-code",})

    ScriptsTab:Section({Title = "no hay scripts"})
end

-- [ util ]
do
    local UtilsTab = Window:Tab({Title = "Util", Icon = "sliders-horizontal",})

    UtilsTab:Section({Title = "moviminto", Icon = "gauge",})


    UtilsTab:Toggle({
        Title = "set speed",
        Value = false, -- default value
        Callback = function(state)

        end
    })

    UtilsTab:Slider({
        Title = "Slider",
        Desc = "Slider Description",
        Step = 0.1,
        Value = {
            Min = 20,
            Max = 2000,
            Default = 32,
        },
        Callback = function(value)
            print(value)
        end
    })


    UtilsTab:Space()

    UtilsTab:Section({Title = "invisibilidad", Icon = "rectangle-goggles",})
    UtilsTab:Toggle({
        Title = "Invisible",
        Value = false, -- default value
        Callback = function(state)

        end
    })

    UtilsTab:Keybind({
        Title = "tecla de i nvisibilidad",
        Desc = "tecla de activar y desactivar invis",
        Value = "G",
        Callback = function(v)
            
        end
    })

    UtilsTab:Toggle({
        Title = "Spam Invisible",
        Type = "Checkbox",
        Value = false, -- default value
        Callback = function(state)

        end
    })
end

-- [ Visuls ]
do
    local VisualsTab = Window:Tab({Title = "visual", Icon = "eye",})

    VisualsTab:Toggle({
        Title = "view GUI",
        Desc = "desactiva y activa las opciones de la pantalla",
        Type = "Checkbox",
        Value = false, -- default value
        Callback = function(state)
            local player = game.Players.LocalPlayer
            local gui = player.PlayerGui:FindFirstChild("ScreenGui")

            if gui then
                gui.Enabled = state
            end
        end
    })

    VisualsTab:Section({Title = "kill aura", Icon = "chevrons-left-right-ellipsis",})

    VisualsTab:Toggle({
        Title = "target view",
        Desc = "visualiza al jugador afectado",
        Type = "Checkbox",
        Value = false, -- default value
        Callback = function(state)

        end
    })

    VisualsTab:Section({Title= "ESP",Icon= "scan-eye"})

    VisualsTab:Toggle({
        Title = "activar ESP",
        Value = false, -- default value
        Callback = function(state)

        end
    })

    VisualsTab:Toggle({
        Title = "View name",
        Desc = "visualiza los nombres de todos los jugadores",
        Type = "Checkbox",
        Value = false, -- default value
        Callback = function(state)

        end
    })

    VisualsTab:Toggle({
        Title = "Xray",
        Desc = "visualiza a los juagdores atraves de muros",
        Type = "Checkbox",
        Value = false, -- default value
        Callback = function(state)

        end
    })

    VisualsTab:Toggle({
        Title = "hitbox",
        Desc = "muestra la hitbox",
        Type = "Checkbox",
        Value = false, -- default value
        Callback = function(state)

        end
    })

end

Window:Divider()

--[ Admin ]
do
    local AdminTab = Window:Tab({Title = "admin Option", Icon = "shield-user",})

    local AdminSection1 = AdminTab:Section({Title = "admin option", Icon = "shield-ellipsis",TextSize = 20,})

    AdminTab:Input({
        Title = "enviar un mensaje global",
        Desc = "envia un mensaje para todos los que esten usando el script",
        Value = "",
        Placeholder = "Enter text...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })
    
    AdminTab:Space()
    AdminTab:Button({
        Title = "lista de admins/moders",
        Callback = function()
            -- ...
        end
    })

    local AdminSection2 = AdminTab:Section({Title = "otorgar admin",}) 
    AdminSection2:Input({
        Title = "anadir admins",
        Desc = "das permisos de admisistrador a un jugador a tu script",
        Value = "",
        Placeholder = "Enter user name...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })

    AdminSection2:Input({
        Title = "remove admins",
        Desc = "das permisos de admisistrador a un jugador a tu script",
        Value = "",
        Placeholder = "Enter user name...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })

    local AdminSection3 = AdminTab:Section({Title = "otorgar moder",}) 
    AdminSection3:Input({
        Title = "add moder",
        Desc = "das permisos de admisistrador a un jugador a tu script",
        Value = "",
        Placeholder = "Enter user name...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })

    AdminSection3:Input({
        Title = "remove moder",
        Desc = "das permisos de admisistrador a un jugador a tu script",
        Value = "",
        Placeholder = "Enter user name...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })

    AdminTab:Section({Title = "Kill aura", Icon = "chevrons-left-right-ellipsis",})

    AdminTab:Button({
        Title = "lista de inmunes",
        Callback = function()
            -- ...
        end
    })

    AdminTab:Input({
        Title = "add inmune",
        Desc = "añade un jugador ala lista de inmunes al kill aura",
        Value = "",
        Placeholder = "Enter User Name...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })

    AdminTab:Input({
        Title = "remove inmune",
        Desc = "remueve un jugador de la lista",
        Value = "",
        Placeholder = "Enter User Name...",
        Callback = function(input) 
            print("text entered: " .. input)
        end
    })

end



-- [ Settings ]
do
    local SettingTab = Window:Tab({
        Title = "Settings",
        Icon = "settings",
    })

    SettingTab:Dropdown({
        Title = "Temas",
        Desc = "selecciona un tema",
        Values = { "default", "naranjo", "golden" },
        Value = "default",
        Callback = function(option) 
            WindUI:SetTheme(tostring(option))
        end
    })

    SettingTab:Keybind({
        Title = "Keybind",
        Desc = "tecla para abrir el ui",
        Value = "G",
        Callback = function(v)
            
        end
    })

end


WindUI:Notify({
    Title = "script añadido con exito",
    Content = "el script esta siendo inyectado sin problemas",
    Duration = 5,
    Icon = "circle-arrow-down",
})
