local PANEL = {}
local PlayerVoicePanels = {}

function PANEL:Init()

    self.LabelName = vgui.Create( 'DLabel', self )
    self.LabelName:SetFont( 'glorioushud.font.playerhud' )
    self.LabelName:SetPos( 48, 9 )
    self.LabelName:SetTextColor( glorioushud.settings.voicenotifyclrs.textclr )

    self.Avatar = vgui.Create( 'AvatarImage', self )
    self.Avatar:SetPos( 5, 5 )
    self.Avatar:SetSize( 30, 30, 30 )

    self:SetSize( 250, 40 )
    self.LabelName:SetWide( 189 )
    self:DockPadding( 4, 4, 4, 4 )
    self:DockMargin( 2, 2, 2, 2 )
    self:Dock( BOTTOM )

end

function PANEL:Setup( ply )

    self.ply = ply
    self.LabelName:SetText( ply:Nick() )
    self.Avatar:SetPlayer( ply )
    
    self:InvalidateLayout()

end

function PANEL:Paint( w, h )

    if ( !IsValid( self.ply ) ) then return end

    draw.RoundedBox( 0, 0, 0, w, h, glorioushud.settings.voicenotifyclrs.backgroundclr )

    draw.RoundedBox( 0, 40, 5, w - 45, 30, glorioushud.settings.voicenotifyclrs.shapesclr )
    
    if( !glorioushud.settings.voicebar ) then return end
    if( self.ply == LocalPlayer() ) then return end
    local volume = self.ply:VoiceVolume()
    local color = glorioushud.settings.voicecolor and HSLToColor( 120 * ( 1 - volume ), 0.5, 0.5 ) or Color( 0, 211, 0, 255 )
    
    draw.RoundedBox( 0, 0, 35, w * volume, 5, color )

end

function PANEL:Think()
    
    if ( IsValid( self.ply ) ) then
        self.LabelName:SetText( self.ply:Nick() )
    end

    if ( self.fadeAnim ) then
        self.fadeAnim:Run()
    end

end

function PANEL:FadeOut( anim, delta, data )
    
    if ( anim.Finished ) then
    
        if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
            PlayerVoicePanels[ self.ply ]:Remove()
            PlayerVoicePanels[ self.ply ] = nil
            return
        end
        
    return end
    
    self:SetAlpha( 255 - ( 255 * delta ) )

end

derma.DefineControl( "VoiceNotify", "", PANEL, "DPanel" )



function GM:PlayerStartVoice( ply )

    if ( !IsValid( g_VoicePanelList ) ) then return end
    
    GAMEMODE:PlayerEndVoice( ply )


    if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

        if ( PlayerVoicePanels[ ply ].fadeAnim ) then
            PlayerVoicePanels[ ply ].fadeAnim:Stop()
            PlayerVoicePanels[ ply ].fadeAnim = nil
        end

        PlayerVoicePanels[ ply ]:SetAlpha( 255 )

        return

    end

    if ( !IsValid( ply ) ) then return end

    local pnl = g_VoicePanelList:Add( "VoiceNotify" )
    pnl:Setup( ply )
    
    PlayerVoicePanels[ ply ] = pnl

end

local function VoiceClean()

    for k, v in pairs( PlayerVoicePanels ) do
    
        if ( !IsValid( k ) ) then
            GAMEMODE:PlayerEndVoice( k )
        end
    
    end

end
timer.Create( "VoiceClean", 10, 0, VoiceClean )

function GM:PlayerEndVoice( ply )

    if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

        if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

        PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
        PlayerVoicePanels[ ply ].fadeAnim:Start( 2 )

    end

end

local function CreateVoiceVGUI()

    g_VoicePanelList = vgui.Create( "DPanel" )

    g_VoicePanelList:ParentToHUD()
    g_VoicePanelList:SetPos( ScrW() - 300, 100 )
    g_VoicePanelList:SetSize( 250, ScrH() - 200 )
    g_VoicePanelList:SetPaintBackground( false )

end

hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )

--This is edited original base gamemode code