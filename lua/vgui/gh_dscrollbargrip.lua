
local PANEL = {}

function PANEL:Init()
	self.color = glorioushud.settings.vguiclrs.sliderleft
end

function PANEL:OnMousePressed()

	self:GetParent():Grip( 1 )

end

function PANEL:OnCursorEntered()
	self.color = glorioushud.settings.vguiclrs.sliderhover
end

function PANEL:OnCursorExited()
	self.color = glorioushud.settings.vguiclrs.sliderleft
end

function PANEL:Paint( w, h )

	--derma.SkinHook( "Paint", "ScrollBarGrip", self, w, h )
	draw.RoundedBox( 10, 0, 0, w, h, self.color )
	return true

end

derma.DefineControl( "GH_DScrollBarGrip", "A Scrollbar Grip", PANEL, "DPanel" )
