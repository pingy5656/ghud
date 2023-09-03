local types = {
	prop_door_rotating = true,
	func_door_rotating = true,
	func_door = true,
}

local doors = {}

local lp = lp or NULL

function glorioushud.entityinit()

	doors = {}

	local entities = ents.GetAll()

	for i, v in ipairs( entities ) do
		
		if( types[ v:GetClass() ] ) then

			table.insert( doors, v )

		end

	end

	lp = LocalPlayer()

end

hook.Add( 'InitPostEntity', 'glorioushud.entityinit', glorioushud.entityinit )
hook.Add( 'PostCleanupMap', 'glorioushud.cleanupinit', glorioushud.entityinit )

function glorioushud.entitycreated( entity ) --Fixing problem on big maps with optimization

	if( types[ entity:GetClass() ] ) then

		for i, v in ipairs( doors ) do 

			if( v == entity ) then
				return
			end

		end

		table.insert( doors, entity )

	end

end

hook.Add( 'NetworkEntityCreated', 'glorioushud.entitycreated', glorioushud.entitycreated )

function glorioushud.drawdoors3d2d()

	for i, v in ipairs( doors ) do

		if( !IsValid( v ) ) then return end
		if( lp == NULL ) then return end
		if( lp:GetPos():Distance( v:GetPos() ) > 200 ) then continue end
		if( v:GetNoDraw() ) then return end

		local dimens = v:OBBMaxs() - v:OBBMins()
		local center = v:OBBCenter()
		local min, j 

		for i = 1, 3 do
			if( !min or dimens[i] <= min ) then
				j = i
				min = dimens[i]
			end
		end

		local norm = Vector()
		norm[j] = 1

		local lang = Angle( 0, norm:Angle().y + 90, 90 )

		if( v:GetClass() == 'prop_door_rotating' ) then
			v.glorioushud_lpos = Vector( center.x - 0.5, center.y, 16 ) + lang:Up() * ( min / 6 )
		else
			v.glorioushud_lpos = center + lang:Up() * ( ( min / 2 ) - 0.1 )
		end

		v.glorioushud_lang = lang

		local lpos = Vector()
		lpos:Set( v.glorioushud_lpos )
		lang:Set( v.glorioushud_lang )

		local ang = v:LocalToWorldAngles( lang )
		local dot = ang:Up():Dot( lp:GetShootPos() - v:WorldSpaceCenter() )

		if( dot < 0 ) then
			lang:RotateAroundAxis( lang:Right(), 180 )

			lpos = lpos - ( 2 * lpos * -lang:Up() )
			ang = v:LocalToWorldAngles( lang )
		end

		local pos = v:LocalToWorld( lpos )

		local owner = v:getDoorOwner()
		local title = v:getKeysTitle()
		local coOwners = v:getKeysCoOwners()
		local allowed = v:getKeysNonOwnable()
		local group = v:getKeysDoorGroup()
		local teams = v:getKeysDoorTeams()

		local titletext = ''
		local ownertext = ''
		local coOwnerstext = ''

		if( allowed != nil and title != nil ) then
			titletext = title
		end

		if( owner == nil and allowed == nil ) then
			if( title != nil ) then
				titletext = title
			elseif( group == nil and teams == nil ) then
				titletext = glorioushud.localisationget( 'forsale', glorioushud.settings.language )
				ownertext = glorioushud.localisationget( 'tobuy', glorioushud.settings.language )
			end
			if( group != nil ) then
				ownertext = group
			end
			if( teams != nil ) then
				for i, v in pairs( teams ) do

					coOwnerstext = coOwnerstext .. RPExtraTeams[ i ].name .. '\n'

				end
			end
		elseif( allowed == nil ) then
			if( title != nil ) then
				titletext = title
			else
				titletext = glorioushud.localisationget( 'solddoor', glorioushud.settings.language )
			end
			ownertext = glorioushud.localisationget( 'owner', glorioushud.settings.language ) .. ' ' .. owner:GetName()

			if( coOwners != nil ) then
				for i, v in pairs( player.GetAll() ) do

					if( coOwners[ v:UserID() ] ) then
						coOwnerstext = coOwnerstext .. v:GetName() .. '\n'
					end

				end
			end
		end

		cam.Start3D2D( pos, ang, 0.1 )

			draw.SimpleText( titletext, 'glorioushud.font.overhead60', 0, 0, glorioushud.settings.doorsclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
			draw.SimpleText( ownertext, 'glorioushud.font.doors40', 0, 55, glorioushud.settings.doorsclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
			draw.DrawText( coOwnerstext, 'glorioushud.font.doors40', 0, 85, glorioushud.settings.doorsclrs.textclr, TEXT_ALIGN_CENTER )

		cam.End3D2D()

		cam.Start3D2D( pos, ang, 0.1 )

			draw.SimpleText( titletext, 'glorioushud.font.overhead60', 0, 0, glorioushud.settings.doorsclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
			draw.SimpleText( ownertext, 'glorioushud.font.doors40', 0, 55, glorioushud.settings.doorsclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
			draw.DrawText( coOwnerstext, 'glorioushud.font.doors40', 0, 85, glorioushud.settings.doorsclrs.textclr, TEXT_ALIGN_CENTER )

		cam.End3D2D()

	end

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_drawdoor3d2d', function()

	hook.Add( 'PostDrawTranslucentRenderables', 'glorioushud.drawdoors3d2d', glorioushud.drawdoors3d2d )

	if( !glorioushud.settings.enabled.doors or !glorioushud.adminenabled.doors ) then 
		hook.Remove( 'PostDrawTranslucentRenderables', 'glorioushud.drawdoors3d2d' )
	end

end)



local buttonsw, buttonsh, indent = 200, 30, 5

local function addbutton( frame, text, icon, onclick )

	local button = vgui.Create( 'DButton', frame )
	button.alpha = glorioushud.settings.doorsmenuclrs.buttonclr.a
	button:SetSize( buttonsw, buttonsh )
	button:SetPos( 5, 35 + ( buttonsh + indent ) * frame.buttons )
	button:SetText( '' )
	button.OnCursorEntered = function( self )
		self.alpha = 255
	end
	button.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.doorsmenuclrs.buttonclr.a
	end
	button.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.doorsmenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( text, 'glorioushud.font.playerhud', 35, 4, glorioushud.settings.doorsmenuclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	end
	button.DoClick = onclick

	local buttonicon = vgui.Create( 'DImage', frame )
	buttonicon:SetSize( 24, 24 )
	buttonicon:SetPos( 8, 38 + ( buttonsh + indent ) * frame.buttons )
	buttonicon:SetImage( 'icons/' .. icon .. '.png' )
	buttonicon:SetImageColor( glorioushud.settings.doorsmenuclrs.iconsclr )

	frame.buttons = frame.buttons + 1
	frame:SetSize( indent * 2 + buttonsw, 35 + ( buttonsh + indent ) * frame.buttons )
	frame:Center()

	return button

end

local tframe

local function titlemenu( vehicle, yesFunc )

	if( IsValid( tframe ) ) then return end
	tframe = vgui.Create( 'DFrame' )
	tframe:MakePopup()
	tframe:SetDraggable( false )
	tframe:ShowCloseButton( false )
	tframe:SetSize( 400, 110 )
	tframe:Center()
	tframe:SetTitle( '' )
	tframe.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.titlemenuclrs.backgroundclr )
		draw.RoundedBoxEx( 5, 0, 0, w, 30, glorioushud.settings.titlemenuclrs.headclr, true, true, false, false )
		draw.SimpleText( glorioushud.localisationget( !vehicle and 'settitle' or 'setvtitle', glorioushud.settings.language ), 'glorioushud.font.playerhud', 8, 5, glorioushud.settings.titlemenuclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	end

	local closebtn = vgui.Create( 'DButton', tframe )
	closebtn.alpha = 0
	closebtn:SetSize( 24, 24 )
	closebtn:SetPos( 400 - 27, 3 )
	closebtn:SetText( '' )
	closebtn.OnCursorEntered = function( self )
		self.alpha = 150
	end
	closebtn.OnCursorExited = function( self )
		self.alpha = 0
	end
	closebtn.Paint = function( self, w, h )
		draw.RoundedBox( 5, 0, 0, 24, 24, ColorAlpha( glorioushud.settings.titlemenuclrs.buttonclr, self.alpha ) )
	end
	closebtn.DoClick = function()
		tframe:Close()
	end

	local closeimg = vgui.Create( 'DImage', tframe )
	closeimg:SetSize( 24, 24 )
	closeimg:SetPos( 400 - 27, 3 )
	closeimg:SetImage( 'icons/x.png' )
	closeimg:SetImageColor( glorioushud.settings.titlemenuclrs.iconsclr )

	local entry = vgui.Create( 'DTextEntry', tframe )
	entry:SetSize( 380, 25 )
	entry:SetPos( 10, 40 )
	entry:SetFont( 'glorioushud.font.playerhud' )
	entry:SetTextColor( glorioushud.settings.titlemenuclrs.textclr )
	entry:SetCursorColor( glorioushud.settings.titlemenuclrs.cursorclr )
	entry:SetHighlightColor( glorioushud.settings.titlemenuclrs.highlightclr )
	entry:SetDrawLanguageID( false )
	entry.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.titlemenuclrs.entrybgclr )
		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )

	end
	entry.OnEnter = function()

		tframe:Close()
		return yesFunc( entry:GetValue() )
		
	end

	local sbutton = vgui.Create( 'DButton', tframe )
	sbutton.alpha = 155
	sbutton:SetSize( 185, 25 )
	sbutton:SetPos( 10, 75 )
	sbutton:SetText( '' )
	sbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	sbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.titlemenuclrs.buttonclr.a
	end
	sbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.titlemenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'set', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h / 2 - 2, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	sbutton.DoClick = function()
		tframe:Close()
		return yesFunc( entry:GetValue() )
	end

	local nbutton = vgui.Create( 'DButton', tframe )
	nbutton.alpha = 155
	nbutton:SetSize( 185, 25 )
	nbutton:SetPos( 205, 75 )
	nbutton:SetText( '' )
	nbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	nbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.titlemenuclrs.buttonclr.a
	end
	nbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.titlemenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'cancel', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h / 2 - 2, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	nbutton.DoClick = function()
		tframe:Close()
	end

end

local frame

function glorioushud.doormenu( setDoorOwnerAccess, doorSettingsAccess )

	local eyetrace = LocalPlayer():GetEyeTrace()
	local ent = eyetrace.Entity
	local vehicle = ent:IsVehicle()

	if( !IsValid( ent ) or IsValid( frame ) or !ent:isKeysOwnable() or eyetrace.HitPos:DistToSqr( LocalPlayer():EyePos() ) > 20000 ) then return end
	
	frame = vgui.Create( 'DFrame' )
	frame.buttons = 0
	frame:MakePopup()
	frame:SetDraggable( false )
	frame:ShowCloseButton( false )
	frame:SetSize( indent * 2 + buttonsw, 40 )
	frame:Center()
	frame:SetTitle( '' )
	frame.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.doorsmenuclrs.backgroundclr )
		draw.RoundedBoxEx( 5, 0, 0, w, 30, glorioushud.settings.doorsmenuclrs.headclr, true, true, false, false )
		draw.SimpleText( glorioushud.localisationget( !vehicle and 'doorsettings' or 'vehiclesettings', glorioushud.settings.language ), 'glorioushud.font.playerhud', 8, 5, glorioushud.settings.doorsmenuclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	end

	local closebtn = vgui.Create( 'DButton', frame )
	closebtn.alpha = 0
	closebtn:SetSize( 24, 24 )
	closebtn:SetPos( ( indent * 2 + buttonsw ) - 27, 3 )
	closebtn:SetText( '' )
	closebtn.OnCursorEntered = function( self )
		self.alpha = 150
	end
	closebtn.OnCursorExited = function( self )
		self.alpha = 0
	end
	closebtn.Paint = function( self, w, h )
		draw.RoundedBox( 5, 0, 0, 24, 24, ColorAlpha( glorioushud.settings.doorsmenuclrs.buttonclr, self.alpha ) )
	end
	closebtn.DoClick = function()
		frame:Close()
	end

	local closeimg = vgui.Create( 'DImage', frame )
	closeimg:SetSize( 24, 24 )
	closeimg:SetPos( ( indent * 2 + buttonsw ) - 27, 3 )
	closeimg:SetImage( 'icons/x.png' )
	closeimg:SetImageColor( glorioushud.settings.doorsmenuclrs.iconsclr )

	if ( ent:isKeysOwnedBy( LocalPlayer() ) ) then
        
        addbutton( frame, glorioushud.localisationget( 'selldoor', glorioushud.settings.language ), 'sell', function() RunConsoleCommand( 'darkrp', 'toggleown' ) frame:Close() end)

        addbutton( frame, glorioushud.localisationget( 'adduser', glorioushud.settings.language ), 'user-plus', function()

            local menu = vgui.Create( 'GH_DMenu' )
            menu.found = false
            for _, v in pairs( DarkRP.nickSortedPlayers() ) do
                if( !ent:isKeysOwnedBy(v) and !ent:isKeysAllowedToOwn( v ) ) then
                    local steamID = v:SteamID()
                    menu.found = true
                    menu:AddOption( v:Nick(), function() RunConsoleCommand( 'darkrp', 'ao', steamID ) end)
                end
            end
            if( !menu.found ) then
                menu:AddOption( glorioushud.localisationget( 'noavailable', glorioushud.settings.language ), function() end)
            end
            menu:Open()

        end)

        local removeowner = addbutton( frame, glorioushud.localisationget( 'removeuser', glorioushud.settings.language ), 'user-x', function()

            local menu = vgui.Create( 'GH_DMenu' )
            for _, v in pairs( DarkRP.nickSortedPlayers() ) do
                if( ent:isKeysOwnedBy( v ) and !ent:isMasterOwner( v ) or ent:isKeysAllowedToOwn( v ) ) then
                    local steamID = v:SteamID()
                    menu.found = true
                    menu:AddOption( v:Nick(), function() RunConsoleCommand( 'darkrp', 'ro', steamID ) end)
                end
            end
            if( !menu.found ) then
                menu:AddOption( glorioushud.localisationget( 'noavailable', glorioushud.settings.language ), function() end)
            end
            menu:Open()

        end)

        if( !ent:isMasterOwner( LocalPlayer() ) ) then
            removeowner:SetDisabled(true)
        end

    end

    if( doorSettingsAccess ) then
        addbutton( frame, ent:getKeysNonOwnable() and glorioushud.localisationget( 'allow', glorioushud.settings.language ) or glorioushud.localisationget( 'disallow', glorioushud.settings.language ), ent:getKeysNonOwnable() and 'unlock' or 'lock24', function() frame:Close() RunConsoleCommand( 'darkrp', 'toggleownable' ) end)
    end

    if( doorSettingsAccess and ( ent:isKeysOwned() or ent:getKeysNonOwnable() or ent:getKeysDoorGroup() or hasTeams ) or ent:isKeysOwnedBy( LocalPlayer() ) ) then
        addbutton( frame, glorioushud.localisationget( !vehicle and 'settitle' or 'setvtitle', glorioushud.settings.language ), 'edit-2', function()

            titlemenu( vehicle, function( text )
                RunConsoleCommand( 'darkrp', 'title', text )
                if( IsValid( frame ) ) then
                    frame:Close()
                end
           	end)

        end)
    end

	if( not ent:isKeysOwned() and !ent:getKeysNonOwnable() and !ent:getKeysDoorGroup() and !ent:getKeysDoorTeams() or !ent:isKeysOwnedBy( LocalPlayer() ) and ent:isKeysAllowedToOwn( LocalPlayer() ) ) then
        addbutton( frame, glorioushud.localisationget( 'buydoor', glorioushud.settings.language ), 'buy', function() RunConsoleCommand( 'darkrp', 'toggleown' ) frame:Close() end )
    end

    if( doorSettingsAccess ) then

	    addbutton( frame, glorioushud.localisationget( 'editdoor', glorioushud.settings.language ), 'settings', function()

	        local menu = vgui.Create( 'GH_DMenu' )
	        local groups = menu:AddSubMenu( glorioushud.localisationget( 'doorgroups', glorioushud.settings.language ) )
	        local teams = menu:AddSubMenu( glorioushud.localisationget( 'jobs', glorioushud.settings.language ) )
	        local add = teams:AddSubMenu( glorioushud.localisationget( 'add', glorioushud.settings.language ) )
	        local remove = teams:AddSubMenu( glorioushud.localisationget( 'remove', glorioushud.settings.language ) )

	        menu:AddOption( glorioushud.localisationget( 'none', glorioushud.settings.language ), function()
	            RunConsoleCommand( 'darkrp', 'togglegroupownable' )
	            if IsValid( frame ) then frame:Close() end
	        end)

	        for k in pairs( RPExtraTeamDoors ) do
	            groups:AddOption( k, function()
		            RunConsoleCommand( 'darkrp', 'togglegroupownable', k )
		            if IsValid( frame ) then frame:Close() end
	            end)
	        end

	        local doorTeams = ent:getKeysDoorTeams()
	        for k, v in pairs( RPExtraTeams ) do
	            local which = ( not doorTeams or not doorTeams[k] ) and add or remove
	            which:AddOption( v.name, function()
	                RunConsoleCommand( 'darkrp', 'toggleteamownable', k )
	                if IsValid( frame ) then frame:Close() end
	            end)
	        end

	        menu:Open()

	    end)

	end

end

--Rewrite default function
hook.Add( 'Initialize', 'glorioushud.initialize', function()
	function DarkRP.openKeysMenu(um)
	    CAMI.PlayerHasAccess(LocalPlayer(), "DarkRP_SetDoorOwner", function(setDoorOwnerAccess)
	        CAMI.PlayerHasAccess(LocalPlayer(), "DarkRP_ChangeDoorSettings", fp{glorioushud.doormenu, setDoorOwnerAccess})
	    end)
	end
	usermessage.Hook( 'KeysMenu', DarkRP.openKeysMenu )
end)

local w, h
local x, y

local function updatesize()

	w, h = ScrW(), ScrH() 
	x, y = ScrW() / 2, ScrH() - 190

end

updatesize()

hook.Add( 'glorioushud.sizechanged', 'glorioushud.updatesize1', updatesize )

function glorioushud.drawvehicleinfo()

	if( !glorioushud.settings.enabled.vehicleinfo ) then return end

	local lp = LocalPlayer()
	local ent = lp:GetEyeTrace().Entity

	if( !IsValid( ent ) ) then return end
	if( !ent:IsVehicle() ) then return end
	if( lp:InVehicle() ) then return end
	if( lp:GetPos():Distance( ent:GetPos() ) > 200 ) then return end

	local owner = ent:getDoorOwner()
	local title = ent:getKeysTitle()
	local group = ent:getKeysDoorGroup()
	local allowed = ent:getKeysNonOwnable()
	local locked = ent:GetNWBool( 'm_bLocked' )

	local printTitle = ''
	local printOwner = ''

	if( allowed != nil ) then
		printTitle = 'Vehicle'
		if( title != nil ) then
			printTitle = title
		end
		printOwner = glorioushud.localisationget( 'cantbuy', glorioushud.settings.language )
	elseif( owner != nil ) then
		printTitle = 'Vehicle'
		if( title != nil ) then
			printTitle = title
		end
		printOwner = glorioushud.localisationget( 'owner', glorioushud.settings.language ) .. ' ' .. owner:GetName()
	elseif( group != nil ) then
		printTitle = 'Vehicle'
		if( title != nil ) then
			printTitle = title
		end
		printOwner = glorioushud.localisationget( 'owner', glorioushud.settings.language ) .. ' ' .. group
	else
		printTitle = 'Vehicle'
		printOwner = glorioushud.localisationget( 'forsale', glorioushud.settings.language )
	end

	surface.SetFont( 'glorioushud.font.playerhud' )
	local titlew = surface.GetTextSize( printTitle )
	surface.SetFont( 'glorioushud.font.playerhud' )
	local ownerw = surface.GetTextSize( printOwner )
	local totalw = 0

	if( ownerw > titlew ) then
		totalw = ownerw
	else
		totalw = titlew
	end

	totalw = totalw + 61

	draw.RoundedBox( 0, x - totalw / 2, y, totalw, 75, glorioushud.settings.vehicleindclrs.backgroundclr )

	draw.RoundedBox( 0, x - totalw / 2 + 5, y + 5, 30, 30, glorioushud.settings.vehicleindclrs.shapesclr )
	draw.RoundedBox( 0, x - totalw / 2 + 40, y + 5, totalw - 46, 30, glorioushud.settings.vehicleindclrs.shapesclr )
	draw.SimpleText( printTitle, 'glorioushud.font.playerhud', ( x - totalw / 2 + 40 ) + ( totalw - 45 ) / 2, y + 9, glorioushud.settings.vehicleindclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	draw.RoundedBox( 0, x - totalw / 2 + 5, y + 40, 30, 30, glorioushud.settings.vehicleindclrs.shapesclr )
	draw.RoundedBox( 0, x - totalw / 2 + 40, y + 40, totalw - 46, 30, glorioushud.settings.vehicleindclrs.shapesclr )
	draw.SimpleText( printOwner, 'glorioushud.font.playerhud', ( x - totalw / 2 + 40 ) + ( totalw - 45 ) / 2, y + 44, glorioushud.settings.vehicleindclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	if( locked ) then
		surface.SetDrawColor( glorioushud.settings.vehicleindclrs.iconsclr )
		surface.SetMaterial( glorioushud.materials[ 'lock' ] )
		surface.DrawTexturedRect( x - totalw / 2 + 8, y + 8, 24, 24 )
	else
		surface.SetDrawColor( glorioushud.settings.vehicleindclrs.iconsclr )
		surface.SetMaterial( glorioushud.materials[ 'unlock24' ] )
		surface.DrawTexturedRect( x - totalw / 2 + 8, y + 8, 24, 24 )
	end

	surface.SetDrawColor( glorioushud.settings.vehicleindclrs.iconsclr )
	surface.SetMaterial( glorioushud.materials[ 'user' ] )
	surface.DrawTexturedRect( x - totalw / 2 + 8, y + 43, 24, 24 )

end

hook.Add( 'HUDPaint', 'glorioushud.drawvehicleinfo', glorioushud.drawvehicleinfo )