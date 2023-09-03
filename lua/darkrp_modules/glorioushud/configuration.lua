local cfg = {}

--Weapons which will show props limit in Weapon HUD
--First field it's weapon class, you can get it clicking RMB on weapons in Spawn Menu.
--Second field just true. Comma required! Example - weapon_fists = true,
cfg.buildWeapons = {
	gmod_tool = true,
	weapon_physgun = true,
}

--SWEPs which will show player health on whick you looking
--First field it's SWEP class, you can get it clicking RMB on SWEPs in Spawn Menu.
--Second field just true. Comma required! Example - [ 'weapon_medkit' ] = true,
cfg.medkitsClasses = {
	[ 'weapon_medkit' ] = true,
	[ 'med_kit' ] = true,
}

--Sound path when vote will start
--You can find sounds here: https://wiki.facepunch.com/gmod/HL2_Sound_List
--I recommend to test sounds from 'Buttons' tab
cfg.voteSound = 'plats/elevbell1.wav'

--Chat command which open settings menu
cfg.settingsCommand = '!glorioushud_settings'

--Enable default overhead speak icon
--false - no, true - yes
cfg.speakIcon = false

--Enable HUD outdate alerts in chat and console, when player connected to server
--false - no, true - yes
cfg.outdateAlert = true

--Enable default simfphys HUD. Only then simfphys installed!
--false - no, true - yes
cfg.simfphysHUD = false

--Auto reconnect time in seconds (default 60)
cfg.timeoutTime = 60

--Set HUD language from game language. If the player's language is missing in the HUD, then the default language will be set (option below)
cfg.autoLanguage = true

--Default language on clients
--Must write id of language (ex. 'en', 'ru'). All ids you can see in files on 3 line, in folder 'locales'
cfg.defaultLanguage = 'en'

--Enabling/Disabling modules of HUD
--false - disabled, true - enabled
cfg.main_hud = true
cfg.votes = true
cfg.agenda = true
cfg.arrest = true
cfg.lockdown = true
cfg.wanted = true
cfg.pickup = true
cfg.doors = true
cfg.vehicle = true
cfg.timeout = true
cfg.overhead = true
cfg.news = true
cfg.vehicleinfo = true
cfg.medkit = true
cfg.gestures = true
cfg.notify = true
cfg.level = true --Only then leveling system installed
cfg.stamina = true --Only then simple stamina installed

return cfg