glorioushud = {}

glorioushud.locales = {}
glorioushud.adminenabled = {}

hook.Call( 'glorioushud.initialized' )

local cfg = include( 'darkrp_modules/glorioushud/configuration.lua' )

glorioushud.buildweapons = cfg.buildWeapons
glorioushud.medkits = cfg.medkitsClasses
glorioushud.simfphyshud = cfg.simfphysHUD
glorioushud.votesound = cfg.voteSound
glorioushud.timeout = cfg.timeoutTime
glorioushud.autoLanguage = cfg.autoLanguage
glorioushud.defaultLang = cfg.defaultLanguage
glorioushud.adminenabled.hud = cfg.main_hud
glorioushud.adminenabled.votes = cfg.votes
glorioushud.adminenabled.agenda = cfg.agenda
glorioushud.adminenabled.arrest = cfg.arrest
glorioushud.adminenabled.lockdown = cfg.lockdown
glorioushud.adminenabled.wanted = cfg.wanted
glorioushud.adminenabled.pickup = cfg.pickup
glorioushud.adminenabled.doors = cfg.doors
glorioushud.adminenabled.vehicle = cfg.vehicle
glorioushud.adminenabled.timeout = cfg.timeout
glorioushud.adminenabled.overhead = cfg.overhead
glorioushud.adminenabled.news = cfg.news
glorioushud.adminenabled.vehicleinfo = cfg.vehicleinfo
glorioushud.adminenabled.medkit = cfg.medkit
glorioushud.adminenabled.gestures = cfg.gestures
glorioushud.adminenabled.notify = cfg.notify
glorioushud.adminenabled.level = cfg.level
glorioushud.adminenabled.stamina = cfg.stamina

if( glorioushud.autoLanguage ) then

	local gmodLang = string.Left( GetConVar( 'gmod_language' ):GetString(), 2 )
	if( glorioushud.locales[ gmodLang ] != nil ) then
		glorioushud.defaultLang = gmodLang
	end

end

function glorioushud.localisationget( phrase, languageid )

	return glorioushud.locales[ languageid ][ phrase ]

end

surface.CreateFont( 'glorioushud.font.playerhud', {
	font = "Montserrat Medium",
	size = 20,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.overhead', {
	font = "Montserrat Medium",
	size = 75,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.overhead60', {
	font = "Montserrat Medium",
	size = 60,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.votesmall', {
	font = "Montserrat Medium",
	size = 15,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.doors40', {
	font = "Montserrat Medium",
	size = 40,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.timeout45', {
	font = "Montserrat Medium",
	size = 45,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.timeout35', {
	font = "Montserrat Medium",
	size = 35,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.timeout30', {
	font = "Montserrat Medium",
	size = 25,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.timeout25', {
	font = "Montserrat Medium",
	size = 25,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.pickup15', {
	font = "Montserrat Medium",
	size = 15,
	weight = 500,
	extended = true,
})

surface.CreateFont( 'glorioushud.font.20', {
	font = "Montserrat Medium",
	size = 20,
	weight = 500,
	extended = true,
})

local hideElements = {
	["DarkRP_HUD"] = true,  
    ["DarkRP_EntityDisplay"] = true, 
    ["DarkRP_LocalPlayerHUD"] = true, 
    ["DarkRP_Hungermod"] = true,
    ["DarkRP_Agenda"] = true, 
    ["DarkRP_LockdownHUD"] = true,
    ["DarkRP_ArrestedHUD"] = true,
    ["DarkRP_ChatReceivers"] = true,
    ['CHudAmmo'] = true,
    ['CHudBattery'] = true,
    ['CHudHealth'] = true,
    ['CHudSecondaryAmmo'] = true,
    ['VCMod_Side'] = true,
}

function glorioushud.hidehudelements( name )

	if( hideElements[ name ] ) then return false end

end

hook.Add( 'HUDShouldDraw', 'glorioushud.hidehudelements', glorioushud.hidehudelements )

