--//		SnipingGood		//--

local frame = CreateFrame("Frame", "SnipingGoodFrame", UIParent)
frame:SetSize(52, 52)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, -180)
frame:RegisterEvent("UNIT_AURA", "target")
frame:RegisterEvent("UNIT_AURA", "focus")

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
Time:SetText("12")

-- Change the timer
local SecondsToTimeAbbrev = function(time)
	local hr, m, s, text
	if time <= 0 then 
		text = ""
	elseif(time < 3600 and time > 40) then
		m = floor(time / 60)
		s = mod(time, 60)
		text = (m == 0 and format("|cffffffff%d", s)) or format("|cffffffff%d:%02d", m, s)
	elseif time < 60 then
		m = floor(time / 60)
		s = mod(time, 60)
		text = (m == 0 and format("|cffffff00%d", s))
	else
		hr = floor(time / 3600)
		m = floor(mod(time, 3600) / 60)
		text = format("%d:%2d", hr, m)
	end
	return text
end

frame:SetScript("OnEvent",function(self, event, sourceUnit, spellName)
	local sec
	if spellName == "Verwundbar" or spellName == "Vulnurable" then
		--debug
		print("Verwundbar auf dem target")
		if UnitExists("Focus") or (UnitExists("target") and not UnitExists("Focus")) then
			icon:SetAlpha(1)
			_, _, _, _, _, sec = UnitBuff(sourceUnit, 187131)
		else
			icon:SetAlpha(0)
			sec = 0
		end
	end
	--wenn timer icon alpha 1, sonst 0
	-- wenn timer <= 4 sec icon blinken, roter text
end)