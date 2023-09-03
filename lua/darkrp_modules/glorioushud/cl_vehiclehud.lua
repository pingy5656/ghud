local function simfphysHUD()

	local meta = FindMetaTable( 'Player' )

	if( isfunction( meta.GetSimfphys ) ) then
		if( !glorioushud.simfphyshud ) then
			RunConsoleCommand( 'cl_simfphys_hud', 0 )
		else
			RunConsoleCommand( 'cl_simfphys_hud', 1 )
		end
	end

end

hook.Add( 'glorioushud.initialized', 'glorioushud.simfphysHUD', simfphysHUD )

local w, h
local x, y
local x1, y1

local function updatesize()

	w, h = ScrW(), ScrH()
	x, y = w - 255, h - 155
	x1, y1 = w - 300, h - 155

end

updatesize()

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesize7', updatesize )

if( isfunction( LocalPlayer().GetSimfphys ) ) then
	local slushbox = GetConVar( "cl_simfphys_auto" ):GetBool()
end

local function simfphys_vehiclehud()

	local lp = LocalPlayer()
	if( !isfunction( lp.GetSimfphys ) ) then return end
	if( !lp:InVehicle() ) then return end

	local vehicle = lp:GetSimfphys()

	if( !IsValid( vehicle ) ) then return end

	local speed = vehicle:GetVelocity():Length()
	local mph = math.Round( speed * 0.0568182, 0 )
	local kmh = math.Round( speed * 0.09144, 0 )
	local maxrpm = math.Round( vehicle:GetLimitRPM(), 0 )
	local rpm = math.Round( vehicle:GetRPM(), 0 )
	local fuel = math.Round( vehicle:GetFuel(), 0 )
	local maxfuel = math.Round( vehicle:GetMaxFuel(), 0 )
	local gear = vehicle:GetGear()
	local showgear = !slushbox and ( gear == 1 and 'R' or gear == 2 and 'N' or ( gear - 2 ) ) or ( gear == 1 and 'R' or gear == 2 and 'N' or '(' .. ( gear - 2 ) .. ')' )
	local handbrake = vehicle:GetHandBrakeEnabled()
	local cruise = vehicle:GetIsCruiseModeOn()
	local foglightson = vehicle:GetFogLightsEnabled()
	local lightson = vehicle:GetLightsEnabled()
	local lampson = vehicle:GetLampsEnabled()

	draw.RoundedBox( 0, x, y, 245, 145, glorioushud.settings.vehicleclrs.backgroundclr )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 5, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.SimpleText( glorioushud.localisationget( 'simfphyscar', glorioushud.settings.language ), 'glorioushud.font.playerhud', x + 48, y + 9, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'car' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 40, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 40, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.SimpleText( glorioushud.settings.kmh and kmh .. glorioushud.localisationget( 'kmh', glorioushud.settings.language ) or mph .. glorioushud.localisationget( 'mph', glorioushud.settings.language ), 'glorioushud.font.playerhud', x + 48, y + 44, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	draw.SimpleText( showgear, 'glorioushud.font.playerhud', x + 232, y + 44, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'speed' ] )
	surface.DrawTexturedRect( x + 8, y + 43, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 75, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 75, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 5, x + 45, y + 80, 190, 20, glorioushud.settings.vehicleclrs.rpmbgclr )
	draw.RoundedBox( 5, x + 45, y + 80, 190 / maxrpm * rpm , 20, glorioushud.settings.vehicleclrs.rpmclr )
	draw.SimpleText( glorioushud.localisationget( 'rpm', glorioushud.settings.language ) .. rpm, 'glorioushud.font.playerhud', x + 140, y + 79, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'speed' ] )
	surface.DrawTexturedRect( x + 8, y + 78, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 110, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 110, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 5, x + 45, y + 115, 190, 20, glorioushud.settings.vehicleclrs.fuelbgclr )
	draw.RoundedBox( 5, x + 45, y + 115, 190 / maxfuel * fuel, 20, glorioushud.settings.vehicleclrs.fuelclr )
	draw.SimpleText( ( glorioushud.settings.barnames and glorioushud.localisationget( 'fuel', glorioushud.settings.language ) or '' ) .. fuel .. '%', 'glorioushud.font.playerhud', x + 140, y + 114, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'fuel' ] )
	surface.DrawTexturedRect( x + 8, y + 113, 24, 24 )

	draw.RoundedBox( 0, x1, y1, 40, 145, glorioushud.settings.vehicleclrs.backgroundclr )

	draw.RoundedBox( 0, x1 + 5, y1 + 5, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( handbrake and glorioushud.settings.vehicleclrs.handbrakeiconclr or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ 'handbrake' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 8, 24, 24 )

	draw.RoundedBox( 0, x1 + 5, y1 + 40, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( cruise and glorioushud.settings.vehicleclrs.cruiseiconclr or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ 'cruise' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 43, 24, 24 )

	draw.RoundedBox( 0, x1 + 5, y1 + 75, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( foglightson and glorioushud.settings.vehicleclrs.foglightsiconclr or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ 'foglights' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 78, 24, 24 )

	draw.RoundedBox( 0, x1 + 5, y1 + 110, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( lightson and ( lampson and glorioushud.settings.vehicleclrs.lampsiconclr or glorioushud.settings.vehicleclrs.lighticonclr ) or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ lightson and ( lampson and 'lamps' or 'lights' ) or 'lights' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 113, 24, 24 )

end

local shp = 0

local function vcmod_vehiclehud()

	local lp = LocalPlayer()
	if( !isbool( vcmod_main ) ) then return end
	if( !lp:InVehicle() ) then return end

	local vehicle = lp:GetVehicle()

	local vcTest = vehicle:VC_getName()
	if( !vcTest ) then return end

	local speedKmh = math.Round( vehicle:VC_getSpeedKmH() )
	local speedMph = math.Round( speedKmh / 1.609 )
	local health = math.Round( vehicle:VC_getHealth( false ) )
	local fuel = math.ceil( vehicle:VC_fuelGet( false ) )
	local fuelMax = math.ceil( vehicle:VC_fuelGetMax() )
	local name = vehicle:VC_getName()
	local damagedParts = vehicle:VC_getDamagedParts()

	local b_light = damagedParts[ 'light' ]
	local b_engine = damagedParts[ 'engine' ]
	local b_exhaust = damagedParts[ 'exhaust' ]
	local b_wheel = damagedParts[ 'wheel' ]

	draw.RoundedBox( 0, x, y, 245, 145, glorioushud.settings.vehicleclrs.backgroundclr )

	draw.RoundedBox( 0, x + 5, y + 5, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 5, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.SimpleText( name, 'glorioushud.font.playerhud', x + 48, y + 9, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'car' ] )
	surface.DrawTexturedRect( x + 8, y + 8, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 40, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 40, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.SimpleText( glorioushud.settings.kmh and speedKmh .. glorioushud.localisationget( 'kmh', glorioushud.settings.language ) or speedMph .. glorioushud.localisationget( 'mph', glorioushud.settings.language ), 'glorioushud.font.playerhud', x + 48, y + 44, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'speed' ] )
	surface.DrawTexturedRect( x + 8, y + 43, 24, 24 )

	shp = math.Approach( shp, health, glorioushud.settings.animationspeed )

	draw.RoundedBox( 0, x + 5, y + 75, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 75, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 5, x + 45, y + 80, 190, 20, glorioushud.settings.vehicleclrs.rpmbgclr )
	draw.RoundedBox( 5, x + 45, y + 80, 190 / 100 * shp , 20, glorioushud.settings.vehicleclrs.rpmclr )
	draw.SimpleText( glorioushud.localisationget( 'hp', glorioushud.settings.language ) .. health .. '%', 'glorioushud.font.playerhud', x + 140, y + 79, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'status' ] )
	surface.DrawTexturedRect( x + 8, y + 78, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 110, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 110, 200, 30, glorioushud.settings.vehicleclrs.shapesclr )
	draw.RoundedBox( 5, x + 45, y + 115, 190, 20, glorioushud.settings.vehicleclrs.fuelbgclr )
	draw.RoundedBox( 5, x + 45, y + 115, 190 / fuelMax * fuel, 20, glorioushud.settings.vehicleclrs.fuelclr )
	draw.SimpleText( ( glorioushud.settings.barnames and glorioushud.localisationget( 'fuel', glorioushud.settings.language ) or '' ) .. fuel .. '/' .. fuelMax .. glorioushud.localisationget( 'liters', glorioushud.settings.language ), 'glorioushud.font.playerhud', x + 140, y + 114, glorioushud.settings.vehicleclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	surface.SetDrawColor( glorioushud.settings.vehicleclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'fuel' ] )
	surface.DrawTexturedRect( x + 8, y + 113, 24, 24 )

	draw.RoundedBox( 0, x1, y1, 40, 145, glorioushud.settings.vehicleclrs.backgroundclr )

	draw.RoundedBox( 0, x1 + 5, y1 + 5, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( b_light and glorioushud.settings.vehicleclrs.brokeniconclr or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ 'lights' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 8, 24, 24 ) 

	draw.RoundedBox( 0, x1 + 5, y1 + 40, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( b_engine and glorioushud.settings.vehicleclrs.brokeniconclr or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ 'engine' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 43, 24, 24 ) 

	draw.RoundedBox( 0, x1 + 5, y1 + 75, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( b_exhaust and glorioushud.settings.vehicleclrs.brokeniconclr or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ 'exhaust' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 78, 24, 24 ) 

	draw.RoundedBox( 0, x1 + 5, y1 + 110, 30, 30, glorioushud.settings.vehicleclrs.shapesclr )

	surface.SetDrawColor( b_wheel and glorioushud.settings.vehicleclrs.brokeniconclr or glorioushud.settings.vehicleclrs.officonclr )
	surface.SetMaterial( glorioushud.materials[ 'wheel' ] )
	surface.DrawTexturedRect( x1 + 8, y1 + 113, 24, 24 )

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_vehiclehud', function()

	hook.Add( 'HUDPaint', 'glorioushud.simfphys_vehiclehud', simfphys_vehiclehud )
	hook.Add( 'HUDPaint', 'glorioushud.vcmod_vehiclehud', vcmod_vehiclehud )

	if( !glorioushud.settings.enabled.vehicle or !glorioushud.adminenabled.vehicle ) then 
		hook.Remove( 'HUDPaint', 'glorioushud.simfphys_vehiclehud' )
		hook.Remove( 'HUDPaint', 'glorioushud.vcmod_vehiclehud' )
	end

end)