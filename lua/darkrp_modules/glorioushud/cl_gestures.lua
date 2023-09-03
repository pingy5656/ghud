local gestures = {}

local function loadgestures()

	gestures[ACT_GMOD_GESTURE_BOW] = glorioushud.localisationget( 'bow', glorioushud.settings.language )
    gestures[ACT_GMOD_TAUNT_MUSCLE] = glorioushud.localisationget( 'sexydance', glorioushud.settings.language )
    gestures[ACT_GMOD_GESTURE_BECON] = glorioushud.localisationget( 'followme', glorioushud.settings.language )
    gestures[ACT_GMOD_TAUNT_LAUGH] = glorioushud.localisationget( 'laugh', glorioushud.settings.language )
    gestures[ACT_GMOD_TAUNT_PERSISTENCE] = glorioushud.localisationget( 'lionpose', glorioushud.settings.language )
    gestures[ACT_GMOD_GESTURE_DISAGREE] = glorioushud.localisationget( 'nonverbalno', glorioushud.settings.language )
    gestures[ACT_GMOD_GESTURE_AGREE] = glorioushud.localisationget( 'thumbsup', glorioushud.settings.language )
    gestures[ACT_GMOD_GESTURE_WAVE] = glorioushud.localisationget( 'wave', glorioushud.settings.language )
    gestures[ACT_GMOD_TAUNT_DANCE] = glorioushud.localisationget( 'dance', glorioushud.settings.language )

end

hook.Add( 'loadCustomDarkRPItems', 'glorioushud.gestures', loadgestures )

local buttonsw, buttonsh, indent = 200, 30, 5

local frame

function glorioushud.gestures()

	if( !glorioushud.adminenabled.gestures ) then return end

	if( IsValid( frame ) ) then return end

	frame = vgui.Create( 'DFrame' )
	frame.buttons = 0
	frame:MakePopup()
	frame:SetDraggable( false )
	frame:ShowCloseButton( false )
	frame:SetSize( indent * 2 + buttonsw, 40 )
	frame:Center()
	frame:SetTitle( '' )
	frame.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.gesturesclrs.backgroundclr )
		draw.RoundedBoxEx( 5, 0, 0, w, 30, glorioushud.settings.gesturesclrs.headclr, true, true, false, false )
		draw.SimpleText( glorioushud.localisationget( 'gestures', glorioushud.settings.language ), 'glorioushud.font.playerhud', 8, 5, glorioushud.settings.gesturesclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

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
		draw.RoundedBox( 5, 0, 0, 24, 24, ColorAlpha( glorioushud.settings.gesturesclrs.buttonclr, self.alpha ) )
	end
	closebtn.DoClick = function()
		frame:Close()
	end

	local closeimg = vgui.Create( 'DImage', frame )
	closeimg:SetSize( 24, 24 )
	closeimg:SetPos( ( indent * 2 + buttonsw ) - 27, 3 )
	closeimg:SetImage( 'icons/x.png' )
	closeimg:SetImageColor( glorioushud.settings.gesturesclrs.iconsclr )

	local lasty = 0
	for i, v in SortedPairs( gestures ) do

		local button = vgui.Create( 'DButton', frame )
		button.alpha = glorioushud.settings.gesturesclrs.buttonclr.a
		button:SetSize( buttonsw, buttonsh )
		button:SetPos( 5, 35 + lasty )
		button:SetText( '' )
		button.OnCursorEntered = function( self )
			self.alpha = 255
		end
		button.OnCursorExited = function( self )
			self.alpha = glorioushud.settings.gesturesclrs.buttonclr.a
		end
		button.Paint = function( self, w, h )

			draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.gesturesclrs.buttonclr, self.alpha ) )
			draw.SimpleText( v, 'glorioushud.font.playerhud', 8, 4, glorioushud.settings.gesturesclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

		end
		button.DoClick = function()

			RunConsoleCommand( '_DarkRP_DoAnimation', i )
			frame:Close()

		end

		lasty = lasty + buttonsh + indent

	end

	frame:SetSize( indent * 2 + buttonsw, 35 + lasty )
	frame:Center()

end

concommand.Add( '_DarkRP_AnimationMenu', glorioushud.gestures )