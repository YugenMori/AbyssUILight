-- Author: Yugen
--
-- Classic
--
-- Hope you like my addOn ^^
--
-- Extra functions for Classic
--------------------------------------------------------------------------------
-- Init - Tables - Saves
local addonName, addonTable = ...
local L = LibStub("AceLocale-3.0"):GetLocale("AbyssUIClassic")
local GetWoWVersion = ((select(4, GetBuildInfo())))
local f = CreateFrame("Frame", "AbyssUIClassic_Config", UIParent)
f:SetSize(50, 50)
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event, ...)
  character = UnitName("player").."-"..GetRealmName()
  -- Config/Panel
  if not AbyssUIClassic_Config then
    local AbyssUIClassic_Config = {}
  end
    if not AbyssUIClassic_Config then
    local AbyssUIClassic_Config = {}
  end
  -- AddonSettings
  if not AbyssUIClassicAddonSettings then
    AbyssUIClassicAddonSettings = {}
  end
  if not AbyssUIClassicAddonSettings[character] then
    AbyssUIClassicAddonSettings[character] = {}
  end
  -- Color Init
  if not COLOR_MY_UI then
      COLOR_MY_UI = {}
  end
  if not COLOR_MY_UI[character] then
      COLOR_MY_UI[character] = {}
  end
  if not COLOR_MY_UI[character].Color then
      COLOR_MY_UI[character].Color = { r = 1, g = 1, b = 1 }
  end
end)
-- Fontfication
local function AbyssUIClassic_Fontification(globalFont, subFont, damageFont, oldglobalFont)
local locale = GetLocale()
local fontName, fontHeight, fontFlags = MinimapZoneText:GetFont()
local mediaFolder = "Interface\\AddOns\\AbyssUIClassic\\Textures\\font\\"
	if ( locale == "zhCN") then
		globalFont	= mediaFolder.."zhCN-TW\\senty.ttf"
		subFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
		damageFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
		oldglobalFont = mediaFolder.."zhCN-TW\\senty.ttf"
	elseif ( locale == "zhTW" ) then
		globalFont	= mediaFolder.."zhCN-TW\\senty.ttf"
		subFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
		damageFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
		oldglobalFont = mediaFolder.."zhCN-TW\\senty.ttf"
	elseif ( locale == "ruRU" ) then
		globalFont	= mediaFolder.."ruRU\\dejavu.ttf"
		subFont 	= mediaFolder.."ruRU\\dejavu.ttf"
		damageFont 	= mediaFolder.."ruRU\\dejavu.ttf"
		oldglobalFont = mediaFolder.."ruRU\\dejavu.ttf"
	elseif ( locale == "koKR" ) then
		globalFont	= mediaFolder.."koKR\\dxlbab.ttf"
		subFont 	= mediaFolder.."koKR\\dxlbab.ttf"
		damageFont 	= mediaFolder.."koKR\\dxlbab.ttf"
		oldglobalFont = mediaFolder.."koKR\\dxlbab.ttf"
	elseif ( locale == "frFR" or locale == "deDE" or locale == "enGB" or locale == "enUS" or locale == "itIT" or
		locale == "esES" or locale == "esMX" or locale == "ptBR") then
		globalFont	= mediaFolder.."global.tff"
		subFont 	= mediaFolder.."damagefont_classic.ttf"
		damageFont 	= mediaFolder.."damagefont.ttf"
		oldglobalFont = mediaFolder .. "damagefont_classic.ttf"
	else
		globalFont	= fontName
		subFont 	= fontName
		damageFont 	= fontName
		oldglobalFont = fontName
	end
	return globalFont, subFont, damageFont, oldglobalFont
end
local globalFont, subFont, damageFont, oldglobalFont = AbyssUIClassic_Fontification(globalFont, subFont, damageFont, oldglobalFont)
local function AbyssUIClassic_RBGColorizationFrameFunction(...)
	local v = ...
	if AbyssUIClassicAddonSettings.UIVertexColorFrames01 == true then
		return 1, 1, 1
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames02 == true then
		return .2, .2, .2
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames03 == true then
		return 182/255, 42/255, 37/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames04 == true then
		return 236/255, 193/255, 60/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames05 == true then
		return 196/255, 31/255, 59/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames06 == true then
		return 163/255, 48/255, 201/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames07 == true then
		return 252/255, 163/255, 85/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames08 == true then
		return 190/255, 221/255, 115/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames09 == true then
		return 64/255, 220/255, 255/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames10 == true then
		return 86/255, 255/255, 184/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames11 == true then
		return 255/255, 155/255, 195/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames12 == true then
		return 23/255, 28/255, 99/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames13 == true then
		return 255/255, 255/255, 0/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames14 == true then
		return 0/255, 112/255, 222/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames15 == true then
		return 135/255, 135/255, 237/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames16 == true then
		return 199/255, 156/255, 110/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames17 == true then
		return 51/255, 147/255, 127/255
	elseif AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker == true then
		local character = UnitName("player").."-"..GetRealmName()
		return COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b	
	else
		return .4, .4, .4
	end
