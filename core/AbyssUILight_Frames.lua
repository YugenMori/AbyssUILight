-- Author: Yugen
--
-- Classic
--
-- Hope you like my addOn ^^
--
-- Frames for AbyssUILight
--------------------------------------------------------------------------------
-- Init - Tables - Saves
local addonName, addonTable = ...
local L = LibStub("AceLocale-3.0"):GetLocale("AbyssUILight")
local GetWoWVersion = ((select(4, GetBuildInfo())))
local f = CreateFrame("Frame", "AbyssUILight_Config", UIParent)
f:SetSize(50, 50)
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event, ...)
  character = UnitName("player").."-"..GetRealmName()
  -- Config/Panel
  if not AbyssUILight_Config then
    local AbyssUILight_Config = {}
  end
    if not AbyssUI_Config then
    local AbyssUI_Config = {}
  end
  -- AddonSettings
  if not AbyssUILightAddonSettings then
    AbyssUILightAddonSettings = {}
  end
  if not AbyssUILightAddonSettings[character] then
    AbyssUILightAddonSettings[character] = {}
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
local function AbyssUILight_Fontification(globalFont, subFont, damageFont)
local locale = GetLocale()
local fontName, fontHeight, fontFlags = MinimapZoneText:GetFont()
local mediaFolder = "Interface\\AddOns\\AbyssUILight\\Textures\\font\\"
	if ( locale == "zhCN") then
		globalFont	= mediaFolder.."zhCN-TW\\senty.ttf"
		subFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
		damageFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
	elseif ( locale == "zhTW" ) then
		globalFont	= mediaFolder.."zhCN-TW\\senty.ttf"
		subFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
		damageFont 	= mediaFolder.."zhCN-TW\\senty.ttf"
	elseif ( locale == "ruRU" ) then
		globalFont	= mediaFolder.."ruRU\\dejavu.ttf"
		subFont 	= mediaFolder.."ruRU\\dejavu.ttf"
		damageFont 	= mediaFolder.."ruRU\\dejavu.ttf"
	elseif ( locale == "koKR" ) then
		globalFont	= mediaFolder.."koKR\\dxlbab.ttf"
		subFont 	= mediaFolder.."koKR\\dxlbab.ttf"
		damageFont 	= mediaFolder.."koKR\\dxlbab.ttf"
	elseif ( locale == "frFR" or locale == "deDE" or locale == "enGB" or locale == "enUS" or locale == "itIT" or
		locale == "esES" or locale == "esMX" or locale == "ptBR") then
		globalFont	= mediaFolder.."global.ttf"
		subFont 	= mediaFolder.."npcfont.ttf"
		damageFont 	= mediaFolder.."damagefont_classic.ttf"
	else
		globalFont	= fontName
		subFont 	= fontName
		damageFont 	= fontName
	end
	return globalFont, subFont, damageFont
end
local globalFont, subFont, damageFont = AbyssUILight_Fontification(globalFont, subFont, damageFont)
-- RegionList
local function AbyssUILight_RegionListSize(self, width, height)
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
local function AbyssUILight_FrameSize(self, width, height)
	self:SetWidth(width)
	self:SetHeight(height)
end
--------------------------------------------------------------
--------------------------------------------------------------
local _G = _G
local moveString      = _G["BINDING_NAME_MOVEFORWARD"]
local cancelString    = _G["CANCEL"]
local confirmString   = _G["OKAY"]
local dialogFrameTexture 		= "Interface\\Addons\\AbyssUILight\\textures\\extra\\dialogFrameTexture"
local dialogFrameTextureBorder 	= "Interface\\DialogFrame\\UI-DialogBox-Background"
----------------------------------------------------
----------------------------------------------------
-- AbyssUILight_EditBox_Frame
AbyssUILight_EditBox_Frame = CreateFrame("Frame", "$parentAbyssUILight_EditBox_Frame", AbyssUILight_Config.childpanel1)
AbyssUILight_EditBox_Frame:Hide()
AbyssUILight_EditBox_Frame:SetWidth(500)
AbyssUILight_EditBox_Frame:SetHeight(128)
AbyssUILight_EditBox_Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel1, "CENTER", 0, 0)
AbyssUILight_EditBox_Frame:EnableMouse(true)
AbyssUILight_EditBox_Frame:SetClampedToScreen(true)
AbyssUILight_EditBox_Frame:SetMovable(true)
AbyssUILight_EditBox_Frame:RegisterForDrag("LeftButton")
AbyssUILight_EditBox_Frame:SetScript("OnDragStart", AbyssUILight_EditBox_Frame.StartMoving)
AbyssUILight_EditBox_Frame:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)
AbyssUILight_EditBox_Frame:SetFrameStrata("Dialog")
----------------------------------------------------
local Border = AbyssUILight_EditBox_Frame:CreateTexture(nil, "BACKGROUND")
Border:SetTexture(dialogFrameTextureBorder)
Border:SetPoint("TOPLEFT", -3, 3)
Border:SetPoint("BOTTOMRIGHT", 3, -3)
--Border:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILight_EditBox_Frame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture(dialogFrameTextureBorder)
BorderBody:SetAllPoints(AbyssUILight_EditBox_Frame)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILight_EditBox_Frame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture(dialogFrameTextureBorder)
Texture:SetAllPoints(AbyssUILight_EditBox_Frame)
AbyssUILight_EditBox_Frame.texture = Texture
----------------------------------------------------
local f = CreateFrame("Frame", nil)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function() 
	local FrameButtonConfirm = CreateFrame("Button","$parentFrameButtonConfirm", AbyssUILight_EditBox_Frame, "UIPanelButtonTemplate")
	FrameButtonConfirm:SetHeight(24)
	FrameButtonConfirm:SetWidth(100)
	FrameButtonConfirm:SetPoint("BOTTOM", AbyssUILight_EditBox_Frame, "BOTTOM", 0, 0)
	FrameButtonConfirm.text = FrameButtonConfirm.text or FrameButtonConfirm:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
	FrameButtonConfirm.text:SetFont(globalFont, 12)
	FrameButtonConfirm.text:SetPoint("CENTER", FrameButtonConfirm, "CENTER", 0, 0)
	FrameButtonConfirm.text:SetText(confirmString)
	FrameButtonConfirm.text:SetTextColor(229/255, 229/255, 229/255)
	FrameButtonConfirm.text:SetShadowColor(0, 0, 0)
	FrameButtonConfirm.text:SetShadowOffset(1, -1)
	FrameButtonConfirm:SetScript("OnClick", function()
	  AbyssUILight_EditBox_Frame:Hide()
	end)
