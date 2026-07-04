local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Функция очистки старого ESP при перезапуске
local function clearEsp(character)
    if character:FindFirstChild("SolaraESP") then
        character.SolaraESP:Destroy()
    end
end

local function applySolaraEsp(player)
    if player == LocalPlayer then return end

    local function onChar(character)
        clearEsp(character) -- Убираем баги прошлых запусков
        
        -- Ждем загрузки торса игрока
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        if not hrp then return end

        -- Создаем контейнер для эффектов
        local folder = Instance.new("Folder")
        folder.Name = "SolaraESP"
        folder.Parent = character

        -- РИСУЕМ НАДПИСЬ (Никнейм)
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0) -- Высота над головой
        billboard.AlwaysOnTop = true -- Видно сквозь стены!
        billboard.Adornee = hrp
        billboard.Parent = folder

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый текст
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = billboard

        -- РИСУЕМ КВАДРАТ (Бокс вокруг игрока)
        local box = Instance.new("BoxHandleAdornment")
        box.Size = Vector3.new(4, 6, 4) -- Размеры коробки вокруг тела
        box.Color3 = Color3.fromRGB(255, 0, 0) -- Красный цвет
        box.Transparency = 0.6 -- Степень прозрачности
        box.AlwaysOnTop = true -- Видно сквозь стены!
        box.ZIndex = 10
        box.Adornee = hrp
        box.Parent = folder
    end

    if player.Character then onChar(player.Character) end
    player.CharacterAdded:Connect(onChar)
end

-- Активация
for _, p in pairs(Players:GetPlayers()) do applySolaraEsp(p) end
Players.PlayerAdded:Connect(applySolaraEsp)
