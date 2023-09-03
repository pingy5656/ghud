--[[---------------------------------------------------------------------------------------------------------------------------
Disabling default DarkRP voting, I know what UMSG is deprecated. Just rewrite default!
Source: https://github.com/FPtje/DarkRP/blob/f9b4293c6a57d50df93ab16e3faf1b011dfc7206/gamemode/modules/voting/cl_voting.lua#L98
-----------------------------------------------------------------------------------------------------------------------------]] 
usermessage.Hook("DoVote", function()end)
-------------------------------------------------------------------------------------------------------------------------------

local votes = {}

local function addvote( vote_tbl )

	local function voteremove( vote_tbl )

		table.remove( votes, 1 )

		for i, v in pairs( votes ) do
		
			if( math.ceil( ( v.time + v.start_time ) - CurTime() ) < 1 ) then
				
				table.remove( votes, i ) 
					
			end

		end

		if( #votes != 0 ) then 
			addvote( votes[ 1 ] )
		end

	end

	local yes = glorioushud.localisationget( 'yes', glorioushud.settings.language )
	local no = glorioushud.localisationget( 'no', glorioushud.settings.language )

	local text_width = 0

	surface.SetFont( 'glorioushud.font.votesmall' )
	local size_y = surface.GetTextSize( yes )
	surface.SetFont( 'glorioushud.font.votesmall' )
	local size_n = surface.GetTextSize( no )

	if( size_y > size_n ) then
		text_width = size_y
	else
		text_width = size_n
	end
	
	surface.SetFont( 'glorioushud.font.playerhud' )
	local questionh = select( 2, surface.GetTextSize( vote_tbl.question ) )

	glorioushud.voteframe = vgui.Create( 'DFrame' )
	glorioushud.voteframe.yalpha = 155
	glorioushud.voteframe.nalpha = 155
	glorioushud.voteframe:SetSize( 250, 70 + questionh )
	glorioushud.voteframe:SetPos( 10, 10 )
	glorioushud.voteframe:SetTitle( '' )
	glorioushud.voteframe:SetDraggable( false )
	glorioushud.voteframe:ShowCloseButton( false )
	glorioushud.voteframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h - 25, glorioushud.settings.voteclrs.backgroundclr )
		draw.RoundedBox( 0, 0, 0, ( w / vote_tbl.time ) * math.Round( ( vote_tbl.time + vote_tbl.start_time ) - CurTime(), 1 ), 5, glorioushud.settings.voteclrs.timeclr )
		draw.RoundedBox( 0, 250 - 5 - ( ( 24 + text_width + 4 ) * 2 + 5 ), 15 + questionh, 24 + text_width + 4, 24, ColorAlpha( glorioushud.settings.voteclrs.btnclr, self.yalpha ) )
		draw.RoundedBox( 0, 250 - 5 - ( 24 + text_width + 4 ), 15 + questionh, 24 + text_width + 4, 24, ColorAlpha( glorioushud.settings.voteclrs.btnclr, self.nalpha ) )
		draw.SimpleText( yes, 'glorioushud.font.votesmall', 250 - 5 - ( ( 24 + text_width + 4 ) * 2 + 5 ) + 24, 19 + questionh, glorioushud.settings.voteclrs.textclr )
		draw.SimpleText( no, 'glorioushud.font.votesmall', 250 - 5 - ( 24 + text_width + 4 ) + 24, 19 + questionh, glorioushud.settings.voteclrs.textclr )

		if( #votes > 1 ) then
			draw.RoundedBox( 0, 0, h - 20, w, 20, glorioushud.settings.voteclrs.backgroundclr )
			draw.SimpleText( tostring( #votes - 1 ) .. glorioushud.localisationget( 'votequeue', glorioushud.settings.language ), 'glorioushud.font.playerhud', w / 2, h - 11, glorioushud.settings.voteclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end
	glorioushud.voteframe.Think = function( self )

		if( math.ceil( ( vote_tbl.time + vote_tbl.start_time ) - CurTime() ) < 1 ) then
			if( !IsValid( self ) ) then return end
			voteremove( vote_tbl )
			self:Close()
		end

	end

	glorioushud.votetitle = vgui.Create( 'DLabel', glorioushud.voteframe )
	glorioushud.votetitle:SetFont( 'glorioushud.font.playerhud' )
	glorioushud.votetitle:SetWide( 364 )
	glorioushud.votetitle:SetPos( 5, 5 )
	glorioushud.votetitle:SetText( vote_tbl.question )
	glorioushud.votetitle:SetTextColor( glorioushud.settings.voteclrs.textclr )
	glorioushud.votetitle:SetWrap( true )
	glorioushud.votetitle:SetContentAlignment( 8 )
	glorioushud.votetitle:SizeToContentsY()

	local yesbtnicon = vgui.Create( 'DImage', glorioushud.voteframe )
	yesbtnicon:SetSize( 16, 16 )
	yesbtnicon:SetPos( 250 - 5 - ( ( 24 + text_width + 4 ) * 2 + 5 ) + 4, 19 + questionh )
	yesbtnicon:SetImage( 'icons/thumbs-up.png' )
	yesbtnicon:SetImageColor( glorioushud.settings.voteclrs.iconsclr )

	local yesbtn = vgui.Create( 'DButton', glorioushud.voteframe )
	yesbtn:SetSize( 24 + text_width + 4, 24 )
	yesbtn:SetPos( 250 - 5 - ( ( 24 + text_width + 4 ) * 2 + 5 ), 15 + questionh )
	yesbtn:SetText( '' )
	yesbtn.Paint = function()end
	yesbtn.DoClick = function()
		if( !IsValid( glorioushud.voteframe ) ) then return end
		LocalPlayer():ConCommand( 'vote ' .. vote_tbl.id .. ' yea' )
		glorioushud.voteframe:Close()
		voteremove( vote_tbl )
	end 
	yesbtn.OnCursorEntered = function()
		glorioushud.voteframe.yalpha = 255
	end
	yesbtn.OnCursorExited = function()
		glorioushud.voteframe.yalpha = 155
	end

	local nobtnicon = vgui.Create( 'DImage', glorioushud.voteframe )
	nobtnicon:SetSize( 16, 16 )
	nobtnicon:SetPos( 250 - 5 - ( 24 + text_width + 4 ) + 4, 19 + questionh )
	nobtnicon:SetImage( 'icons/thumbs-down.png' )
	nobtnicon:SetImageColor( glorioushud.settings.voteclrs.iconsclr )

	local nobtn = vgui.Create( 'DButton', glorioushud.voteframe )
	nobtn:SetSize( 24 + text_width + 4, 24 )
	nobtn:SetPos( 250 - 5 - ( 24 + text_width + 4 ), 15 + questionh )
	nobtn:SetText( '' )
	nobtn.Paint = function()end
	nobtn.DoClick = function()
		if( !IsValid( glorioushud.voteframe ) ) then return end
		LocalPlayer():ConCommand( 'vote ' .. vote_tbl.id .. ' nay' )
		glorioushud.voteframe:Close()
		voteremove( vote_tbl )
	end
	nobtn.OnCursorEntered = function()
		glorioushud.voteframe.nalpha = 255
	end
	nobtn.OnCursorExited = function()
		glorioushud.voteframe.nalpha = 155
	end

end

local function votehandler()

	if( !glorioushud.settings.enabled.votes or !glorioushud.adminenabled.votes ) then return end
	local vote = net.ReadString()
	local ply = net.ReadEntity()
	if( ply == LocalPlayer() ) then return end
	local vote_tbl = util.JSONToTable( vote )

	surface.PlaySound( glorioushud.votesound )

	local vote_repack = {
		time = vote_tbl.time,
		question = vote_tbl.question,
		id = vote_tbl.id,
		start_time = CurTime(),
	}

	table.insert( votes, vote_repack )

	if( #votes == 1 ) then
		addvote( vote_repack )
	end

end

net.Receive( 'glorioushud.sendvote', votehandler )