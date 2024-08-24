-- Author: Yugen (changes, fixes and enchantments for AbyssUI), KawF (Original code)
--
-- Classic
--
-- UnitFrameImproved for AbyssUIClassic.
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
		damageFont 	= mediaFolder.."damagefont_classic.ttf"
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
-- UnitFrameImproved
local AbyssUIClassic_UnitFrame = CreateFrame("Frame", "$parentAbyssUIClassic_UnitFrame", nil)
AbyssUIClassic_UnitFrame:RegisterEvent("ADDON_LOADED")
AbyssUIClassic_UnitFrame:RegisterEvent("PLAYER_LOGIN")
AbyssUIClassic_UnitFrame:RegisterEvent("PLAYER_LOGOUT")
AbyssUIClassic_UnitFrame:SetScript("OnEvent", function(self, event, arg1)
	if ( event == "ADDON_LOADED" and arg1 == "AbyssUIClassic" )  then		
		-- UnitColor
		local UnitColor
		local function UnitColor(unit)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				if (AbyssUIClassicAddonSettings.ExtraFunctionFriendlyHealthGreen ~= true) then
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
				end
			else
				return nil
			end
		end
		local function DragonflightUnitPlayerFrameStyle()
			PlayerFrameHealthBar:SetHeight(20)
			PlayerFrameHealthBar:SetWidth(125)
	 		PlayerFrameHealthBar:SetPoint("TOPLEFT", 103, -34)
 			PlayerFrameBackground:SetAlpha(0)
		end
		local function DragonflightUnitTargetFrameStyle()
			TargetFrameHealthBar:SetHeight(20)
			TargetFrameHealthBar:SetWidth(125)
			TargetFrameHealthBar:SetPoint("CENTER", 50, 6)
	 		TargetFrameHealthBar:SetPoint("TOPLEFT", 5, -34)
 			TargetFrameBackground:SetAlpha(0)
		end
		-- PlayerFrameStyle
    local function UnitFramesImproved_Style_PlayerFrame()
			if (AbyssUIClassicAddonSettings.UnitFrameImproved == true) then
				if (GetWoWVersion <= 90500) then
				  if not InCombatLockdown() then 
					  PlayerFrameHealthBar.lockColor = true
					  PlayerFrameHealthBar.capNumericDisplay = true
					  PlayerFrameHealthBar:SetWidth(119)
					  PlayerFrameHealthBar:SetHeight(30)
					  PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -22)
					  PlayerFrameHealthBarText:SetPoint("CENTER", 50, 6)
				  end
				  if (AbyssUIClassicAddonSettings.UnitFrameImprovedDefaultTexture ~= true) then
					  if (AbyssUIClassicAddonSettings.ElitePortrait == true and AbyssUIClassicAddonSettings.Dragonflight ~= true and AbyssUIClassicAddonSettings.RarePortrait ~= true) then
						  PlayerFrameTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\UI-TargetingFrame-Elite")
					  elseif (AbyssUIClassicAddonSettings.RarePortrait == true and AbyssUIClassicAddonSettings.Dragonflight ~= true and AbyssUIClassicAddonSettings.ElitePortrait ~= true) then
						  PlayerFrameTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\UI-TargetingFrame-Rare")
						elseif (AbyssUIClassicAddonSettings.DKAllyPortrait == true) then
							PlayerFrameTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\UI-PlayerFrame-Deathknight-Alliance")
						elseif (AbyssUIClassicAddonSettings.DKHordePortrait == true) then
							PlayerFrameTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\UI-PlayerFrame-Deathknight-Horde")
						elseif (AbyssUIClassicAddonSettings.DemonHunterPortrait == true) then
							PlayerFrameTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\UI-TargetingFrame-DemonHunter")
						   PlayerFrameTexture:SetVertexColor(1, 1, 1)
					   elseif (AbyssUIClassicAddonSettings.Dragonflight == true and AbyssUIClassicAddonSettings.ElitePortrait ~= true) then
						   PlayerFrameTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\Dragonflight-UI-PlayerFrameLarge")
						  DragonflightUnitPlayerFrameStyle()
					  elseif (AbyssUIClassicAddonSettings.Dragonflight == true and AbyssUIClassicAddonSettings.ElitePortrait == true) then
						   PlayerFrameTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\Dragonflight-UI-PlayerFrameLarge-Elite")
						  DragonflightUnitPlayerFrameStyle()
						else
							 PlayerFrameTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\UI-TargetingFrame")
						end
					  if (AbyssUIClassicAddonSettings.DKHordePortrait == true) then
						  PlayerStatusTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\improved\\UI-Player-StatusDKH")
						  PlayerFrameHealthBar:SetWidth(105)
					  else
						  PlayerStatusTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\UI-Player-Status")
					  end
					  if (GetWoWVersion <= 90500) then
						  PlayerFrameHealthBar:SetStatusBarColor(UnitColor("player"))
					  end
				  else
					  if (AbyssUIClassicAddonSettings.ElitePortrait == true and AbyssUIClassicAddonSettings.Dragonflight ~= true) then
						  PlayerFrameTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\backup\\UI-TargetingFrame-Elite")
					  elseif (AbyssUIClassicAddonSettings.ElitePortrait == true and AbyssUIClassicAddonSettings.Dragonflight == true) then
						  PlayerFrameTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\Dragonflight-UI-PlayerFrameLarge-Elite")
						  DragonflightUnitPlayerFrameStyle()
					  elseif (AbyssUIClassicAddonSettings.Dragonflight == true and AbyssUIClassicAddonSettings.ElitePortrait ~= true) then
						  PlayerFrameTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\Dragonflight-UI-PlayerFrameLarge")
						  DragonflightUnitPlayerFrameStyle()
					  else
						  PlayerFrameTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\backup\\UI-TargetingFrame")
					  end
						if (GetWoWVersion <= 90500) then
							PlayerStatusTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\backup\\UI-Player-Status")
							PlayerFrameHealthBar:SetStatusBarColor(UnitColor("player"))
					  end
				  end		      	
				end		      	
			else
				if (AbyssUIClassicAddonSettings.UnitFrameImproved ~= true) then
  				C_Timer.After(0.5, function() 
						PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
					end)
  			end
			end
	  end
	    -- PlayerArt
	    local function UnitFramesImproved_PlayerFrame_ToPlayerArt(self)
	      if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
	        if not InCombatLockdown() then
	          UnitFramesImproved_Style_PlayerFrame()
	        end
	      else
	        return nil
	      end
	    end
		-- TargetFrameStyle
		local function UnitFramesImproved_Style_TargetFrame(self)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				if not InCombatLockdown() then
					local classification = UnitClassification(self.unit)
					if (classification == "minus") then
						self.healthbar:SetHeight(12)
						self.healthbar:SetPoint("TOPLEFT",7,-41)
						if (self.healthbar.TextString) then
							self.healthbar.TextString:SetPoint("CENTER",-50,4)
						end
						self.deadText:SetPoint("CENTER",-50,4)
						self.Background:SetPoint("TOPLEFT",7,-41)
					else
						self.healthbar:SetHeight(29)
						self.healthbar:SetPoint("TOPLEFT",7,-22)
						if (self.healthbar.TextString) then
							self.healthbar.TextString:SetPoint("CENTER",-50,6)
						end
						self.deadText:SetPoint("CENTER",-50,6)
						self.nameBackground:Hide()
						self.Background:SetPoint("TOPLEFT",7,-22)
					end
					self.healthbar:SetWidth(119)
					self.healthbar.lockColor = true
					--end
				else
					return nil
				end
			end
		end
		-- BossStyle
		local function UnitFramesImproved_BossTargetFrame_Style(self)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				if ( AbyssUIClassicAddonSettings.UnitFrameImprovedDefaultTexture ~= true ) then
					self.borderTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\Textures\\UI-UnitFrame-Boss")
				else
					self.borderTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\Textures\\backup\\UI-UnitFrame-Boss")
				end
				UnitFramesImproved_Style_TargetFrame(self)
			else 
				return nil
			end
		end
		-- Utility functions
		local function UnitFramesImproved_AbbreviateLargeNumbers(value)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				local strLen = strlen(value)
				local retString = value
				if ( strLen >= 10 ) then
					retString = string.sub(value, 1, -10).."."..string.sub(value, -9, -8).."G"
				elseif ( strLen >= 7 ) then
					retString = string.sub(value, 1, -7).."."..string.sub(value, -6, -5).."M"
				elseif ( strLen >= 4 ) then
					retString = string.sub(value, 1, -4).."."..string.sub(value, -3, -3).."k"
				end
				return retString
			else
				return nil
			end
		end
		-- UpdateTextString Values
		local function UnitFramesImproved_TextStatusBar_UpdateTextStringWithValues(statusFrame, textString, value, valueMin, valueMax)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				if( statusFrame.LeftText and statusFrame.RightText ) then
					statusFrame.LeftText:SetText("")
					statusFrame.RightText:SetText("")
					statusFrame.LeftText:Hide()
					statusFrame.RightText:Hide()
					textString:Show()
				end
				if ( ( tonumber(valueMax) ~= valueMax or valueMax > 0 ) and not ( statusFrame.pauseUpdates ) ) then
					local valueDisplay = value
					local valueMaxDisplay = valueMax
					if ( statusFrame.capNumericDisplay ) then
						valueDisplay = UnitFramesImproved_AbbreviateLargeNumbers(value)
						valueMaxDisplay = UnitFramesImproved_AbbreviateLargeNumbers(valueMax)
					else
						valueDisplay = BreakUpLargeNumbers(value)
						valueMaxDisplay = BreakUpLargeNumbers(valueMax)
					end
					local textDisplay = GetCVar("statusTextDisplay")
					if (textDisplay == "NONE") then return end
					if ( value and valueMax > 0 and ( textDisplay ~= "NUMERIC" or statusFrame.showPercentage ) and not statusFrame.showNumeric) then
						if ( value == 0 and statusFrame.zeroText ) then
							textString:SetText(statusFrame.zeroText)
							statusFrame.isZero = 1
							textString:Show()
							return
						end
						percent = math.ceil((value / valueMax) * 100) .. "%"
						if ( textDisplay == "BOTH" and not statusFrame.showPercentage) then
							valueDisplay = valueDisplay .. " (" .. percent .. ")"
							textString:SetText(valueDisplay)
						else
							valueDisplay = percent
							if ( statusFrame.prefix and (statusFrame.alwaysPrefix or not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) ) ) then
								textString:SetText(statusFrame.prefix .. " " .. valueDisplay)
							else
								textString:SetText(valueDisplay)
							end
						end
					elseif ( value == 0 and statusFrame.zeroText ) then
						textString:SetText(statusFrame.zeroText)
						statusFrame.isZero = 1
						textString:Show()
						return
					else
						statusFrame.isZero = nil
						if ( statusFrame.prefix and (statusFrame.alwaysPrefix or not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) ) ) then
							textString:SetText(statusFrame.prefix.." "..valueDisplay.."/"..valueMaxDisplay)
						else
							textString:SetText(valueDisplay.."/"..valueMaxDisplay)
						end
					end
				end
			else
				return nil
			end
		end
		-- VehicleArt
		local function UnitFramesImproved_PlayerFrame_ToVehicleArt(self)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				if not InCombatLockdown() then
					PlayerFrameHealthBar:SetHeight(12)
					--PlayerFrameHealthBarText:SetPoint("CENTER", 50, 3)
				end
			else
				return nil
			end
		end
		-- Unit Name
		local function UnitFramesImproved_UnitName_Color(self)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				if not InCombatLockdown() then
					-- names
					for i, v in pairs({
						PlayerName,
						TargetFrameTextureFrameName,
					}) do
						C_Timer.After(0.1, function() 
							v:SetVertexColor(229/255, 229/255, 229/255)
							v:SetShadowColor(0, 0, 0)
							v:SetShadowOffset(1, -1)
							v:SetScale(1.2)
							v:ClearAllPoints()
							PlayerName:SetPoint("CENTER", PlayerFrame, "CENTER", 40, 15)
							TargetFrameTextureFrameName:SetPoint("CENTER", TargetFrame, "CENTER", -40, 15)
						end)
					end
					-- numbers
					for i, v in pairs ({
						PlayerFrameHealthBarText,
						PlayerFrameManaBarText,
						TargetFrameTextureFrameHealthBarText,
						TargetFrameTextureFrameManaBarText,
 					}) do
						v:SetFont(globalFont, 12)
						v:SetShadowColor(0, 0, 0)
						v:SetShadowOffset(1, -1)					
					end
				end
			else
				return nil
			end
		end
		-- TargetUpdate
		local function UnitFramesImproved_TargetFrame_Update(self)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				if (AbyssUIClassicAddonSettings.ExtraFunctionFriendlyHealthGreen ~= true) then
					-- Set back color of health bar
					if ( not UnitPlayerControlled(self.unit) and UnitIsTapDenied(self.unit) ) then
						-- Gray if npc is tapped by other player
						self.healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
					else
						-- Standard by class etc if not
						if ( UnitIsPlayer(self.unit) ) then
							if ((UnitHealth(self.unit) > 0) and UnitIsConnected(self.unit)) then
								local healthPercentage = ceil(((UnitHealth(self.unit) / UnitHealthMax(self.unit)) * 1000) /10)
								if ( healthPercentage == 0 ) then return end
								if healthPercentage == 100 then
									self.healthbar:SetStatusBarColor(UnitColor(self.healthbar.unit))
								elseif healthPercentage < 100 and healthPercentage > 21 then
									self.healthbar:SetStatusBarColor(UnitColor(self.healthbar.unit))
								elseif healthPercentage < 21 then
									self.healthbar:SetStatusBarColor(255/255, 255/255, 255/255)
								end				
							end	
						else
							-- Change Color By health
							if ((UnitHealth(self.unit) > 0) and UnitIsConnected(self.unit)) then
								local healthPercentage = ceil(((UnitHealth(self.unit) / UnitHealthMax(self.unit)) * 1000) /10)
								if ( healthPercentage == 0 ) then return end
								if healthPercentage == 100 then
									self.healthbar:SetStatusBarColor(UnitColor(self.healthbar.unit))
								elseif healthPercentage < 100 and healthPercentage > 21 then
									self.healthbar:SetStatusBarColor(UnitColor(self.healthbar.unit))
								elseif healthPercentage < 21 then
									self.healthbar:SetStatusBarColor(255/255, 255/255, 255/255)
								end				
							end	
						end
					end
				end
				if ((UnitHealth(self.unit) <= 0) and UnitIsConnected(self.unit)) then
					if (not UnitIsUnconscious(self.unit)) then
						if (self.healthbar.TextString) then
							self.healthbar.TextString:Hide()
							self.healthbar.forceHideText = true
						end
					end
				end		
			end
		end
		-- CheckClassification
		local function UnitFramesImproved_TargetFrame_CheckClassification(self, forceNormalTexture)
			if (AbyssUIClassicAddonSettings.UnitFrameImprovedDefaultTexture ~= true) then
				if (AbyssUIClassicAddonSettings.UnitFrameImproved == true and GetWoWVersion <= 90500) then
					local texture
					local classification = UnitClassification(self.unit)
					if (classification == "worldboss" or classification == "elite") then
						texture = "Interface\\Addons\\AbyssUIClassic\\textures\\UI-TargetingFrame-Elite"
					elseif (classification == "rareelite") then
						texture = "Interface\\Addons\\AbyssUIClassic\\textures\\UI-TargetingFrame-Rare-Elite"
					elseif (classification == "rare") then
						texture = "Interface\\Addons\\AbyssUIClassic\\textures\\UI-TargetingFrame-Rare"
					end
					if (texture and not forceNormalTexture) then
						self.borderTexture:SetTexture(texture)
					else
						if (not (classification == "minus")) then
							if (AbyssUIClassicAddonSettings.Dragonflight == true) then
								self.borderTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\Dragonflight-UI-TargetingFrame")
								DragonflightUnitTargetFrameStyle()
							else
								self.borderTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\UI-TargetingFrame")
							end
						end
					end
					self.nameBackground:SetAlpha(0)
				else
					return nil
				end
			else
				if (AbyssUIClassicAddonSettings.UnitFrameImproved == true and GetWoWVersion <= 90500) then
					local texture
					local classification = UnitClassification(self.unit)
					if (classification == "worldboss" or classification == "elite") then
						texture = "Interface\\Addons\\AbyssUIClassic\\textures\\backup\\UI-TargetingFrame-Elite"
					elseif (classification == "rareelite") then
						texture = "Interface\\Addons\\AbyssUIClassic\\textures\\backup\\UI-TargetingFrame-Rare-Elite"
					elseif (classification == "rare") then
						texture = "Interface\\Addons\\AbyssUIClassic\\textures\\backup\\UI-TargetingFrame-Rare"
					end
					if (texture and not forceNormalTexture) then
						self.borderTexture:SetTexture(texture)
					else
						if (not (classification == "minus")) then
							if (AbyssUIClassicAddonSettings.Dragonflight == true) then
								self.borderTexture:SetTexture("Interface\\AddOns\\AbyssUIClassic\\textures\\improved\\Dragonflight-UI-TargetingFrame")
								DragonflightUnitTargetFrameStyle()
							else
								self.borderTexture:SetTexture("Interface\\Addons\\AbyssUIClassic\\textures\\backup\\UI-TargetingFrame")
							end
						end
					end
					self.nameBackground:SetAlpha(0)
				else
					return nil
				end
			end
		end
		-- CheckFaction
		local function UnitFramesImproved_TargetFrame_CheckFaction(self)
			local factionGroup = UnitFactionGroup(self.unit)
			local creatureType = UnitCreatureType(self.unit)
			if ( creatureType == "Humanoid" or UnitIsPlayer(self.unit) ) then
				if ( UnitIsPVPFreeForAll(self.unit) ) then
					--self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
					if ( AbyssUIClassicAddonSettings.HideUnitImprovedFaction ~= true ) then
						self.pvpIcon:Show()
					else
						self.pvpIcon:Hide()
					end
				elseif ( factionGroup and UnitIsPVP(self.unit) and UnitIsEnemy("player", self.unit) ) then
					--self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
					if ( AbyssUIClassicAddonSettings.HideUnitImprovedFaction ~= true ) then
						self.pvpIcon:Show()
					else
						self.pvpIcon:Hide()
					end
				elseif ( factionGroup == "Alliance" or factionGroup == "Horde" ) then
					--self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup)
					if ( AbyssUIClassicAddonSettings.HideUnitImprovedFaction ~= true ) then
						self.pvpIcon:Show()
					else
						self.pvpIcon:Hide()
					end
				else
					self.pvpIcon:Hide()
				end
			else
				self.pvpIcon:Hide()
			end
			UnitFramesImproved_Style_TargetFrame(self)
		end
		local function UnitFramesImproved_Style_TargetOfTargetFrame()
			if not InCombatLockdown() then 
				TargetFrameToTHealthBar.lockColor = true
			end
		end
		--StatusBarTextString
		local function CreateStatusBarText(name, parentName, parent, point, x, y)
			if ( AbyssUIClassicAddonSettings.UnitFrameImproved == true ) then
				local fontString = parent:CreateFontString(parentName..name, nil, "TextStatusBarText")
				fontString:SetPoint(point, parent, point, x, y)
				return fontString
			else
				return nil
			end
		end
		-- EnableUnitFramesImproved
		local EnableUnitFramesImproved = CreateFrame("Frame", nil)
		EnableUnitFramesImproved:RegisterEvent("PLAYER_ENTERING_WORLD")
		EnableUnitFramesImproved:SetScript("OnEvent", function()
			C_Timer.After(0.2, function()
				-- Generic status text hook
				hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UnitFramesImproved_TextStatusBar_UpdateTextStringWithValues)
				
				-- Hook PlayerFrame functions
	      		hooksecurefunc("PlayerFrame_ToPlayerArt", UnitFramesImproved_PlayerFrame_ToPlayerArt)
				hooksecurefunc("PlayerFrame_ToVehicleArt", UnitFramesImproved_PlayerFrame_ToVehicleArt)

				-- Hook TargetFrame functions
				hooksecurefunc("TargetFrame_CheckDead", UnitFramesImproved_TargetFrame_Update)
				hooksecurefunc("TargetFrame_Update", UnitFramesImproved_TargetFrame_Update)
				hooksecurefunc("TargetFrame_CheckClassification", UnitFramesImproved_TargetFrame_CheckClassification)
				hooksecurefunc("TargetofTarget_Update", UnitFramesImproved_TargetFrame_Update)
				hooksecurefunc("TargetFrame_CheckFaction", UnitFramesImproved_TargetFrame_CheckFaction)
				-- BossFrame hooks
				hooksecurefunc("BossTargetFrame_OnLoad", UnitFramesImproved_BossTargetFrame_Style)
				
				-- Set up some stylings
				UnitFramesImproved_Style_PlayerFrame()
				UnitFramesImproved_BossTargetFrame_Style(Boss1TargetFrame)
				UnitFramesImproved_BossTargetFrame_Style(Boss2TargetFrame)
				UnitFramesImproved_BossTargetFrame_Style(Boss3TargetFrame)
				UnitFramesImproved_BossTargetFrame_Style(Boss4TargetFrame)
				UnitFramesImproved_Style_TargetFrame(TargetFrame)
				--UnitFramesImproved_Style_TargetFrame(FocusFrame)
				UnitFramesImproved_UnitName_Color()
				--[[
				if (FocusFrame) then
					UnitFramesImproved_Style_TargetFrame(FocusFrame)
				end
				--]]
				UnitFramesImproved_Style_TargetOfTargetFrame()
				
				-- Update some values
				TextStatusBar_UpdateTextString(PlayerFrame.healthbar)
				TextStatusBar_UpdateTextString(PlayerFrame.manabar)

				if (not FocusFrame) then
			
					TargetFrameHealthBar.TextString = CreateStatusBarText("Text", "TargetFrameHealthBar", TargetFrameTextureFrame, "CENTER", -50, 3)
					TargetFrameHealthBar.LeftText = CreateStatusBarText("TextLeft", "TargetFrameHealthBar", TargetFrameTextureFrame, "LEFT", 8, 3)
					TargetFrameHealthBar.RightText = CreateStatusBarText("TextRight", "TargetFrameHealthBar", TargetFrameTextureFrame, "RIGHT", -110, 3)
					
					TargetFrameManaBar.TextString = CreateStatusBarText("Text", "TargetFrameManaBar", TargetFrameTextureFrame, "CENTER", -50, -8)
					TargetFrameManaBar.LeftText = CreateStatusBarText("TextLeft", "TargetFrameManaBar", TargetFrameTextureFrame, "LEFT", 8, -8)
					TargetFrameManaBar.RightText = CreateStatusBarText("TextRight", "TargetFrameManaBar", TargetFrameTextureFrame, "RIGHT", -110, -8)
				end
			end)
		end)
	end
end)
-- End
----------------------------------------------------
