local w, h
local x, y

local function updatesize()

	w, h = ScrW(), ScrH() 
	x, y = w / 2 - 150, h - 190

end

updatesize()

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesize2', updatesize )

local hppos = 0

function glorioushud.medkitpaint()

	local lp = LocalPlayer()
	local weapon = lp:GetActiveWeapon()
	local entity = lp:GetEyeTrace().Entity

	if( !IsValid( weapon ) ) then return end 
	if( !glorioushud.medkits[ weapon:GetClass() ] ) then return end
	if( !entity:IsPlayer() ) then return end
	if( lp:GetPos():Distance( entity:GetPos() ) > 100 ) then return end

	if( glorioushud.settings.animationenabled ) then
		hppos = math.Approach( hppos, entity:Health(), glorioushud.settings.animationspeed )
	else
		hppos = entity:Health()
	end

	draw.RoundedBox( 0, x, y, 300, 75, glorioushud.settings.medkitclrs.backgroundclr )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, glorioushud.settings.medkitclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 5, 255, 30, glorioushud.settings.medkitclrs.shapesclr )
	draw.SimpleText( entity:GetName(), 'glorioushud.font.playerhud', x + 48, y + 9, glorioushud.settings.medkitclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.medkitclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'user' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 40, 30, 30, glorioushud.settings.medkitclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 40, 255, 30, glorioushud.settings.medkitclrs.shapesclr )
	draw.RoundedBox( 5, x + 45, y + 45, 245, 20, glorioushud.settings.medkitclrs.hpbgclr )
	draw.RoundedBox( 5, x + 45, y + 45, 245 / entity:GetMaxHealth() * hppos, 20, glorioushud.settings.medkitclrs.hpclr )
	draw.SimpleText( ( glorioushud.settings.barnames and glorioushud.localisationget( 'hp', glorioushud.settings.language ) or '' ) .. entity:Health() .. '%', 'glorioushud.font.playerhud', x + 167.5, y + 45, glorioushud.settings.medkitclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.medkitclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'heart' ] )
	surface.DrawTexturedRect( x + 8, y + 43, 24, 24 )

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_medkitpaint', function()

	hook.Add( 'HUDPaint', 'glorioushud.medkitpaint', glorioushud.medkitpaint )

	if( !glorioushud.settings.enabled.medkit or !glorioushud.adminenabled.medkit ) then 
		hook.Remove( 'HUDPaint', 'glorioushud.medkitpaint' )
	end

end)