end)
----------------------------------------------------
-- EditBox
AbyssUILight_EditBox = CreateFrame("EditBox", "$parentAbyssUILight_EditBox", AbyssUILight_EditBox_Frame)
AbyssUILight_EditBox:SetFont(globalFont, 14, "THINOUTLINE")
AbyssUILight_EditBox:SetPoint("CENTER", 0, 0)
AbyssUILight_EditBox:SetMultiLine(true)
AbyssUILight_EditBox:SetHeight(24)
AbyssUILight_EditBox:SetWidth(450)
----------------------------------------------------
-- AbyssUILight_AFKCameraFrame
local AbyssUILight_AFKCameraFrame = CreateFrame("Frame", "$parentAbyssUILight_AFKCameraFrame", WorldFrame)
AbyssUILight_AFKCameraFrame:SetFrameStrata("HIGH")
AbyssUILight_AFKCameraFrame:SetScale(UIParent:GetScale())
AbyssUILight_AFKCameraFrame:SetAllPoints(UIParent)
AbyssUILight_AFKCameraFrame:SetClampedToScreen(true)
AbyssUILight_AFKCameraFrame:Hide()
-- Text
AbyssUILight_AFKCameraFrame.text = AbyssUILight_AFKCameraFrame.text or AbyssUILight_AFKCameraFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
AbyssUILight_AFKCameraFrame.text:SetScale(2)
AbyssUILight_AFKCameraFrame.text:SetAllPoints(true)
AbyssUILight_AFKCameraFrame.text:SetJustifyH("BOTTOM")
AbyssUILight_AFKCameraFrame.text:SetJustifyV("BOTTOM")
AbyssUILight_AFKCameraFrame.text:SetWidth(GetScreenWidth()/4)
AbyssUILight_AFKCameraFrame.text:SetHeight(GetScreenHeight()/2)
AbyssUILight_AFKCameraFrame.text:SetText(moveString)
-- Texture
local Texture = AbyssUILight_AFKCameraFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_AFKCameraFrame)
AbyssUILight_AFKCameraFrame.texture = Texture
----------------------------------------------------
-- AFK Camera Function
local AbyssUILight_AFKCamera = CreateFrame("Frame", "$parentAbyssUILight_AFKCamera", nil)
AbyssUILight_AFKCamera:RegisterEvent("PLAYER_FLAGS_CHANGED")
AbyssUILight_AFKCamera:RegisterEvent("PLAYER_ENTERING_WORLD")
----------------------------------------------------
-- ModelFrameAFKMode
-- Model1
local AbyssUILight_ModelFrameAFKMode = CreateFrame("Frame", "$parentAbyssUILight_ModelFrameAFKMode", AbyssUILight_AFKCameraFrame)
AbyssUILight_ModelFrameAFKMode:SetPoint("BOTTOMRIGHT", 5, 5)
AbyssUILight_ModelFrameAFKMode:SetWidth(CharacterModelFrame:GetWidth()*2)
AbyssUILight_ModelFrameAFKMode:SetHeight(CharacterModelFrame:GetHeight()*2)
AbyssUILight_ModelFrameAFKMode:SetAlpha(1)
local ModelFrame_Model1 = CreateFrame("PlayerModel", "$parentModelFrame_Model1", AbyssUILight_ModelFrameAFKMode)
ModelFrame_Model1:SetUnit("player")
ModelFrame_Model1:SetAlpha(1)
ModelFrame_Model1:SetAllPoints(AbyssUILight_ModelFrameAFKMode)
ModelFrame_Model1:SetCustomCamera(1)
----------------------------------------------------
-- PlayerInfoAFKMode
-- Name
local PlayerInfo_Name1 = CreateFrame("Frame", "$parentPlayerInfo_Name1", AbyssUILight_AFKCameraFrame)
local playerName = UnitName("player")
PlayerInfo_Name1:SetAllPoints(AbyssUILight_AFKCameraFrame)
PlayerInfo_Name1:SetScale(4)
PlayerInfo_Name1.text = PlayerInfo_Name1.text or PlayerInfo_Name1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
PlayerInfo_Name1.text:SetPoint("TOP", 0, -1)
PlayerInfo_Name1.text:SetText(playerName)
-- Race
local PlayerInfo_Race1 = CreateFrame("Frame", "$parentPlayerInfo_Race1", AbyssUILight_AFKCameraFrame)
local race, raceEn = UnitRace("player")
PlayerInfo_Race1:SetAllPoints(AbyssUILight_AFKCameraFrame)
PlayerInfo_Race1:SetScale(3)
PlayerInfo_Race1.text = PlayerInfo_Race1.text or PlayerInfo_Race1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
PlayerInfo_Race1.text:SetPoint("BOTTOMLEFT", 5, 100)
PlayerInfo_Race1.text:SetText(raceEn)
-- Class
local PlayerInfo_Class1 = CreateFrame("Frame", "$parentPlayerInfo_Class1", AbyssUILight_AFKCameraFrame)
local playerClass, englishClass = UnitClass("player")
PlayerInfo_Class1:SetAllPoints(AbyssUILight_AFKCameraFrame)
PlayerInfo_Class1:SetScale(3)
PlayerInfo_Class1.text = PlayerInfo_Class1.text or PlayerInfo_Class1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
PlayerInfo_Class1.text:SetPoint("BOTTOMLEFT", 5, 90)
PlayerInfo_Class1.text:SetText(playerClass)
-- Level
local PlayerInfo_Level1 = CreateFrame("Frame", "$parentPlayerInfo_Level1", AbyssUILight_AFKCameraFrame)
local level = UnitLevel("player")
PlayerInfo_Level1:SetAllPoints(AbyssUILight_AFKCameraFrame)
PlayerInfo_Level1:SetScale(3)
PlayerInfo_Level1.text = PlayerInfo_Level1.text or PlayerInfo_Level1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
PlayerInfo_Level1.text:SetPoint("BOTTOMLEFT", 5, 80)
PlayerInfo_Level1.text:SetText(level)
-- Zone
local PlayerInfo_CurrentZone1 = CreateFrame("Frame", "$parentPlayerInfo_Class1", AbyssUILight_AFKCameraFrame)
local zoneName = GetZoneText()
PlayerInfo_CurrentZone1:SetAllPoints(AbyssUILight_AFKCameraFrame)
PlayerInfo_CurrentZone1:SetScale(3)
PlayerInfo_CurrentZone1.text = PlayerInfo_CurrentZone1.text or PlayerInfo_CurrentZone1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
PlayerInfo_CurrentZone1.text:SetPoint("BOTTOMLEFT", 5, 70)
PlayerInfo_CurrentZone1.text:SetText(zoneName)
-- Guild Info
local PlayerInfo_Guild1 = CreateFrame("Frame", "$parentPlayerInfo_Class1", AbyssUILight_AFKCameraFrame)
local guildName, guildRankName, guildRankIndex = GetGuildInfo("player")
PlayerInfo_Guild1:SetAllPoints(AbyssUILight_AFKCameraFrame)
PlayerInfo_Guild1:SetScale(3)
PlayerInfo_Guild1.text = PlayerInfo_Guild1.text or PlayerInfo_Guild1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
PlayerInfo_Guild1.text:SetPoint("BOTTOMLEFT", 5, 50)
PlayerInfo_Guild1.text:SetText(guildName)
-- CLock
local ExtraInfo_Clock1 = CreateFrame("Frame", "$parentExtraInfo_Clock1", AbyssUILight_AFKCameraFrame)
ExtraInfo_Clock1:SetAllPoints(AbyssUILight_AFKsCameraFrame)
ExtraInfo_Clock1:SetScale(3)
ExtraInfo_Clock1.text = ExtraInfo_Clock1.text or ExtraInfo_Clock1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
ExtraInfo_Clock1.text:SetPoint("TOPRIGHT", -5, -1)
-- Faction
local englishFaction, localizedFaction = UnitFactionGroup("player")
local ExtraInfo_Faction1 = CreateFrame("Frame", "$parentExtraInfo_Faction1", AbyssUILight_AFKCameraFrame)
ExtraInfo_Faction1:SetWidth(64)
ExtraInfo_Faction1:SetHeight(64)
ExtraInfo_Faction1:SetPoint("TOPLEFT", 5, -5)
ExtraInfo_Faction1:SetScale(3)
if (GetWoWVersion >= 30500) then
	local t = ExtraInfo_Faction1:CreateTexture(nil, "HIGH")
		if ( englishFaction == "Horde" ) then
			t:SetTexture("Interface\\AddOns\\AbyssUILight\\Textures\\extra\\Horde-Logo")
		else
			t:SetTexture("Interface\\AddOns\\AbyssUILight\\Textures\\extra\\Alliance-Logo")
		end
	t:SetAllPoints(ExtraInfo_Faction1)
