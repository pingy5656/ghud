local hungermod = DarkRP.disabledDefaults[ 'modules' ][ 'hungermod' ]
local w, h = ScrW(), ScrH()
local x, y = 10, 0

y = h - 235
if( hungermod ) then y = h - 200 end

local xpPos = 0
local showBar = false
local alpha = 0
local endTime = 0
local oldXp = 0

function glorioushud.levelhud()

	if( showBar ) then
		alpha = math.Approach( alpha, 1, 0.05 )
	else
		alpha = math.Approach( alpha, 0, 0.05 )
	end

	if( endTime <= CurTime() and !glorioushud.settings.levelalways ) then
		showBar = false
	end

	if( alpha == 0 ) then return end

	local lp = LocalPlayer()
	local level = lp:getDarkRPVar( 'level' ) or 0
	local xp = lp:getDarkRPVar( 'xp' ) or 0
	local percent = math.Round( ( ( xp or 0 ) / ( ( ( 10 + ( ( ( level or 1 ) * ( ( level or 1 ) + 1 ) * 90 ) ) ) ) * LevelSystemConfiguration.XPMult ) ) * 100 )
	local niceXp = math.Clamp( percent, 0, 99 )

	xpPos = math.Approach( xpPos, niceXp, glorioushud.settings.animationspeed )

	draw.RoundedBox( 0, x, y, 400, 40, ColorAlpha( glorioushud.settings.levelhudclrs.backgroundclr, glorioushud.settings.levelhudclrs.backgroundclr.a * alpha ) )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, ColorAlpha( glorioushud.settings.levelhudclrs.shapesclr, glorioushud.settings.levelhudclrs.shapesclr.a * alpha ) )
	draw.RoundedBox( 0, x + 40, y + 5, 355, 30, ColorAlpha( glorioushud.settings.levelhudclrs.shapesclr, glorioushud.settings.levelhudclrs.shapesclr.a * alpha ) )
	draw.RoundedBox( 5, x + 45, y + 10, 345, 20, ColorAlpha( glorioushud.settings.levelhudclrs.levelbgclr, glorioushud.settings.levelhudclrs.levelbgclr.a * alpha ) )
	draw.RoundedBox( 5, x + 45, y + 10, 345 / 100 * xpPos, 20, ColorAlpha( glorioushud.settings.levelhudclrs.levelclr, glorioushud.settings.levelhudclrs.levelclr.a * alpha ) )
	draw.SimpleText( glorioushud.localisationget( 'level', glorioushud.settings.language ) .. level .. ' - ' .. niceXp .. '%', 'glorioushud.font.playerhud', x + 217, y + 29, ColorAlpha( glorioushud.settings.levelhudclrs.textclr, glorioushud.settings.levelhudclrs.textclr.a * alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

	surface.SetDrawColor( ColorAlpha( glorioushud.settings.levelhudclrs.iconsclr, glorioushud.settings.levelhudclrs.iconsclr.a * alpha ) )
	surface.SetMaterial( glorioushud.materials[ 'star24' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

end

hook.Add( 'HUDPaint', 'glorioushud.levelhud', glorioushud.levelhud )

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_level', function()

	if( !LevelSystemConfiguration ) then return end

	LevelSystemConfiguration.EnableBar = false
	LevelSystemConfiguration.BarText = false
	LevelSystemConfiguration.LevelText = false

	timer.Remove( 'glorioushud.checkxp' )

	timer.Create( 'glorioushud.checkxp', 1, 0, function()

		if( !LevelSystemConfiguration ) then
			timer.Remove( 'glorioushud.checkxp' )
			return
		end

		local meta = FindMetaTable( 'Player' )
		if( !isfunction( meta.getDarkRPVar ) or !IsValid( LocalPlayer() ) ) then return end

		local xp = LocalPlayer():getDarkRPVar( 'xp' )

		if( oldXp != xp ) then 

			endTime = CurTime() + glorioushud.settings.leveltime
			showBar = true
			oldXp = xp

		end

	end)

	if( glorioushud.settings.levelalways ) then
		timer.Remove( 'glorioushud.checkxp' )
		showBar = true
	end

	hook.Add( 'HUDPaint', 'glorioushud.levelhud', glorioushud.levelhud )

	if( !glorioushud.settings.enabled.level or !glorioushud.adminenabled.level ) then
		timer.Remove( 'glorioushud.checkxp' ) 
		hook.Remove( 'HUDPaint', 'glorioushud.levelhud' )
	end

end)