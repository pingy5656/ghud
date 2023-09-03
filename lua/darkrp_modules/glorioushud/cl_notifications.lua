local notifications = {}

function notification.AddLegacy( text, type, lenght )

	local notify = {
		text = text,
		type = type,
		lenght = lenght,
		start_time = CurTime(),
		progess = false,
		id = '',
		frac = nil,
		alpha = 0,
		isdeleting = false,
		y = 0,
	}

	table.insert( notifications, notify )

end

function notification.AddProgress( id, text, frac )

	for i, v in pairs( notifications ) do
		
		if( v.id == id ) then

			local notify = {
				text = text,
				type = '',
				lenght = '',
				start_time = 0,
				progress = true,
				id = id,
				frac = frac,
				alpha = 1,
				isdeleting = false,
				y = 0,
			}

			table.remove( notifications, i )
			table.insert( notifications, i, notify )

			return

		end

	end

	local notify = {
		text = text,
		type = '',
		lenght = '',
		start_time = 0,
		progress = true,
		id = id,
		frac = frac,
		alpha = 0,
		isdeleting = false,
		y = 0,
	}

	table.insert( notifications, notify )

end

function notification.Kill( id )

	for i, v in pairs( notifications ) do
		
		if( v.progress ) then
			if( v.id == id ) then
				v.isdeleting = true
			end
		end

	end

end

local w, h
local x, y

local function updatesize()

	w, h = ScrW(), ScrH()
	x, y = w - 10, h - 95

end

updatesize()

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesize5', updatesize )

local lp = LocalPlayer()

local types = {
	[ NOTIFY_GENERIC ] = 'generic',
	[ NOTIFY_ERROR ] = 'error',
	[ NOTIFY_UNDO ] = 'undo',
	[ NOTIFY_HINT ] = 'hint',
	[ NOTIFY_CLEANUP ] = 'cleanup',
}

local function notify_paint()

	if( !glorioushud.adminenabled.notify ) then return end

	if( LocalPlayer():InVehicle() ) then y = h - 165 else y = h - 95 end

	local lasty = 0
	for i, v in pairs( notifications ) do
		
		surface.SetFont( 'glorioushud.font.playerhud' )
		local tsize = surface.GetTextSize( v.text )
		local wsize = tsize + 31 + 25
		local hsize = 40

		v.y = math.Approach( v.y, lasty, 3 )

		if( !v.progress ) then

			if( ( v.start_time + v.lenght ) >= CurTime() + 0.2 ) then
				v.alpha = math.Approach( v.alpha, 1, 0.05 )
			else
				v.alpha = math.Approach( v.alpha, 0, 0.05 )
			end

		else

			if( !v.isdeleting ) then
				v.alpha = math.Approach( v.alpha, 1, 0.05 )
			end

		end

		if( tobool( v.isdeleting ) ) then

			v.alpha = math.Approach( v.alpha, 0, 0.05 )
			if( v.alpha == 0 ) then
				table.remove( notifications, i )
			end
		
		end

		if( v.progress ) then

			draw.RoundedBox( 0, x - wsize + 35, y - hsize - v.y, wsize - 35, hsize, ColorAlpha( glorioushud.settings.notifyclrs.backgroundclr, glorioushud.settings.notifyclrs.backgroundclr.a * v.alpha ) )
			draw.RoundedBox( 0, ( x - ( wsize - 35 ) ) + 5, ( y - hsize - v.y ) + 5, 10 + tsize, 30, ColorAlpha( glorioushud.settings.notifyclrs.shapesclr, glorioushud.settings.notifyclrs.shapesclr.a * v.alpha ) )
			draw.SimpleText( v.text, 'glorioushud.font.playerhud', ( x - wsize ) + 40 + 5, ( y - hsize - v.y ) + 5 + 24, glorioushud.settings.notifyclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
			local px = x - wsize + 35
			if( v.frac == nil ) then
				local pos = ( ( wsize - 35 ) / 2 - 10 ) * math.sin( CurTime() * 5 )
				draw.RoundedBox( 0, px + ( wsize - 35 ) / 2 - 10 + pos, y - 5 - v.y, 20, 5, ColorAlpha( glorioushud.settings.notifyclrs.progressbarclr, glorioushud.settings.notifyclrs.progressbarclr.a * v.alpha ) )
			else
				draw.RoundedBox( 0, px, y - 5 - v.y, ( wsize - 35 ) * v.frac, 5, ColorAlpha( glorioushud.settings.notifyclrs.progressbarclr, glorioushud.settings.notifyclrs.progressbarclr.a * v.alpha ) )
			end

		else

			if( ( v.start_time + v.lenght ) <= CurTime() ) then
				table.remove( notifications, i )
			end

			draw.RoundedBox( 0, x - wsize, y - hsize - v.y, wsize, hsize, ColorAlpha( glorioushud.settings.notifyclrs.backgroundclr, glorioushud.settings.notifyclrs.backgroundclr.a * v.alpha ) )
			draw.RoundedBox( 0, ( x - wsize ) + 5, ( y - hsize - v.y ) + 5, 30, 30, ColorAlpha( glorioushud.settings.notifyclrs.shapesclr, glorioushud.settings.notifyclrs.shapesclr.a * v.alpha ) )
			draw.RoundedBox( 0, ( x - wsize ) + 40, ( y - hsize - v.y ) + 5, 10 + tsize, 30, ColorAlpha( glorioushud.settings.notifyclrs.shapesclr, glorioushud.settings.notifyclrs.shapesclr.a * v.alpha ) )
			draw.SimpleText( v.text, 'glorioushud.font.playerhud', ( x - wsize ) + 40 + 5, ( y - hsize - v.y ) + 5 + 24, ColorAlpha( glorioushud.settings.notifyclrs.textclr, glorioushud.settings.notifyclrs.textclr.a * v.alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )

			surface.SetDrawColor( ColorAlpha( glorioushud.settings.notifyclrs.iconsclr, glorioushud.settings.notifyclrs.iconsclr.a * v.alpha ) )
			surface.SetMaterial( glorioushud.materials[ types[ v.type ] ] )
			surface.DrawTexturedRect( ( x - wsize ) + 5 + 3, ( y - hsize - v.y ) + 5 + 3, 24, 24 )

		end

		lasty = lasty + hsize + 10

	end

end

hook.Add( 'HUDPaint', 'glorioushud.notifypaint', notify_paint )