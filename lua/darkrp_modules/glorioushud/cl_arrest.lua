function glorioushud.arrest()

	local lp = LocalPlayer()
	local arrest = lp:getDarkRPVar( 'Arrested' )

	if( arrest == nil ) then return end

	local time_left = math.ceil( ( lp.glorioushud_arrest_start + lp.glorioushud_arrest_time ) - CurTime() )

	surface.SetFont( 'glorioushud.font.playerhud' )
	local title_width = surface.GetTextSize( glorioushud.localisationget( 'arrest', glorioushud.settings.language ) )
	surface.SetFont( 'glorioushud.font.playerhud' )
	local time_width = surface.GetTextSize( glorioushud.localisationget( 'arrest_timeleft', glorioushud.settings.language ) .. ' ' .. time_left )

	local width = 0

	if( title_width > time_width ) then
		width = title_width
	else
		width = time_width
	end

	local w, h = ScrW(), ScrH()
	local x, y = w / 2 - ( ( 61 + width ) / 2 ), h - 85

	draw.RoundedBox( 0, x, y, 61 + width, 75, glorioushud.settings.arrestclrs.backgroundclr )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, glorioushud.settings.arrestclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 5, 16 + width, 30, glorioushud.settings.arrestclrs.shapesclr )
	draw.SimpleText( glorioushud.localisationget( 'arrest', glorioushud.settings.language ), 'glorioushud.font.playerhud', x + 40 + ( ( 16 + width ) / 2 ), y + 9, glorioushud.settings.arrestclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.arrestclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'lock' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 40, 30, 30, glorioushud.settings.arrestclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 40, 16 + width, 30, glorioushud.settings.arrestclrs.shapesclr )
	draw.SimpleText( glorioushud.localisationget( 'arrest_timeleft', glorioushud.settings.language ) .. ' ' .. math.Clamp( time_left, 0, 1000000 ), 'glorioushud.font.playerhud', x + 40 + ( ( 16 + width ) / 2 ), y + 44, glorioushud.settings.arrestclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.arrestclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'time' ] )
	surface.DrawTexturedRect( x + 8, y + 43, 24, 24 )

end

function glorioushud.arrestreceive()

	local executor = net.ReadEntity()
	local time = net.ReadInt( 12 )

	LocalPlayer().glorioushud_arrest_time = time
	LocalPlayer().glorioushud_arrest_start = CurTime()

end

net.Receive( 'glorioushud.sendarrest', glorioushud.arrestreceive )

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_arrest', function()

	hook.Add( 'HUDPaint', 'glorioushud.arrest', glorioushud.arrest )

	if( !glorioushud.settings.enabled.arrest or !glorioushud.adminenabled.arrest ) then 
		hook.Remove( 'HUDPaint', 'glorioushud.arrest' )
	end

end)