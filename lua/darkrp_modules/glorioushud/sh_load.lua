local files = file.Find( 'darkrp_modules/glorioushud/locales/*.lua', 'LUA' )

for i, v in pairs( files ) do

	if SERVER then
		AddCSLuaFile( 'darkrp_modules/glorioushud/locales/' .. v )
	else
		include( 'darkrp_modules/glorioushud/locales/' .. v )
	end

end