local icons = {
	case = 'icons/briefcase.png',
	coffee = 'icons/coffee.png',
	chicken = 'icons/chicken-leg.png',
	humburger = 'icons/humburger.png',
	money = 'icons/dollar-sign.png',
	license = 'icons/file-text.png',
	heart = 'icons/heart.png',
	shield = 'icons/shield.png',
	user = 'icons/user.png',
	volume64 = 'icons/volume.png',
	lock64 = 'icons/lock.png',
	user64 = 'icons/user64.png',
	case64 = 'icons/briefcase64.png',
	message64 = 'icons/message-circle.png',
	generic = 'icons/info.png',
	hint = 'icons/help-circle.png',
	undo = 'icons/refresh-ccw.png',
	error = 'icons/x-circle.png',
	cleanup = 'icons/scissors.png',
	progress = 'icons/rotate-ccw.png',
	gun = 'icons/gun.png',
	construct = 'icons/construct.png',
	bullet = 'icons/bullet.png',
	agenda = 'icons/agenda.png',
	time = 'icons/clock.png',
	lock = 'icons/lock24.png',
	home = 'icons/home.png',
	eye = 'icons/eye.png',
	eye64 = 'icons/eye64.png',
	news = 'icons/send.png',
	eyeoff = 'icons/eye-off.png',
	gun16 = 'icons/gun16.png',
	item16 = 'icons/trolley.png',
	bullet16 = 'icons/bullet16.png',
	unlock24 = 'icons/unlock24.png',
	star24 = 'icons/star.png',

	fuel = 'icons/fuel.png',
	foglights = 'icons/foglights.png',
	lights = 'icons/lights.png',
	lamps = 'icons/lamps.png',
	handbrake = 'icons/handbrake.png',
	cruise = 'icons/cruise.png',
	car = 'icons/car.png',
	speed = 'icons/speed.png',
	wheel = 'icons/wheel.png',
	status = 'icons/status.png',
	engine = 'icons/motor.png',
	exhaust = 'icons/exhaust.png',

	walk = 'icons/walk.png',
	jog = 'icons/jog.png',
	maxrun = 'icons/maxrun.png',
	standing = 'icons/standing.png',
}

glorioushud.materials = {}

for i, icon in pairs( icons ) do
	
	if( i == 'undo' or i == 'hint' or i == 'error' or i == 'cleanup' ) then
		glorioushud.materials[ i ] = Material( icon, 'noclamp smooth' )
		continue
	end
	glorioushud.materials[ i ] = Material( icon )

end

