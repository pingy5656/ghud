local news = {}

function glorioushud.addnews( type, text )

	local new = {
		type = type,
		text = text,
		start_time = CurTime(),
		alpha = 0,
		y = 0,
	}

	table.insert( news, new )

end

local w, h

local function updatesize()

	w, h = ScrW(), ScrH() 

end

updatesize()

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesize3', updatesize )

local types = {
	'eye',
	'license',
	'lock',
	'eyeoff',
}

function glorioushud.newspaint()

	local lasty = 0
	for i, v in ipairs( news ) do

		surface.SetFont( 'glorioushud.font.playerhud' )
		local tsize = surface.GetTextSize( v.text ) + 16

		local x, y = w / 2 - ( tsize + 45 ) / 2 , 190

		v.y = math.Approach( v.y, lasty, 3 )

		if( ( v.start_time + 5 ) <= CurTime() ) then

			v.alpha = math.Approach( v.alpha, 0, 0.05 )
			if( v.alpha == 0 ) then
				table.remove( news, i )
			end

		else
			v.alpha = math.Approach( v.alpha, 1, 0.05 )
		end
		
		draw.RoundedBox( 0, x, y + v.y, tsize + 45, 40, ColorAlpha( glorioushud.settings.newsclrs.backgroundclr, glorioushud.settings.newsclrs.backgroundclr.a * v.alpha ) )

		draw.RoundedBox( 0, x + 5, y + 5 + v.y, 30, 30, ColorAlpha( glorioushud.settings.newsclrs.shapesclr, glorioushud.settings.newsclrs.shapesclr.a * v.alpha ) )
		draw.RoundedBox( 0, x + 40, y + 5 + v.y, tsize, 30, ColorAlpha( glorioushud.settings.newsclrs.shapesclr, glorioushud.settings.newsclrs.shapesclr.a * v.alpha ) )
		draw.SimpleText( v.text, 'glorioushud.font.playerhud', x + 48, y + 9 + v.y, ColorAlpha( glorioushud.settings.newsclrs.textclr, glorioushud.settings.newsclrs.textclr.a * v.alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

		surface.SetDrawColor( ColorAlpha( glorioushud.settings.agendaclrs.iconsclr, glorioushud.settings.agendaclrs.iconsclr.a * v.alpha ) )
		surface.SetMaterial( glorioushud.materials[ types[ tonumber( v.type ) ] ] )
		surface.DrawTexturedRect( x + 8, y + 8 + v.y, 24, 24 )

		lasty = lasty + 50

	end 

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_newspaint', function()

	hook.Add( 'HUDPaint', 'glorioushud.newspaint', glorioushud.newspaint )

	if( !glorioushud.settings.enabled.news or !glorioushud.adminenabled.news ) then 
		hook.Remove( 'HUDPaint', 'glorioushud.newspaint' )
	end

end)

function glorioushud.newshook()

	local data = util.JSONToTable( net.ReadString() )

	if( data.type == 1 ) then
		glorioushud.addnews( data.type, data.ply_name .. glorioushud.localisationget( 'wantednews', glorioushud.settings.language ) .. ' ' .. data.arg .. glorioushud.localisationget( 'orderedby', glorioushud.settings.language ) .. data.executor_name )
	elseif( data.type == 2 ) then
		glorioushud.addnews( data.type, glorioushud.localisationget( 'warrant', glorioushud.settings.language ) .. data.ply_name .. glorioushud.localisationget( 'reason', glorioushud.settings.language ) .. data.arg .. glorioushud.localisationget( 'orderedby', glorioushud.settings.language ) .. data.executor_name )
	elseif( data.type == 3 ) then
		glorioushud.addnews( data.type, data.ply_name .. glorioushud.localisationget( 'arrested', glorioushud.settings.language ) .. data.arg .. glorioushud.localisationget( 'seconds', glorioushud.settings.language ) )
	elseif( data.type == 4 ) then
		glorioushud.addnews( data.type, data.ply_name .. glorioushud.localisationget( 'unwanted', glorioushud.settings.language ) .. data.executor_name )
	end

end

net.Receive( 'glorioushud.newshooks', glorioushud.newshook )