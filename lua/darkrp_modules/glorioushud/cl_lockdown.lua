local alpha = 0

function glorioushud.lockdown()

	if( !GetGlobalBool( 'DarkRP_LockDown' ) ) then 
		if( alpha > 0 ) then
			alpha = math.Approach( alpha, 0, 0.05 )
		else
			return
		end
	end

	if( GetGlobalBool( 'DarkRP_LockDown' ) ) then
		alpha = math.Approach( alpha, 1, 0.05 )
	end

	surface.SetFont( 'glorioushud.font.playerhud' )
	local text_width = surface.GetTextSize( glorioushud.localisationget( 'lockdown', glorioushud.settings.language ) )

	local w, h = ScrW(), ScrH()
	local x, y = w / 2 - ( 61 + text_width ) / 2, 10

	draw.RoundedBox( 0, x, y, 61 + text_width, 40, ColorAlpha( glorioushud.settings.lockdownclrs.backgroundclr, glorioushud.settings.lockdownclrs.backgroundclr.a * alpha ) )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, ColorAlpha( glorioushud.settings.lockdownclrs.shapesclr, glorioushud.settings.lockdownclrs.shapesclr.a * alpha ) )
	draw.RoundedBox( 0, x + 40, y + 5, text_width + 16, 30, ColorAlpha( glorioushud.settings.lockdownclrs.shapesclr, glorioushud.settings.lockdownclrs.shapesclr.a * alpha ) )
	draw.SimpleText( glorioushud.localisationget( 'lockdown', glorioushud.settings.language ), 'glorioushud.font.playerhud', x + 40 + ( text_width + 16 ) / 2, y + 9, ColorAlpha( glorioushud.settings.lockdownclrs.textclr, glorioushud.settings.lockdownclrs.textclr.a * alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( ColorAlpha( glorioushud.settings.lockdownclrs.iconsclr, glorioushud.settings.lockdownclrs.iconsclr.a * alpha ) )
	surface.SetMaterial( glorioushud.materials[ 'home' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_lockdown', function()

	hook.Add( 'HUDPaint', 'glorioushud.lockdown', glorioushud.lockdown )

	if( !glorioushud.settings.enabled.lockdown or !glorioushud.adminenabled.lockdown ) then 
		hook.Remove( 'HUDPaint', 'glorioushud.lockdown' )
	end

end)