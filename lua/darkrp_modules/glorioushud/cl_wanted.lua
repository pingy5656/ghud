local alpha = 0

local function wanted()
	
	local lp = LocalPlayer()
	local wanted = lp:getDarkRPVar( 'wanted' )
	local reason = lp:getDarkRPVar( 'wantedReason' ) or ''
	local arrested = lp:getDarkRPVar( 'Arrested' )

	if( arrested != nil ) then return end 

	if( wanted == nil ) then

		if( alpha > 0 ) then
			alpha = math.Approach( alpha, 0, 0.05 )
		else
			return
		end 

	end

    surface.SetFont( 'glorioushud.font.playerhud' )
	local text_width = surface.GetTextSize( glorioushud.localisationget( 'wanted', glorioushud.settings.language ) .. ' ' .. reason )

	local w, h = ScrW(), ScrH()
	local x, y = w / 2 - ( 61 + text_width ) / 2, h - 45

	if( wanted != nil ) then
		alpha = math.Approach( alpha, 1, 0.05 )
	end

	draw.RoundedBox( 0, x, y, 61 + text_width, 40, ColorAlpha( glorioushud.settings.wantedclrs.backgroundclr, glorioushud.settings.wantedclrs.backgroundclr.a * alpha ) )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, ColorAlpha( glorioushud.settings.wantedclrs.shapesclr, glorioushud.settings.wantedclrs.shapesclr.a * alpha ) )
	draw.RoundedBox( 0, x + 40, y + 5, text_width + 16, 30, ColorAlpha( glorioushud.settings.wantedclrs.shapesclr, glorioushud.settings.wantedclrs.shapesclr.a * alpha ) )
	draw.SimpleText( glorioushud.localisationget( 'wanted', glorioushud.settings.language ) .. ' ' .. reason, 'glorioushud.font.playerhud', x + 40 + ( text_width + 16 ) / 2, y + 9, ColorAlpha( glorioushud.settings.wantedclrs.textclr, glorioushud.settings.wantedclrs.textclr.a * alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( ColorAlpha( glorioushud.settings.wantedclrs.iconsclr, glorioushud.settings.wantedclrs.iconsclr.a * alpha ) )
	surface.SetMaterial( glorioushud.materials[ 'eye' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_wanted', function()

	hook.Add( 'HUDPaint', 'glorioushud.wanted', wanted )

	if( !glorioushud.settings.enabled.wanted or !glorioushud.adminenabled.wanted ) then 
		hook.Remove( 'HUDPaint', 'glorioushud.wanted' )
	end

end)