end
local function AbyssUIClassic_ColorizationFrameFunction(...)
	local v = ...
	if AbyssUIClassicAddonSettings.UIVertexColorFrames01 == true then
		v:SetVertexColor(1, 1, 1)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames02 == true then
		v:SetVertexColor(.2, .2, .2)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames03 == true then
		v:SetVertexColor(182/255, 42/255, 37/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames04 == true then
		v:SetVertexColor(236/255, 193/255, 60/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames05 == true then
		v:SetVertexColor(196/255, 31/255, 59/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames06 == true then
		v:SetVertexColor(163/255, 48/255, 201/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames07 == true then
		v:SetVertexColor(252/255, 163/255, 85/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames08 == true then
		v:SetVertexColor(190/255, 221/255, 115/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames09 == true then
		v:SetVertexColor(64/255, 220/255, 255/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames10 == true then
		v:SetVertexColor(86/255, 255/255, 184/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames11 == true then
		v:SetVertexColor(255/255, 155/255, 195/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames12 == true then
		v:SetVertexColor(23/255, 28/255, 99/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames13 == true then
		v:SetVertexColor(255/255, 255/255, 0/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames14 == true then
		v:SetVertexColor(0/255, 112/255, 222/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames15 == true then
		v:SetVertexColor(135/255, 135/255, 237/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames16 == true then
		v:SetVertexColor(199/255, 156/255, 110/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFrames17 == true then
		v:SetVertexColor(51/255, 147/255, 127/255)
	elseif AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker == true then
		local character = UnitName("player").."-"..GetRealmName()
		v:SetVertexColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)	
	else
		v:SetVertexColor(.4, .4, .4)
	end
end
-- RegionList
local function AbyssUIClassic_RegionListSize(self, width, height)
	local regionList = { 
		self:GetRegions() } 
	for i, self in ipairs(regionList) do 
	    local regionType = self:GetObjectType() 
	    if regionType == "Texture" and not self:GetTexture() then  -- the region with no texture, just black colour
	        self:SetWidth(width)
					self:SetHeight(height)
	        break 
	    end  
	end
end
-- FrameSize
local function AbyssUIClassic_FrameSize(self, width, height)
	self:SetWidth(width)
	self:SetHeight(height)
end
----------------------------------------------------
local _G = _G
-- Fonts
----------------------------------------------------
local AbyssUIClassic_FontString = CreateFrame("Frame", "$parentAbyssUIClassic_FontString", nil)
AbyssUIClassic_FontString:RegisterEvent("ADDON_LOADED")
AbyssUIClassic_FontString:RegisterEvent("PLAYER_LOGOUT")
AbyssUIClassic_FontString:SetScript("OnEvent", function(self, event, arg1)
	if ( event == "ADDON_LOADED" and arg1 == "AbyssUIClassic" )  then
		STANDARD_TEXT_FONT          = globalFont
    DAMAGE_TEXT_FONT 						= oldglobalFont
    COMBAT_TEXT_CRIT_MAXHEIGHT	= 24
		UNIT_NAME_FONT              = globalFont
		NAMEPLATE_FONT              = oldglobalFont
		NAMEPLATE_SPELLCAST_FONT    = oldglobalFont
		
		-- XML changes
		local ForcedFontSize = {10, 14, 20, 64, 64}
		local ForcedFontSizeBig = {14, 18, 24, 64, 64}
		local BlizFontObjects = {
			SystemFont_Outline_Small, SystemFont_Outline, SystemFont_InverseShadow_Small, SystemFont_Med2, SystemFont_Med3, SystemFont_Shadow_Med3,
			SystemFont_Huge1, SystemFont_Huge1_Outline, SystemFont_OutlineThick_Huge2, SystemFont_OutlineThick_Huge4, SystemFont_OutlineThick_WTF,
			NumberFont_GameNormal, NumberFont_Shadow_Small, NumberFont_OutlineThick_Mono_Small, NumberFont_Normal_Med, NumberFont_Outline_Med, 
			NumberFont_Outline_Large, NumberFont_Outline_Huge, Fancy22Font, QuestFont_Huge, QuestFont_Outline_Huge,	QuestFont_Super_Huge, 
			QuestFont_Super_Huge_Outline, SplashHeaderFont, Game11Font, Game12Font, Game13Font, Game13FontShadow,	Game15Font, Game18Font, 
			Game20Font, Game24Font, Game27Font, Game30Font, Game32Font, Game36Font, Game48Font, Game48FontShadow,	Game60Font, Game72Font, 
			Game11Font_o1, Game12Font_o1, Game13Font_o1, Game15Font_o1, QuestFont_Enormous, DestinyFontLarge,	CoreAbilityFont, DestinyFontHuge, 
			QuestFont_Shadow_Small, MailFont_Large, SpellFont_Small, InvoiceFont_Med, InvoiceFont_Small, AchievementFont_Small, ReputationDetailFont, 
			FriendsFont_Normal, FriendsFont_Small, FriendsFont_Large,	FriendsFont_UserText, GameFont_Gigantic, Fancy16Font, Fancy18Font, Fancy20Font, 
			Fancy24Font, Fancy27Font, Fancy30Font, Fancy32Font, Fancy48Font,
		}
		local NamePlateFonts = {
			-- These five fonts use the fixedSize argument, causing an incorrent font size return, so input our own sizes (ForcedFontSize)
			SystemFont_NamePlateCastBar, SystemFont_NamePlateFixed, SystemFont_LargeNamePlateFixed, SystemFont_World, SystemFont_World_ThickOutline,
			SystemFont_NamePlate, SystemFont_LargeNamePlate,
		}
		local ChatFonts = {
			ChatFontNormal, ChatFontSmall, ChatFontLarge, ChatFontName, ChatFontHighlight, ChatFontDisable, ChatBubbleFont,
			NumberFont_Shadow_Med,
		}
		--SharedFonts.xml
		local SharedFonts = {
			SystemFont_Tiny2, SystemFont_Tiny, SystemFont_Shadow_Small, SystemFont_Small, SystemFont_Small2, SystemFont_Shadow_Small2, SystemFont_Shadow_Med1_Outline,
			SystemFont_Shadow_Med1, QuestFont_Large, SystemFont_Large, SystemFont_Shadow_Large_Outline, SystemFont_Shadow_Med2, SystemFont_Shadow_Large, 
			SystemFont_Shadow_Large2, SystemFont_Shadow_Huge1, SystemFont_Huge2, SystemFont_Shadow_Huge2, SystemFont_Shadow_Huge3, SystemFont_Shadow_Outline_Huge3,
			SystemFont_Shadow_Outline_Huge2, SystemFont_Med1, SystemFont_WTF2, SystemFont_Outline_WTF2, System_IME,
		}
		local ExtrasFromShared = { 
			GameTooltipHeader, Tooltip_Med, Tooltip_Small, NumberFontNormalRightYellow, NumberFontNormalYellow,
		}
		-- Global
		for i, FontObject in pairs(BlizFontObjects) do
			local _, oldSize, oldStyle  = FontObject:GetFont()
			FontObject:SetFont(globalFont, ForcedFontSize[i] or oldSize, oldStyle)
		end
		-- Nameplates
		for i, FontObject in pairs(NamePlateFonts) do
			local _, oldSize, oldStyle  = FontObject:GetFont()
			FontObject:SetFont(oldglobalFont, ForcedFontSize[i] or oldSize, oldStyle)
		end
		-- Chat
		for i, FontObject in pairs(ChatFonts) do
			local _, oldSize, oldStyle  = FontObject:GetFont()
			FontObject:SetFont(oldglobalFont, ForcedFontSizeBig[i] or oldSize, oldStyle)
		end
		-- SharedFonts.xml
		for i, FontObject in pairs(SharedFonts) do
			local _, oldSize, oldStyle  = FontObject:GetFont()
			FontObject:SetFont(globalFont, ForcedFontSize[i] or oldSize, oldStyle)
		end
		-- Extras from SharedFonts.xml
		for i, FontObject in pairs(ExtrasFromShared) do
			local _, oldSize, oldStyle  = FontObject:GetFont()
			FontObject:SetFont(globalFont, ForcedFontSizeBig[i] or oldSize, oldStyle)
		end
		-- Returns
		BlizFontObjects = nil
		NamePlateFonts = nil
		ChatFonts = nil
		SharedFonts = nil
		ExtrasFromShared = nil
	end
end)
-- Damage font hook
--[[
local function DamageFontHook()
	-- IDK why this need to be hooked to work... but it is what it is
  DAMAGE_TEXT_FONT = globalFont
  COMBAT_TEXT_CRIT_MAXHEIGHT = 24 -- Adjust the maximum height for critical damage text
end
local function DamageFontOnLoad()
  -- Hook the custom font function to the PLAYER_LOGIN event
  local frame = CreateFrame("Frame")
  frame:RegisterEvent("PLAYER_LOGIN")
  frame:SetScript("OnEvent", DamageFontHook)
end
-- Call the OnLoad function when the addon is loaded
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
  if addonName == "AbyssUIClassic" then
    DamageFontOnLoad()
  end
end)
-- Register for the "PLAYER_LOGIN" event to apply the custom font when the player logs in
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", ApplyCustomDamageFont)
--]]
-- Change yellow fonts text color
local f, _ = CreateFrame("frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
  f.yellow = {
    "AchievementDateFont",
    "AchievementPointsFont",
    "AchievementPointsFontSmall",
    "BossEmoteNormalHuge",
    "DialogButtonNormalText",
    "FocusFontSmall",
    "GameFontNormal",
    "GameFontNormalHuge",
    "GameFontNormalLarge",
    "GameFontNormalMed3",
    "GameFontNormalSmall",
    "GameFont_Gigantic",
    "NumberFontNormalLargeRightYellow",
    "NumberFontNormalLargeYellow",
    "NumberFontNormalRightYellow",
    "NumberFontNormalYellow",
    "QuestFont_Enormous",
    "QuestFont_Super_Huge",
    "QuestFont_Super_Huge_Outline",
    "QuestTitleFontBlackShadow",
    "SplashHeaderFont",
  }
  if ( AbyssUIClassicAddonSettings.ExtraFunctionDisableFontWhiteText ~= true ) then
    for _, v in next, f.yellow do 
      _G[v]:SetTextColor(229/255, 229/255, 229/255)
    end
      --_G.WorldMapFrame.NavBar.home.text:SetTextColor(229/255, 229/255, 229/255)
  end
end)
----------------------------------------------------
-- UnitColor
local UnitColor
local function UnitColor(unit)
  if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
    local r, g, b
    if ( ( not UnitIsPlayer(unit) ) and ( ( not UnitIsConnected(unit) ) or ( UnitIsDeadOrGhost(unit) ) ) ) then
      --Color it gray
      r, g, b = 0.5, 0.5, 0.5
    elseif ( UnitIsPlayer(unit) ) then
      --Try to color it by class.
      local localizedClass, englishClass = UnitClass(unit)
      local classColor = RAID_CLASS_COLORS[englishClass]
      if ( classColor ) then
        r, g, b = classColor.r, classColor.g, classColor.b
      else
        if ( UnitIsFriend("player", unit) ) then
          r, g, b = 0.0, 1.0, 0.0
        else
          r, g, b = 1.0, 0.0, 0.0
        end
      end
    else
      r, g, b = UnitSelectionColor(unit)
    end
    return r, g, b
  else
    return nil
  end
end
-- Max Distance Nameplates
local f = CreateFrame("CheckButton", "$parentFrame", UIParent, "ChatConfigCheckButtonTemplate")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event, ...)
	if ( AbyssUIClassicAddonSettings.ExtraFunctionDefaultNameplate ~= true ) then
		SetCVar("nameplateMaxDistance", "8e1")
	else 
		SetCVar("nameplateMaxDistance", "4e1")
	end
end)
-- Fade UI
local FadeUIFirstHide = CreateFrame("CheckButton", "$parentFadeUIFirstHide", UIParent, "ChatConfigCheckButtonTemplate")
FadeUIFirstHide:RegisterEvent("PLAYER_ENTERING_WORLD")
local _G = _G
FadeUIFirstHide:SetScript("OnEvent", function(self, event, ...)
	if ( AbyssUIClassicAddonSettings.FadeUI == true ) then
		C_Timer.After(1, function() 
			for i, v in pairs ({
				BuffFrame,
				QuestWatchFrame,
				GeneralDockManager,
				ChatFrameMenuButton,
				ChatFrameChannelButton,
				MainMenuBar,
				VerticalMultiBarsContainer,
				MultiBarLeft,
			}) do
				UIFrameFadeIn(v, 1, 1, 0)
			end
			for i=1, 12 do
				UIFrameFadeIn(_G["ExtraBarButton"..i], 1, 1, 0)			
			end
		end)
	else
		return nil
	end
end)
local FadeUI = CreateFrame("CheckButton", "$parentFadeUI", UIParent, "ChatConfigCheckButtonTemplate")
FadeUI:RegisterEvent("PLAYER_REGEN_DISABLED")
FadeUI:RegisterEvent("PLAYER_REGEN_ENABLED")
FadeUI:SetScript("OnEvent", function(self, event, ...)
	if ( AbyssUIClassicAddonSettings.FadeUI == true ) then
		if ( event == "PLAYER_REGEN_DISABLED" ) then
			for i, v in pairs ({
				BuffFrame,
				QuestWatchFrame,
				GeneralDockManager,
				ChatFrameMenuButton,
				ChatFrameChannelButton,
				MainMenuBar,
				VerticalMultiBarsContainer,
				MultiBarLeft,
			}) do
				UIFrameFadeIn(v, 1, 0, 1)
			end
		elseif ( event == "PLAYER_REGEN_ENABLED" ) then
			for i, v in pairs ({
				BuffFrame,
				QuestWatchFrame,
				GeneralDockManager,
				ChatFrameMenuButton,
				ChatFrameChannelButton,
				MainMenuBar,
				VerticalMultiBarsContainer,
				MultiBarLeft,
			}) do
				UIFrameFadeIn(v, 1, 1, 0)
			end
		else
			return nil
		end
	else
		return nil
	end
end)
local FadeUI_MouseOver = CreateFrame("CheckButton", "$parentFadeUI_MouseOver", UIParent, "ChatConfigCheckButtonTemplate")
FadeUI_MouseOver:RegisterEvent("PLAYER_ENTERING_WORLD")
FadeUI_MouseOver:RegisterForClicks("AnyDown")
FadeUI_MouseOver:SetScript("OnEvent", function()
	SetBindingClick("ALT-CTRL-P", FadeUI_MouseOver:GetName())
end)
FadeUI_MouseOver:SetScript("OnClick", function()
	if ( AbyssUIClassicAddonSettings.FadeUI == true ) then
		for i, v in pairs ({
			BuffFrame,
			QuestWatchFrame,
			GeneralDockManager,
			ChatFrameMenuButton,
			ChatFrameChannelButton,
			MainMenuBar,
			VerticalMultiBarsContainer,
			MultiBarLeft,
		}) do
			UIFrameFadeIn(v, 1, 0, 1)
		end
	else
		return nil
	end
end)
----------------------------------------------
-- NamePlate Style 
----------------------------------------------
--  Remove realm names
hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
	if ( not frame:IsForbidden() and AbyssUIClassicAddonSettings.ExtraFunctionNameplateChanges ~= true ) then
	    if ShouldShowName(frame) then
	        frame.name:SetVertexColor(1,1,1) -- Fixes tapped mobs permanently setting the nametag gray
	        frame.name:SetText(GetUnitName(frame.unit))
	    end
	end
end)
-- Nameplate Health Percent
hooksecurefunc("CompactUnitFrame_UpdateStatusText", function(frame)
	if ( AbyssUIClassicAddonSettings.ExtraFunctionNameplateChanges ~= true ) then
			if frame:IsForbidden() or ( UnitIsFriend("player", frame.displayedUnit) and not UnitIsUnit(frame.displayedUnit, "player") ) then return end
			if not frame.healthBar.percent then
				frame.healthBar.percent = frame.healthBar:CreateFontString(nil,"OVERLAY")
				frame.healthBar.percent:SetPoint("LEFT", frame.healthBar)
				frame.healthBar.percent:SetFont(damageFont, 10, "THINOUTLINE")
				--frame.healthBar.percent:SetFont(damageFont, 10)
				frame.healthBar.percent:SetShadowColor(0, 0, 0)
				frame.healthBar.percent:SetShadowOffset(1, -0.25)
			end
			local percentcalc = ceil(((UnitHealth(frame.displayedUnit) / UnitHealthMax(frame.displayedUnit)) * 1000) /10)
			if ( percentcalc == 0 ) then return end
			frame.healthBar.percent:SetFormattedText("%d%%", percentcalc)
			--frame.healthBar.percent:Show()
	end
end)
-- Nameplate colorization
-- Player
hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(self)
	if ( not self:IsForbidden() and AbyssUIClassicAddonSettings.ExtraFunctionNameplateChanges ~= true ) then
    local _, class = UnitClass('player')
    local color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
		local unitIsPlayer = UnitIsPlayer('player')
		if self.optionTable.colorNameBySelection and not self:IsForbidden() then
			-- Player
		 	if ( unitIsPlayer == true ) then
				if C_NamePlate.GetNamePlateForUnit(self.unit) == C_NamePlate.GetNamePlateForUnit('player') then
					local healthPercentage = ceil(((UnitHealth(self.displayedUnit) / UnitHealthMax(self.displayedUnit)) * 1000) /10)
					if ( healthPercentage == 0 ) then return end
          			if ( healthPercentage == 100 ) then
       					self.healthBar:SetStatusBarColor(color.r, color.g, color.b)
					elseif healthPercentage < 100 and healthPercentage > 21 then
						self.healthBar:SetStatusBarColor(color.r, color.g, color.b)
					elseif healthPercentage < 21 then
						self.healthBar:SetStatusBarColor(255/255, 255/255, 255/255)
					end
				end
			end
		end
	else
		return nil
	end
end)
-- Target
hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(self)
	if ( not self:IsForbidden() and AbyssUIClassicAddonSettings.ExtraFunctionNameplateChanges ~= true ) then
		local unitTarget = UnitIsPlayer("target")
		local reaction = UnitReaction("player", "target") or 4
		if self.optionTable.colorNameBySelection and not self:IsForbidden() then
			-- Mobs
		 	if  ( unitTarget ~= true and reaction < 5 ) then
				if C_NamePlate.GetNamePlateForUnit(self.unit) == C_NamePlate.GetNamePlateForUnit("target") then
					local healthPercentage = ceil(((UnitHealth(self.displayedUnit) / UnitHealthMax(self.displayedUnit)) * 1000) /10)
					if ( healthPercentage == 0 ) then return end
					if healthPercentage == 100 then
						-- do nothing keep frame color
					elseif healthPercentage < 100 and healthPercentage > 21 then
            			self.healthBar:SetStatusBarColor(UnitColor(self.unit))
          			elseif healthPercentage < 21 then
            			self.healthBar:SetStatusBarColor(255/255, 255/255, 255/255)
          			end
				end
			end
		end
	else
		return nil
	end
end)
----------------------------------------------------
-- ChatBubble
-- Thanks to cokedrivers for this awesome code
local ChatBubbleColorization = CreateFrame("CheckButton", "$parentChatBubbleColorization", UIParent, "ChatConfigCheckButtonTemplate")
ChatBubbleColorization:RegisterEvent("PLAYER_ENTERING_WORLD")
ChatBubbleColorization:SetScript("OnEvent", function(self, event, ...)
if ( AbyssUIClassicAddonSettings.ExtraFunctionChatBubbleChanges ~= true ) then
	if ( event == "PLAYER_ENTERING_WORLD" ) then
	    local reaction = UnitReaction("target", "player")
	    local CUSTOM_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
	    local color = CUSTOM_CLASS_COLORS
	    local events = {
	                CHAT_MSG_SAY = 'chatBubbles', 
	                CHAT_MSG_YELL = 'chatBubbles',
	                CHAT_MSG_PARTY = 'chatBubblesParty', 
	                CHAT_MSG_PARTY_LEADER = 'chatBubblesParty',
	                CHAT_MSG_MONSTER_SAY = 'chatBubbles', 
	                CHAT_MSG_MONSTER_YELL = 'chatBubbles', 
	                CHAT_MSG_MONSTER_PARTY = 'chatBubblesParty',
	            }
	     
	        local function SkinFrame(frame)
	        	if ( not frame:IsForbidden() ) then
		            for i = 1, select('#', frame:GetRegions()) do
		                local region = select(i, frame:GetRegions())
		                if (region:GetObjectType() == 'FontString') then
		                    frame.text = region
		                else
		                    region:Hide()
		                end
		            end
		 
		            frame.text:SetFontObject('SystemFont_Tiny')
		            frame.text:SetJustifyH('LEFT')
		 
		            frame:ClearAllPoints()
		            frame:SetPoint('TOPLEFT', frame.text, -10, 25)
		            frame:SetPoint('BOTTOMRIGHT', frame.text, 10, -10)
		            frame:SetBackdrop({
		                bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
		                edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		                tile = true, tileSize = 16, edgeSize = 18,
		                insets = {left = 3, right = 3, top = 3, bottom = 3}
		            })
		            frame:SetBackdropColor(0, 0, 0, 1)
		            local r, g, b = frame.text:GetTextColor()
		            frame:SetBackdropBorderColor(r, g, b, .8)
		 
		            frame.sender = frame:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		            frame.sender:SetPoint('BOTTOMLEFT', frame.text, 'TOPLEFT', 0, 4)
		            frame.sender:SetJustifyH('LEFT')
		 
		            frame:HookScript('OnHide', function() 
		                frame.inUse = false 
		            end)
		        end
	        end
	 
	        local function UpdateFrame(frame, guid, name)
	        	if ( not frame:IsForbidden() ) then
		            if (not frame.text) then
		                SkinFrame(frame) 
		            end
		            frame.inUse = true
		 
		            local ccolor
		            if (guid ~= nil and guid ~= '') then
		                _, ccolor, _, _, _, _ = GetPlayerInfoByGUID(guid)
		            end
		 
		            if (name) then
		                local color = RAID_CLASS_COLORS[ccolor] or {r = 1, g = 1, b = 0}
		                frame.sender:SetText(('|cFF%2x%2x%2x%s|r'):format(color.r * 255, color.g * 255, color.b * 255, name))
		                if frame.text:GetWidth() < frame.sender:GetWidth() then
		                    frame.text:SetWidth(frame.sender:GetWidth())
		                end
		            end
		        end
	        end
	 	
	        local function FindFrame(msg)
	            for i = 1, WorldFrame:GetNumChildren() do
	                local frame = select(i, WorldFrame:GetChildren())
	                if (not frame:IsForbidden() and not frame:GetName() and not frame.inUse) then
	                    for i = 1, select('#', frame:GetRegions()) do
	                        local region = select(i, frame:GetRegions())
	                        if region:GetObjectType() == 'FontString' and region:GetText() == msg then
	                            return frame
	                        end
	                    end
	                end
	            end
	        end
	 
	        local ChatBubbleFrame = CreateFrame('Frame')
	        for event, cvar in pairs(events) do 
	            ChatBubbleFrame:RegisterEvent(event) 
	        end
	 
	        ChatBubbleFrame:SetScript('OnEvent', function(self, event, msg, sender, _, _, _, _, _, _, _, _, _, guid)
	            if (GetCVarBool(events[event])) then
	                ChatBubbleFrame.elapsed = 0
	                ChatBubbleFrame:SetScript('OnUpdate', function(self, elapsed)
	                    self.elapsed = self.elapsed + elapsed
	                    local frame = FindFrame(msg)
	                    if (frame or self.elapsed > 0.3) then
	                        ChatBubbleFrame:SetScript('OnUpdate', nil)
	                        if (frame) then 
	                            UpdateFrame(frame, guid, sender) 
	                        end
	                    end
	                end)
	            end
	        end)
		else
			return nil
	    end
	else
		return nil
    end
end)
----------------------------------------------------
-- Square Minimap
----------------------------------------------------
-- Thanks to Dawn for part of this amazing minimap code
local SquareMinimap_ = CreateFrame("CheckButton", "$parentSquareMinimap_", UIParent, "ChatConfigCheckButtonTemplate")
SquareMinimap_:RegisterEvent("PLAYER_ENTERING_WORLD")
SquareMinimap_:SetScript("OnEvent", function(self, event, ...)
	
	-- minimap default position - you can move it ingame by holding down ALT!
	if (AbyssUIClassicAddonSettings.DisableSquareMinimap ~= true and AbyssUIClassicAddonSettings.HideMinimap ~= true) then
		local position = "TOPRIGHT"     	
		local position_x = -8       		
		local position_y = -20

		-- achievement/quest tracker position
		local qparent = UIParent
		local qanchor = "TOPRIGHT"  	 
		local qposition_x = -60           
		local qposition_y = -260         
		local qheight = 400             

		local showclock = true		

		local mediaFolder = "Interface\\AddOns\\AbyssUIClassic\\Textures\\minimap\\"
		local texture = "Interface\\AddOns\\AbyssUIClassic\\Textures\\minimap\\WHITE8x8"
		local backdrop = {bgFile = texture, edgeFile = texture, edgeSize = 1, insets = { left = -1, right = -1, top = -1, bottom = -1}}
		local backdrop = {edgeFile = texture, edgeSize = 8}

		local mailicon = mediaFolder.."mail"
		local font = subFont
		local fontSize = 11
		local fontFlag = "THINOUTLINE"

		local backdropcolor = {0/255, 0/255, 0/255}			-- backdrop color	
		local brdcolor = {0/255, 0/255, 0/255}				-- backdrop border color
		--local infocolor = {41/255, 41/255, 41/255}		-- info panel color
		--local IpanelBGalpha = 0.5							-- info panel background alpha

		local classColoredBorder = true
		local scale = 1

		-- style --
		local _, class = UnitClass('player')
		local color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]			
		
		Minimap:SetSize(182*scale, 182*scale)
		Minimap:SetMaskTexture(mediaFolder.."rectanglenew")
		Minimap:SetHitRectInsets(0, 0, scale, scale)
		Minimap:ClearAllPoints()
		Minimap:SetPoint(position, UIParent, position_x, position_y)
		Minimap:SetScale(scale)
		Minimap:SetFrameLevel(6)		

		BorderFrame = CreateFrame("Frame", nil, self, BackdropTemplateMixin and "BackdropTemplate")
		BorderFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, (scale))
		BorderFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, -(scale))
		BorderFrame:SetBackdrop(backdrop)
		if not classColoredBorder then
			BorderFrame:SetBackdropBorderColor(unpack(brdcolor))
		else
			if ( AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true ) then
				if ( AbyssUIClassicAddonSettings.KeepUnitDark == true and AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true ) then
					BorderFrame:SetBackdropBorderColor(unpack(brdcolor))
				elseif ( AbyssUIClassicAddonSettings.UIVertexColorFrames02 == true and AbyssUIClassicAddonSettings.KeepUnitDark ~= true ) then
					BorderFrame:SetBackdropBorderColor(unpack(brdcolor))				
				else
					local r, g, b = AbyssUIClassic_RBGColorizationFrameFunction(BorderFrame)
					BorderFrame:SetBackdropBorderColor(r, g, b)
				end
			else
				local character = UnitName("player").."-"..GetRealmName()
				BorderFrame:SetBackdropBorderColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)
			end
		end	
		BorderFrame:SetBackdropColor(unpack(backdropcolor))
		BorderFrame:SetFrameLevel(2)
		
		-- hide some stuff --
		--MinimapBackdrop:Hide()
		MinimapBorder:Hide()
		MinimapBorderTop:Hide()
		MinimapZoomIn:Hide()
		MinimapZoomOut:Hide()	
		GameTimeFrame:Hide()		
		--MiniMapTracking:Hide()
		MiniMapTrackingButtonBorder:Hide()
		MiniMapTrackingBackground:Hide()
		MiniMapTrackingIconOverlay:Hide()
		MiniMapMailBorder:Hide()	
		--MiniMapVoiceChatFrame:Hide()
		--MinimapZoneTextButton:Hide()	
		--MinimapNorthTag:SetAlpha(0)
		--MiniMapInstanceDifficulty:SetAlpha(0)
		--GuildInstanceDifficulty:SetAlpha(0)

		if showclock then
			LoadAddOn('Blizzard_TimeManager')
			local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
			clockFrame:Hide()
			clockTime:Show()
			clockTime:SetFont(font, fontSize, fontFlag)
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, 0, 0)
		else
			LoadAddOn('Blizzard_TimeManager')
			TimeManagerClockButton.Show = TimeManagerClockButton.Hide
			local region = TimeManagerClockButton:GetRegions()
			region:Hide()	
			TimeManagerClockButton:ClearAllPoints()	
			TimeManagerClockButton:Hide()	
		end
		--MiniMapMailFrame:ClearAllPoints()
		--MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, 1, -20)
		--MiniMapMailFrame:SetFrameLevel(10)
		MiniMapTracking:ClearAllPoints()
		MiniMapTracking:SetPoint("TOPRIGHT", Minimap, -5, -5)
		MiniMapMailIcon:SetTexture(mailicon)
		MiniMapWorldMapButton:Hide()
		DropDownList1:SetClampedToScreen(true)	
		
		-- WatchFrame
		WatchFrame:SetScript("OnUpdate", function()
			if MultiBarRight:IsShown() and MultiBarLeft:IsShown() then
				WatchFrame:ClearAllPoints()
				WatchFrame:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -100, -50)
			elseif MultiBarRight:IsShown() then
				WatchFrame:ClearAllPoints()
				WatchFrame:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -50, -50)
			else
				WatchFrame:ClearAllPoints()
				WatchFrame:SetPoint("TOPRIGHT", MinimapCluster, "BOTTOMRIGHT", -25, -50)
			end
		end)

		-- mousewheel zoom --
		Minimap:EnableMouseWheel(true)
		Minimap:SetScript("OnMouseWheel", function(self, direction)
			if(direction > 0) then
				Minimap_ZoomIn()
			else
				Minimap_ZoomOut()
			end
		end)

		-- options/dropdown
		Minimap:SetScript('OnMouseUp', function(self, button)
			Minimap:StopMovingOrSizing()
			if (button == 'RightButton') then
				ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
			elseif (button == 'MiddleButton') then
				ToggleCalendar()
			else
				Minimap_OnClick(self)
			end
		end)

		local function GetMinimapShape() return 'SQUARE' end

		-- style Battlefield Minimap
		local function hide(f)
			f:SetTexture()
			f.SetTexture = function() end
		end
		hooksecurefunc("LoadAddOn", function(addon)
			if addon ~= "Blizzard_BattlefieldMinimap" then return end

			BattlefieldMinimapBackground:Hide()
			BattlefieldMinimapCorner:Hide()
			BattlefieldMinimapCloseButton:Hide()
			BattlefieldMinimapTab:Hide()
			
			BBorderFrame = CreateFrame("Frame", nil, BattlefieldMinimap)
			BBorderFrame:SetPoint("TOPLEFT", BattlefieldMinimap, "TOPLEFT", -1, 1)
			BBorderFrame:SetPoint("BOTTOMRIGHT", BattlefieldMinimap, "BOTTOMRIGHT", -5, 3)	
			BBorderFrame:SetBackdrop(backdrop)
			if not classColoredBorder then
				BBorderFrame:SetBackdropBorderColor(unpack(brdcolor))
			else
				local r, g, b = AbyssUIClassic_RBGColorizationFrameFunction(BorderFrame)
				BorderFrame:SetBackdropBorderColor(r, g, b)
			end	
			BBorderFrame:SetBackdropColor(unpack(backdropcolor))
			BBorderFrame:SetFrameLevel(6)		
		end)
	else
		Minimap:SetMaskTexture("Interface\\AddOns\\AbyssUIClassic\\Textures\\minimap\\round")
	end
