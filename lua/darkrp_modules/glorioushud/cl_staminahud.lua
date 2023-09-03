local staminaAnim = 0
local alpha = 0
local hungermod = DarkRP.disabledDefaults[ 'modules' ][ 'hungermod' ]
local w, h = ScrW(), ScrH()
local x, y = 415, h - 190
local staminahudHeight = 180

if( hungermod ) then 
	y = h - 155 
	staminahudHeight = 145
end

local function staminahud()

	if( !( LocalPlayer() && IsValid( LocalPlayer() ) && LocalPlayer().GetStamina ) ) then return end

	if( LocalPlayer():InVehicle() || SS.Settings.UnlimitedStamina[ team.GetName( LocalPlayer():Team() ) ] ) then
		return
	end

	if( LocalPlayer():GetStamina() < 100 ) then
		alpha = math.Approach( alpha, 1, 0.05 )
	else
		alpha = math.Approach( alpha, 0, 0.05 )
	end

	if( alpha == 0 ) then return end

	local staminaType

	if( ( LocalPlayer().SSOldPos || LocalPlayer():GetPos() ):DistToSqr( LocalPlayer():GetPos() ) < 0.1 ) then
		staminaType = 'standing'
	elseif( SS.Running ) then
		if( LocalPlayer():GetStamina() < SS.Settings.DecreaseSpeedBelow ) then
			if( LocalPlayer():GetStamina() < SS.Settings.MinStaminaToRun ) then
				SS.Running = false
				staminaType = 'walk'
			else
				staminaType = 'jog'
			end
		else
			staminaType = 'maxrun'
		end
	else
		staminaType = 'walk'
	end

	LocalPlayer().SSOldPos = LocalPlayer():GetPos()

	local stamina = LocalPlayer():GetStamina() * 0.01 * ( staminahudHeight - 55 )
	staminaAnim = math.Approach( staminaAnim, stamina, glorioushud.settings.animationspeed )
	
	draw.RoundedBox( 0, x, y, 40, staminahudHeight, ColorAlpha( glorioushud.settings.staminahudclrs.backgroundclr, glorioushud.settings.staminahudclrs.backgroundclr.a * alpha ) )
	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, ColorAlpha( glorioushud.settings.staminahudclrs.shapesclr, glorioushud.settings.staminahudclrs.shapesclr.a * alpha ) )
	draw.RoundedBox( 0, x + 5, y + 40, 30, staminahudHeight - 45, ColorAlpha( glorioushud.settings.staminahudclrs.shapesclr, glorioushud.settings.staminahudclrs.shapesclr.a * alpha ) )
	draw.RoundedBox( 5, x + 10, y + 45, 20, staminahudHeight - 55, ColorAlpha( glorioushud.settings.staminahudclrs.staminabgclr, glorioushud.settings.staminahudclrs.staminabgclr.a * alpha ) )
	draw.RoundedBox( 5, x + 10, y + 45 + ( ( staminahudHeight - 55 ) - staminaAnim ), 20, staminaAnim, ColorAlpha( glorioushud.settings.staminahudclrs.staminaclr, glorioushud.settings.staminahudclrs.staminaclr.a * alpha ) )

	surface.SetDrawColor( ColorAlpha( glorioushud.settings.staminahudclrs.iconsclr, glorioushud.settings.staminahudclrs.iconsclr.a * alpha ) )
	surface.SetMaterial( glorioushud.materials[ staminaType ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_stamina', function()

	if( !SS ) then return end

	SS.ShowHUD = false

	hook.Add( 'HUDPaint', 'glorioushud.staminahud', staminahud )

	if( !glorioushud.settings.enabled.stamina or !glorioushud.adminenabled.stamina ) then
		hook.Remove( 'HUDPaint', 'glorioushud.staminahud' )
	end

end)