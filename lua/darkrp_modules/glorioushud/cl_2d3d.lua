--[[--------------------
Disabling chat indicator
----------------------]] 
hook.Add("PostPlayerDraw", "DarkRP_ChatIndicator", function()end)
------------------------

function glorioushud.overhead( ply )

	local lp = LocalPlayer()
	if( !IsValid( ply ) ) then return end
	if( ply == lp ) then return end
	if( !ply:Alive() ) then return end
	if( ply != lp ) then
		if( lp:GetPos():DistToSqr( ply:GetPos() ) > ( glorioushud.settings.showrange * glorioushud.settings.showrange ) ) then return end
	end
	if( !ply:OnGround() or ply:InVehicle() ) then return end

	local name = ply:GetName()
	local job = ply:getDarkRPVar( 'job' ) 
	local license = ply:getDarkRPVar( 'HasGunlicense' )
	local arrest = ply:getDarkRPVar( 'Arrested' )
	local wanted = ply:getDarkRPVar( 'wanted' )
	
	local headBone = ply:LookupBone( 'ValveBiped.Bip01_Head1' )

	local pos

	if( !headBone ) then
		pos = ply:GetPos() + Vector( 0, 0, 85 )
	else
		pos = ply:GetBonePosition( ply:LookupBone( 'ValveBiped.Bip01_Head1' ) ) + Vector( 0, 0, 25 )
	end

	if( job == nil ) then job = 'N/A' end

	cam.Start3D2D( pos, Angle( 0, RenderAngles().y - 90, 90), glorioushud.settings.overheadscale )
		
		surface.SetFont( 'glorioushud.font.overhead' )
		local namew = surface.GetTextSize( name )
		surface.SetFont( 'glorioushud.font.overhead' )
		local jobw = surface.GetTextSize( job )
		local w = 0

		if( jobw > namew ) then
			w = jobw
		else
			w = namew
		end

		local total_width = 94 + w
		local total_height = 158

		local x = -( total_width / 2 + 15 )
		local y = -( total_height / 2 )

		draw.RoundedBox( 0, x, y, 74, 74, glorioushud.settings.overheadclrs.shapeclr )

		draw.RoundedBox( 0, x + 84, y, w + 10, 74, glorioushud.settings.overheadclrs.shapeclr )

		if( ply:IsTyping() ) then
			surface.SetDrawColor( glorioushud.settings.overheadclrs.iconclr )
			surface.SetMaterial( glorioushud.materials[ 'message64' ] )
			surface.DrawTexturedRect( x + 5, y + 5, 64, 64 )
		elseif( ply:IsSpeaking() ) then
			surface.SetDrawColor( glorioushud.settings.overheadclrs.iconclr )
			surface.SetMaterial( glorioushud.materials[ 'volume64' ] )
			surface.DrawTexturedRect( x + 5, y + 5, 64, 64 )
		elseif( arrest ) then
			surface.SetDrawColor( glorioushud.settings.overheadclrs.iconclr )
			surface.SetMaterial( glorioushud.materials[ 'lock64' ] )
			surface.DrawTexturedRect( x + 5, y + 5, 64, 64 )
		elseif( wanted != nil ) then
			surface.SetDrawColor( glorioushud.settings.overheadclrs.iconclr )
			surface.SetMaterial( glorioushud.materials[ 'eye64' ] )
			surface.DrawTexturedRect( x + 5, y + 5, 64, 64 )
		else
			surface.SetDrawColor( glorioushud.settings.overheadclrs.iconclr )
			surface.SetMaterial( glorioushud.materials[ 'user64' ] )
			surface.DrawTexturedRect( x + 5, y + 5, 64, 64 )
		end

		draw.SimpleText( name, 'glorioushud.font.overhead', ( x + 88 ) + w / 2, y + 69, glorioushud.settings.overheadclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )



		draw.RoundedBox( 0, x, y + 84, 74, 74, glorioushud.settings.overheadclrs.shapeclr )

		draw.RoundedBox( 0, x + 84, y + 84, w + 10, 74, glorioushud.settings.overheadclrs.shapeclr )

		surface.SetDrawColor( glorioushud.settings.overheadclrs.iconclr )
		surface.SetMaterial( glorioushud.materials[ 'case64' ] )
		surface.DrawTexturedRect( x + 5, y + 89, 64, 64 )

		draw.SimpleText( job, 'glorioushud.font.overhead', ( x + 90 ) + w / 2, y + 153, glorioushud.settings.overheadclrs.textclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

		if( license != nil ) then

			draw.SimpleText( glorioushud.localisationget( 'licensed', glorioushud.settings.language ), 'glorioushud.font.overhead60', x + ( total_width / 2 ), y + 213, glorioushud.settings.overheadclrs.licensetextclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
		
		end

	cam.End3D2D() 

end

hook.Add( 'glorioushud.settings_apply', 'glorioushud.check_overhead', function()

	hook.Add( 'PostPlayerDraw', 'glorioushud.overhead', glorioushud.overhead )

	if( !glorioushud.settings.enabled.overhead or !glorioushud.adminenabled.overhead ) then 
		hook.Remove( 'PostPlayerDraw', 'glorioushud.overhead' )
	end

end)