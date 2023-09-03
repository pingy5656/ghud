local function add_checkbox( panel, text, value )

	local pnl = vgui.Create( 'DPanel', panel )
	pnl:SetSize( 380, 34 )
	pnl:SetPos( 0, panel.height )
	pnl.Paint = function( self, w, h )
		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.settingsmenuclrs.shapesclr )
	end

	local checkbox = vgui.Create( 'GH_DCheckBoxLabel', panel )
	checkbox:SetPos( 5, panel.height + 5 )
	checkbox:SetText( text )
	checkbox:SetValue( value )

	panel.height = panel.height + 44
	return checkbox

end

local function add_combobox( panel, text, value )

	local pnl = vgui.Create( 'DPanel', panel )
	pnl:SetSize( 380, 59 )
	pnl:SetPos( 0, panel.height )
	pnl.Paint = function( self, w, h )
		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.settingsmenuclrs.shapesclr )
		draw.SimpleText( text, 'glorioushud.font.playerhud', 8, 4, glorioushud.settings.settingsmenuclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	end

	local combobox = vgui.Create( 'GH_DComboBox', panel )
	combobox:SetPos( 5, panel.height + 30 )
	combobox:SetSize( 370, 24 )
	combobox:SetText( value )
	combobox:SetValue( value )

	panel.height = panel.height + 69
	return combobox

end

local function add_slider( panel, title, text )

	local pnl = vgui.Create( 'DPanel', panel )
	pnl:SetSize( 380, 59 )
	pnl:SetPos( 0, panel.height )
	pnl.Paint = function( self, w, h )
		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.settingsmenuclrs.shapesclr )
		draw.SimpleText( title, 'glorioushud.font.playerhud', 8, 4, glorioushud.settings.settingsmenuclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	end

	local slider = vgui.Create( 'GH_DNumSlider', panel )
	slider:SetPos( 8, panel.height + 25 )
	slider:SetText( text )
	slider:SetWide( 380 )

	panel.height = panel.height + 69
	return slider

end

local function savesettings()

	local json = util.TableToJSON( glorioushud.settings )
	file.Write( 'gh_settings.txt', json )

	hook.Call( 'glorioushud.settings_apply' )

end

local function chatmessage( text )

	chat.AddText( Color( 0, 122, 209 ), '[', Color( 0, 160, 240 ), 'GloriousHUD', Color( 0, 122, 209 ), '] ', Color( 255, 255, 255 ), text )

end

local tframe

local function openclosemenu( frame )

	if( IsValid( tframe ) ) then return end
	tframe = vgui.Create( 'DFrame' )
	tframe:MakePopup()
	tframe:DoModal()
	tframe:SetDraggable( false )
	tframe:ShowCloseButton( false )
	tframe:SetSize( 400, 115 )
	tframe:Center()
	tframe:SetTitle( '' )
	tframe.Paint = function( self, w, h )

		Derma_DrawBackgroundBlur( self, 5 )
		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.closemenuclrs.backgroundclr )
		draw.RoundedBoxEx( 5, 0, 0, w, 30, glorioushud.settings.closemenuclrs.headclr, true, true, false, false )
		draw.SimpleText( glorioushud.localisationget( 'confirmtitle', glorioushud.settings.language ), 'glorioushud.font.playerhud', 8, 5, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	end
	
	local label = vgui.Create( 'DLabel', tframe )
	label:SetWide( 380 )
	label:SetFont( 'glorioushud.font.playerhud' )
	label:SetTextColor( glorioushud.settings.closemenuclrs.textclr )
	label:SetText( glorioushud.localisationget( 'savetext', glorioushud.settings.language ) )
	label:SetWrap( true )
	label:SetContentAlignment( 8 )
	label:SizeToContentsY()
	label:SetPos( 10, 34 )

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
		draw.RoundedBox( 5, 0, 0, 24, 24, ColorAlpha( glorioushud.settings.closemenuclrs.buttonclr, self.alpha ) )
	end
	closebtn.DoClick = function()
		tframe:Close()
	end

	local closeimg = vgui.Create( 'DImage', tframe )
	closeimg:SetSize( 24, 24 )
	closeimg:SetPos( 400 - 27, 3 )
	closeimg:SetImage( 'icons/x.png' )
	closeimg:SetImageColor( glorioushud.settings.closemenuclrs.iconsclr )

	local sbutton = vgui.Create( 'DButton', tframe )
	sbutton.alpha = 155
	sbutton:SetSize( 123, 25 )
	sbutton:SetPos( 10, 80 )
	sbutton:SetText( '' )
	sbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	sbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.closemenuclrs.buttonclr.a
	end
	sbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.closemenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'save', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h / 2 - 2, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	sbutton.DoClick = function()
		tframe:Close()
		savesettings()
		chatmessage( glorioushud.localisationget( 'saved', glorioushud.settings.language ) )
		if( !IsValid( frame ) ) then return end
		frame:Close()
	end

	local dsbutton = vgui.Create( 'DButton', tframe )
	dsbutton.alpha = 155
	dsbutton:SetSize( 123, 25 )
	dsbutton:SetPos( 138, 80 )
	dsbutton:SetText( '' )
	dsbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	dsbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.closemenuclrs.buttonclr.a
	end
	dsbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.closemenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'dsave', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h / 2 - 2, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	dsbutton.DoClick = function()
		tframe:Close()
		if( !IsValid( frame ) ) then return end
		frame:Close()	
	end

	local cbutton = vgui.Create( 'DButton', tframe )
	cbutton.alpha = 155
	cbutton:SetSize( 123, 25 )
	cbutton:SetPos( 266, 80 )
	cbutton:SetText( '' )
	cbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	cbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.closemenuclrs.buttonclr.a
	end
	cbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.closemenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'cancel', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h / 2 - 2, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	cbutton.DoClick = function()
		tframe:Close()
	end

end

local rframe

local function openresetmenu( frame )

	if( IsValid( rframe ) ) then return end
	rframe = vgui.Create( 'DFrame' )
	rframe:MakePopup()
	rframe:DoModal()
	rframe:SetDraggable( false )
	rframe:ShowCloseButton( false )
	rframe:SetSize( 400, 115 )
	rframe:Center()
	rframe:SetTitle( '' )
	rframe.Paint = function( self, w, h )

		Derma_DrawBackgroundBlur( self, 5 )
		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.closemenuclrs.backgroundclr )
		draw.RoundedBoxEx( 5, 0, 0, w, 30, glorioushud.settings.closemenuclrs.headclr, true, true, false, false )
		draw.SimpleText( glorioushud.localisationget( 'confirmtitle', glorioushud.settings.language ), 'glorioushud.font.playerhud', 8, 5, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	end
	
	local label = vgui.Create( 'DLabel', rframe )
	label:SetWide( 380 )
	label:SetFont( 'glorioushud.font.playerhud' )
	label:SetTextColor( glorioushud.settings.closemenuclrs.textclr )
	label:SetText( glorioushud.localisationget( 'settings_resettext', glorioushud.settings.language ) )
	label:SetWrap( true )
	label:SetContentAlignment( 8 )
	label:SizeToContentsY()
	label:SetPos( 10, 34 )

	local closebtn = vgui.Create( 'DButton', rframe )
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
		draw.RoundedBox( 5, 0, 0, 24, 24, ColorAlpha( glorioushud.settings.closemenuclrs.buttonclr, self.alpha ) )
	end
	closebtn.DoClick = function()
		rframe:Close()
	end

	local closeimg = vgui.Create( 'DImage', rframe )
	closeimg:SetSize( 24, 24 )
	closeimg:SetPos( 400 - 27, 3 )
	closeimg:SetImage( 'icons/x.png' )
	closeimg:SetImageColor( glorioushud.settings.closemenuclrs.iconsclr )

	local rbutton = vgui.Create( 'DButton', rframe )
	rbutton.alpha = 155
	rbutton:SetSize( 187.5, 25 )
	rbutton:SetPos( 10, 80 )
	rbutton:SetText( '' )
	rbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	rbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.closemenuclrs.buttonclr.a
	end
	rbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.closemenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'reset', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h / 2 - 2, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	rbutton.DoClick = function()
		rframe:Close()
		glorioushud.resetdefaults()
		chatmessage( glorioushud.localisationget( 'reseted', glorioushud.settings.language ) )
		if( !IsValid( frame ) ) then return end
		frame:Close()
	end

	local cbutton = vgui.Create( 'DButton', rframe )
	cbutton.alpha = 155
	cbutton:SetSize( 187.5, 25 )
	cbutton:SetPos( 202.5, 80 )
	cbutton:SetText( '' )
	cbutton.OnCursorEntered = function( self )
		self.alpha = 255
	end
	cbutton.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.closemenuclrs.buttonclr.a
	end
	cbutton.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.closemenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'cancel', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h / 2 - 2, glorioushud.settings.closemenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	cbutton.DoClick = function()
		rframe:Close()	
	end

end

local frame

local function opensettings()

	if( IsValid( frame ) ) then return end
	frame = vgui.Create( 'DFrame' )
	frame:MakePopup()
	frame:SetDraggable( false )
	frame:ShowCloseButton( false )
	frame:SetSize( 400, 635 )
	frame:Center()
	frame:SetTitle( '' )
	frame.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, glorioushud.settings.settingsmenuclrs.backgroundclr )
		draw.RoundedBoxEx( 5, 0, 0, w, 30, glorioushud.settings.settingsmenuclrs.headclr, true, true, false, false )
		draw.SimpleText( glorioushud.localisationget( 'settings_title', glorioushud.settings.language ), 'glorioushud.font.playerhud', 8, 5, glorioushud.settings.gesturesclrs.textclr, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	end

	local closebtn = vgui.Create( 'DButton', frame )
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
		draw.RoundedBox( 5, 0, 0, 24, 24, ColorAlpha( glorioushud.settings.settingsmenuclrs.buttonclr, self.alpha ) )
	end
	closebtn.DoClick = function()
		openclosemenu( frame )
	end

	local closeimg = vgui.Create( 'DImage', frame )
	closeimg:SetSize( 24, 24 )
	closeimg:SetPos( 400 - 27, 3 )
	closeimg:SetImage( 'icons/x.png' )
	closeimg:SetImageColor( glorioushud.settings.settingsmenuclrs.iconsclr )

	local savebtn = vgui.Create( 'DButton', frame )
	savebtn.alpha = glorioushud.settings.settingsmenuclrs.buttonclr.a
	savebtn:SetSize( 380, 30 )
	savebtn:SetPos( 10, 560 )
	savebtn:SetText( '' )
	savebtn.OnCursorEntered = function( self )
		self.alpha = 255
	end
	savebtn.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.settingsmenuclrs.buttonclr.a
	end
	savebtn.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.settingsmenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'settings_savebutton', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, 4, glorioushud.settings.settingsmenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	end
	savebtn.DoClick = function()

		savesettings()
		frame:Close()
		chatmessage( glorioushud.localisationget( 'saved', glorioushud.settings.language ) )
		if( !IsValid( tframe ) ) then return end
		tframe:Close()

	end

	local resetbtn = vgui.Create( 'DButton', frame )
	resetbtn.alpha = glorioushud.settings.settingsmenuclrs.buttonclr.a
	resetbtn:SetSize( 380, 30 )
	resetbtn:SetPos( 10, 595 )
	resetbtn:SetText( '' )
	resetbtn.OnCursorEntered = function( self )
		self.alpha = 255
	end
	resetbtn.OnCursorExited = function( self )
		self.alpha = glorioushud.settings.settingsmenuclrs.buttonclr.a
	end
	resetbtn.Paint = function( self, w, h )

		draw.RoundedBox( 5, 0, 0, w, h, ColorAlpha( glorioushud.settings.settingsmenuclrs.buttonclr, self.alpha ) )
		draw.SimpleText( glorioushud.localisationget( 'settings_resetbutton', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, 4, glorioushud.settings.settingsmenuclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	end
	resetbtn.DoClick = function()
		openresetmenu( frame )
	end

	local scroll = vgui.Create( 'GH_DScrollPanel', frame )
	scroll:SetSize( 390, 510 )
	scroll:SetPos( 10, 40 )
	scroll.height = 0
	
	local theme = add_combobox( scroll, glorioushud.localisationget( 'theme', glorioushud.settings.language ), glorioushud.localisationget( glorioushud.settings.theme, glorioushud.settings.language ) )
	theme:AddChoice( glorioushud.localisationget( 'darktheme', glorioushud.settings.language ), 'theme_dark' )
	theme:AddChoice( glorioushud.localisationget( 'whitetheme', glorioushud.settings.language ), 'theme_white' )
	theme.OnSelect = function( index, value, data )
		
		if( data == glorioushud.localisationget( 'darktheme', glorioushud.settings.language ) ) then

			glorioushud.settings.playerhudclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.playerhudclrs.headclr = Color( 40, 40, 40, 240 )
			glorioushud.settings.playerhudclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.playerhudclrs.hpclr = Color( 255, 84, 54, 200 )
			glorioushud.settings.playerhudclrs.hpbgclr = Color( 255, 84, 54, 100 )
			glorioushud.settings.playerhudclrs.armorclr = Color( 80, 19, 255, 200 )
			glorioushud.settings.playerhudclrs.armorbgclr = Color( 80, 19, 255, 100 )
			glorioushud.settings.playerhudclrs.foodclr = Color( 255, 184, 77, 200 )
			glorioushud.settings.playerhudclrs.foodbgclr = Color( 255, 184, 77, 100 )
			glorioushud.settings.playerhudclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.playerhudclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.playerhudclrs.nolicenseiconclr = Color( 60, 60, 60, 255 )
			glorioushud.settings.levelhudclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.levelhudclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.levelhudclrs.levelclr = Color( 255, 184, 77, 200 )
			glorioushud.settings.levelhudclrs.levelbgclr = Color( 255, 184, 77, 100 )
			glorioushud.settings.levelhudclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.levelhudclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.staminahudclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.staminahudclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.staminahudclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.staminahudclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.staminahudclrs.staminaclr = Color( 255, 184, 77, 200 )
			glorioushud.settings.staminahudclrs.staminabgclr = Color( 255, 184, 77, 100 )
			glorioushud.settings.overheadclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.overheadclrs.licensetextclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.overheadclrs.shapeclr = Color( 40, 40, 40, 230 )
			glorioushud.settings.overheadclrs.iconclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.overheadclrs.wantedclr = Color( 255, 84, 54, 255 )
			glorioushud.settings.overheadclrs.outlineclr = Color( 255, 255, 255, 150 )
			glorioushud.settings.voteclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.voteclrs.timeclr = Color( 0, 211, 0, 255 )
			glorioushud.settings.voteclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.voteclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.voteclrs.btnclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.notifyclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.notifyclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.notifyclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.notifyclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.notifyclrs.progressbarclr = Color( 0, 211, 0, 255 )
			glorioushud.settings.weaponhudclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.weaponhudclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.weaponhudclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.weaponhudclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.weaponhudclrs.propsclr = Color( 255, 184, 77, 200 )
			glorioushud.settings.weaponhudclrs.propsbgclr = Color( 255, 184, 77, 100 )
			glorioushud.settings.agendaclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.agendaclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.agendaclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.agendaclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.arrestclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.arrestclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.arrestclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.arrestclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.lockdownclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.lockdownclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.lockdownclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.lockdownclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.wantedclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.wantedclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.wantedclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.wantedclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.doorsclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.doorsmenuclrs.backgroundclr = Color( 50, 50, 50, 255 )
			glorioushud.settings.doorsmenuclrs.headclr = Color( 60, 60, 60, 255 )
			glorioushud.settings.doorsmenuclrs.buttonclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.doorsmenuclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.doorsmenuclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.newsclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.newsclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.newsclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.newsclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.gesturesclrs.backgroundclr = Color( 50, 50, 50, 255 )
			glorioushud.settings.gesturesclrs.headclr = Color( 60, 60, 60, 255 )
			glorioushud.settings.gesturesclrs.buttonclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.gesturesclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.gesturesclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.timeoutclrs.backgroundclr = Color( 40, 40, 40, 180 )
			glorioushud.settings.timeoutclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.timeoutclrs.discriptiontextclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.timeoutclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.timeoutclrs.buttonclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.pickupclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.pickupclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.pickupclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.pickupclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.vehicleclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.vehicleclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vehicleclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.vehicleclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.vehicleclrs.fuelclr = Color( 255, 184, 77, 200 )
			glorioushud.settings.vehicleclrs.fuelbgclr = Color( 255, 184, 77, 100 )
			glorioushud.settings.vehicleclrs.rpmclr = Color( 191, 199, 193, 100 )
			glorioushud.settings.vehicleclrs.rpmbgclr = Color( 161, 169, 163, 100 )
			glorioushud.settings.vehicleclrs.officonclr = Color( 80, 80, 80, 255 )
			glorioushud.settings.vehicleclrs.handbrakeiconclr = Color( 255, 84, 54, 200 )
			glorioushud.settings.vehicleclrs.cruiseiconclr = Color( 72, 201, 84, 200 )
			glorioushud.settings.vehicleclrs.foglightsiconclr = Color( 219, 141, 15, 200 ) 
			glorioushud.settings.vehicleclrs.lighticonclr = Color( 88, 166, 0, 200 )
			glorioushud.settings.vehicleclrs.lampsiconclr = Color( 0, 157, 241, 200 )
			glorioushud.settings.vehicleclrs.brokeniconclr = Color( 255, 84, 54, 200 )
			glorioushud.settings.vehicleindclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.vehicleindclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vehicleindclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.vehicleindclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.settingsmenuclrs.backgroundclr = Color( 50, 50, 50, 255 )
			glorioushud.settings.settingsmenuclrs.headclr = Color( 60, 60, 60, 255 )
			glorioushud.settings.settingsmenuclrs.buttonclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.settingsmenuclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.settingsmenuclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.settingsmenuclrs.shapesclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.vguiclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.vguiclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.vguiclrs.backgroundclr = Color( 50, 50, 50, 255 )
			glorioushud.settings.vguiclrs.cornerclr = Color( 0, 122, 209, 255 )
			glorioushud.settings.vguiclrs.hoverclr = Color( 2, 99, 168, 255 )
			glorioushud.settings.vguiclrs.dmenuhover = Color( 30, 30, 30, 0 )
			glorioushud.settings.vguiclrs.sliderleft = Color( 0, 122, 209, 255 )
			glorioushud.settings.vguiclrs.sliderright = Color( 50, 50, 50, 255 )
			glorioushud.settings.vguiclrs.sliderpoint = Color( 0, 122, 209, 255 )
			glorioushud.settings.vguiclrs.sliderhover = Color( 2, 99, 168, 255 )
			glorioushud.settings.vguiclrs.checkboxhover = Color( 60, 60, 60, 255 )
			glorioushud.settings.vguiclrs.shapeclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.vguiclrs.scrollhover = Color( 60, 60, 60, 255 )
			glorioushud.settings.titlemenuclrs.backgroundclr = Color( 50, 50, 50, 255 )
			glorioushud.settings.titlemenuclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.titlemenuclrs.headclr = Color( 60, 60, 60, 255 )
			glorioushud.settings.titlemenuclrs.buttonclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.titlemenuclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.titlemenuclrs.cursorclr = Color( 0, 122, 209, 255 )
			glorioushud.settings.titlemenuclrs.entrybgclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.titlemenuclrs.highlightclr = Color( 0, 122, 209, 150 )
			glorioushud.settings.medkitclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.medkitclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.medkitclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.medkitclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.medkitclrs.hpclr = Color( 255, 84, 54, 200 )
			glorioushud.settings.medkitclrs.hpbgclr = Color( 255, 84, 54, 100 )
			glorioushud.settings.closemenuclrs.backgroundclr = Color( 50, 50, 50, 255 )
			glorioushud.settings.closemenuclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.closemenuclrs.headclr = Color( 60, 60, 60, 255 )
			glorioushud.settings.closemenuclrs.buttonclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.closemenuclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.voicenotifyclrs.backgroundclr = Color( 40, 40, 40, 170 )
			glorioushud.settings.voicenotifyclrs.shapesclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.voicenotifyclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.theme = 'darktheme'

		end

		if( data == glorioushud.localisationget( 'whitetheme', glorioushud.settings.language ) ) then

			glorioushud.settings.playerhudclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.playerhudclrs.headclr = Color( 40, 40, 40, 240 )
			glorioushud.settings.playerhudclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.playerhudclrs.hpclr = Color( 230, 72, 45, 230 )
			glorioushud.settings.playerhudclrs.hpbgclr = Color( 230, 72, 45, 130 )
			glorioushud.settings.playerhudclrs.armorclr = Color( 149, 105, 255, 220 )
			glorioushud.settings.playerhudclrs.armorbgclr = Color( 149, 105, 255, 130 )
			glorioushud.settings.playerhudclrs.foodclr = Color( 255, 153, 0, 230 )
			glorioushud.settings.playerhudclrs.foodbgclr = Color( 255, 153, 0, 130 )
			glorioushud.settings.playerhudclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.playerhudclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.playerhudclrs.nolicenseiconclr = Color( 190, 190, 190, 255 )
			glorioushud.settings.levelhudclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.levelhudclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.levelhudclrs.levelclr = Color( 255, 153, 0, 230 )
			glorioushud.settings.levelhudclrs.levelbgclr = Color( 255, 153, 0, 130 )
			glorioushud.settings.levelhudclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.levelhudclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.staminahudclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.staminahudclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.staminahudclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.staminahudclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.staminahudclrs.staminaclr = Color( 255, 153, 0, 230 )
			glorioushud.settings.staminahudclrs.staminabgclr = Color( 255, 153, 0, 130 )
			glorioushud.settings.overheadclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.overheadclrs.licensetextclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.overheadclrs.shapeclr = Color( 200, 200, 200, 230 )
			glorioushud.settings.overheadclrs.iconclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.overheadclrs.wantedclr = Color( 255, 84, 54, 255 )
			glorioushud.settings.overheadclrs.outlineclr = Color( 255, 255, 255, 150 )
			glorioushud.settings.voteclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.voteclrs.timeclr = Color( 0, 211, 0, 255 )
			glorioushud.settings.voteclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.voteclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.voteclrs.btnclr = Color( 150, 150, 150, 255 )
			glorioushud.settings.notifyclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.notifyclrs.shapesclr =Color( 200, 200, 200, 255 )
			glorioushud.settings.notifyclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.notifyclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.notifyclrs.progressbarclr = Color( 0, 211, 0, 255 )
			glorioushud.settings.weaponhudclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.weaponhudclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.weaponhudclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.weaponhudclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.weaponhudclrs.propsclr = Color( 255, 153, 0, 230 )
			glorioushud.settings.weaponhudclrs.propsbgclr = Color( 255, 153, 0, 130 )
			glorioushud.settings.agendaclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.agendaclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.agendaclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.agendaclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.arrestclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.arrestclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.arrestclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.arrestclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.lockdownclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.lockdownclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.lockdownclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.lockdownclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.wantedclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.wantedclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.wantedclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.wantedclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.doorsclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.doorsmenuclrs.backgroundclr = Color( 190, 190, 190, 255 )
			glorioushud.settings.doorsmenuclrs.headclr = Color( 170, 170, 170, 255 )
			glorioushud.settings.doorsmenuclrs.buttonclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.doorsmenuclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.doorsmenuclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.newsclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.newsclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.newsclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.newsclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.gesturesclrs.backgroundclr = Color( 190, 190, 190, 255 )
			glorioushud.settings.gesturesclrs.headclr = Color( 170, 170, 170, 255 )
			glorioushud.settings.gesturesclrs.buttonclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.gesturesclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.gesturesclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.timeoutclrs.backgroundclr = Color( 40, 40, 40, 180 )
			glorioushud.settings.timeoutclrs.textclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.timeoutclrs.discriptiontextclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.timeoutclrs.iconsclr = Color( 255, 255, 255, 255 )
			glorioushud.settings.timeoutclrs.buttonclr = Color( 30, 30, 30, 150 )
			glorioushud.settings.pickupclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.pickupclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.pickupclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.pickupclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vehicleclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.vehicleclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.vehicleclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vehicleclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vehicleclrs.fuelclr = Color( 255, 153, 0, 230 )
			glorioushud.settings.vehicleclrs.fuelbgclr = Color( 255, 153, 0, 130 )
			glorioushud.settings.vehicleclrs.rpmclr = Color( 99, 107, 101, 100 )
			glorioushud.settings.vehicleclrs.rpmbgclr = Color( 68, 75, 70, 100 )
			glorioushud.settings.vehicleclrs.officonclr = Color( 120, 120, 120, 255 )
			glorioushud.settings.vehicleclrs.handbrakeiconclr = Color( 230, 72, 45, 255 )
			glorioushud.settings.vehicleclrs.cruiseiconclr = Color( 0, 175, 39, 255 )
			glorioushud.settings.vehicleclrs.foglightsiconclr = Color( 209, 116, 6, 255 ) 
			glorioushud.settings.vehicleclrs.lighticonclr = Color( 3, 112, 0, 255 )
			glorioushud.settings.vehicleclrs.lampsiconclr = Color( 7, 120, 200, 255 )
			glorioushud.settings.vehicleclrs.brokeniconclr = Color( 230, 72, 45, 255 )
			glorioushud.settings.vehicleindclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.vehicleindclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.vehicleindclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vehicleindclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.settingsmenuclrs.backgroundclr = Color( 190, 190, 190, 255 )
			glorioushud.settings.settingsmenuclrs.headclr = Color( 170, 170, 170, 255 )
			glorioushud.settings.settingsmenuclrs.buttonclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.settingsmenuclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.settingsmenuclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.settingsmenuclrs.shapesclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.vguiclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vguiclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.vguiclrs.backgroundclr = Color( 190, 190, 190, 255 )
			glorioushud.settings.vguiclrs.cornerclr = Color( 0, 122, 209, 255 )
			glorioushud.settings.vguiclrs.hoverclr = Color( 2, 99, 168, 255 )
			glorioushud.settings.vguiclrs.dmenuhover = Color( 30, 30, 30, 0 )
			glorioushud.settings.vguiclrs.sliderleft = Color( 0, 122, 209, 255 )
			glorioushud.settings.vguiclrs.sliderright = Color( 190, 190, 190, 255 )
			glorioushud.settings.vguiclrs.sliderpoint = Color( 0, 122, 209, 255 )
			glorioushud.settings.vguiclrs.sliderhover = Color( 2, 99, 168, 255 )
			glorioushud.settings.vguiclrs.checkboxhover = Color( 140, 140, 140, 150 )
			glorioushud.settings.vguiclrs.shapeclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.vguiclrs.scrollhover = Color( 170, 170, 170, 255 )
			glorioushud.settings.titlemenuclrs.backgroundclr = Color( 190, 190, 190, 255 )
			glorioushud.settings.titlemenuclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.titlemenuclrs.headclr = Color( 170, 170, 170, 255 )
			glorioushud.settings.titlemenuclrs.buttonclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.titlemenuclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.titlemenuclrs.cursorclr = Color( 0, 122, 209, 255 )
			glorioushud.settings.titlemenuclrs.entrybgclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.titlemenuclrs.highlightclr = Color( 0, 122, 209, 150 )
			glorioushud.settings.medkitclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.medkitclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.medkitclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.medkitclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.medkitclrs.hpclr = Color( 230, 72, 45, 230 )
			glorioushud.settings.medkitclrs.hpbgclr = Color( 230, 72, 45, 130 )
			glorioushud.settings.closemenuclrs.backgroundclr = Color( 190, 190, 190, 255 )
			glorioushud.settings.closemenuclrs.iconsclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.closemenuclrs.headclr = Color( 170, 170, 170, 255 )
			glorioushud.settings.closemenuclrs.buttonclr = Color( 140, 140, 140, 150 )
			glorioushud.settings.closemenuclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.voicenotifyclrs.backgroundclr = Color( 200, 200, 200, 150 )
			glorioushud.settings.voicenotifyclrs.shapesclr = Color( 200, 200, 200, 255 )
			glorioushud.settings.voicenotifyclrs.textclr = Color( 40, 40, 40, 255 )
			glorioushud.settings.theme = 'whitetheme'

		end

	end

	local lang = add_combobox( scroll, glorioushud.localisationget( 't_lang', glorioushud.settings.language ), glorioushud.locales[ glorioushud.settings.language ].lang )
	for i, v in pairs( glorioushud.locales ) do
		
		lang:AddChoice( v.lang, v.langid )

	end
	lang.OnSelect = function( self )

		local a, b = self:GetSelected()
		glorioushud.settings.language = b

	end
	
	local drawrange = add_slider( scroll, glorioushud.localisationget( 'drawrange', glorioushud.settings.language ), glorioushud.localisationget( 'range', glorioushud.settings.language ) )
	drawrange:SetMin( 100 )
	drawrange:SetMax( 1000 )
	drawrange:SetDecimals( 0 )
	drawrange:SetValue( glorioushud.settings.showrange )
	drawrange.OnValueChanged = function()
 		glorioushud.settings.showrange = drawrange:GetValue()
	end

	local ohscale = add_slider( scroll, glorioushud.localisationget( 't_scale', glorioushud.settings.language ), glorioushud.localisationget( 'scale', glorioushud.settings.language ) )
	ohscale:SetMin( 1 )
	ohscale:SetMax( 10 )
	ohscale:SetDecimals( 0 )
	ohscale:SetValue( math.floor( math.Remap( glorioushud.settings.overheadscale, 0.05, 0.15, 1, 10 ) ) )
	ohscale.OnValueChanged = function()
 		glorioushud.settings.overheadscale = math.Remap( ohscale:GetValue(), 1, 10, 0.05, 0.15 )
	end

	local overhead = add_checkbox( scroll, glorioushud.localisationget( 'enableoverhead', glorioushud.settings.language ), glorioushud.settings.enabled.overhead )
	overhead.OnChange = function( self, value )
		glorioushud.settings.enabled.overhead = value
	end

	local animspeed = add_slider( scroll, glorioushud.localisationget( 'animspeed', glorioushud.settings.language ), glorioushud.localisationget( 'speed', glorioushud.settings.language ) )
	animspeed:SetMin( 1 )
	animspeed:SetMax( 3 )
	animspeed:SetDecimals( 0 )
	animspeed:SetValue( glorioushud.settings.animationspeed )
	animspeed.OnValueChanged = function()
 		glorioushud.settings.animationspeed = animspeed:GetValue()
	end

	local anim = add_checkbox( scroll, glorioushud.localisationget( 'anim', glorioushud.settings.language ), glorioushud.settings.animationenabled )
	anim.OnChange = function( self, value )
		glorioushud.settings.animationenabled = value
	end

	if( LevelSystemConfiguration ) then

		local leveltime = add_slider( scroll, glorioushud.localisationget( 'leveltime', glorioushud.settings.language ), glorioushud.localisationget( 'time', glorioushud.settings.language ) )
		leveltime:SetMin( 3 )
		leveltime:SetMax( 10 )
		leveltime:SetDecimals( 0 )
		leveltime:SetValue( glorioushud.settings.leveltime )
		leveltime.OnValueChanged = function()
	 		glorioushud.settings.leveltime = leveltime:GetValue()
		end

		local levelalways = add_checkbox( scroll, glorioushud.localisationget( 'levelalways', glorioushud.settings.language ), glorioushud.settings.levelalways )
		levelalways.OnChange = function( self, value )
			glorioushud.settings.levelalways = value
		end

		local level = add_checkbox( scroll, glorioushud.localisationget( 'enablelevel', glorioushud.settings.language ), glorioushud.settings.enabled.level )
		level.OnChange = function( self, value )
			glorioushud.settings.enabled.level = value
		end

	end

	if( SS ) then

		local stamina = add_checkbox( scroll, glorioushud.localisationget( 'enablestamina', glorioushud.settings.language ), glorioushud.settings.enabled.stamina )
		stamina.OnChange = function( self, value )
			glorioushud.settings.enabled.stamina = value
		end

	end

	local model = add_checkbox( scroll, glorioushud.localisationget( 'model', glorioushud.settings.language ), glorioushud.settings.model )
	model.OnChange = function( self, value )
		glorioushud.settings.model = value
		if( !value ) then glorioushud.avatar() else glorioushud.model() end
	end

	local speedvalue = add_checkbox( scroll, glorioushud.localisationget( 'speedunit', glorioushud.settings.language ), glorioushud.settings.kmh )
	speedvalue.OnChange = function( self, value )
		glorioushud.settings.kmh = value
	end

	local voicebar = add_checkbox( scroll, glorioushud.localisationget( 'enablevoicebar', glorioushud.settings.language ), glorioushud.settings.voicebar )
	voicebar.OnChange = function( self, value )
		glorioushud.settings.voicebar = value
	end

	local voicecolor = add_checkbox( scroll, glorioushud.localisationget( 'enablevoicecolor', glorioushud.settings.language ), glorioushud.settings.voicecolor )
	voicecolor.OnChange = function( self, value )
		glorioushud.settings.voicecolor = value
	end

	local barnames = add_checkbox( scroll, glorioushud.localisationget( 'showbarnames', glorioushud.settings.language ), glorioushud.settings.barnames )
	barnames.OnChange = function( self, value )
		glorioushud.settings.barnames = value
	end

	local hud = add_checkbox( scroll, glorioushud.localisationget( 'enablehud', glorioushud.settings.language ), glorioushud.settings.enabled.hud )
	hud.OnChange = function( self, value )
		glorioushud.settings.enabled.hud = value
	end

	local votes = add_checkbox( scroll, glorioushud.localisationget( 'enablevotes', glorioushud.settings.language ), glorioushud.settings.enabled.votes )
	votes.OnChange = function( self, value )
		glorioushud.settings.enabled.votes = value
	end

	local agenda = add_checkbox( scroll, glorioushud.localisationget( 'enableagenda', glorioushud.settings.language ), glorioushud.settings.enabled.agenda )
	agenda.OnChange = function( self, value )
		glorioushud.settings.enabled.agenda = value
	end

	local arrest = add_checkbox( scroll, glorioushud.localisationget( 'enablearrest', glorioushud.settings.language ), glorioushud.settings.enabled.arrest )
	arrest.OnChange = function( self, value )
		glorioushud.settings.enabled.arrest = value
	end

	local lockdown = add_checkbox( scroll, glorioushud.localisationget( 'enablelockdown', glorioushud.settings.language ), glorioushud.settings.enabled.lockdown )
	lockdown.OnChange = function( self, value )
		glorioushud.settings.enabled.lockdown = value
	end

	local wanted = add_checkbox( scroll, glorioushud.localisationget( 'enablewanted', glorioushud.settings.language ), glorioushud.settings.enabled.wanted )
	wanted.OnChange = function( self, value )
		glorioushud.settings.enabled.wanted = value
	end

	local pickup = add_checkbox( scroll, glorioushud.localisationget( 'enablepickup', glorioushud.settings.language ), glorioushud.settings.enabled.pickup )
	pickup.OnChange = function( self, value )
		glorioushud.settings.enabled.pickup = value
	end

	local doors = add_checkbox( scroll, glorioushud.localisationget( 'enabledoors', glorioushud.settings.language ), glorioushud.settings.enabled.doors )
	doors.OnChange = function( self, value )
		glorioushud.settings.enabled.doors = value
	end

	local vehicle = add_checkbox( scroll, glorioushud.localisationget( 'enablevehicle', glorioushud.settings.language ), glorioushud.settings.enabled.vehicle )
	vehicle.OnChange = function( self, value )
		glorioushud.settings.enabled.vehicle = value
	end

	local timeout = add_checkbox( scroll, glorioushud.localisationget( 'enabletimeout', glorioushud.settings.language ), glorioushud.settings.enabled.timeout )
	timeout.OnChange = function( self, value )
		glorioushud.settings.enabled.timeout = value
	end

	local news = add_checkbox( scroll, glorioushud.localisationget( 'enablenews', glorioushud.settings.language ), glorioushud.settings.enabled.news )
	news.OnChange = function( self, value )
		glorioushud.settings.enabled.news = value
	end

	local vehicleinfo = add_checkbox( scroll, glorioushud.localisationget( 'enablevehicleind', glorioushud.settings.language ), glorioushud.settings.enabled.vehicleinfo )
	vehicleinfo.OnChange = function( self, value )
		glorioushud.settings.enabled.vehicleinfo = value
	end

	local medkit = add_checkbox( scroll, glorioushud.localisationget( 'enablemedkit', glorioushud.settings.language ), glorioushud.settings.enabled.medkit )
	medkit.OnChange = function( self, value )
		glorioushud.settings.enabled.medkit = value
	end

end 

net.Receive( 'glorioushud.opensettings', function()

	opensettings()

end)

list.Set( 'DesktopWindows', 'glorioushud', {
	title = 'GloriousHUD',
	icon = 'icons/settings64.png',
	init = function()
		opensettings()
	end
} )

CreateClientConVar( 'gh_showoutdate', 1, true, false, 'Show HUD outdate alerts in chat, then you connect', 0, 1 )

local function outdate_query()

	net.Start( 'glorioushud.outdate_query' )
	net.SendToServer()

end

hook.Add( 'InitPostEntity', 'glorioushud.outdate_query', outdate_query )

local function outdate()

	if( GetConVar( 'gh_showoutdate' ):GetInt() == 0 ) then return end

	local latest, version = net.ReadString(), net.ReadString()

	chatmessage( glorioushud.localisationget( 'outdate', glorioushud.settings.language ) )
	print( '[GloriousHUD] ' .. glorioushud.localisationget( 'outdate', glorioushud.settings.language ) .. ' | Installed: ' .. version .. ' | Latest: ' .. latest )

end

net.Receive( 'glorioushud.outdate', outdate )