end
-- Gold Amount
local _G = _G
local currency = _G["MONEY"]
local PlayerInfo_GoldAmount1 = CreateFrame("Frame", "$parentPlayerInfo_GoldAmount1", AbyssUILight_AFKCameraFrame)
PlayerInfo_GoldAmount1:RegisterEvent("PLAYER_FLAGS_CHANGED")
PlayerInfo_GoldAmount1:RegisterEvent("PLAYER_ENTERING_WORLD")
local money = GetCoinTextureString(GetMoney())
PlayerInfo_GoldAmount1:SetAllPoints(AbyssUILight_AFKCameraFrame)
PlayerInfo_GoldAmount1:SetScale(3)
PlayerInfo_GoldAmount1.text = PlayerInfo_GoldAmount1.text or PlayerInfo_GoldAmount1:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
PlayerInfo_GoldAmount1.text:SetPoint("BOTTOMLEFT", 5 , 1)
PlayerInfo_GoldAmount1.text:SetText(currency.."|cfff2dc7f"..money.."|r")
-- Class colorization (all player info)
 if ( englishClass == "DEATHKNIGHT" ) then
 	for i, v in pairs({ 
		AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(196/255, 30/255, 59/255)
 	end 
 elseif ( englishClass == "DEMONHUNTER" ) then
 	 for i, v in pairs({ 
 		AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1,	 }) do
 		v.text:SetVertexColor(163/255, 48/255, 201/255)
 	end 
 elseif ( englishClass == "DRUID" ) then
 	 for i, v in pairs({ 
 	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(255/255, 125/255, 10/255)
 	end 
 elseif ( englishClass == "HUNTER" ) then
  	 for i, v in pairs({
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(171/255, 212/255, 115/255)
 	end 
 elseif ( englishClass == "MAGE" ) then
  	 for i, v in pairs({ 
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(105/255, 204/255, 240/255)
 	end 
 elseif ( englishClass == "MONK" ) then
  	 for i, v in pairs({ 
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(0/255, 255/255, 150/255)
 	end 
 elseif ( englishClass == "PALADIN" ) then
  	 for i, v in pairs({ 
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(245/255, 140/255, 186/255)
 	end 
 elseif ( englishClass == "PRIEST" ) then
  	 for i, v in pairs({ 
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(255/255, 255/255, 255/255)
 	end 
 elseif ( englishClass == "ROGUE" ) then
  	 for i, v in pairs({ 
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(255/255, 245/255, 105/255)
 	end 
 elseif ( englishClass == "SHAMAN" ) then
  	 for i, v in pairs({
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(0/255, 112/255, 222/255)
 	end 
 elseif ( englishClass == "WARLOCK" ) then
  	 for i, v in pairs({ 
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(148/255, 130/255, 201/255)
 	end 
 elseif ( englishClass == "WARRIOR" ) then
  	 for i, v in pairs({ 
  	 	AbyssUILight_AFKCameraFrame,
		PlayerInfo_Name1,
		PlayerInfo_Level1, 
		PlayerInfo_Race1, 
		PlayerInfo_Class1,
		PlayerInfo_CurrentZone1,
		PlayerInfo_Guild1,
		ExtraInfo_Clock1,
	PlayerInfo_GoldAmount1, }) do
 		v.text:SetVertexColor(199/255, 156/255, 110/255)
 	end 
 else
 	return nil
 end
 local function AbyssUILight_UpdateAFKCameraData()
	-- Get
	playerName = UnitName("player")
	level = UnitLevel("player")
	race, raceEn = UnitRace("player")
	playerClass, englishClass = UnitClass("player")
	zoneName = GetZoneText()
	guildName, guildRankName, guildRankIndex = GetGuildInfo("player")
	if ( AbyssUILightAddonSettings.ExtraFunctionAmericanClock == true ) then
		dataTime = date("%H:%M |cfff2dc7f%m/%d/%y|r ")
	else
		dataTime = date("%H:%M |cfff2dc7f%d/%m/%y|r ")
	end
	money = GetCoinTextureString(GetMoney())
	-- Set
	PlayerInfo_Name1.text:SetText(playerName)
	PlayerInfo_Level1.text:SetText("Level: "..level)
	PlayerInfo_Race1.text:SetText(race)
	PlayerInfo_Class1.text:SetText(playerClass)
	ExtraInfo_Clock1.text:SetText(dataTime)
	PlayerInfo_GoldAmount1.text:SetText(currency..": |cfff2dc7f"..money.."|r")
	PlayerInfo_CurrentZone1.text:SetText(zoneName)
	PlayerInfo_Guild1.text:SetText(guildName)
end
-- Clock Update
local timer = ExtraInfo_Clock1:CreateAnimationGroup()
local timerAnim = timer:CreateAnimation()
timerAnim:SetDuration(5) -- how often you want it to finish
timer:SetScript("OnFinished", function(self, requested)
	-- requested = true if you used timer:Stop(), false if it finished naturally
	AbyssUILight_UpdateAFKCameraData()
	self:Play() -- start it over again
end)
timer:Play()
----------------------------------------------------
-- AbyssUILight_AFKCamera SetScript
AbyssUILight_AFKCamera:SetScript("OnEvent", function(self, event, ...)
	local inInstance, instanceType = IsInInstance()
	if ( AbyssUILightAddonSettings.AFKCammeraFrame ~= true ) then
		if ( event == "PLAYER_FLAGS_CHANGED" or event == "PLAYER_ENTERING_WORLD" ) then
			local isAFK = UnitIsAFK("player")
			if isAFK == true and inInstance ~= true then
				UIParent:SetAlpha(0)
				if AbyssUILightAddonSettings.HideMinimap ~= true then
					MinimapCluster:Hide()
				end
				AbyssUILight_UpdateAFKCameraData()
				UIFrameFadeIn(AbyssUILight_AFKCameraFrame, 3, 0, 1)
			elseif isAFK == false and inInstance ~= true then
				AbyssUILight_AFKCameraFrame:Hide()
				UIParent:SetAlpha(1)
				if AbyssUILightAddonSettings.HideMinimap ~= true then
					MinimapCluster:Show()
				end
			elseif isAFK == true and inInstance == true then
				AbyssUILight_AFKCameraFrame:Hide()
				UIParent:SetAlpha(1)
				if AbyssUILightAddonSettings.HideMinimap ~= true then
					MinimapCluster:Show()
				end
			elseif isAFK == false and inInstance == true then
				AbyssUILight_AFKCameraFrame:Hide()
				UIParent:SetAlpha(1)
				if AbyssUILightAddonSettings.HideMinimap ~= true then
					MinimapCluster:Show()
				end
			else
				AbyssUILight_AFKCameraFrame:Hide()
			end
		end
		-- OnClick
		if ( AbyssUILight_AFKCameraFrame:IsShown() ) then
			AbyssUILight_AFKCameraFrame:SetScript("OnMouseDown", function (self, button)
			    if ( button == 'RightButton' ) then 
			    	AbyssUILight_AFKCameraFrame:Hide()
					UIParent:SetAlpha(1)
					if AbyssUILightAddonSettings.HideMinimap ~= true then
						MinimapCluster:Show()
					end
			    end
			end)
		end
	else
		return nil
	end
end)
--------------------------------------------
-- YouDied Frame
local _G = _G
local deathrecap = _G["DEAD"]
local AbyssUILight_YouDiedFrame = CreateFrame("Frame", "$parentAbyssUILight_YouDiedFrame", UIParent)
AbyssUILight_YouDiedFrame:RegisterEvent("PLAYER_DEAD")
AbyssUILight_YouDiedFrame:SetFrameStrata("HIGH")
AbyssUILight_YouDiedFrame:SetWidth(GetScreenWidth())
AbyssUILight_YouDiedFrame:SetHeight(GetScreenHeight()/4)
AbyssUILight_YouDiedFrame:SetClampedToScreen(true)
AbyssUILight_YouDiedFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
AbyssUILight_YouDiedFrame.text = AbyssUILight_YouDiedFrame.text or AbyssUILight_YouDiedFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
AbyssUILight_YouDiedFrame.text:SetScale(8*2)
AbyssUILight_YouDiedFrame.text:SetAllPoints(true)
AbyssUILight_YouDiedFrame.text:SetJustifyH("CENTER")
AbyssUILight_YouDiedFrame.text:SetJustifyV("CENTER")
AbyssUILight_YouDiedFrame.text:SetText(strupper("|cff8b0000"..deathrecap.."|r"))
AbyssUILight_YouDiedFrame.text:SetWidth(GetScreenWidth())
AbyssUILight_YouDiedFrame.text:SetHeight(GetScreenHeight()/4)
AbyssUILight_YouDiedFrame:Hide()
AbyssUILight_YouDiedFrame:SetScript("OnEvent", function(self, event, ...)
	if ( AbyssUILightAddonSettings.HideYouDiedLevelUpFrame ~= true ) then
		if ( event == "PLAYER_DEAD" ) then
			UIFrameFadeIn(AbyssUILight_YouDiedFrame, 2, 0, 1)
			C_Timer.After(4, function()
				UIFrameFadeIn(AbyssUILight_YouDiedFrame, 4, 1, 0)
			end)
			C_Timer.After(10, function()
				AbyssUILight_YouDiedFrame:Hide()
			end)
		else
			return nil
		end
	else
		return nil
	end
end)
----------------------------------------------------
local AbyssUILightBorder = AbyssUILight_YouDiedFrame:CreateTexture(nil, "BACKGROUND")
AbyssUILightBorder:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
AbyssUILightBorder:SetPoint("TOPLEFT", -3, 3)
AbyssUILightBorder:SetPoint("BOTTOMRIGHT", 3, -3)
AbyssUILightBorder:SetVertexColor(0.6, 0.6, 0.6, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILight_YouDiedFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILight_YouDiedFrame)
BorderBody:SetVertexColor(0.6, 0.6, 0.6, 0.6)
----------------------------------------------------
local Texture = AbyssUILight_YouDiedFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_YouDiedFrame)
AbyssUILight_YouDiedFrame.texture = Texture
----------------------------------------------------
-- LevelUp Fixes
local _G = _G
local levelupreachedString 	= _G["LEVEL_UP_YOU_REACHED"]
local levelString 	 		= _G["LEVEL"]
-- LevelUp Frame
local AbyssUILight_LevelUpFrame = CreateFrame("Frame", "$parentAbyssUILight_LevelUpFrame", UIParent)
AbyssUILight_LevelUpFrame:SetFrameStrata("DIALOG")
AbyssUILight_LevelUpFrame:SetWidth(GetScreenWidth())
AbyssUILight_LevelUpFrame:SetHeight(GetScreenHeight()/4)
AbyssUILight_LevelUpFrame:SetClampedToScreen(true)
AbyssUILight_LevelUpFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
AbyssUILight_LevelUpFrame.text = AbyssUILight_LevelUpFrame.text or AbyssUILight_LevelUpFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
AbyssUILight_LevelUpFrame.text:SetScale(8)
AbyssUILight_LevelUpFrame.text:SetPoint("CENTER", 0, 5)
AbyssUILight_LevelUpFrame.text:SetText(strupper(levelupreachedString))
AbyssUILight_LevelUpFrame.text:SetWidth(GetScreenWidth())
AbyssUILight_LevelUpFrame.text:SetHeight(GetScreenHeight()/4)
AbyssUILight_LevelUpFrame:Hide()
----------------------------------------------------
local AbyssUILightBorder = AbyssUILight_LevelUpFrame:CreateTexture(nil, "BACKGROUND")
AbyssUILightBorder:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
AbyssUILightBorder:SetPoint("TOPLEFT", -3, 3)
AbyssUILightBorder:SetPoint("BOTTOMRIGHT", 3, -3)
AbyssUILightBorder:SetVertexColor(0.3, 0.3, 0.3, 0.3)
----------------------------------------------------
local BorderBody = AbyssUILight_LevelUpFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILight_LevelUpFrame)
BorderBody:SetVertexColor(0.3, 0.3, 0.3, 0.3)
----------------------------------------------------
local Texture = AbyssUILight_LevelUpFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_LevelUpFrame)
AbyssUILight_LevelUpFrame.texture = Texture
----------------------------------------------------
-- Player Name/Level
local LevelUp_PlayerInfo = CreateFrame("Frame", "$parentLevelUp_PlayerLevel", AbyssUILight_LevelUpFrame)
LevelUp_PlayerInfo:SetAllPoints(AbyssUILight_LevelUpFrame)
LevelUp_PlayerInfo:SetScale(8)
LevelUp_PlayerInfo.text = LevelUp_PlayerInfo.text or LevelUp_PlayerInfo:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
LevelUp_PlayerInfo.text:SetPoint("CENTER", 0, -5)
LevelUp_PlayerInfo.text:SetText(strupper("|cfff2dc7f"..levelString.."|r ".."|cfff2dc7f"..level.."|r"))
LevelUp_PlayerInfo.text:SetWidth(GetScreenWidth())
LevelUp_PlayerInfo.text:SetHeight(GetScreenHeight()/4)
local function AbyssUILight_UpdateYouDiedLevelUpData()
	-- Get
	level = UnitLevel("player")
	-- Set
	LevelUp_PlayerInfo.text:SetText(strupper("|cfff2dc7f"..levelString.."|r ".."|cfff2dc7f"..level.."|r"))
end
AbyssUILight_LevelUpFrame:RegisterEvent("PLAYER_LEVEL_UP")
AbyssUILight_LevelUpFrame:SetScript("OnEvent", function(self, event, ...)
	if ( AbyssUILightAddonSettings.HideYouDiedLevelUpFrame ~= true ) then
		if ( event == "PLAYER_LEVEL_UP" ) then
			C_Timer.After(1, function()
				AbyssUILight_UpdateYouDiedLevelUpData()
				UIFrameFadeIn(AbyssUILight_LevelUpFrame, 2, 0, 1)
			end)
			C_Timer.After(3, function()
				UIFrameFadeIn(AbyssUILight_LevelUpFrame, 4, 1, 0)
			end)
			C_Timer.After(10, function()
				AbyssUILight_LevelUpFrame:Hide()
			end)
		else
			return nil
		end
	else
		return nil
	end
end)
----------------------------------------------------
-- AbyssUILightFirstFrame
local AbyssUILightFirstFrame = CreateFrame("Frame", "$parentAbyssUILightFirstFrame", UIParent)
AbyssUILightFirstFrame:Hide()
AbyssUILightFirstFrame:SetWidth(GetScreenWidth())
AbyssUILightFirstFrame:SetHeight(GetScreenHeight())
AbyssUILightFirstFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
AbyssUILightFirstFrame:EnableMouse(true)
AbyssUILightFirstFrame:SetFrameStrata("HIGH")
AbyssUILightFirstFrame.text = AbyssUILightFirstFrame.text or AbyssUILightFirstFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
AbyssUILightFirstFrame.text:SetScale(5)
AbyssUILightFirstFrame.text:SetAllPoints(true)
AbyssUILightFirstFrame.text:SetJustifyH("CENTER")
AbyssUILightFirstFrame.text:SetJustifyV("CENTER")
AbyssUILightFirstFrame.text:SetText("Thank you for choosing AbyssUI|cff0d75d4Light|r!")
----------------------------------------------------
local Subtittle = CreateFrame("Frame", "$parentSubtittle", AbyssUILightFirstFrame)
Subtittle:SetWidth(GetScreenWidth())
Subtittle:SetHeight(GetScreenHeight())
Subtittle:SetPoint("CENTER", AbyssUILightFirstFrame, "CENTER", 0, -50)
Subtittle:EnableMouse(false)
Subtittle:SetFrameStrata("HIGH")
Subtittle.text = Subtittle.text or Subtittle:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
Subtittle.text:SetScale(3)
Subtittle.text:SetAllPoints(true)
Subtittle.text:SetJustifyH("CENTER")
Subtittle.text:SetJustifyV("CENTER")
Subtittle.text:SetText("The improved World of Warcraft user interface")
----------------------------------------------------
local AbyssUILightBorder = AbyssUILightFirstFrame:CreateTexture(nil, "BACKGROUND")
AbyssUILightBorder:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
AbyssUILightBorder:SetPoint("TOPLEFT", -3, 3)
AbyssUILightBorder:SetPoint("BOTTOMRIGHT", 3, -3)
AbyssUILightBorder:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILightFirstFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILightFirstFrame)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILightFirstFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILightFirstFrame)
AbyssUILightFirstFrame.texture = Texture
----------------------------------------------------
local CloseButton = CreateFrame("Button", "$parentFrameButton", AbyssUILightFirstFrame, "UIPanelButtonTemplate")
CloseButton:SetHeight(40)
CloseButton:SetWidth(40)
CloseButton:SetPoint("TOPRIGHT", AbyssUILightFirstFrame, "TOPRIGHT", 0, 0)
CloseButton:SetText("x")
CloseButton:SetNormalTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
----------------------------------------------------
local BorderCloseButton = CloseButton:CreateTexture(nil, "ARTWORK")
BorderCloseButton:SetAllPoints(CloseButton)
CloseButton:SetScript("OnClick", function()
	AbyssUILightFirstFrame:Hide()
	AbyssUILightSecondFrame:Show()
end)
----------------------------------------------------
local FrameButton = CreateFrame("Button", "$parentFrameButton", AbyssUILightFirstFrame, "UIPanelButtonTemplate")
FrameButton:SetHeight(GetScreenHeight())
FrameButton:SetWidth(GetScreenWidth())
FrameButton:SetPoint("CENTER", AbyssUILightFirstFrame, "CENTER", 0, 0)
FrameButton:SetNormalTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
FrameButton:SetAlpha(0)
FrameButton:SetScript("OnClick", function()
	UIFrameFadeIn(AbyssUILightFirstFrame, 1, 1, 0)
	C_Timer.After(1, function()
		AbyssUILightFirstFrame:Hide()
		UIFrameFadeIn(AbyssUILightSecondFrame, 1, 0, 1)
	end)
end)
----------------------------------------------------
-- AbyssUILightSecondFrame
AbyssUILightSecondFrame = CreateFrame("Frame", "$parentAbyssUILightSecondFrame", UIParent)
AbyssUILightSecondFrame:Hide()
AbyssUILightSecondFrame:SetWidth(GetScreenWidth())
AbyssUILightSecondFrame:SetHeight(GetScreenHeight())
AbyssUILightSecondFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
AbyssUILightSecondFrame:EnableMouse(true)
AbyssUILightSecondFrame:SetFrameStrata("HIGH")
AbyssUILightSecondFrame.text = AbyssUILightSecondFrame.text or AbyssUILightSecondFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
AbyssUILightSecondFrame.text:SetScale(2)
AbyssUILightSecondFrame.text:SetAllPoints(true)
AbyssUILightSecondFrame.text:SetJustifyH("CENTER")
AbyssUILightSecondFrame.text:SetJustifyV("CENTER")
AbyssUILightSecondFrame.text:SetText("Let's save the variables and prepare the interface for the first use.\n"
.."To do this, choose the option that best suits your taste.\n\n"
.."|cfff2dc7fClassic|r: an interface model more like the original blizzard, with few modifications.\n\n"
.."|cfff2dc7fModern|r: a more modern interface model, with striking changes to the interface.\n\n"
.."You always can change options on the configuration panel.\nType '|cfff2dc7f/abyssui|r' on chat for more info.")
----------------------------------------------------
local AbyssUILightBorder = AbyssUILightSecondFrame:CreateTexture(nil, "BACKGROUND")
AbyssUILightBorder:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
AbyssUILightBorder:SetPoint("TOPLEFT", -3, 3)
AbyssUILightBorder:SetPoint("BOTTOMRIGHT", 3, -3)
AbyssUILightBorder:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILightSecondFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILightSecondFrame)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILightSecondFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILightSecondFrame)
AbyssUILightSecondFrame.texture = Texture
----------------------------------------------------
local FrameButtonModern = CreateFrame("Button", "$parentFrameButton", AbyssUILightSecondFrame, "UIPanelButtonTemplate")
FrameButtonModern:SetHeight(40)
FrameButtonModern:SetWidth(120)
FrameButtonModern:SetPoint("CENTER", AbyssUILightSecondFrame, "CENTER", 100, -200)
FrameButtonModern.text = FrameButtonModern.text or FrameButtonModern:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
FrameButtonModern.text:SetFont(globalFont, 18)
FrameButtonModern.text:SetPoint("CENTER", FrameButtonModern, "CENTER", 0, -2)
FrameButtonModern.text:SetText("Modern")
FrameButtonModern.text:SetTextColor(229/255, 229/255, 229/255)
FrameButtonModern.text:SetShadowColor(0, 0, 0)
FrameButtonModern.text:SetShadowOffset(1, -1)
FrameButtonModern.GlowTexture = FrameButtonModern:CreateTexture(nil, "OVERLAY", "UIPanelButtonHighlightTexture")
FrameButtonModern.GlowTexture:SetAllPoints()
FrameButtonModern.GlowTexture:Hide()
FrameButtonModern.Glow = FrameButtonModern:CreateAnimationGroup()
FrameButtonModern.Glow:SetLooping("REPEAT")
local anim = FrameButtonModern.Glow:CreateAnimation("Alpha")
	anim:SetChildKey("GlowTexture")
	anim:SetOrder(1)
	anim:SetFromAlpha(0)
	anim:SetToAlpha(1)
	anim:SetDuration(0.5)
anim = FrameButtonModern.Glow:CreateAnimation("Alpha")
	anim:SetOrder(2)
	anim:SetChildKey("GlowTexture")
	anim:SetFromAlpha(1)
	anim:SetToAlpha(0)
	anim:SetDuration(0.5)
FrameButtonModern.Glow:SetScript("OnPlay", function(self)
		self:GetParent().GlowTexture:Show()
	end)
FrameButtonModern.Glow:SetScript("OnStop", function(self)
		self:GetParent().GlowTexture:Hide()
	end)
if not FrameButtonModern.running then
	FrameButtonModern.running = true
	FrameButtonModern.Glow:Play()
else
	FrameButtonModern.running = false
	FrameButtonModern.Glow:Stop()
end
----------------------------------------------------
local BorderButtonModern = FrameButtonModern:CreateTexture(nil, "ARTWORK")
BorderButtonModern:SetAllPoints(FrameButtonModern)
FrameButtonModern:SetScript("OnClick", function()
	-- Set
	for i, v in pairs {
		addonTable.HideUnitImprovedFaction,
		addonTable.HideGroupFrame,
		addonTable.InspectTarget,
		addonTable.ConfirmPopUps,
		addonTable.AutoSellGray,
		addonTable.HideInCombat,
		addonTable.DisableHealingSpam,
		addonTable.TooltipOnCursor,
		addonTable.UnitFrameImproved,
		addonTable.ElitePortrait,
	} do
	 	v:SetChecked(true)
	end
	-- Get
	AbyssUILightAddonSettings.HideUnitImprovedFaction 					= addonTable.HideUnitImprovedFaction:GetChecked()
	AbyssUILightAddonSettings.HideGroupFrame										= addonTable.HideGroupFrame:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionInspectTarget 				= addonTable.InspectTarget:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionConfirmPopUps 				= addonTable.ConfirmPopUps:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionSellGray 						= addonTable.AutoSellGray:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionHideInCombat					= addonTable.HideInCombat:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionDisableHealingSpam		= addonTable.DisableHealingSpam:GetChecked()
	AbyssUILightAddonSettings.TooltipOnCursor 									= addonTable.TooltipOnCursor:GetChecked()
	AbyssUILightAddonSettings.UnitFrameImproved 								= addonTable.UnitFrameImproved:GetChecked()
	AbyssUILightAddonSettings.ElitePortrait 										= addonTable.ElitePortrait:GetChecked()
	AbyssUILightSecondFrame:Hide()
	FrameButtonModern.Glow:Finish()
	ReloadUI()
end)
----------------------------------------------------
local FrameButtonClassic = CreateFrame("Button", "$parentFrameButton", AbyssUILightSecondFrame, "UIPanelButtonTemplate")
FrameButtonClassic:SetHeight(40)
FrameButtonClassic:SetWidth(120)
FrameButtonClassic:SetPoint("CENTER", AbyssUILightSecondFrame, "CENTER", -100, -200)
FrameButtonClassic.text = FrameButtonClassic.text or FrameButtonClassic:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
FrameButtonClassic.text:SetFont(globalFont, 18)
FrameButtonClassic.text:SetPoint("CENTER", FrameButtonClassic, "CENTER", 0, -2)
FrameButtonClassic.text:SetText("Classic")
FrameButtonClassic.text:SetTextColor(229/255, 229/255, 229/255)
FrameButtonClassic.text:SetShadowColor(0, 0, 0)
FrameButtonClassic.text:SetShadowOffset(1, -1)
----------------------------------------------------
local BorderButtonClassic = FrameButtonClassic:CreateTexture(nil, "ARTWORK")
BorderButtonClassic:SetAllPoints(FrameButtonClassic)
FrameButtonClassic:SetScript("OnClick", function()
	-- Set
	for i, v in pairs {
		addonTable.FPSMSFrame,
		addonTable.YouDiedLevelUpFrame,
		addonTable.HideUnitImprovedFaction,
		addonTable.HideCastTimer,
		addonTable.InspectTarget,
		addonTable.ConfirmPopUps,
		addonTable.AutoSellGray,
		addonTable.ChatBubbleChanges,
		addonTable.DisableHealingSpam,
		addonTable.DisableSquareMinimap,
		addonTable.DisableUnitFrameSmoke,
		addonTable.DisableCharacterText,
		addonTable.DisableTooltipHealth,
		addonTable.AlwaysShowClock,
	} do
		v:SetChecked(true)
	end
	-- Get
	AbyssUILightAddonSettings.HideFPSMSFrame 										= addonTable.FPSMSFrame:GetChecked()
	AbyssUILightAddonSettings.HideYouDiedLevelUpFrame 					= addonTable.YouDiedLevelUpFrame:GetChecked()
	AbyssUILightAddonSettings.HideUnitImprovedFaction 					= addonTable.HideUnitImprovedFaction:GetChecked()
	AbyssUILightAddonSettings.HideCastTimer											= addonTable.HideCastTimer:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionInspectTarget 				= addonTable.InspectTarget:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionConfirmPopUps 				= addonTable.ConfirmPopUps:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionSellGray 						= addonTable.AutoSellGray:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionChatBubbleChanges 		= addonTable.ChatBubbleChanges:GetChecked()
	AbyssUILightAddonSettings.ExtraFunctionDisableHealingSpam		= addonTable.DisableHealingSpam:GetChecked()
	AbyssUILightAddonSettings.DisableSquareMinimap							= addonTable.DisableSquareMinimap:GetChecked()
	AbyssUILightAddonSettings.UnitFrameImprovedDefaultTexture 	= addonTable.DisableUnitFrameSmoke:GetChecked()
	AbyssUILightAddonSettings.DisableCharacterText							= addonTable.DisableCharacterText:GetChecked()
	AbyssUILightAddonSettings.DisableTooltipHealth 							= addonTable.DisableTooltipHealth:GetChecked()
	AbyssUILightAddonSettings.AlwaysShowClock 									= addonTable.AlwaysShowClock:GetChecked()
	AbyssUILightSecondFrame:Hide()
	FrameButtonModern.Glow:Finish()
	ReloadUI()
end)
----------------------------------------------------
local CloseButton = CreateFrame("Button", "$parentFrameButton", AbyssUILightSecondFrame, "UIPanelButtonTemplate")
CloseButton:SetHeight(40)
CloseButton:SetWidth(40)
CloseButton:SetPoint("TOPRIGHT", AbyssUILightSecondFrame, "TOPRIGHT", 0, 0)
CloseButton.text = CloseButton.text or CloseButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
CloseButton.text:SetFont(globalFont, 18)
CloseButton.text:SetPoint("CENTER", CloseButton, "CENTER", 0, 0)
CloseButton.text:SetText("x")
----------------------------------------------------
local BorderCloseButton = CloseButton:CreateTexture(nil, "ARTWORK")
BorderCloseButton:SetAllPoints(CloseButton)
CloseButton:SetScript("OnClick", function()
	AbyssUILightSecondFrame:Hide()
	FrameButtonModern.Glow:Finish()
	ReloadUI()
end)
----------------------------------------------------
-- AbyssUILight_ReloadFrame
AbyssUILight_ReloadFrame = CreateFrame("Frame", "$parentAbyssUILight_ReloadFrame", UIParent)
AbyssUILight_ReloadFrame:Hide()
AbyssUILight_ReloadFrame:SetWidth(400)
AbyssUILight_ReloadFrame:SetHeight(150)
AbyssUILight_ReloadFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, -100)
AbyssUILight_ReloadFrame:EnableMouse(true)
AbyssUILight_ReloadFrame:SetClampedToScreen(true)
AbyssUILight_ReloadFrame:SetMovable(true)
AbyssUILight_ReloadFrame:RegisterForDrag("LeftButton")
AbyssUILight_ReloadFrame:SetScript("OnDragStart", AbyssUILight_ReloadFrame.StartMoving)
AbyssUILight_ReloadFrame:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)
AbyssUILight_ReloadFrame:SetFrameStrata("Dialog")
AbyssUILight_ReloadFrame.text = AbyssUILight_ReloadFrame.text or AbyssUILight_ReloadFrame:CreateFontString(nil,"ARTWORK","QuestMapRewardsFont")
AbyssUILight_ReloadFrame.text:SetScale(1.5)
AbyssUILight_ReloadFrame.text:SetAllPoints(true)
AbyssUILight_ReloadFrame.text:SetJustifyH("CENTER")
AbyssUILight_ReloadFrame.text:SetJustifyV("CENTER")
AbyssUILight_ReloadFrame.text:SetText("A reload is necessary so this configuration can be save!\n"..
"Click the |cffffcc00'"..confirmString.."'|r button to Reload.\nYou still can make changes (do before you confirm).")
----------------------------------------------------
local Border = AbyssUILight_ReloadFrame:CreateTexture(nil, "BACKGROUND")
Border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Border:SetPoint("TOPLEFT", -3, 3)
Border:SetPoint("BOTTOMRIGHT", 3, -3)
Border:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILight_ReloadFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILight_ReloadFrame)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILight_ReloadFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_ReloadFrame)
AbyssUILight_ReloadFrame.texture = Texture
----------------------------------------------------
local FrameButtonConfirm = CreateFrame("Button","$parentFrameButtonConfirm", AbyssUILight_ReloadFrame, "UIPanelButtonTemplate")
FrameButtonConfirm:SetHeight(24)
FrameButtonConfirm:SetWidth(100)
FrameButtonConfirm:SetPoint("BOTTOM", AbyssUILight_ReloadFrame, "BOTTOM", 0, 10)
FrameButtonConfirm.text = FrameButtonConfirm.text or FrameButtonConfirm:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
FrameButtonConfirm.text:SetFont(globalFont, 12)
FrameButtonConfirm.text:SetPoint("CENTER", FrameButtonConfirm, "CENTER", 0, 0)
FrameButtonConfirm.text:SetText(confirmString)
FrameButtonConfirm.text:SetTextColor(229/255, 229/255, 229/255)
FrameButtonConfirm.text:SetShadowColor(0, 0, 0)
FrameButtonConfirm.text:SetShadowOffset(1, -1)
FrameButtonConfirm:SetNormalTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
----------------------------------------------------
local BorderButton = FrameButtonConfirm:CreateTexture(nil, "ARTWORK")
BorderButton:SetAllPoints(FrameButtonConfirm)
FrameButtonConfirm:SetScript("OnClick", function()
	AbyssUILight_ReloadFrame:Hide()
	ReloadUI()
end)
----------------------------------------------------
-- AbyssUILight_ReloadFrameFadeUI
AbyssUILight_ReloadFrameFadeUI = CreateFrame("Frame", "$parentAbyssUILight_ReloadFrameFadeUI", UIParent)
AbyssUILight_ReloadFrameFadeUI:Hide()
AbyssUILight_ReloadFrameFadeUI:SetWidth(500)
AbyssUILight_ReloadFrameFadeUI:SetHeight(180)
AbyssUILight_ReloadFrameFadeUI:SetPoint("CENTER", "UIParent", "CENTER", 0, -100)
AbyssUILight_ReloadFrameFadeUI:EnableMouse(true)
AbyssUILight_ReloadFrameFadeUI:SetClampedToScreen(true)
AbyssUILight_ReloadFrameFadeUI:SetMovable(true)
AbyssUILight_ReloadFrameFadeUI:RegisterForDrag("LeftButton")
AbyssUILight_ReloadFrameFadeUI:SetScript("OnDragStart", AbyssUILight_ReloadFrameFadeUI.StartMoving)
AbyssUILight_ReloadFrameFadeUI:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)
AbyssUILight_ReloadFrameFadeUI:SetFrameStrata("Dialog")
AbyssUILight_ReloadFrameFadeUI.text = AbyssUILight_ReloadFrameFadeUI.text or AbyssUILight_ReloadFrameFadeUI:CreateFontString(nil,"ARTWORK","QuestMapRewardsFont")
AbyssUILight_ReloadFrameFadeUI.text:SetScale(1.5)
AbyssUILight_ReloadFrameFadeUI.text:SetAllPoints(true)
AbyssUILight_ReloadFrameFadeUI.text:SetJustifyH("CENTER")
AbyssUILight_ReloadFrameFadeUI.text:SetJustifyV("CENTER")
AbyssUILight_ReloadFrameFadeUI.text:SetText("It will only hide Blizzard frames, addons have their own frames,\n a good addon probably has an option to hide while out of combat.\n I could have added the entire interface to be hidden,\n but that would prevent interaction with some frames (eg auction, loot, quest, frames).")
----------------------------------------------------
local Border = AbyssUILight_ReloadFrameFadeUI:CreateTexture(nil, "BACKGROUND")
Border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Border:SetPoint("TOPLEFT", -3, 3)
Border:SetPoint("BOTTOMRIGHT", 3, -3)
Border:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILight_ReloadFrameFadeUI:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILight_ReloadFrameFadeUI)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILight_ReloadFrameFadeUI:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_ReloadFrameFadeUI)
AbyssUILight_ReloadFrameFadeUI.texture = Texture
----------------------------------------------------
local FrameButtonConfirm = CreateFrame("Button","$parentFrameButtonConfirm", AbyssUILight_ReloadFrameFadeUI, "UIPanelButtonTemplate")
FrameButtonConfirm:SetHeight(24)
FrameButtonConfirm:SetWidth(100)
FrameButtonConfirm:SetPoint("BOTTOM", AbyssUILight_ReloadFrameFadeUI, "BOTTOM", 0, 10)
FrameButtonConfirm.text = FrameButtonConfirm.text or FrameButtonConfirm:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
FrameButtonConfirm.text:SetFont(globalFont, 12)
FrameButtonConfirm.text:SetPoint("CENTER", FrameButtonConfirm, "CENTER", 0, 0)
FrameButtonConfirm.text:SetText(confirmString)
FrameButtonConfirm.text:SetTextColor(229/255, 229/255, 229/255)
FrameButtonConfirm.text:SetShadowColor(0, 0, 0)
FrameButtonConfirm.text:SetShadowOffset(1, -1)
----------------------------------------------------
local BorderButton = FrameButtonConfirm:CreateTexture(nil, "ARTWORK")
BorderButton:SetAllPoints(FrameButtonConfirm)
FrameButtonConfirm:SetScript("OnClick", function()
	AbyssUILight_ReloadFrameFadeUI:Hide()
	ReloadUI()
end)
----------------------------------------------------
-- AbyssUILight_ActionBarCleaner
AbyssUILight_ActionBarCleaner = CreateFrame("Frame", "$parentAbyssUILight_ActionBarCleaner", UIParent)
AbyssUILight_ActionBarCleaner:Hide()
AbyssUILight_ActionBarCleaner:SetWidth(400)
AbyssUILight_ActionBarCleaner:SetHeight(150)
AbyssUILight_ActionBarCleaner:SetPoint("CENTER", "UIParent", "CENTER", 0, -100)
AbyssUILight_ActionBarCleaner:EnableMouse(true)
AbyssUILight_ActionBarCleaner:SetClampedToScreen(true)
AbyssUILight_ActionBarCleaner:SetMovable(true)
AbyssUILight_ActionBarCleaner:RegisterForDrag("LeftButton")
AbyssUILight_ActionBarCleaner:SetScript("OnDragStart", AbyssUILight_ActionBarCleaner.StartMoving)
AbyssUILight_ActionBarCleaner:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)
AbyssUILight_ActionBarCleaner:SetFrameStrata("Dialog")
AbyssUILight_ActionBarCleaner.text = AbyssUILight_ActionBarCleaner.text or AbyssUILight_ActionBarCleaner:CreateFontString(nil,"ARTWORK","QuestMapRewardsFont")
AbyssUILight_ActionBarCleaner.text:SetScale(1.5)
AbyssUILight_ActionBarCleaner.text:SetAllPoints(true)
AbyssUILight_ActionBarCleaner.text:SetJustifyH("CENTER")
AbyssUILight_ActionBarCleaner.text:SetJustifyV("CENTER")
AbyssUILight_ActionBarCleaner.text:SetText("Wait!\nThis will clean all your skills/spells from Actions Bars.")
----------------------------------------------------
local Border = AbyssUILight_ActionBarCleaner:CreateTexture(nil, "BACKGROUND")
Border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Border:SetPoint("TOPLEFT", -3, 3)
Border:SetPoint("BOTTOMRIGHT", 3, -3)
Border:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILight_ActionBarCleaner:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILight_ActionBarCleaner)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILight_ActionBarCleaner:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_ActionBarCleaner)
AbyssUILight_ActionBarCleaner.texture = Texture
----------------------------------------------------
local FrameButtonConfirm = CreateFrame("Button","$parentFrameButtonConfirm", AbyssUILight_ActionBarCleaner, "UIPanelButtonTemplate")
FrameButtonConfirm:SetHeight(24)
FrameButtonConfirm:SetWidth(100)
FrameButtonConfirm:SetPoint("BOTTOM", AbyssUILight_ActionBarCleaner, "BOTTOM", -50, 10)
FrameButtonConfirm.text = FrameButtonConfirm.text or FrameButtonConfirm:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
FrameButtonConfirm.text:SetFont(globalFont, 12)
FrameButtonConfirm.text:SetPoint("CENTER", FrameButtonConfirm, "CENTER", 0, 0)
FrameButtonConfirm.text:SetText(confirmString)
FrameButtonConfirm.text:SetTextColor(229/255, 229/255, 229/255)
FrameButtonConfirm.text:SetShadowColor(0, 0, 0)
FrameButtonConfirm.text:SetShadowOffset(1, -1)
----------------------------------------------------
local FrameButtonCancel = CreateFrame("Button","$parentFrameButtonCancel", AbyssUILight_ActionBarCleaner, "UIPanelButtonTemplate")
FrameButtonCancel:SetHeight(24)
FrameButtonCancel:SetWidth(100)
FrameButtonCancel:SetPoint("BOTTOM", AbyssUILight_ActionBarCleaner, "BOTTOM", 50, 10)
FrameButtonCancel.text = FrameButtonCancel.text or FrameButtonCancel:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
FrameButtonCancel.text:SetFont(globalFont, 12)
FrameButtonCancel.text:SetPoint("CENTER", FrameButtonCancel, "CENTER", 0, 0)
FrameButtonCancel.text:SetText(cancelString)
FrameButtonCancel.text:SetTextColor(229/255, 229/255, 229/255)
FrameButtonCancel.text:SetShadowColor(0, 0, 0)
FrameButtonCancel.text:SetShadowOffset(1, -1)
----------------------------------------------------
local BorderButton = FrameButtonConfirm:CreateTexture(nil, "ARTWORK")
BorderButton:SetAllPoints(FrameButtonConfirm)
FrameButtonConfirm:SetScript("OnClick", function()
	for i = 1, 120 do
		PickupAction(i) ClearCursor()
	end
	AbyssUILight_ActionBarCleaner:Hide()
end)
----------------------------------------------------
local BorderButton = FrameButtonCancel:CreateTexture(nil, "ARTWORK")
BorderButton:SetAllPoints(FrameButtonCancel)
FrameButtonCancel:SetScript("OnClick", function()
	AbyssUILight_ActionBarCleaner:Hide()
end)
----------------------------------------------------
-- AbyssUILight_ActionBarInfo
AbyssUILight_ActionBarInfo = CreateFrame("Frame", "$parentAbyssUILight_ActionBarInfo", UIParent)
AbyssUILight_ActionBarInfo:Hide()
AbyssUILight_ActionBarInfo:SetWidth(500)
AbyssUILight_ActionBarInfo:SetHeight(160)
AbyssUILight_ActionBarInfo:SetPoint("CENTER", "UIParent", "CENTER", 0, -100)
AbyssUILight_ActionBarInfo:EnableMouse(true)
AbyssUILight_ActionBarInfo:SetClampedToScreen(true)
AbyssUILight_ActionBarInfo:SetMovable(true)
AbyssUILight_ActionBarInfo:RegisterForDrag("LeftButton")
AbyssUILight_ActionBarInfo:SetScript("OnDragStart", AbyssUILight_ActionBarInfo.StartMoving)
AbyssUILight_ActionBarInfo:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)
AbyssUILight_ActionBarInfo:SetFrameStrata("Dialog")
AbyssUILight_ActionBarInfo.text = AbyssUILight_ActionBarInfo.text or AbyssUILight_ActionBarInfo:CreateFontString(nil,"ARTWORK","QuestMapRewardsFont")
AbyssUILight_ActionBarInfo.text:SetScale(1.5)
AbyssUILight_ActionBarInfo.text:SetAllPoints(true)
AbyssUILight_ActionBarInfo.text:SetJustifyH("CENTER")
AbyssUILight_ActionBarInfo.text:SetJustifyV("CENTER")
AbyssUILight_ActionBarInfo.text:SetText("AbyssUI|cff0d75d4Light|r Actionbar could glitch sometimes.")
----------------------------------------------------
local Border = AbyssUILight_ActionBarInfo:CreateTexture(nil, "BACKGROUND")
Border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Border:SetPoint("TOPLEFT", -3, 3)
Border:SetPoint("BOTTOMRIGHT", 3, -3)
Border:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILight_ActionBarInfo:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILight_ActionBarInfo)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILight_ActionBarInfo:CreateTexture(nil,"BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_ActionBarInfo)
AbyssUILight_ActionBarInfo.texture = Texture
----------------------------------------------------
local FrameButtonReset = CreateFrame("Button","$parentFrameButtonReset", AbyssUILight_ActionBarInfo, "UIPanelButtonTemplate")
FrameButtonReset:SetHeight(24)
FrameButtonReset:SetWidth(85)
FrameButtonReset:SetPoint("BOTTOM", AbyssUILight_ActionBarInfo, "BOTTOM", 0, 10)
FrameButtonReset:SetText("Reload UI")
----------------------------------------------------
local BorderButton = FrameButtonReset:CreateTexture(nil, "ARTWORK")
BorderButton:SetAllPoints(FrameButtonReset)
FrameButtonReset:SetScript("OnClick", function()
	AbyssUILight_ActionBarInfo:Hide()
	ReloadUI()
end)
----------------------------------------------------
-- AbyssUILight_ColorPickerFrame
AbyssUILight_ColorPickerFrame = CreateFrame("Frame", "$parentAbyssUILight_ColorPickerFrame", UIParent)
AbyssUILight_ColorPickerFrame:Hide()
AbyssUILight_ColorPickerFrame:SetWidth(400)
AbyssUILight_ColorPickerFrame:SetHeight(150)
AbyssUILight_ColorPickerFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, -100)
AbyssUILight_ColorPickerFrame:EnableMouse(true)
AbyssUILight_ColorPickerFrame:SetClampedToScreen(true)
AbyssUILight_ColorPickerFrame:SetMovable(true)
AbyssUILight_ColorPickerFrame:RegisterForDrag("LeftButton")
AbyssUILight_ColorPickerFrame:SetScript("OnDragStart", AbyssUILight_ColorPickerFrame.StartMoving)
AbyssUILight_ColorPickerFrame:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)
AbyssUILight_ColorPickerFrame:SetFrameStrata("Dialog")
AbyssUILight_ColorPickerFrame.text = AbyssUILight_ColorPickerFrame.text or AbyssUILight_ColorPickerFrame:CreateFontString(nil,"ARTWORK","QuestMapRewardsFont")
AbyssUILight_ColorPickerFrame.text:SetScale(1.5)
AbyssUILight_ColorPickerFrame.text:SetAllPoints(true)
AbyssUILight_ColorPickerFrame.text:SetJustifyH("CENTER")
AbyssUILight_ColorPickerFrame.text:SetJustifyV("CENTER")
AbyssUILight_ColorPickerFrame.text:SetText("Choose a color by clicking on 'Choose a color', 'Okay' and then reload the UI.")
----------------------------------------------------
local Border = AbyssUILight_ColorPickerFrame:CreateTexture(nil, "BACKGROUND")
Border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Border:SetPoint("TOPLEFT", -3, 3)
Border:SetPoint("BOTTOMRIGHT", 3, -3)
Border:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = AbyssUILight_ColorPickerFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
BorderBody:SetAllPoints(AbyssUILight_ColorPickerFrame)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = AbyssUILight_ColorPickerFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
Texture:SetAllPoints(AbyssUILight_ColorPickerFrame)
AbyssUILight_ColorPickerFrame.texture = Texture
----------------------------------------------------
local FrameButtonColorPicker = CreateFrame("Button","$parentFrameButtonColorPicker", AbyssUILight_ColorPickerFrame, "UIPanelButtonTemplate")
FrameButtonColorPicker:SetHeight(24)
FrameButtonColorPicker:SetWidth(120)
FrameButtonColorPicker:SetPoint("BOTTOM", AbyssUILight_ColorPickerFrame, "BOTTOM", -50, 10)
FrameButtonColorPicker:SetText("Choose a Color")
----------------------------------------------------
local BorderButton = FrameButtonColorPicker:CreateTexture(nil, "ARTWORK")
BorderButton:SetAllPoints(FrameButtonColorPicker)
FrameButtonColorPicker:SetScript("OnClick", function()
	AbyssUILight_ShowColorPicker()
end)
----------------------------------------------------
local FrameButtonReset = CreateFrame("Button","$parentFrameButtonReset", AbyssUILight_ColorPickerFrame, "UIPanelButtonTemplate")
FrameButtonReset:SetHeight(24)
FrameButtonReset:SetWidth(85)
FrameButtonReset:SetPoint("BOTTOM", AbyssUILight_ColorPickerFrame, "BOTTOM", 50, 10)
FrameButtonReset:SetText("Reload UI")
----------------------------------------------------
local BorderButton = FrameButtonReset:CreateTexture(nil, "ARTWORK")
BorderButton:SetAllPoints(FrameButtonReset)
FrameButtonReset:SetScript("OnClick", function()
	AbyssUILight_ColorPickerFrame:Hide()
	ReloadUI()
end)
-- Start Function
local function AbyssUILightStart()
	AbyssUILightFirstFrame:Show()
end
----------------------------------------------------
--------------------------------- Save ---------------------------------
local AbyssUILightSave = CreateFrame("Frame")
AbyssUILightSave:RegisterEvent("ADDON_LOADED")
AbyssUILightSave:RegisterEvent("PLAYER_LOGOUT")
AbyssUILightSave:SetScript("OnEvent", function(self, event, arg1)
	if ( event == "ADDON_LOADED" and arg1 == "AbyssUILight" ) then
		if ( AbyssUILightCount == nil ) then
			AbyssUILightCount = 0
		end
		if ( AbyssUILightProfile == nil ) then
			AbyssUILightCount = AbyssUILightCount + 1
			AbyssUILightStart()
		else
			AbyssUILightFirstFrame:Hide()
		end
	elseif ( event == "PLAYER_LOGOUT" ) then
		AbyssUILightProfile = time()
	else
		return nil
	end
end)
-- End