local defaults = {
	playerhudclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		headclr = Color( 40, 40, 40, 240 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		hpclr = Color( 255, 84, 54, 200 ),
		hpbgclr = Color( 255, 84, 54, 100 ),
		armorclr = Color( 80, 19, 255, 200 ),
		armorbgclr = Color( 80, 19, 255, 100 ),
		foodclr = Color( 255, 184, 77, 200 ),
		foodbgclr = Color( 255, 184, 77, 100 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		nolicenseiconclr = Color( 60, 60, 60, 255 ),
	},
	levelhudclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		levelclr = Color( 255, 184, 77, 200 ),
		levelbgclr = Color( 255, 184, 77, 100 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
	},
	staminahudclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		staminaclr = Color( 255, 184, 77, 200 ),
		staminabgclr = Color( 255, 184, 77, 100 ),
	},
	overheadclrs = {
		textclr = Color( 255, 255, 255, 255 ),
		licensetextclr = Color( 255, 255, 255, 255 ),
		shapeclr = Color( 40, 40, 40, 230 ),
		iconclr = Color( 255, 255, 255, 255 ),
		wantedclr = Color( 255, 84, 54, 255 ),
		outlineclr = Color( 255, 255, 255, 150 ),
	},
	voteclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		timeclr = Color( 0, 211, 0, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		btnclr = Color( 40, 40, 40, 255 ),
	},
	notifyclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		progressbarclr = Color( 0, 211, 0, 255 ),
	},
	weaponhudclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		propsclr = Color( 255, 184, 77, 200 ),
		propsbgclr = Color( 255, 184, 77, 100 ),
	},
	agendaclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
	},
	arrestclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
	},
	lockdownclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
	},
	wantedclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
	},
	doorsclrs = {
		textclr = Color( 255, 255, 255, 255 ),
	},
	doorsmenuclrs = {
		backgroundclr = Color( 50, 50, 50, 255 ),
		headclr = Color( 60, 60, 60, 255 ),
		buttonclr = Color( 30, 30, 30, 150 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
	},
	newsclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
	},
	gesturesclrs = {
		backgroundclr = Color( 50, 50, 50, 255 ),
		headclr = Color( 60, 60, 60, 255 ),
		buttonclr = Color( 30, 30, 30, 150 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
	},
	timeoutclrs = {
		backgroundclr = Color( 40, 40, 40, 180 ),
		textclr = Color( 255, 255, 255, 255 ),
		discriptiontextclr = Color( 200, 200, 200, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		buttonclr = Color( 30, 30, 30, 150 ),
	},
	pickupclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
	},
	vehicleclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		fuelclr = Color( 255, 184, 77, 200 ),
		fuelbgclr = Color( 255, 184, 77, 100 ),
		rpmclr = Color( 191, 199, 193, 100 ),
		rpmbgclr = Color( 161, 169, 163, 100 ),

		officonclr = Color( 80, 80, 80, 255 ),
		handbrakeiconclr = Color( 255, 84, 54, 200 ),
		cruiseiconclr = Color( 72, 201, 84, 200 ),
		foglightsiconclr = Color( 219, 141, 15, 200 ), 
		lighticonclr = Color( 88, 166, 0, 200 ),
		lampsiconclr = Color( 0, 157, 241, 200 ),

		brokeniconclr = Color( 255, 84, 54, 200 ),
	},
	vehicleindclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
	},
	settingsmenuclrs = {
		backgroundclr = Color( 50, 50, 50, 255 ),
		headclr = Color( 60, 60, 60, 255 ),
		buttonclr = Color( 30, 30, 30, 150 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		shapesclr = Color( 30, 30, 30, 150 ),
	},
	vguiclrs = {
		iconsclr = Color( 255, 255, 255, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		backgroundclr = Color( 50, 50, 50, 255 ),
		cornerclr = Color( 0, 122, 209, 255 ),
		hoverclr = Color( 2, 99, 168, 255 ),
		dmenuhover = Color( 30, 30, 30, 0 ),
		sliderleft = Color( 0, 122, 209, 255 ),
		sliderright = Color( 50, 50, 50, 255 ),
		sliderpoint = Color( 0, 122, 209, 255 ),
		sliderhover = Color( 2, 99, 168, 255 ),
		checkboxhover = Color( 60, 60, 60, 255 ),
		shapeclr = Color( 30, 30, 30, 150 ),
		scrollhover = Color( 60, 60, 60, 255 ),
	},
	titlemenuclrs = {
		backgroundclr = Color( 50, 50, 50, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		headclr = Color( 60, 60, 60, 255 ),
		buttonclr = Color( 30, 30, 30, 150 ),
		textclr = Color( 255, 255, 255, 255 ),
		cursorclr = Color( 0, 122, 209, 255 ),
		entrybgclr = Color( 30, 30, 30, 150 ),
		highlightclr = Color( 0, 122, 209, 150 ),
	},
	medkitclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		hpclr = Color( 255, 84, 54, 200 ),
		hpbgclr = Color( 255, 84, 54, 100 ),
	},
	closemenuclrs = {
		backgroundclr = Color( 50, 50, 50, 255 ),
		iconsclr = Color( 255, 255, 255, 255 ),
		headclr = Color( 60, 60, 60, 255 ),
		buttonclr = Color( 30, 30, 30, 150 ),
		textclr = Color( 255, 255, 255, 255 ),
	},
	voicenotifyclrs = {
		backgroundclr = Color( 40, 40, 40, 170 ),
		shapesclr = Color( 40, 40, 40, 255 ),
		textclr = Color( 255, 255, 255, 255 ),
	},
	enabled = {
		hud = true,
		votes = true,
		agenda = true,
		arrest = true,
		lockdown = true,
		wanted = true,
		pickup = true,
		doors = true,
		vehicle = true,
		timeout = true,
		overhead = true,
		news = true,
		vehicleinfo = true,
		medkit = true,
		level = true,
		stamina = true,
	},
	animationenabled = true,
	animationspeed = 1,
	overheadscale = 0.1,
	model = false,
	kmh = true,
	language = glorioushud.defaultLang,
	theme = 'darktheme',
	showrange = 500,
	barnames = false,
	voicebar = true,
	voicecolor = true,
	leveltime = 5,
	levelalways = false,
}

local function ValidateSettings( settings )

	local invalid = {
		enabled = {},
	}
	local result = true

	for i, v in pairs( defaults ) do

		if( settings[ i ] == nil ) then
			table.insert( invalid, i )
		end

	end

	for i, v in pairs( defaults.enabled ) do

		if( settings.enabled[ i ] == nil ) then
			table.insert( invalid.enabled, i )
		end

	end

	if( table.Count( invalid ) > 1 ) then
		for i, v in pairs( invalid ) do
			if( i == 'enabled' ) then
				for i, v in ipairs( v ) do
					settings.enabled[ v ] = defaults.enabled[ v ]
				end
				continue
			end
			settings[ v ] = defaults[ v ]
		end
		result = settings
	end

	return result

end

local function loadsettings()

	if( file.Exists( 'gh_settings.txt', 'DATA' ) ) then
		local settings = util.JSONToTable( file.Read( 'gh_settings.txt', 'DATA' ) )

		local result = ValidateSettings( settings )

		if( istable( result ) ) then
			file.Write( 'gh_settings.txt', util.TableToJSON( result ) )
			glorioushud.settings = result
		else
			glorioushud.settings = settings
		end
	else
		glorioushud.settings = table.Copy( defaults )
	end

	hook.Call( 'glorioushud.settings_apply' )

end

loadsettings()

function glorioushud.callsizechanges()

	hook.Call( 'glorioushud.sizechanged' )

end

hook.Add( 'OnScreenSizeChanged', 'glorioushud.sizechanged', glorioushud.callsizechanges )

local hungermod = DarkRP.disabledDefaults[ 'modules' ][ 'hungermod' ]
local width, height
local bgy
local x, y
local weaponx, weapony

local function updatesize()

	width, height = ScrW(), ScrH()
	bgy = height - 190
	if( hungermod ) then bgy = height - 155 end
	x, y = 10, bgy
	weaponx, weapony = width - 260, height - 85

end

updatesize()

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesize6', updatesize )

function glorioushud.avatar()

	timer.Remove( 'update_model' )
	glorioushud.avatarpanel = vgui.Create( 'AvatarImage' )
	glorioushud.avatarpanel:SetPos( x + 10, y + 10 )
	glorioushud.avatarpanel:SetSize( 55, 55 )
	glorioushud.avatarpanel:SetPlayer( LocalPlayer(), 64 )
	glorioushud.avatarpanel:SetPaintedManually( true )

end

function glorioushud.model()

	glorioushud.modelpanel = vgui.Create( 'DModelPanel' )
	glorioushud.modelpanel:SetPos( x + 10, y + 10 )
	glorioushud.modelpanel:SetSize( 55, 55 )
	glorioushud.modelpanel:SetModel( LocalPlayer():GetModel() )
	glorioushud.modelpanel:SetPaintedManually( true )
	local eyepos = glorioushud.modelpanel.Entity:GetBonePosition( glorioushud.modelpanel.Entity:LookupBone( 'ValveBiped.Bip01_Head1' ) )
	eyepos:Add( Vector( 0, 0, 0 ) )
	glorioushud.modelpanel:SetFOV( 48 )
	glorioushud.modelpanel:SetLookAt( eyepos )
	glorioushud.modelpanel:SetCamPos( eyepos - Vector( -20, 0, 0 ) )
	glorioushud.modelpanel.Entity:SetEyeTarget( eyepos - Vector( -12, 0, 0 ) )
	glorioushud.modelpanel.LayoutEntity = function() return end
	timer.Remove( 'update_model' )
	timer.Create( 'update_model', 1, 0, function()

		if( !IsValid( glorioushud.modelpanel ) ) then return end

		glorioushud.modelpanel:SetModel( LocalPlayer():GetModel() )

	end)

end

function glorioushud.loadavatarormodel()

	if( glorioushud.settings.model ) then
		if( IsValid( glorioushud.avatarpanel ) ) then
			glorioushud.avatarpanel:Remove()
		end
		glorioushud.model()
	else
		if( IsValid( glorioushud.modelpanel ) ) then
			glorioushud.modelpanel:Remove()
		end
		glorioushud.avatar()
	end

end

if( IsValid( LocalPlayer() ) ) then

	glorioushud.loadavatarormodel()
	
end

hook.Add( 'InitPostEntity', 'glorioushud.initavatarormodel', glorioushud.loadavatarormodel )

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesizepanel', glorioushud.loadavatarormodel )

function glorioushud.resetdefaults()

	glorioushud.settings = table.Copy( defaults )
	glorioushud.loadavatarormodel()
	if( file.Exists( 'gh_settings.txt', 'DATA' ) ) then
		file.Delete( 'gh_settings.txt' )
	end

	hook.Call( 'glorioushud.settings_apply' )

end

if( glorioushud.settings.animationenabled ) then
	glorioushud.hppos = 0
	glorioushud.armorpos = 0
	glorioushud.hungerpos = 0

	glorioushud.propspos = 0
end

function glorioushud.playerhud()

	local lp = LocalPlayer()
	if( !IsValid( lp ) ) then return end

	if( !hungermod ) then
		glorioushud.hunger = math.ceil( lp:getDarkRPVar( 'Energy' ) ) or 0
	end
	glorioushud.money = DarkRP.formatMoney( lp:getDarkRPVar( 'money' ) )
	glorioushud.salary = DarkRP.formatMoney( lp:getDarkRPVar( 'salary' ) )
	glorioushud.job = lp:getDarkRPVar( 'job' )
	glorioushud.licensed = lp:getDarkRPVar( 'HasGunlicense' )

	if( glorioushud.settings.animationenabled ) then
		glorioushud.hppos = math.Approach( glorioushud.hppos, lp:Health(), glorioushud.settings.animationspeed )
		glorioushud.armorpos = math.Approach( glorioushud.armorpos, lp:Armor(), glorioushud.settings.animationspeed )
		if( !hungermod ) then
			glorioushud.hungerpos = math.Approach( glorioushud.hungerpos, glorioushud.hunger, glorioushud.settings.animationspeed )
		end

		glorioushud.propspos = math.Approach( glorioushud.propspos, lp:GetCount( 'props' ), glorioushud.settings.animationspeed )
	else
		glorioushud.hppos = lp:Health()
		glorioushud.armorpos = lp:Armor()
		if( !hungermod ) then
			glorioushud.hungerpos = glorioushud.hunger
		end

		glorioushud.propspos = lp:GetCount( 'props' )
	end

	local bgh = 180
	if( hungermod ) then bgh = 145 end
	
	draw.RoundedBox( 0, x, y, 400, bgh, glorioushud.settings.playerhudclrs.backgroundclr )

	if( !hungermod ) then

		draw.RoundedBox( 0, x + 5, y + 145, 30, 30, glorioushud.settings.playerhudclrs.shapesclr )
		draw.RoundedBox( 0, x + 40, y + 145, 355, 30, glorioushud.settings.playerhudclrs.shapesclr )
		draw.RoundedBox( 5, x + 45, y + 150, 345, 20, glorioushud.settings.playerhudclrs.foodbgclr )
		draw.RoundedBox( 5, x + 45, y + 150, 345 / 100 * glorioushud.hungerpos, 20, glorioushud.settings.playerhudclrs.foodclr )
		draw.SimpleText( ( glorioushud.settings.barnames and glorioushud.localisationget( 'food', glorioushud.settings.language ) or '' ) .. glorioushud.hunger .. '%', 'glorioushud.font.playerhud', x + 217, y + 160, glorioushud.settings.playerhudclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		surface.SetDrawColor( glorioushud.settings.playerhudclrs.iconsclr )
		surface.SetMaterial( glorioushud.materials[ 'humburger' ] )
		surface.DrawTexturedRect( x + 8, y + 148, 24, 24 )

	end

	draw.RoundedBox( 0, x + 5, y + 110, 30, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 110, 355, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.RoundedBox( 5, x + 45, y + 115, 345, 20, glorioushud.settings.playerhudclrs.armorbgclr )
	draw.RoundedBox( 5, x + 45, y + 115, 345 / lp:GetMaxArmor() * math.Clamp( glorioushud.armorpos, 0, lp:GetMaxArmor() ), 20, glorioushud.settings.playerhudclrs.armorclr )
	draw.SimpleText( ( glorioushud.settings.barnames and glorioushud.localisationget( 'armor', glorioushud.settings.language ) or '' ) .. lp:Armor() .. '%', 'glorioushud.font.playerhud', x + 217, y + 125, glorioushud.settings.playerhudclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	surface.SetDrawColor( glorioushud.settings.playerhudclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'shield' ] )
	surface.DrawTexturedRect( x + 8, y + 113, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 75, 30, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.RoundedBox( 0, x + 40, y + 75, 355, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.RoundedBox( 5, x + 45, y + 80, 345, 20, glorioushud.settings.playerhudclrs.hpbgclr )
	draw.RoundedBox( 5, x + 45, y + 80, 345 / lp:GetMaxHealth() * math.Clamp( glorioushud.hppos, 0, lp:GetMaxHealth() ), 20, glorioushud.settings.playerhudclrs.hpclr )
	draw.SimpleText( ( glorioushud.settings.barnames and glorioushud.localisationget( 'hp', glorioushud.settings.language ) or '' ) .. lp:Health() .. '%', 'glorioushud.font.playerhud', x + 217, y + 90, glorioushud.settings.playerhudclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	surface.SetDrawColor( glorioushud.settings.playerhudclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'heart' ] )
	surface.DrawTexturedRect( x + 8, y + 78, 24, 24 )

	draw.RoundedBox( 0, x + 5, y + 5, 65, 65, glorioushud.settings.playerhudclrs.shapesclr )

	draw.RoundedBox( 0, x + 75, y + 5, 30, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.RoundedBox( 0, x + 110, y + 5, 285, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.SimpleText( glorioushud.job, 'glorioushud.font.playerhud', x + 120, y + 29, glorioushud.settings.playerhudclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )

	surface.SetDrawColor( glorioushud.settings.playerhudclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'case' ] )
	surface.DrawTexturedRect( x + 78, y + 8, 24, 24 )

	if( glorioushud.licensed != nil ) then
		surface.SetDrawColor( glorioushud.settings.playerhudclrs.iconsclr )
		surface.SetMaterial( glorioushud.materials[ 'license' ] )
		surface.DrawTexturedRect( x + 370, y + 8, 24, 24 )
	else
		surface.SetDrawColor( glorioushud.settings.playerhudclrs.nolicenseiconclr )
		surface.SetMaterial( glorioushud.materials[ 'license' ] )
		surface.DrawTexturedRect( x + 370, y + 8, 24, 24 )
	end
	
	draw.RoundedBox( 0, x + 75, y + 40, 30, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.RoundedBox( 0, x + 110, y + 40, 285, 30, glorioushud.settings.playerhudclrs.shapesclr )
	draw.SimpleText( glorioushud.money .. ' + ' .. glorioushud.salary, 'glorioushud.font.playerhud', x + 120, y + 64, glorioushud.settings.playerhudclrs.textclr,TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )

	surface.SetDrawColor( glorioushud.settings.playerhudclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'money' ] )
	surface.DrawTexturedRect( x + 78, y + 43, 24, 24 )

	if( IsValid( glorioushud.modelpanel ) and glorioushud.settings.model ) then
		glorioushud.modelpanel:PaintManual()
	end
	if( IsValid( glorioushud.avatarpanel ) and !glorioushud.settings.model ) then
		glorioushud.avatarpanel:PaintManual()
	end



	local weapon = lp:GetActiveWeapon()
	if( lp:InVehicle() ) then return end
	if( !IsValid( weapon ) ) then return end
	if( weapon:Clip1() < 0 and !glorioushud.buildweapons[ weapon:GetClass() ] ) then return end

	draw.RoundedBox( 0, weaponx, weapony, 250, 75, glorioushud.settings.weaponhudclrs.backgroundclr )

	draw.RoundedBox( 0, weaponx + 5, weapony + 5, 30, 30, glorioushud.settings.weaponhudclrs.shapesclr )
	draw.RoundedBox( 0, weaponx + 40, weapony + 5, 205, 30, glorioushud.settings.weaponhudclrs.shapesclr )
	draw.SimpleText( weapon:GetPrintName(), 'glorioushud.font.playerhud', weaponx + 48, weapony + 29, glorioushud.settings.weaponhudclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM ) 

	surface.SetDrawColor( glorioushud.settings.weaponhudclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'gun' ] )
	surface.DrawTexturedRect( weaponx + 8, weapony + 8, 24, 24 )

	draw.RoundedBox( 0, weaponx + 5, weapony + 40, 30, 30, glorioushud.settings.weaponhudclrs.shapesclr )
	draw.RoundedBox( 0, weaponx + 40, weapony + 40, 205, 30, glorioushud.settings.weaponhudclrs.shapesclr )

	if( glorioushud.buildweapons[ weapon:GetClass() ] ) then

		surface.SetDrawColor( glorioushud.settings.weaponhudclrs.iconsclr )
		surface.SetMaterial( glorioushud.materials[ 'construct' ] )
		surface.DrawTexturedRect( weaponx + 8, weapony + 43, 24, 24 )

		local maxprops = 'error'

		if( istable( sam ) && lp:GetLimit( 'props' ) > -1 ) then
			maxprops = lp:GetLimit( 'props' )
		else
			maxprops = GetConVar( 'sbox_maxprops' ):GetInt()
		end
		
		draw.RoundedBox( 5, weaponx + 45, weapony + 45, 195, 20, glorioushud.settings.weaponhudclrs.propsbgclr )
		draw.RoundedBox( 5, weaponx + 45, weapony + 45, 195 / maxprops * glorioushud.propspos, 20, glorioushud.settings.weaponhudclrs.propsclr )

		draw.SimpleText( glorioushud.localisationget( 'props', glorioushud.settings.language ) .. lp:GetCount( 'props' ) .. '/' .. maxprops, 'glorioushud.font.playerhud', weaponx + 142.5, weapony + 64, glorioushud.settings.weaponhudclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

		return

	end 

	draw.SimpleText( weapon:Clip1() .. '/' .. lp:GetAmmoCount( weapon:GetPrimaryAmmoType() ), 'glorioushud.font.playerhud', weaponx + 48, weapony + 64, glorioushud.settings.weaponhudclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
	if( lp:GetAmmoCount( weapon:GetSecondaryAmmoType() ) != 0 ) then
		
		draw.SimpleText( lp:GetAmmoCount( weapon:GetSecondaryAmmoType() ), 'glorioushud.font.playerhud', weaponx + 237, weapony + 64, glorioushud.settings.weaponhudclrs.textclr, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
	
	end

	surface.SetDrawColor( glorioushud.settings.weaponhudclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'bullet' ] )
	surface.DrawTexturedRect( weaponx + 8, weapony + 43, 24, 24 )

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_playerhud', function()

	hook.Add( 'HUDPaint', 'glorioushud.playerhud', glorioushud.playerhud )

	if( !glorioushud.settings.enabled.hud or !glorioushud.adminenabled.hud ) then
		hook.Remove( 'HUDPaint', 'glorioushud.playerhud' )
	end

end)

hook.Add( 'Initialize', 'glorioushud.loadall', function()

	hook.Call( 'glorioushud.settings_apply' )

end)