-- cl_magicinfo.lua

local ply = LocalPlayer()

-- Display magic information
local function drawMagicInfo()
    local magic = ply:GetNWInt("Magic", 0)
    local maxMagic = ply:GetNWInt("MaxMagic", 100)

    -- Displaying the magic info near the bottom right of the screen
    draw.SimpleText("Magic: " .. magic .. "/" .. maxMagic, "Default", ScrW() - 10, ScrH() - 65, Color(255, 255, 255, 200), TEXT_ALIGN_RIGHT)
end

hook.Add("HUDPaint", "DrawMagicInfo", drawMagicInfo)
