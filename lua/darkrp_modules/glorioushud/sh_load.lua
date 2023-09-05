local files = file.Find('darkrp_modules/glorioushud/locales/*.lua', 'LUA')

for i, v in pairs(files) do
    if SERVER then
        AddCSLuaFile('darkrp_modules/glorioushud/locales/' .. v)
    else
        include('darkrp_modules/glorioushud/locales/' .. v)
    end
end

-- Adding the magic system files
if SERVER then
    AddCSLuaFile('darkrp_modules/glorioushud/cl_magic_hud.lua')
    AddCSLuaFile('darkrp_modules/glorioushud/cl_magicinfo.lua')
else
    include('darkrp_modules/glorioushud/cl_magic_hud.lua')
    include('darkrp_modules/glorioushud/cl_magicinfo.lua')
end
