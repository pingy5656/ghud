local pickup = {}

function glorioushud.ammopickedup( ammo, amount )

	if( ammo == nil ) then return end

	local oldammo = 0

	for i, v in pairs( pickup ) do
		
		if( v.ammo == ammo ) then

			oldammo = v.amount
			table.remove( pickup, i )

		end 

	end

	local new_pickup = {
		ammo = ammo,
		amount = amount + oldammo,
		item = nil,
		weapon = nil,
		start_time = CurTime(),
		type = 1,

		x = 0,
		y = 0,
		started = false,
	}

	table.insert( pickup, new_pickup )

end

hook.Add( 'HUDAmmoPickedUp', 'glorioushud.ammopickedup', glorioushud.ammopickedup )

function glorioushud.itempickedup( item )

	if( item == nil ) then return end

	local new_pickup = {
		ammo = nil,
		amount = nil,
		item = item,
		weapon = nil,
		start_time = CurTime(),
		type = 2,

		x = 0,
		y = 0,
		started = false,
	}

	table.insert( pickup, new_pickup )

end

hook.Add( 'HUDItemPickedUp', 'glorioushud.itempickedup', glorioushud.itempickedup )

function glorioushud.weaponpickedup( weapon )

	if( !IsValid( weapon ) ) then return end
	if( !isfunction( weapon.GetPrintName ) ) then return end

	local new_pickup = {
		ammo = nil,
		amount = nil,
		item = nil,
		weapon = weapon:GetPrintName(),
		start_time = CurTime(),
		type = 3,

		x = 0,
		y = 0,
		started = false,
	}

	table.insert( pickup, new_pickup )

end

hook.Add( 'HUDWeaponPickedUp', 'glorioushud.weaponpickedup', glorioushud.weaponpickedup )

local w, h
local x, y

local function updatesize()

	w, h = ScrW(), ScrH()
	x, y = w - 10, 220

end

updatesize()

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesize4', updatesize )

local types = {
	'bullet16',
	'item16',
	'gun16',
}

function glorioushud.pickeduppaint()

	local lasty = 0

	for i, v in ipairs( pickup ) do

		local text = ''
		local text2 = nil
		local tsize = 0
		if( v.type == 1 ) then
			text = '#' .. v.ammo .. '_ammo'
			text2 = '+' .. v.amount
		end
		if( v.type == 2 ) then
			text = '#' .. v.item
		end
		if( v.type == 3 ) then		
			text = v.weapon
		end

		surface.SetFont( 'glorioushud.font.pickup15' )
		if( text2 == nil ) then
			tsize = 16 + surface.GetTextSize( text )
		else
			surface.SetFont( 'glorioushud.font.pickup15' )
			tsize = 26 + surface.GetTextSize( text ) + surface.GetTextSize( text2 )
		end

		if( !v.started ) then
			v.x = x + 10 + ( tsize + 32 )
		end
		v.started = true

		if( v.start_time + 4 <= CurTime() ) then
			v.x = math.Approach( v.x, x + 10 + ( tsize + 32 ), 3 )
			if( v.x == x + 10 + ( tsize + 32 ) ) then
				table.remove( pickup, i )
			end
		else
			v.x = math.Approach( v.x, x - ( tsize + 32 ), 3 )
		end

		v.y = math.Approach( v.y, lasty, 3 )

		draw.RoundedBox( 0, v.x, y + v.y, tsize + 37, 32, glorioushud.settings.pickupclrs.backgroundclr )

		draw.RoundedBox( 0, v.x + 5, y + v.y + 5, 22, 22, glorioushud.settings.pickupclrs.shapesclr )
		draw.RoundedBox( 0, v.x + 32, y + v.y + 5, tsize, 22, glorioushud.settings.pickupclrs.shapesclr )

		if( text2 == nil ) then
			draw.SimpleText( text, 'glorioushud.font.pickup15', v.x + 40, y + v.y + 8, glorioushud.settings.pickupclrs.textclr )
		else
			draw.SimpleText( text, 'glorioushud.font.pickup15', v.x + 40, y + v.y + 8, glorioushud.settings.pickupclrs.textclr )
			draw.SimpleText( text2, 'glorioushud.font.pickup15', v.x + 40 + tsize - 16, y + v.y + 8, glorioushud.settings.pickupclrs.textclr, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
		end

		surface.SetDrawColor( glorioushud.settings.pickupclrs.iconsclr )
		surface.SetMaterial( glorioushud.materials[ types[ v.type ] ] )
		surface.DrawTexturedRect( v.x + 8, y + v.y + 8, 16, 16 )

		lasty = lasty + 37

	end

	return false

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_pickeduppaint', function()

	hook.Add( 'HUDDrawPickupHistory', 'glorioushud.pickeduppaint', glorioushud.pickeduppaint )

	if( !glorioushud.settings.enabled.pickup or !glorioushud.adminenabled.pickup ) then 
		hook.Remove( 'HUDDrawPickupHistory', 'glorioushud.pickeduppaint' )
	end

end)