end)
----------------------------------------------------
-- Kill Announcer Frame
----------------------------------------------------
local KillAnouncerFrame = CreateFrame("Frame", "$parentKillAnouncerFrame", UIParent)
KillAnouncerFrame:SetFrameStrata("BACKGROUND")
KillAnouncerFrame:SetWidth(128)
KillAnouncerFrame:SetHeight(128)
KillAnouncerFrame:SetAlpha(.90)
KillAnouncerFrame:SetClampedToScreen(true)
KillAnouncerFrame:SetPoint("CENTER", 120, 5)
KillAnouncerFrame:Hide()
local t = KillAnouncerFrame:CreateTexture(nil, "BACKGROUND")
t:SetTexture("Interface\\Addons\\AbyssUIClassic\\Textures\\extra\\bloodtexture")
t:SetAllPoints(KillAnouncerFrame)
KillAnouncerFrame.texture = t
-- Text
KillAnouncerFrame.text = KillAnouncerFrame.text or KillAnouncerFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
KillAnouncerFrame.text:SetScale(1)
KillAnouncerFrame.text:SetJustifyH("CENTER")
KillAnouncerFrame.text:SetJustifyV("CENTER")
KillAnouncerFrame.text:SetPoint("CENTER", KillAnouncerFrame, "CENTER", 0, -15)
KillAnouncerFrame.text:SetFont(damageFont, 14, "THINOUTLINE")
KillAnouncerFrame.text:SetShadowColor(0/255, 0/255, 0/255)
KillAnouncerFrame.text:SetShadowOffset(1, -1)
-- KillAnouncerHeader
local _G = _G
local KillText = _G["KILLS"]
local KillAnouncerHeader = CreateFrame("Frame", "$parentKillAnouncerHeader", KillAnouncerFrame)
KillAnouncerHeader:SetFrameStrata("BACKGROUND")
KillAnouncerHeader:SetWidth(128)
KillAnouncerHeader:SetHeight(128)
KillAnouncerHeader:SetPoint("CENTER", 0, 20)
-- Text
KillAnouncerHeader.text = KillAnouncerHeader.text or KillAnouncerHeader:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
KillAnouncerHeader.text:SetScale(1.25)
KillAnouncerHeader.text:SetJustifyH("CENTER")
KillAnouncerHeader.text:SetJustifyV("CENTER")
KillAnouncerHeader.text:SetPoint("CENTER", KillAnouncerHeader, "CENTER", 0, -8)
KillAnouncerHeader.text:SetFont(damageFont, 14, "THINOUTLINE")
KillAnouncerHeader.text:SetShadowColor(0/255, 0/255, 0/255)
KillAnouncerHeader.text:SetShadowOffset(1, -1)
KillAnouncerHeader.text:SetText(strupper("|cfffd0101"..KillText.."|r"))
-- Kill SoundList
local soundIDSHorde = { 
	24531,  -- RAGNAROS 
	24530,  -- RAGNAROS2
	38065,  -- GARROSH 
	38066,  -- GARROSH2
	16020,  -- GARROSH3
	24477,  -- FANDRAL 
	13324,  -- Telestra 
	45439,  -- BLACKHAND2 
	21164,  -- Baine
	43913,  -- Koromar
	16146,  -- JARAXXUS
	109300, -- Bwonsamdi
	15591,  -- Kologarn
	42070,  -- Gugrokk2
	50083,  -- Kormrok
	24226,  -- DAAKARA
	44525,  -- KARGATH
	17067,  -- Valithria
	48498, 	-- Orc Male
	14506,  -- Xevozz
	16695,  -- Dsaurfang 
	16854,  -- Taldaram
	16681,  -- Valanar
	35572, 	-- KAZRAJIN
	50594,  -- DARKVINDICATOR
	50593,	-- DARKVINDICATOR2
	8894, 	-- BLA_NAXX
	8801,	-- FAER_NAXX
	10169,	-- Keli
	12027,	-- Halazzi
	10334,	-- Garg
	5831,	-- Herod
	15740,	-- Thorim
	10454,  -- Thrall
	35591, 	-- LeiShen
}
local soundIDSAlly = { 
	24531,  -- RAGNAROS 
	24530,  -- RAGNAROS2
	24477,  -- FANDRAL 
	13324,  -- Telestra 
	43913,  -- Koromar
	21576,  -- Muradin
	21574,  -- Muradin2
	16146,  -- JARAXXUS
	109300, -- Bwonsamdi
	15591,  -- Kologarn
	16061,  -- Varian
	16062, 	-- Varian2
	42070,  -- Gugrokk2
	43254,  -- Leroy Jenkins
	50083,  -- Kormrok
	44525,  -- KARGATH
	17067,  -- Valithria
	14506,  -- Xevozz
	16854,  -- Taldaram
	16681,  -- Valanar
	35572, 	-- KAZRAJIN
	50594,  -- DARKVINDICATOR
	50593,	-- DARKVINDICATOR2
	8894, 	-- BLA_NAXX
	8801,	-- FAER_NAXX
	10169,	-- Keli
	12027,	-- Halazzi
	10334,	-- Garg
	5831,	-- Herod
	15740,	-- Thorim
	35591, 	-- LeiShen
}
local numSoundsHorde = #soundIDSHorde
local numSoundsAlly  = #soundIDSAlly
local englishFaction, localizedFaction = UnitFactionGroup("player")
local function PlaySoundRandom()
	if ( englishFaction == "Horde") then
		PlaySound(soundIDSHorde[random(1, numSoundsHorde)], "MASTER")
	elseif ( englishFaction == "Alliance") then
		PlaySound(soundIDSAlly[random(1, numSoundsAlly)], "MASTER")
	else
		return nil
	end
