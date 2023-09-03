function glorioushud.agenda()

	local lp = LocalPlayer()
	local hasagenda = lp:getAgendaTable()
	local agenda = lp:getDarkRPVar( 'agenda' ) or ''

	local w, h = ScrW(), ScrH()
	local x, y = w - 410, 10

	if( hasagenda == nil ) then return end

	if( string.Trim( agenda ) == '' ) then agenda = glorioushud.localisationget( 'agenda_empty', glorioushud.settings.language ) else agenda = agenda end
	
	draw.RoundedBox( 0, x, y, 400, 200, glorioushud.settings.agendaclrs.backgroundclr )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, glorioushud.settings.agendaclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 5, 355, 30, glorioushud.settings.agendaclrs.shapesclr )
	draw.SimpleText( glorioushud.localisationget( 'agenda', glorioushud.settings.language ), 'glorioushud.font.playerhud', x + 48, y + 29, glorioushud.settings.agendaclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )

	surface.SetDrawColor( glorioushud.settings.agendaclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'agenda' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 40, 390, 155, glorioushud.settings.agendaclrs.shapesclr )
	draw.DrawText( agenda, 'glorioushud.font.playerhud', x + 13, y + 44, glorioushud.settings.agendaclrs.textclr, TEXT_ALIGN_TOP )
 
end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_agenda', function()

	hook.Add( 'HUDPaint', 'glorioushud.agenda', glorioushud.agenda )

	if( !glorioushud.settings.enabled.agenda or !glorioushud.adminenabled.agenda ) then 
		hook.Remove( 'HUDPaint', 'glorioushud.agenda' )
	end

end)