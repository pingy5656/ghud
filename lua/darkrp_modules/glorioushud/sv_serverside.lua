resource.AddWorkshop( '2530375512' )

glorioushud = {}

hook.Call( 'glorioushud.initializedServer' )

AddCSLuaFile( 'darkrp_modules/glorioushud/configuration.lua' )
local cfg = include( 'darkrp_modules/glorioushud/configuration.lua' )

glorioushud.speakicon = cfg.speakIcon
glorioushud.outdatealert = cfg.outdateAlert
glorioushud.settingscommand = cfg.settingsCommand

--[[--------------------------------------------------------------
Warning! If you change this value, outdate alerts will don't work!
----------------------------------------------------------------]] 
local version = '1.1.4-release'
--[[------------------------------------------------------------]]

util.AddNetworkString( 'glorioushud.sendvote' )
util.AddNetworkString( 'glorioushud.sendarrest' )
util.AddNetworkString( 'glorioushud.newshooks' )
util.AddNetworkString( 'glorioushud.outdate_query' )
util.AddNetworkString( 'glorioushud.outdate' )
util.AddNetworkString( 'glorioushud.opensettings' )

function glorioushud.sendvote( vote )

	local vote_tbl = {
		time = vote.time,
		question = vote.question,
		id = vote.id,
	}

	net.Start( 'glorioushud.sendvote' )
		net.WriteString( util.TableToJSON( vote_tbl ) )
		net.WriteEntity( vote.target )
	net.Broadcast()

end

hook.Add( 'onVoteStarted', 'glorioushud.onvotestarted', glorioushud.sendvote )

function glorioushud.sendnew( data )

	net.Start( 'glorioushud.newshooks' )
		net.WriteString( util.TableToJSON( data ) )
	net.Broadcast()

end

function glorioushud.sendarrest( ply, time, actor )

	net.Start( 'glorioushud.sendarrest' )
		net.WriteEntity( actor )
		net.WriteInt( time, 12 )
	net.Send( ply )

	glorioushud.sendnew( {
		ply_name = ply:GetName(),
		executor_name = actor:GetName() or '',
		arg = time,
		type = 3,
	} )

end

hook.Add( 'playerArrested', 'glorioushud.sendarrest', glorioushud.sendarrest )

function glorioushud.sendwarrant( ply, actor, reason )

	glorioushud.sendnew( {
		ply_name = ply:GetName(),
		executor_name = actor:GetName(),
		arg = reason,
		type = 2,
	} )

	return true

end

hook.Add( 'playerWarranted', 'glorioushud.sendwarrant', glorioushud.sendwarrant )

function glorioushud.sendwanted( ply, actor, reason )

	glorioushud.sendnew( {
		ply_name = ply:GetName(),
		executor_name = actor:GetName(),
		arg = reason,
		type = 1,
	} )

	return true

end

hook.Add( 'playerWanted', 'glorioushud.sendwanted', glorioushud.sendwanted )

function glorioushud.sendunwanted( ply, actor )

	if( !actor ) then return true end

	glorioushud.sendnew( {
		ply_name = ply:GetName(),
		executor_name = actor:GetName(),
		type = 4,
	} )
	
	return true

end

hook.Add( 'playerUnWanted', 'glorioushud.sendunwanted', glorioushud.sendunwanted )



local types = {
	prop_door_rotating = true,
	func_door_rotating = true,
	func_door = true,
}

function glorioushud.initdoorsstatus()

	local entities = ents.GetAll()

	for i, v in ipairs( entities ) do

		if( types[ v:GetClass() ] ) then
		
			v:SetNWBool( 'm_bLocked', v:GetInternalVariable( 'm_bLocked' ) )

		end

	end

end

hook.Add( 'InitPostEntity', 'glorioushud.initdoorsstatus', glorioushud.initdoorsstatus )

function glorioushud.keysOpen( entity )

	entity:SetNWBool( 'm_bLocked', false )

end

hook.Add( 'onKeysUnlocked', 'glorioushud.keysOpen', glorioushud.keysOpen )

function glorioushud.keysClose( entity )

	entity:SetNWBool( 'm_bLocked', true )

end

hook.Add( 'onKeysLocked', 'glorioushud.keysClose', glorioushud.keysClose )

local function checkoutdate( len, ply )

	if( !glorioushud.outdatealert ) then return end

	http.Fetch( 'https://holy-filipp.github.io/glorioushud_ver.html',
	
		function( body )
			local a, b, result = string.find( body, '([%d]%.[%d]%.[%d]%-([%w]+))' )
			if( result != version ) then
				net.Start( 'glorioushud.outdate' )
					net.WriteString( result )
					net.WriteString( version )
				net.Send( ply )
			end
		end,

		function( message )
			MsgC( Color( 255, 0, 0 ), '[GloriousHUD] Outdate alerts error:', message, '\n' )
			return
		end
		
	)

end

net.Receive( 'glorioushud.outdate_query', checkoutdate )

if( !glorioushud.speakicon ) then
	RunConsoleCommand( 'mp_show_voice_icons', 0 )
else
	RunConsoleCommand( 'mp_show_voice_icons', 1 )
end

local function chat_handler( ply, text )

	if( text == glorioushud.settingscommand ) then

		net.Start( 'glorioushud.opensettings' )
		net.Send( ply )
		return ''

	end

end

hook.Add( 'PlayerSay', 'glorioushud.chat_handler', chat_handler )