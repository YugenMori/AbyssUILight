-- Author: Yugen
--
-- Supports any version of wow
--
-- Classic module for AbyssUILight
--------------------------------------------------------------
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
local function AbyssUILight_ColorizationFrameFunction(...)
	local v = ...
	if AbyssUILightAddonSettings.UIVertexColorFrames01 == true then
		v:SetVertexColor(1, 1, 1)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames02 == true then
		v:SetVertexColor(.2, .2, .2)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames03 == true then
		v:SetVertexColor(182/255, 42/255, 37/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames04 == true then
		v:SetVertexColor(236/255, 193/255, 60/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames05 == true then
		v:SetVertexColor(196/255, 31/255, 59/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames06 == true then
		v:SetVertexColor(163/255, 48/255, 201/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames07 == true then
		v:SetVertexColor(252/255, 163/255, 85/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames08 == true then
		v:SetVertexColor(190/255, 221/255, 115/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames09 == true then
		v:SetVertexColor(64/255, 220/255, 255/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames10 == true then
		v:SetVertexColor(86/255, 255/255, 184/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames11 == true then
		v:SetVertexColor(255/255, 155/255, 195/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames12 == true then
		v:SetVertexColor(23/255, 28/255, 99/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames13 == true then
		v:SetVertexColor(255/255, 255/255, 0/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames14 == true then
		v:SetVertexColor(0/255, 112/255, 222/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames15 == true then
		v:SetVertexColor(135/255, 135/255, 237/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFrames16 == true then
		v:SetVertexColor(199/255, 156/255, 110/255)
	elseif AbyssUILightAddonSettings.UIVertexColorFramesColorPicker == true then
		local character = UnitName("player").."-"..GetRealmName()
		v:SetVertexColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)	
	else
		v:SetVertexColor(.4, .4, .4)
	end
end
-- Darker UI Core --
--------------------
local BasicFrames = CreateFrame("Frame")
BasicFrames:RegisterEvent("ADDON_LOADED")
BasicFrames:SetScript("OnEvent", function(self, event, addon)
	if (addon == "AbyssUILight") then
		for i, v in pairs({	PlayerFrameTexture,
			TargetFrameTextureFrameTexture,
			PetFrameTexture,
			PartyMemberFrame1Texture,
			PartyMemberFrame2Texture,
			PartyMemberFrame3Texture,
			PartyMemberFrame4Texture,
			PartyMemberFrame1PetFrameTexture,
			PartyMemberFrame2PetFrameTexture,
			PartyMemberFrame3PetFrameTexture,
			PartyMemberFrame4PetFrameTexture,
			FocusFrameTextureFrameTexture,
			TargetFrameToTTextureFrameTexture,
			FocusFrameToTTextureFrameTexture,
			BonusActionBarFrameTexture0,
			BonusActionBarFrameTexture1,
			BonusActionBarFrameTexture2,
			BonusActionBarFrameTexture3,
			BonusActionBarFrameTexture4,
			MainMenuBarTexture0,
			MainMenuBarTexture1,
			MainMenuBarTexture2,
			MainMenuBarTexture3,
			MainMenuMaxLevelBar0,
			MainMenuMaxLevelBar1,
			MainMenuMaxLevelBar2,
			MainMenuMaxLevelBar3,
			MinimapBorder,
			MinimapBorderTop,
			CastingBarFrameBorder,
			FocusFrameSpellBarBorder,
			TargetFrameSpellBarBorder,
			MiniMapTrackingButtonBorder,
			MiniMapLFGFrameBorder,
			MiniMapBattlefieldBorder,
			MiniMapMailBorder,
			MiniMapBorderTop, }) do
			MiniMapWorldMapButton:SetAlpha(0.3)
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		self:UnregisterEvent("ADDON_LOADED")
		BasicFrames:SetScript("OnEvent", nil)
	end
end)
-- Dark Unit Frames Exception
local DarkException = CreateFrame("Frame")
DarkException:RegisterEvent("ADDON_LOADED")
DarkException:SetScript("OnEvent", function(self, event, addon)
	if (addon == "AbyssUILight") then
		for i, v in pairs({
			PlayerFrameTexture,
			TargetFrameTextureFrameTexture,
			PetFrameTexture,
			PartyMemberFrame1Texture,
			PartyMemberFrame2Texture,
			PartyMemberFrame3Texture,
			PartyMemberFrame4Texture,
			PartyMemberFrame1PetFrameTexture,
			PartyMemberFrame2PetFrameTexture,
			PartyMemberFrame3PetFrameTexture,
			PartyMemberFrame4PetFrameTexture,
			FocusFrameTextureFrameTexture,
			TargetFrameToTTextureFrameTexture,
			FocusFrameToTTextureFrameTexture,
			MinimapBorder,
			MiniMapTrackingButtonBorder,
			MiniMapLFGFrameBorder,
			MiniMapBattlefieldBorder,
			MiniMapMailBorder, }) do
			if AbyssUILightAddonSettings ~= nil then
				if AbyssUILightAddonSettings.KeepUnitDark == true then
					v:SetVertexColor(.4, .4, .4)
				elseif AbyssUILightAddonSettings.KeepUnitBlizzard == true then
					v:SetVertexColor(1, 1, 1)
				else
					return nil
				end
			end
		end
	self:UnregisterEvent("ADDON_LOADED")
	DarkException:SetScript("OnEvent", nil)
	end
end)
------------------------- New Darker Parts -------------------------
-- New Interface Action Bar
local NewFrames = CreateFrame("Frame")
NewFrames:RegisterEvent("ADDON_LOADED")
NewFrames:SetScript("OnEvent", function(self, event, addon)
	if (addon == "AbyssUILight") then
		for i, v in pairs({ MainMenuBarLeftEndCap,
			MainMenuBarRightEndCap, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- Chat
		for i, v in pairs({ ChatFrame1EditBoxLeft,
			ChatFrame1EditBoxRight,
			ChatFrame1EditBoxMid,
			ChatFrame2EditBoxLeft,
			ChatFrame2EditBoxRight,
			ChatFrame2EditBoxMid,
			ChatFrame3EditBoxLeft,
			ChatFrame3EditBoxRight,
			ChatFrame3EditBoxMid,
			ChatFrame4EditBoxLeft,
			ChatFrame4EditBoxRight,
			ChatFrame4EditBoxMid,
			ChatFrame5EditBoxLeft,
			ChatFrame5EditBoxRight,
			ChatFrame5EditBoxMid,
			ChatFrame6EditBoxLeft,
			ChatFrame6EditBoxRight,
			ChatFrame6EditBoxMid,
			ChatFrame7EditBoxLeft,
			ChatFrame7EditBoxRight,
			ChatFrame7EditBoxMid,	}) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- StatusBar (ExpBar)
		for i, v in pairs({ MainMenuXPBarTexture0,
			MainMenuXPBarTexture1,
			MainMenuXPBarTexture2,
			MainMenuXPBarTexture3,
			ReputationWatchBar.StatusBar.WatchBarTexture0,
			ReputationWatchBar.StatusBar.WatchBarTexture1,
			ReputationWatchBar.StatusBar.WatchBarTexture2,
			ReputationWatchBar.StatusBar.WatchBarTexture3, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- StanceBar
		for i, v in pairs({ StanceBarLeft,
			StanceBarMiddle,
			StanceBarRight, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- HelpFrame
		for i, v in pairs({ HelpFrameTopBorder,
			HelpFrameRightBorder,
			HelpFrameTopRightCorner,
			HelpFrameBottomRightCorner,
			HelpFrameBottomBorder,
			HelpFrameBottomLeftCorner,
			HelpFrameLeftBorder,
			HelpFrameTopLeftCorner,
		 	HelpFrameVertDivTop,
			HelpFrameVertDivMiddle,
			HelpFrameVertDivBottom,
			HelpFrameHeaderTopBorder,
			HelpFrameHeaderTopRightCorner,
			HelpFrameHeaderRightBorder,
			HelpFrameHeaderBottomRightCorner,
			HelpFrameHeaderBottomBorder,
			HelpFrameHeaderBottomLeftCorner,
			HelpFrameHeaderLeftBorder,
			HelpFrameHeaderTopLeftCorner, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- Channels
		for i, v in pairs({ ChannelFrameTopBorder,
			ChannelFrameTopRightCorner,
			ChannelFrameRightBorder,
			ChannelFrameBotRightCorner,
			ChannelFrameBtnCornerRight,
			ChannelFrameBottomBorder,
			ChannelFrameBotLeftCorner,
			ChannelFrameBtnCornerLeft,
			ChannelFrameLeftBorder,
			ChannelFramePortraitFrame,	}) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- FriendsFrame
		for i, v in pairs({ FriendsFrameTopBorder,
			FriendsFrameTopRightCorner,
			FriendsFrameRightBorder,
			FriendsFrameBotRightCorner,
			FriendsFrameBtnCornerRight,
			FriendsFrameBottomBorder,
			FriendsFrameBotLeftCorner,
			FriendsFrameBtnCornerLeft,
			FriendsFrameLeftBorder,
			FriendsFramePortraitFrame,	}) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- MerchantFrame
		for i, v in pairs({ MerchantFrameTopBorder,
			MerchantFrameTopRightCorner,
			MerchantFrameRightBorder,
			MerchantFrameBotRightCorner,
			MerchantFrameBtnCornerRight,
			MerchantFrameBottomBorder,
			MerchantFrameBotLeftCorner,
			MerchantFrameBtnCornerLeft,
			MerchantFrameLeftBorder,
			MerchantFramePortraitFrame,	}) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- LootFrame
		for i, v in pairs({ LootFrameTopBorder,
			LootFrameTopRightCorner,
			LootFrameRightBorder,
			LootFrameBotRightCorner,
			LootFrameBtnCornerRight,
			LootFrameBottomBorder,
			LootFrameBotLeftCorner,
			LootFrameBtnCornerLeft,
			LootFrameLeftBorder,
			LootFramePortraitFrame,	}) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- MailFrame
		for i, v in pairs({ MailFrameTopBorder,
			MailFrameTopRightCorner,
			MailFrameRightBorder,
			MailFrameBotRightCorner,
			MailFrameBtnCornerRight,
			MailFrameBottomBorder,
			MailFrameBotLeftCorner,
			MailFrameBtnCornerLeft,
			MailFrameLeftBorder,
			MailFramePortraitFrame,	}) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
		-- Frames that blizzard didn't atribute proper names 
		--[[
		for i, v in pairs({ PaperDollFrame, 
			QuestLogFrame,
			SpellBookFrame, }) do
			if AbyssUILightAddonSettings ~= nil then
				if AbyssUILightAddonSettings.UIVertexColorFrames01 == true then
					v:SetVertexColor(1, 1, 1)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames02 == true then
					v:SetVertexColor(.2, .2, .2)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames03 == true then
					v:SetVertexColor(182/255, 42/255, 37/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames04 == true then
					v:SetVertexColor(236/255, 193/255, 60/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames05 == true then
					v:SetVertexColor(196/255, 31/255, 59/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames06 == true then
					v:SetVertexColor(163/255, 48/255, 201/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames07 == true then
					v:SetVertexColor(252/255, 163/255, 85/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames08 == true then
					v:SetVertexColor(190/255, 221/255, 115/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames09 == true then
					v:SetVertexColor(64/255, 220/255, 255/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames10 == true then
					v:SetVertexColor(86/255, 255/255, 184/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames11 == true then
					v:SetVertexColor(255/255, 155/255, 195/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames12 == true then
					v:SetVertexColor(23/255, 28/255, 99/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames13 == true then
					v:SetVertexColor(255/255, 255/255, 0/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames14 == true then
					v:SetVertexColor(0/255, 112/255, 222/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames15 == true then
					v:SetVertexColor(135/255, 135/255, 237/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFrames16 == true then
					v:SetVertexColor(199/255, 156/255, 110/255)
				elseif AbyssUILightAddonSettings.UIVertexColorFramesColorPicker == true then
					local character = UnitName("player").."-"..GetRealmName()
					v:SetVertexColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)
				else
					v:SetVertexColor(.4, .4, .4)
				end
			else
				return nil
			end
		end
		--]]
		-- End
		self:UnregisterEvent("ADDON_LOADED")
		NewFrames:SetScript("OnEvent", nil)
	end
end)
-------------- Frames that need a load to work properly --------------
-- AuctionHouse
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AuctionUI" then
		for i, v in pairs({ AuctionFrameTop, 
			AuctionFrameTopLeft, 
			AuctionFrameTopRight,
			AuctionFrameBot, 
			AuctionFrameBotLeft, 
			AuctionFrameBotRight, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
	end
end)
-- Macros
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_MacroUI" then
		for i, v in pairs({ MacroFrameTopBorder,
			MacroFrameTopRightCorner,
			MacroFrameRightBorder,
			MacroFrameBotRightCorner,
			MacroFrameBtnCornerRight,
			MacroFrameBottomBorder,
			MacroFrameBotLeftCorner,
			MacroFrameBtnCornerLeft,
			MacroFrameLeftBorder,
			MacroFramePortraitFrame, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
	end
end)
---------------------------- NEW FOR HARDCORE ---------------------------------- 
-- UnitColor
local UnitColor
local function UnitColor(unit)
  if (AbyssUILightAddonSettings.UnitFrameImproved == true) then
    local r, g, b, a
    if ((not UnitIsPlayer(unit)) and ((not UnitIsConnected(unit)) or (UnitIsDeadOrGhost(unit)))) then
      --Color it gray
      r, g, b, a = 0.5, 0.5, 0.5, 1
    elseif (UnitIsPlayer(unit)) then
      --Try to color it by class.
      local localizedClass, englishClass = UnitClass(unit)
      local classColor = RAID_CLASS_COLORS[englishClass]
      if (classColor and not AbyssUILightAddonSettings.GreenHealth) then
        r, g, b, a = classColor.r, classColor.g, classColor.b, classColor.a
      else
        if (UnitIsFriend("player", unit)) then
          r, g, b, a = 0.0, 1.0, 0.0, 1
        else
          r, g, b, a = 1.0, 0.0, 0.0, 1
        end
      end
    else
      r, g, b, a = UnitSelectionColor(unit)
    end
    return r, g, b, a
  end
end
---------------------------- Classic Frames ----------------------------------
local ClassicFrames = CreateFrame("Frame")
ClassicFrames:RegisterEvent("ADDON_LOADED")
ClassicFrames:SetScript("OnEvent", function(self, event, addon)
	if (addon == "AbyssUILight") then
		if GetWoWVersion <= 30600 then
			-- General
			for i, v in pairs({ 
				MiniMapTrackingBorder,
				GameTimeTexture,
				MainMenuXPBarTexture0,
				MainMenuXPBarTexture1,
				MainMenuXPBarTexture2,
				MainMenuXPBarTexture3,
				ReputationWatchBar.StatusBar.WatchBarTexture0,
				ReputationWatchBar.StatusBar.WatchBarTexture1,
				ReputationWatchBar.StatusBar.WatchBarTexture2,
				ReputationWatchBar.StatusBar.WatchBarTexture3,
				ChatFrame1EditBoxLeft,
				ChatFrame1EditBoxMid,
				ChatFrame1EditBoxRight,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			--GameMenuFrame
			for i, v in pairs({ 
				GameMenuFrame.BottomEdge,
				GameMenuFrame.BottomLeftCorner,
				GameMenuFrame.BottomRightCorner,
				GameMenuFrame.Center,
				GameMenuFrame.LeftEdge,
				GameMenuFrame.RightEdge,
				GameMenuFrame.TopLeftCorner,
				GameMenuFrame.TopRightCorner,
				GameMenuFrameHeader,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					if GetWoWVersion > 10000 then
						AbyssUILight_ColorizationFrameFunction(v)
					end
				end
			end
			-- HelpFrame
			for i, v in pairs({ 
				HelpFrameTopBorder,
				HelpFrameTopLeftCorner,
				HelpFrameTopRightCorner,
				HelpFrameBotLeftCorner,
				HelpFrameBotRightCorner,
				HelpFrameLeftBorder,
				HelpFrameRightBorder,
				HelpFrameBottomBorder,
				HelpFrameBtnCornerLeft,
				HelpFrameBtnCornerRight,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- InterfaceOptionsFrame
			for i, v in pairs({ 
				InterfaceOptionsFrame.BottomEdge,
				InterfaceOptionsFrame.BottomLeftCorner,
				InterfaceOptionsFrame.BottomRightCorner,
				InterfaceOptionsFrame.Center,
				InterfaceOptionsFrame.LeftEdge,
				InterfaceOptionsFrame.RightEdge,
				InterfaceOptionsFrame.TopEdge,
				InterfaceOptionsFrame.TopLeftCorner,
				InterfaceOptionsFrame.TopRightCorner,
				InterfaceOptionsFrameHeader,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- VideoOptionsFrame
			for i, v in pairs({ 
				VideoOptionsFrame.BottomEdge,
				VideoOptionsFrame.BottomLeftCorner,
				VideoOptionsFrame.BottomRightCorner,
				VideoOptionsFrame.Center,
				VideoOptionsFrame.LeftEdge,
				VideoOptionsFrame.RightEdge,
				VideoOptionsFrame.TopEdge,
				VideoOptionsFrame.TopLeftCorner,
				VideoOptionsFrame.TopRightCorner,
				VideoOptionsFrameHeader,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- AddonList
			for i, v in pairs({ 
				AddonListTopBorder,
				AddonListTopLeftCorner,
				AddonListTopRightCorner,
				AddonListBotLeftCorner,
				AddonListBotRightCorner,
				AddonListLeftBorder,
				AddonListRightBorder,
				AddonListBottomBorder,
				AddonListButtonBottomBorder,
				AddonListBtnCornerLeft,
				AddonListBtnCornerRight,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- ContainerFrame1
			for i, v in pairs({ 
				ContainerFrame1Background1Slot,
				ContainerFrame1BackgroundBottom,
				ContainerFrame1BackgroundMiddle1,
				ContainerFrame1BackgroundMiddle2,
				ContainerFrame1BackgroundTop,
				ContainerFrame1BackgroundPortrait,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- ContainerFrame2
			for i, v in pairs({ 
				ContainerFrame2Background1Slot,
				ContainerFrame2BackgroundBottom,
				ContainerFrame2BackgroundMiddle1,
				ContainerFrame2BackgroundMiddle2,
				ContainerFrame2BackgroundTop,
				ContainerFrame2BackgroundPortrait,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- ContainerFrame3
			for i, v in pairs({ 
				ContainerFrame3Background1Slot,
				ContainerFrame3BackgroundBottom,
				ContainerFrame3BackgroundMiddle1,
				ContainerFrame3BackgroundMiddle2,
				ContainerFrame3BackgroundTop,
				ContainerFrame3BackgroundPortrait,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- ContainerFrame4
			for i, v in pairs({ 
				ContainerFrame4Background1Slot,
				ContainerFrame4BackgroundBottom,
				ContainerFrame4BackgroundMiddle1,
				ContainerFrame4BackgroundMiddle2,
				ContainerFrame4BackgroundTop,
				ContainerFrame4BackgroundPortrait,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- ContainerFrame5
			for i, v in pairs({ 
				ContainerFrame5Background1Slot,
				ContainerFrame5BackgroundBottom,
				ContainerFrame5BackgroundMiddle1,
				ContainerFrame5BackgroundMiddle2,
				ContainerFrame5BackgroundTop,
				ContainerFrame5BackgroundPortrait,
		 	 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- StaticPopUp ("LogoutFrame")
			for i, v in pairs({	
				StaticPopup1.BottomEdge,
				StaticPopup1.BottomLeftCorner,
				StaticPopup1.BottomRightCorner,
				StaticPopup1.Center,
				StaticPopup1.LeftEdge,
				StaticPopup1.RightEdge,
				StaticPopup1.TopEdge,
				StaticPopup1.TopLeftCorner,
				StaticPopup1.TopRightCorner,
				StaticPopup2.BottomEdge,
				StaticPopup2.BottomLeftCorner,
				StaticPopup2.BottomRightCorner,
				StaticPopup2.Center,
				StaticPopup2.LeftEdge,
				StaticPopup2.RightEdge,
				StaticPopup2.TopEdge,
				StaticPopup2.TopLeftCorner,
				StaticPopup2.TopRightCorner,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					if (not InCombatLockdown()) then
						AbyssUILight_ColorizationFrameFunction(v)
					end
				end
			end
			-- FriendsFrame
			for i, v in pairs({ 
				FriendsFrameTopBorder,
				FriendsFrameTopLeftCorner,
				FriendsFrameTopRightCorner,
				FriendsFrameBotLeftCorner,
				FriendsFrameBotRightCorner,
				FriendsFrameLeftBorder,
				FriendsFrameRightBorder,
				FriendsFrameBottomBorder,
				FriendsFrameButtonBottomBorder,
				FriendsFrameBtnCornerLeft,
				FriendsFrameBtnCornerRight,
				FriendsFramePortraitFrame,
				FriendsFrameTab1Left,
				FriendsFrameTab1LeftDisabled,
				FriendsFrameTab1Middle,
				FriendsFrameTab1MiddleDisabled,
				FriendsFrameTab1Right,
				FriendsFrameTab1RightDisabled,
				FriendsFrameTab2Left,
				FriendsFrameTab2LeftDisabled,
				FriendsFrameTab2Middle,
				FriendsFrameTab2MiddleDisabled,
				FriendsFrameTab2Right,
				FriendsFrameTab2RightDisabled,
				FriendsFrameTab3Left,
				FriendsFrameTab3LeftDisabled,
				FriendsFrameTab3Middle,
				FriendsFrameTab3MiddleDisabled,
				FriendsFrameTab3Right,
				FriendsFrameTab3RightDisabled,
				FriendsFrameTab4Left,
				FriendsFrameTab4LeftDisabled,
				FriendsFrameTab4Middle,
				FriendsFrameTab4MiddleDisabled,
				FriendsFrameTab4Right,
				FriendsFrameTab4RightDisabled,
				FriendsFrameBattlenetFrame.BroadcastFrame.BottomEdge,
				FriendsFrameBattlenetFrame.BroadcastFrame.BottomLeftCorner,
				FriendsFrameBattlenetFrame.BroadcastFrame.BottomRightCorner,
				FriendsFrameBattlenetFrame.BroadcastFrame.Center,
				FriendsFrameBattlenetFrame.BroadcastFrame.LeftEdge,
				FriendsFrameBattlenetFrame.BroadcastFrame.RightEdge,
				FriendsFrameBattlenetFrame.BroadcastFrame.TopEdge,
				FriendsFrameBattlenetFrame.BroadcastFrame.TopLeftCorner,
				FriendsFrameBattlenetFrame.BroadcastFrame.TopRightCorner,
				DropDownList1Backdrop.BottomEdge,
				DropDownList1Backdrop.BottomLeftCorner,
				DropDownList1Backdrop.BottomRightCorner,
				DropDownList1Backdrop.Center,
				DropDownList1Backdrop.LeftEdge,
				DropDownList1Backdrop.RightEdge,
				DropDownList1Backdrop.TopEdge,
				DropDownList1Backdrop.TopLeftCorner,
				DropDownList1Backdrop.TopRightCorner,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- MerchantFrame
			for i, v in pairs({ 
				MerchantFrameTopBorder,
				MerchantFrameTopLeftCorner,
				MerchantFrameTopRightCorner,
				MerchantFrameBotLeftCorner,
				MerchantFrameBotRightCorner,
				MerchantFrameLeftBorder,
				MerchantFrameRightBorder,
				MerchantFrameBottomBorder,
				MerchantFrameButtonBottomBorder,
				MerchantFrameBtnCornerLeft,
				MerchantFrameBtnCornerRight,
				MerchantFramePortraitFrame,
				MerchantFrameTab1Left,
				MerchantFrameTab1LeftDisabled,
				MerchantFrameTab1Middle,
				MerchantFrameTab1MiddleDisabled,
				MerchantFrameTab1Right,
				MerchantFrameTab1RightDisabled,
				MerchantFrameTab2Left,
				MerchantFrameTab2LeftDisabled,
				MerchantFrameTab2Middle,
				MerchantFrameTab2MiddleDisabled,
				MerchantFrameTab2Right,
				MerchantFrameTab2RightDisabled,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- CharacterFrame
			for i, v in pairs({
				CharacterFrameTab1Left,
				CharacterFrameTab1LeftDisabled,
				CharacterFrameTab1Middle,
				CharacterFrameTab1MiddleDisabled,
				CharacterFrameTab1Right,
				CharacterFrameTab1RightDisabled,
				CharacterFrameTab2Left,
				CharacterFrameTab2LeftDisabled,
				CharacterFrameTab2Middle,
				CharacterFrameTab2MiddleDisabled,
				CharacterFrameTab2Right,
				CharacterFrameTab2RightDisabled,
				CharacterFrameTab3Left,
				CharacterFrameTab3LeftDisabled,
				CharacterFrameTab3Middle,
				CharacterFrameTab3MiddleDisabled,
				CharacterFrameTab3Right,
				CharacterFrameTab3RightDisabled,
				CharacterFrameTab4Left,
				CharacterFrameTab4LeftDisabled,
				CharacterFrameTab4Middle,
				CharacterFrameTab4MiddleDisabled,
				CharacterFrameTab4Right,
				CharacterFrameTab4RightDisabled,
				CharacterFrameTab5Left,
				CharacterFrameTab5LeftDisabled,
				CharacterFrameTab5Middle,
				CharacterFrameTab5MiddleDisabled,
				CharacterFrameTab5Right,
				CharacterFrameTab5RightDisabled,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- MailFrame
			for i, v in pairs({ 
				MailFrameTopBorder,
				MailFrameTopLeftCorner,
				MailFrameTopRightCorner,
				MailFrameBotLeftCorner,
				MailFrameBotRightCorner,
				MailFrameLeftBorder,
				MailFrameRightBorder,
				MailFrameBottomBorder,
				MailFrameButtonBottomBorder,
				MailFrameBtnCornerLeft,
				MailFrameBtnCornerRight,
				MailFramePortraitFrame,
				MailFrameTab1Left,
				MailFrameTab1LeftDisabled,
				MailFrameTab1Middle,
				MailFrameTab1MiddleDisabled,
				MailFrameTab1Right,
				MailFrameTab1RightDisabled,
				MailFrameTab2Left,
				MailFrameTab2LeftDisabled,
				MailFrameTab2Middle,
				MailFrameTab2MiddleDisabled,
				MailFrameTab2Right,
			MailFrameTab2RightDisabled,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
			-- CastBarBorder
			if (GetWoWVersion <= 90500) then
				for i, v in pairs({	
					CastingBarFrame.Border,
					TargetFrameSpellBar.Border,
				TargetFrameSpellBar.BorderShield, }) do
					if AbyssUILightAddonSettings ~= nil then
						AbyssUILight_ColorizationFrameFunction(v)
					else
						return nil
					end
				end	
			end
			-- TradeFrame
			for i, v in pairs({ 
				TradeFrameTopBorder,
				TradeFrameTopLeftCorner,
				TradeFrameTopRightCorner,
				TradeFrameBotLeftCorner,
				TradeFrameBotRightCorner,
				TradeFrameLeftBorder,
				TradeFrameRightBorder,
				TradeFrameBottomBorder,
				TradeFrameBtnCornerLeft,
				TradeFrameBtnCornerRight,
				TradeFramePlayerPortrait,
				TradeFrameRecipientPortrait,
			 }) do
				if AbyssUILightAddonSettings ~= nil then
					AbyssUILight_ColorizationFrameFunction(v)
				end
			end
		-- End
		else
			return nil
		end
	end		
end)
---------------------------- Classic Functions ----------------------------------
-- KeyBindingFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_BindingUI" and GetWoWVersion == 20502 and GetWoWVersion >= 12000 then
		for i, v in pairs({
			KeyBindingFrame.BottomEdge,
			KeyBindingFrame.BottomLeftCorner,
			KeyBindingFrame.BottomRightCorner,
			KeyBindingFrame.Center,
			KeyBindingFrame.LeftEdge,
			KeyBindingFrame.RightEdge,
			KeyBindingFrame.TopEdge,
			KeyBindingFrame.TopLeftCorner,
			KeyBindingFrame.TopRightCorner,
			KeyBindingFrameHeader, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
	end
end)
-- MacroFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_MacroUI" and GetWoWVersion <= 30600 then
		for i, v in pairs({
			MacroFramePortraitFrame,
			MacroFrameTopBorder,
			MacroFrameTopLeftCorner,
			MacroFrameTopRightCorner,
			MacroFrameBotLeftCorner,
			MacroFrameBotRightCorner,
			MacroFrameLeftBorder,
			MacroFrameRightBorder,
			MacroFrameBottomBorder,
			MacroFrameButtonBottomBorder,
			MacroFrameBtnCornerLeft,
			MacroFrameBtnCornerRight, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
	end
end)
-- TimeManagerFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TimeManager" and GetWoWVersion <= 30600 then
		for i, v in pairs({
			TimeManagerFrameTopBorder,
			TimeManagerFrameTopLeftCorner,
			TimeManagerFrameTopRightCorner,
			TimeManagerFrameBotLeftCorner,
			TimeManagerFrameBotRightCorner,
			TimeManagerFrameLeftBorder,
			TimeManagerFrameRightBorder,
			TimeManagerFrameBottomBorder,
			TimeManagerFrameButtonBottomBorder,
			TimeManagerFrameBtnCornerLeft,
			TimeManagerFrameBtnCornerRight,
			TimeManagerFramePortraitFrame, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
	end
end)

-- AuctionFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AuctionUI" and GetWoWVersion <= 30600 then
		for i, v in pairs({
			AuctionFrameBot,
			AuctionFrameBotLeft,
			AuctionFrameBotRight,
			AuctionFrameTop,
			AuctionFrameTopLeft,
			AuctionFrameTopRight,
			AuctionFrameTab1Left,
			AuctionFrameTab1LeftDisabled,
			AuctionFrameTab1Middle,
			AuctionFrameTab1MiddleDisabled,
			AuctionFrameTab1Right,
			AuctionFrameTab1RightDisabled,
			AuctionFrameTab2Left,
			AuctionFrameTab2LeftDisabled,
			AuctionFrameTab2Middle,
			AuctionFrameTab2MiddleDisabled,
			AuctionFrameTab2Right,
			AuctionFrameTab2RightDisabled,
			AuctionFrameTab3Left,
			AuctionFrameTab3LeftDisabled,
			AuctionFrameTab3Middle,
			AuctionFrameTab3MiddleDisabled,
			AuctionFrameTab3Right,
			AuctionFrameTab3RightDisabled, }) do
			if AbyssUILightAddonSettings ~= nil then
				AbyssUILight_ColorizationFrameFunction(v)
			else
				return nil
			end
		end
	end
end)
-- PlayerTalentFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TalentUI" and GetWoWVersion == 20502 and GetWoWVersion >= 12000 then
		self:UnregisterAllEvents()
    local ChildRegions = { PlayerTalentFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
    for i, v in pairs({ 
    	PlayerTalentFrameTab1Left,
		PlayerTalentFrameTab1LeftDisabled,
		PlayerTalentFrameTab1Middle,
		PlayerTalentFrameTab1MiddleDisabled,
		PlayerTalentFrameTab1Right,
		PlayerTalentFrameTab1RightDisabled,
		PlayerTalentFrameTab2Left,
		PlayerTalentFrameTab2LeftDisabled,
		PlayerTalentFrameTab2Middle,
		PlayerTalentFrameTab2MiddleDisabled,
		PlayerTalentFrameTab2Right,
		PlayerTalentFrameTab2RightDisabled,
		PlayerTalentFrameTab3Left,
		PlayerTalentFrameTab3LeftDisabled,
		PlayerTalentFrameTab3Middle,
		PlayerTalentFrameTab32MiddleDisabled,
		PlayerTalentFrameTab3Right,
		PlayerTalentFrameTab3RightDisabled,	}) do
		AbyssUILight_ColorizationFrameFunction(v)
    end
	end
end)
-- ClassTrainerFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TrainerUI" and GetWoWVersion == 20502 and GetWoWVersion >= 12000 then
		self:UnregisterAllEvents()
    local ChildRegions = { ClassTrainerFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
	end
end)
-- PaperDollFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { PaperDollFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- ReputationFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { ReputationFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- SkillFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { SkillFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- PVPFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 and GetWoWVersion >= 12000 then
    self:UnregisterAllEvents()
    local ChildRegions = { PVPFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- HonorFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion ~= 20502 and GetWoWVersion <= 12000 then
    self:UnregisterAllEvents()
    local ChildRegions = { HonorFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- GameMenuFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 12000 then
    self:UnregisterAllEvents()
    local ChildRegions = { GameMenuFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- SpellBookFrame
--[[
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { SpellBookFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
    for i, v in pairs({
    	SpellButton1SubSpellName,
    	SpellButton2SubSpellName,
    	SpellButton3SubSpellName,
    	SpellButton4SubSpellName,
    	SpellButton5SubSpellName,
    	SpellButton6SubSpellName,
    	SpellButton7SubSpellName,
    	SpellButton8SubSpellName,
    	SpellButton9SubSpellName,
    	SpellButton10SubSpellName,
    	SpellButton11SubSpellName,
    	SpellButton12SubSpellName,
    }) do
    	v:SetVertexColor(219/255, 222/255, 231/255)
    end
  end
end)
--]]
--[[
-- QuestLogFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
		if (AbyssUILightAddonSettings.ExtraFunctionDisableQuestFrame ~= true) then
	    self:UnregisterAllEvents()
	    local ChildRegions = { QuestLogFrame:GetRegions(), QuestFrameDetailPanel:GetRegions() }
	    local fs = {}
	    for k, v in pairs(ChildRegions) do
	    	AbyssUILight_ColorizationFrameFunction(v)
	    end
	    for i, v in pairs({ 
	    	QuestLogQuestTitle,
	    	QuestLogObjective1,
	    	QuestLogObjective2,
	    	QuestLogObjectivesText,
	    	QuestLogDescriptionTitle,
	    	QuestLogQuestDescription,
	    }) do
	    	v:SetVertexColor(219/255, 222/255, 231/255)
	    end
	  end
  end
end)
--]]
--[[
-- QuestFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 and GetWoWVersion >= 12000 then
		if (AbyssUILightAddonSettings.ExtraFunctionDisableQuestFrame ~= true) then
	    self:UnregisterAllEvents()
	    local ChildRegions = { 
	    	QuestFrame:GetRegions(), 
	    	QuestLogDetailFrame:GetRegions(),
	  		QuestFrameProgressPanel:GetRegions(),
	  		QuestFrameRewardPanel:GetRegions()
	  	}
	    local ScrollRegions = { 
	    	QuestDetailScrollFrame:GetRegions(),
	     	QuestDetailScrollChildFrame:GetRegions(), 
	    	QuestLogDetailScrollFrame:GetRegions(), 
	     	QuestLogDetailScrollChildFrame:GetRegions(), 
	     	QuestRewardScrollFrame:GetRegions(), 
	     	QuestRewardScrollChildFrame:GetRegions(), 
	   		QuestInfoRewardsFrame:GetRegions(),
	   		QuestProgressTitleText,
	   		QuestProgressText,
	   		QuestInfoRewardText,
	    }
	    local fs = {}
	    for k, v in pairs(ChildRegions) do
	    	AbyssUILight_ColorizationFrameFunction(v)
	    end
	    for k, v in pairs(ScrollRegions) do
	    	v:SetVertexColor(219/255, 222/255, 231/255)
	    end
  	end
  end
end)
--]]
--[[
-- GossipFrameGreetingPanel
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { GossipFrameGreetingPanel:GetRegions() }
    local ScrollRegions = { 
    	GossipGreetingScrollFrame:GetRegions(), 
     	GossipGreetingScrollChildFrame:GetRegions(),  }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
    for k, v in pairs(ScrollRegions) do
    	v:SetVertexColor(219/255, 222/255, 231/255)
    end
  end
end)
--]]
-- BankFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { BankFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
    for i, v in pairs({
	    BankFrameTab1Left,
			BankFrameTab1LeftDisabled,
			BankFrameTab1Middle,
			BankFrameTab1MiddleDisabled,
			BankFrameTab1Right,
			BankFrameTab1RightDisabled,
			BankFrameTab2Left,
			BankFrameTab2LeftDisabled,
			BankFrameTab2Middle,
			BankFrameTab2MiddleDisabled,
			BankFrameTab2Right,
			BankFrameTab2RightDisabled, 
	 	}) do
	 		AbyssUILight_ColorizationFrameFunction(v)
		end
  end
end)
-- TaxiFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { TaxiFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- TabardFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { TabardFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- WorldMapFrame.BorderFrame
local leatrix = IsAddOnLoaded("Leatrix_Maps")
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 then
		if (not leatrix) then
	    self:UnregisterAllEvents()
	    local ChildRegions = { WorldMapFrame.BorderFrame:GetRegions() }
	    local fs = {}
	    for k, v in pairs(ChildRegions) do
	    	AbyssUILight_ColorizationFrameFunction(v)
	    end
	  end
  end
end)
-- LFGParentFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 20600 and GetWoWVersion >= 12000 then
    self:UnregisterAllEvents()
    local ChildRegions = { LFGParentFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
   	for i, v in pairs({
	    LFGParentFrameTab1Left,
			LFGParentFrameTab1LeftDisabled,
			LFGParentFrameTab1Middle,
			LFGParentFrameTab1MiddleDisabled,
			LFGParentFrameTab1Right,
			LFGParentFrameTab1RightDisabled,
			LFGParentFrameTab2Left,
			LFGParentFrameTab2LeftDisabled,
			LFGParentFrameTab2Middle,
			LFGParentFrameTab2MiddleDisabled,
			LFGParentFrameTab2Right,
			LFGParentFrameTab2RightDisabled, 
	 	}) do
	 		AbyssUILight_ColorizationFrameFunction(v)
		end
  end
end)
-- ArenaFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion >= 20502 and GetWoWVersion < 90000 then
    self:UnregisterAllEvents()
    local ChildRegions = { ArenaFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- InterfaceOptionsFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 12000 then
    self:UnregisterAllEvents()
    local ChildRegions = { InterfaceOptionsFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- VideoOptionsFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 12000 then
    self:UnregisterAllEvents()
    local ChildRegions = { VideoOptionsFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- HonorFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30000 then
    self:UnregisterAllEvents()
    local ChildRegions = { HonorFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
---------------------------- Classic Dynamically ----------------------------------
-- Clock
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event, name)
	if GetWoWVersion <= 30600 then
		loaded = IsAddOnLoaded("Blizzard_TimeManager")
		if not loaded then
			LoadAddOn('Blizzard_TimeManager')
		end
		local showclock = true
		if (showclock and not AbyssUILightAddonSettings.ExtraFunctionMinimapClock) then
			local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
			if (AbyssUILightAddonSettings.AlwaysShowClock ~= true) then
				clockFrame:Hide()
				clockTime:Show()
				TimeManagerClockButton:SetPoint("BOTTOM", Minimap, 0, -6)
				TimeManagerClockButton:SetAlpha(0)
			end
		elseif (showclock and AbyssUILightAddonSettings.ExtraFunctionMinimapClock) then
			LoadAddOn('Blizzard_TimeManager')
			local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
			clockFrame:Hide()
			clockTime:Show()
			clockTime:SetFont(damageFont, 12, "THINOUTLINE")
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, 0, -6)
			TimeManagerClockButton:SetAlpha(1)
		else
			TimeManagerClockButton.Show = TimeManagerClockButton.Hide
			local region = TimeManagerClockButton:GetRegions()
			region:Hide()	
			TimeManagerClockButton:ClearAllPoints()	
			TimeManagerClockButton:Hide()	
		end
		-- Clock/Calendar Handler
		Minimap:HookScript("OnEnter", function()
		  TimeManagerClockButton:SetAlpha(1)
		end)
		Minimap:HookScript("OnLeave", function()
			if (not AbyssUILightAddonSettings.ExtraFunctionMinimapClock and AbyssUILightAddonSettings.AlwaysShowClock ~= true) then
		  	TimeManagerClockButton:SetAlpha(0)
			end
		end)
	end
end)
-- KeyBindingFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_BindingUI" and GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { KeyBindingFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
	end
end)
-- PlayerTalentFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TalentUI" and GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { PlayerTalentFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
	end
end)
-- PlayerTalentFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_InspectUI" and GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { InspectPaperDollFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
	end
end)
--[[
local function ChatHiderFunc()
	-- Chat Hide Frame (needs to be here so the hide chat buttons works on this too)
	-- Thanks to Syncrow for part of this 
	local ChatHideFrame = CreateFrame("Button", "$parentChatHideFrame", UIParent)
	ChatHideFrame:SetSize(30, 30)
	ChatHideFrame.t = ChatHideFrame:CreateTexture(nil, "BORDER")
	ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
	ChatHideFrame.t:SetAllPoints(ChatHideFrame)
	ChatHideFrame:SetPoint("BOTTOM","ChatFrame1ButtonFrame","BOTTOM", 0, -35)
	if ( AbyssUILightAddonSettings.FadeUI ~= true ) then
	  ChatHideFrame:Show()
	else
	  ChatHideFrame:Hide()
	end

	local ChatHide = false
	ChatHideFrame:SetScript("OnMouseDown", function(self, Button)
	  if ChatHide == false then
	    if Button == "LeftButton" then
	      ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Down.blp")
	    end
	  elseif ChatHide == true then
	    if Button == "LeftButton" then
	      ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Down.blp")
	    end
	  end
	end)

	ChatHideFrame:SetScript("OnMouseUp", function(self, Button)
	  if ChatHide == false then
	    if Button == "LeftButton" then
	      ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
	    end
	  elseif ChatHide == true then
	    if Button == "LeftButton" then
	      ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
	    end
	  end
	end)

	ChatHideFrame:SetScript("OnClick", function(self, Button)
	  if ChatHide == false then
	    ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
	    GeneralDockManager:Hide()
	    ChatFrameMenuButton:Hide()
	    ChatFrameChannelButton:Hide()
	    ChatFrame1EditBox:Hide()
	    if GetWoWVersion > 30600 then
	  		QuickJoinToastButton:Hide()
				ChatFrameToggleVoiceDeafenButton.Icon:Hide()
	    	ChatFrameToggleVoiceMuteButton.Icon:Hide()
	    end

	    for i = 1, NUM_CHAT_WINDOWS do
	      _G["ChatFrame"..i..""]:SetAlpha(0)
	      _G["ChatFrame"..i.."ButtonFrame"]:Hide()
	      _G["ChatFrame"..i.."EditBox"]:SetAlpha(0)
	    end
	    ChatHide = true
	  elseif ChatHide == true then
	    ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
	    GeneralDockManager:Show()
	    ChatFrameMenuButton:Show()
	    ChatFrameChannelButton:Show()
	    ChatFrame1EditBox:Show()
	    if GetWoWVersion > 30600 then
	  		QuickJoinToastButton:Show()
				ChatFrameToggleVoiceDeafenButton.Icon:Show()
	    	ChatFrameToggleVoiceMuteButton.Icon:Show()
	    end

	    for i = 1 , NUM_CHAT_WINDOWS do
	      _G["ChatFrame"..i..""]:SetAlpha(1)
	      _G["ChatFrame"..i.."ButtonFrame"]:Show()
	      _G["ChatFrame"..i.."EditBox"]:SetAlpha(1)
	    end
	    ChatHide = false
	  end
	end)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	ChatHiderFunc()
end)
--]]
---------------------------- LichKing Classic Modules ----------------------------------
-- GlyphFrame
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_GlyphUI" and GetWoWVersion <= 30600 then
    self:UnregisterAllEvents()
    local ChildRegions = { GlyphFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
	end
end)
-- PetPaperDollFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 and GetWoWVersion >= 30000  then
    self:UnregisterAllEvents()
    local ChildRegions = { PetPaperDollFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
-- LFGFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 and GetWoWVersion >= 12000 then
    local ChildRegions = { LFGListingFrame:GetRegions(), LFGBrowseFrame:GetRegions(), }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
    for i, v in pairs({
    	LFGListingFrameFrameBackgroundTop,
			LFGListingFrameFrameBackgroundBottom,
    }) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
--[[
-- GameTimeFrame
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if GetWoWVersion <= 30600 and GetWoWVersion >= 30000  then
    self:UnregisterAllEvents()
    local ChildRegions = { GameTimeFrame:GetRegions() }
    local fs = {}
    for k, v in pairs(ChildRegions) do
    	AbyssUILight_ColorizationFrameFunction(v)
    end
  end
end)
--]]
---------------------------- Classic Era Modules ----------------------------------
-- Character Name Class Color
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if not AbyssUILightAddonSettings then
    AbyssUILightAddonSettings = {}
  end
	if name == "AbyssUILight" and AbyssUILightAddonSettings.DisableCharacterText ~= true then
		local localizedClass, englishClass = UnitClass("player")
    local classColor = RAID_CLASS_COLORS[englishClass]
    if (classColor) then
      r, g, b = classColor.r, classColor.g, classColor.b
    end
    if GetWoWVersion <= 30600 then
    	CharacterNameText:SetVertexColor(r, g, b)
    else
    	if GetWoWVersion > 40000 then
    		CharacterFrameTitleText:SetVertexColor(r, g, b)
    	end
  	end
	end
end)
local function TargetFramePortraitChecker()
local classification = UnitClassification("target")
	if (classification == "normal") then
		TargetFrameTextureFrameTexture:SetTexture("Interface\\Addons\\AbyssUILight\\textures\\targetingframe\\UI-TargetingFrame")
	elseif (classification == "elite") then
		TargetFrameTextureFrameTexture:SetTexture("Interface\\Addons\\AbyssUILight\\textures\\targetingframe\\UI-TargetingFrame-Elite")
	else
		return nil
	end
end
-- Target Mob(Enemy) Health Bar Color
local frame = CreateFrame("Frame", "$parentFrame", nil)
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
local function eventHandler(self, event, ...)
	if ( AbyssUILightAddonSettings.UnitFrameImproved ~= true ) then
		if GetWoWVersion <= 30600 then
			if ( event == "PLAYER_TARGET_CHANGED" ) then
				TargetFramePortraitChecker()
				if ( UnitReaction("player", "target") ~= nil ) then
					local target = UnitReaction("player", "target")
					local utarget = UnitIsPlayer("target")
					if utarget == false and target < 3 then
						TargetFrameHealthBar:SetStatusBarColor(255/255, 0/255, 0/255)
					elseif ( utarget == false and target == 3 ) then
						TargetFrameHealthBar:SetStatusBarColor(242/255, 96/255, 0/255)
					elseif ( utarget == false and target == 4 ) then
						TargetFrameHealthBar:SetStatusBarColor(255/255, 255/255, 0/255)
					elseif ( utarget == false and target > 4 ) then
						TargetFrameHealthBar:SetStatusBarColor(51/255, 255/255, 51/255)
					else
						return nil
					end
				end
			end
		end
	end
end
frame:SetScript("OnEvent", eventHandler)
for _, BarTextures in pairs({ TargetFrameNameBackground, FocusFrameNameBackground, }) do
	BarTextures:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
end
--[[
-- Change HealthBarSize
local frame = CreateFrame("Frame", "$parentFrameHealthBarSize", nil)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
local function eventHandler(self, event, ...)
	if ( AbyssUILightAddonSettings.UnitFrameImproved ~= true ) then
		if GetWoWVersion <= 30600 then
			if not InCombatLockdown() then 
			  PlayerFrameHealthBar.lockColor = true
			  PlayerFrameHealthBar.capNumericDisplay = true
			  PlayerFrameHealthBar:SetWidth(119)
			  PlayerFrameHealthBar:SetHeight(29)
			  PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -22)
			  PlayerFrameHealthBarText:SetPoint("CENTER", 50, 6)
			end
		end
	end
end
frame:SetScript("OnEvent", eventHandler)
--]]
----------------------------------------------------
-- Keep the color when health changes
hooksecurefunc("HealthBar_OnValueChanged", function()
	if GetWoWVersion <= 30600 then
		if ( AbyssUILightAddonSettings.UnitFrameImproved ~= true ) then
			if ( UnitReaction("player", "target") ~= nil ) then
				local target = UnitReaction("player", "target")
				local utarget = UnitIsPlayer("target")
				if utarget == false and target < 3 then
					TargetFrameHealthBar:SetStatusBarColor(255/255, 0/255, 0/255)
				elseif ( utarget == false and target == 3 ) then
					TargetFrameHealthBar:SetStatusBarColor(242/255, 96/255, 0/255)
				elseif ( utarget == false and target == 4 ) then
					TargetFrameHealthBar:SetStatusBarColor(255/255, 255/255, 0/255)
				elseif ( utarget == false and target > 4 ) then
					TargetFrameHealthBar:SetStatusBarColor(51/255, 255/255, 51/255)
				else
					return nil
				end
			end
		end
	end
end)
-- Change Health Bar Fill
local f = CreateFrame("Frame", nil)
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "AbyssUILight" and GetWoWVersion <= 30600 and AbyssUILightAddonSettings ~= nil then
		local TEXTURE = "Interface\\AddOns\\AbyssUILight\\textures\\Raid-Bar-Hp-Fill"
		local UnitFrames = {
		  PlayerFrame,
		  PetFrame,
		  TargetFrame,
		  TargetFrameToT,
		  FocusFrame,
		  FocusFrameToT,
		  PartyMemberFrame1,
		  PartyMemberFrame2,
		  PartyMemberFrame3,
		  PartyMemberFrame4,
		}
		local UnitFrameRegions = {
		  "healthbar",
		  "myHealPredictionBar",
		  "otherHealPredictionBar",
		  "healAbsorbBar",
		  "totalAbsorbBar",
		  --"manabar",
		  --"myManaCostPredictionBar",
		  "spellbar",
		}
		local OtherStatusBars = {
		  CastingBarFrame,
		  MirrorTimer1StatusBar,
		  MirrorTimer2StatusBar,
		  MirrorTimer3StatusBar,
		}
		if (AbyssUILightAddonSettings.FlatHealth == true) then
			for _, frame in next, UnitFrames do
		    for _, region in next, UnitFrameRegions do
		      local bar = frame[region]
		      if bar and bar.SetStatusBarTexture then
		        bar:SetStatusBarTexture(TEXTURE)
		        bar:GetStatusBarTexture():SetHorizTile(true)
		      elseif bar and bar.SetTexture then
		        bar:SetTexture(TEXTURE)
		        bar:SetHorizTile(true)
		      end
		    end
			end
			for _, bar in next, OtherStatusBars do
		    bar:SetStatusBarTexture(TEXTURE)
		    bar:GetStatusBarTexture():SetHorizTile(true)
			end
		end
	end
end)
-- End