end
-- Kill Announcer
local KillAnouncer = CreateFrame("FRAME", "$parentKillAnouncer")
local name = GetUnitName("player")
KillAnouncer:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
KillAnouncer:SetScript("OnEvent", function(self)
	if ( AbyssUIClassicAddonSettings.DisableKillAnnouncer ~= true ) then
	    local timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, prefixParam1, prefixParam2, dummyparam, suffixParam1, suffixParam2 = CombatLogGetCurrentEventInfo()
	    if ( event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" ) and suffixParam2 > 0 then
			if ( suffixParam2 ~= nil ) then
				if ( sourceName == name ) then
					if ( string.find(destGUID, "Player") ) then
						KillAnouncerFrame:Hide()
						KillAnouncerFrame.text:SetText("|cfff2f2f2"..destName.."|r")
						if ( AbyssUIClassicAddonSettings.SilenceKillAnnouncer ~= true ) then
							PlaySoundRandom()
						end
						UIFrameFadeIn(KillAnouncerFrame, 4, 1, 0)
					end
		  		end
		  	end
	  	elseif ( event == "SWING_DAMAGE" ) and prefixParam2 > 0 then
	  		if ( prefixParam2 ~= nil ) then
				if ( sourceName == name ) then
					if ( string.find(destGUID, "Player") ) then
						KillAnouncerFrame:Hide()
						KillAnouncerFrame.text:SetText("|cfff2f2f2"..destName.."|r")
						if ( AbyssUIClassicAddonSettings.SilenceKillAnnouncer ~= true ) then
							PlaySoundRandom()
						end
						UIFrameFadeIn(KillAnouncerFrame, 4, 1, 0)
					end
		  		end
		  	end
	    else
	    	return nil
	    end
	else
		return nil
	end
end)
-- Tooltip on cursor
local function cursorSetPoint(self)
	local scale = self:GetEffectiveScale()
	local x, y = GetCursorPosition()
	self:ClearAllPoints()
	self:SetPoint("BOTTOMLEFT", UIParent, x / scale + 16, (y / scale - self:GetHeight() - 16))
end
local TooltipOnCursor = CreateFrame("Frame", nil)
TooltipOnCursor:RegisterEvent("PLAYER_ENTERING_WORLD")
TooltipOnCursor:SetScript("OnEvent", function()
	if ( AbyssUIClassicAddonSettings.TooltipOnCursor == true ) then
		hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
			if GetMouseFocus() ~= WorldFrame then return end
			tooltip:SetOwner(parent, "ANCHOR_CURSOR")
			cursorSetPoint(tooltip)
			-- tooltip.default = 1
		end)
	end
end)
--End