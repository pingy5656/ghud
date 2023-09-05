-- cl_magichud.lua

local ply = LocalPlayer()

-- Draw the magic bar underneath the armor bar
local function drawMagicBar()
    local magic = ply:GetNWInt("Magic", 0)
    local maxMagic = ply:GetNWInt("MaxMagic", 100)
    local magicPercentage = (magic / maxMagic) * 100

    -- Assuming the armor bar is at ScrH() - 40, we'll place the magic bar at ScrH() - 65
    draw.RoundedBox(0, 10, ScrH() - 65, 200, 20, Color(50, 50, 50, 200))
    draw.RoundedBox(0, 10, ScrH() - 65, 2 * magicPercentage, 20, Color(0, 0, 255, 200))
end

hook.Add("HUDPaint", "DrawMagicHUD", drawMagicBar)
