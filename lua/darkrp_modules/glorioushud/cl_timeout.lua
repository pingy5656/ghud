local frame

local function timeout()
	
	local blur = Material( 'pp/blurscreen' )

	local w, h = ScrW(), ScrH()

	local start_time = SysTime()

	frame = vgui.Create( 'DFrame' )
	frame:SetAlpha( 0 )
	frame:SetSize( w, h )
	frame:Center()
	frame:MakePopup( true )
	frame:SetDraggable( false )
	frame:ShowCloseButton( false )
	frame:SetTitle( '' )
	frame:SetBackgroundBlur( true )
	frame:AlphaTo( 255, 0.1 )
	frame.Paint = function( self, w, h )

		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.SetMaterial( blur )

		blur:SetFloat( '$blur', 3.0 )
		blur:Recompute()
		if render then render.UpdateScreenEffectTexture() end

		surface.DrawTexturedRect( 0, 0, w, h )

		draw.RoundedBox( 0, 0, 0, w, h, glorioushud.settings.timeoutclrs.backgroundclr )

		draw.SimpleText( glorioushud.localisationget( 'timeout_title', glorioushud.settings.language ), 'glorioushud.font.timeout45', w / 2, 250, glorioushud.settings.timeoutclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		draw.DrawText( glorioushud.localisationget( 'timeout_description', glorioushud.settings.language ), 'glorioushud.font.timeout35', w / 2, 320, glorioushud.settings.timeoutclrs.discriptiontextclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		draw.SimpleText( glorioushud.localisationget( 'timeout_autorc', glorioushud.settings.language ) .. math.Clamp( math.ceil( start_time + glorioushud.timeout - SysTime() ), 1, glorioushud.timeout ) .. glorioushud.localisationget( 'timeout_seconds', glorioushud.settings.language ), 'glorioushud.font.timeout30', w / 2, 410, glorioushud.settings.timeoutclrs.discriptiontextclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	frame.Think = function()

		if( start_time + glorioushud.timeout <= SysTime() ) then

			RunConsoleCommand( 'retry' )

		end

	end

	local image = vgui.Create( 'DImage', frame )
	image:SetSize( 100, 100 )
	image:SetPos( w / 2 - 50, 100 )
	image:SetImage( 'icons/wifi-off.png' )

	local rcbutton = vgui.Create( 'DButton', frame )
	rcbutton.alpha = 155
	rcbutton:SetSize( 200, 50 )
	rcbutton:SetPos( w / 2 - 250, 500 )
	rcbutton:SetText( '' )
	rcbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	rcbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.timeoutclrs.buttonclr.a
	end
	rcbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.timeoutclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'timeout_reconnect', glorioushud.settings.language ), 'glorioushud.font.timeout25', w / 2, h / 2 - 2, glorioushud.settings.timeoutclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	rcbutton.DoClick = function()
		RunConsoleCommand( 'retry' )
	end

	local dcbutton = vgui.Create( 'DButton', frame )
	dcbutton.alpha = 155
	dcbutton:SetSize( 200, 50 )
	dcbutton:SetPos( w / 2 + 50, 500 )
	dcbutton:SetText( '' )
	dcbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	dcbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.timeoutclrs.buttonclr.a
	end
	dcbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.timeoutclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'timeout_leave', glorioushud.settings.language ), 'glorioushud.font.timeout25', w / 2, h / 2 - 2, glorioushud.settings.timeoutclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	dcbutton.DoClick = function()
		RunConsoleCommand( 'disconnect' )
	end

end

local function checktimeout()

	local to = GetTimeoutInfo()

	if( to ) then
		if( IsValid( frame ) ) then return end
		timeout()
	else
		if( IsValid( frame ) ) then
			frame:AlphaTo( 0, 0.1, 0, function()
				frame:Close()
			end)
		end
	end

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_checktimeout', function()

	hook.Add( 'Think', 'glorioushud.checktimeout', checktimeout )

	if( !glorioushud.settings.enabled.timeout or !glorioushud.adminenabled.timeout ) then 
		hook.Remove( 'Think', 'glorioushud.checktimeout' )
	end

end)