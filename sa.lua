local head = player.Character:FindFirstChild("Head")
local root = player.Character:FindFirstChild("HumanoidRootPart")

if head and root then
    -- Получаем 2D координаты головы и ног
    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
    local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

    -- Вычисляем высоту и ширину рамки на экране
    local boxHeight = math.abs(headPos.Y - legPos.Y)
    local boxWidth = boxHeight / 2 -- Обычно ширина персонажа в 2 раза меньше высоты

    -- Задаем параметры квадрату (Drawing.new("Square"))
    box.Size = Vector2.new(boxWidth, boxHeight)
    box.Position = Vector2.new(headPos.X - (boxWidth / 2), headPos.Y)
end
