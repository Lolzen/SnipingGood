--//		SnipingGood		//--

local frame = CreateFrame("Frame", "SnipingGoodFrame", UIParent)
frame:SetSize(52, 52)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, -180)

local icon = frame:CreateTexture(nil, "OVERLAY")
icon:SetTexCoord(.04, .94, .04, .94)
icon:SetAllPoints(frame)
icon:SetTexture(GetSpellTexture(187131))

local border = CreateFrame("Frame")
border:SetBackdrop({
	edgeFile = "Interface\\AddOns\\SnipingGood\\media\\border", edgeSize = 12,
	insets = {left = 4, right = 4, top = 4, bottom = 4},
})
border:SetPoint("TOPLEFT", icon, -2, 3)
border:SetPoint("BOTTOMRIGHT", icon, 3, -2)
border:SetBackdropBorderColor(0, 0, 0)
border:SetFrameLevel(3)
	
local Time = border:CreateFontString(nil, "OVERLAY")
Time:SetPoint("TOP", icon, "BOTTOM", 0, 7)
Time:SetFont("Interface\\AddOns\\SnipingGood\\media\\DroidSansBold.ttf", 12 ,"OUTLINE")
Time:SetTextColor(1, 1, 1)

local unitDebuffed = border:CreateFontString(nil, "OVERLAY")
unitDebuffed:SetPoint("BOTTOM", icon, "TOP", 0, -7)
unitDebuffed:SetFont("Interface\\AddOns\\SnipingGood\\media\\DroidSansBold.ttf", 12 ,"OUTLINE")
unitDebuffed:SetTextColor(1, 1, 1)

local last = 0
frame:SetScript("OnUpdate", function(self, elapsed)
	last = last + elapsed
	if last > 0.1 then
		if UnitExists("focus") then
			if UnitDebuff("focus", GetSpellInfo(187131)) then
				local _, _, _, _, _, _, expirationTime, unitCaster = UnitDebuff("focus", GetSpellInfo(187131))
				if unitCaster == "player" then
					icon:SetAlpha(1)
					border:SetAlpha(1)
					unitDebuffed:SetText("Focus")
					if expirationTime and expirationTime - GetTime() - 0.1 > 4 then
						Time:SetFormattedText("%.1f", expirationTime - GetTime())
					elseif expirationTime and expirationTime - GetTime() > 0 then
						Time:SetFormattedText("|cffff0000 %.1f |r", expirationTime - GetTime())
					end
				end
			else
				icon:SetAlpha(0)
				border:SetAlpha(0)
			end
		elseif UnitExists("target") and not UnitExists("Focus") then
			if UnitDebuff("target", GetSpellInfo(187131)) then
				local _, _, _, _, _, _, expirationTime, unitCaster = UnitDebuff("target", GetSpellInfo(187131))
				print(unitCaster)
				if unitCaster == "player" then
					icon:SetAlpha(1)
					border:SetAlpha(1)
					unitDebuffed:SetText("Ziel")
					if expirationTime and expirationTime - GetTime() - 0.1 > 4 then
						Time:SetFormattedText("%.1f", expirationTime - GetTime())
					elseif expirationTime and expirationTime - GetTime() > 0 then
						Time:SetFormattedText("|cffff0000 %.1f |r", expirationTime - GetTime())
					end
				end
			else
				icon:SetAlpha(0)
				border:SetAlpha(0)
			end
		end
		last = 0
	end
end)