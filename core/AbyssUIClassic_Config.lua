-- Author: Yugen
--
-- Classic
--
-- Hope you like my addOn ^^
--
-- Configuration page for AbyssUIClassic
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
    if not AbyssUI_Config then
    local AbyssUI_Config = {}
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
    globalFont  = mediaFolder.."zhCN-TW\\senty.ttf"
    subFont   = mediaFolder.."zhCN-TW\\senty.ttf"
    damageFont  = mediaFolder.."zhCN-TW\\senty.ttf"
    oldglobalFont = mediaFolder.."zhCN-TW\\senty.ttf"
  elseif ( locale == "zhTW" ) then
    globalFont  = mediaFolder.."zhCN-TW\\senty.ttf"
    subFont   = mediaFolder.."zhCN-TW\\senty.ttf"
    damageFont  = mediaFolder.."zhCN-TW\\senty.ttf"
    oldglobalFont = mediaFolder.."zhCN-TW\\senty.ttf"
  elseif ( locale == "ruRU" ) then
    globalFont  = mediaFolder.."ruRU\\dejavu.ttf"
    subFont   = mediaFolder.."ruRU\\dejavu.ttf"
    damageFont  = mediaFolder.."ruRU\\dejavu.ttf"
    oldglobalFont = mediaFolder.."ruRU\\dejavu.ttf"
  elseif ( locale == "koKR" ) then
    globalFont  = mediaFolder.."koKR\\dxlbab.ttf"
    subFont   = mediaFolder.."koKR\\dxlbab.ttf"
    damageFont  = mediaFolder.."koKR\\dxlbab.ttf"
    oldglobalFont = mediaFolder.."koKR\\dxlbab.ttf"
  elseif ( locale == "frFR" or locale == "deDE" or locale == "enGB" or locale == "enUS" or locale == "itIT" or
    locale == "esES" or locale == "esMX" or locale == "ptBR") then
    globalFont  = mediaFolder.."global.ttf"
    subFont   = mediaFolder.."damagefont_classic.ttf"
    damageFont  = mediaFolder.."damagefont_classic.ttf"
    oldglobalFont = mediaFolder .. "damagefont_classic.ttf"
  else
    globalFont  = fontName
    subFont   = fontName
    damageFont  = fontName
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
--------------------------------------------------------------
--------------------------------------------------------------
local _G = _G
local confirmString     = _G["OKAY"]
local colorString       = _G["COLOR_PICKER"]
local colorColorString  = _G["COLOR"]
local applyString       = _G["APPLY"]
--------------------------------------------------------------
local function InitSettings()
  AbyssUIClassic_Config.panel = CreateFrame( "Frame", "$parentAbyssUIClassic_Config", InterfaceOptionsFramePanelContainer)
  -- Register in the Interface Addon Options GUI
  -- Set the name for the Category for the Options Panel1
  AbyssUIClassic_Config.panel.name = "AbyssUI|cff0d75d4Classic|r"
  -- Add the panel to the Interface Options
  InterfaceOptions_AddCategory(AbyssUIClassic_Config.panel, addonName)
  --Child Panels
  AbyssUIClassic_Config.childpanel1 = CreateFrame( "Frame", "$parentConfigChild_ActionBar", AbyssUIClassic_Config.panel)
  AbyssUIClassic_Config.childpanel1.name = "ActionBar"
  AbyssUIClassic_Config.childpanel1.parent = AbyssUIClassic_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUIClassic_Config.childpanel1)
  --
  AbyssUIClassic_Config.childpanel2 = CreateFrame( "Frame", "$parentConfigChild_HideElements", AbyssUIClassic_Config.panel)
  AbyssUIClassic_Config.childpanel2.name = "Hide Elements"
  AbyssUIClassic_Config.childpanel2.parent = AbyssUIClassic_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUIClassic_Config.childpanel2)
  --
  AbyssUIClassic_Config.childpanel3 = CreateFrame( "Frame", "$parentConfigChild_Miscellaneous", AbyssUIClassic_Config.panel)
  AbyssUIClassic_Config.childpanel3.name = "Miscellaneous"
  AbyssUIClassic_Config.childpanel3.parent = AbyssUIClassic_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUIClassic_Config.childpanel3)
  --
  AbyssUIClassic_Config.childpanel4 = CreateFrame( "Frame", "$parentConfigChild_Themes", AbyssUIClassic_Config.panel)
  AbyssUIClassic_Config.childpanel4.name = "Themes"
  AbyssUIClassic_Config.childpanel4.parent = AbyssUIClassic_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUIClassic_Config.childpanel4)
  --
  AbyssUIClassic_Config.childpanel5 = CreateFrame( "Frame", "$parentConfigChild_Extras", AbyssUIClassic_Config.panel)
  AbyssUIClassic_Config.childpanel5.name = "Tweaks & Extra"
  AbyssUIClassic_Config.childpanel5.parent = AbyssUIClassic_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUIClassic_Config.childpanel5)
    --
  AbyssUIClassic_Config.childpanel7 = CreateFrame( "Frame", "$parentConfigChild_Extras", AbyssUIClassic_Config.panel)
  AbyssUIClassic_Config.childpanel7.name = "Icons"
  AbyssUIClassic_Config.childpanel7.parent = AbyssUIClassic_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUIClassic_Config.childpanel7)
  -- Title
  local Frame = CreateFrame("Frame","$parentFrameButtonTitle", AbyssUIClassic_Config.panel)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.panel, "TOP", 0, -20)
  Frame:SetHeight(24)
  Frame:SetWidth(70)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("AbyssUI|cff0d75d4Classic|r")
  -- SubTittle
  local Frame = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUIClassic_Config.panel)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.panel, "TOP", 0, -120)
  Frame:SetHeight(24)
  Frame:SetWidth(200)
  Frame:SetScale(1.1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Thanks for using Abyss|cff0d75d4UI|r.\nIf you enjoy this addon,"..
  " consider sharing with your friends\n or even making a donation."..
  " It helps a lot!\nThis is a minimalist UI that makes changes directly to the WoW frames,\n"..
  "using nearly the same amount of CPU/RAM as the Blizzard default UI.\n\n"..
  "Options that have a different text color are recommended.\nThose options are set by default if you choose recommended (modern) settings.\n\n"..
  "Options that have a different text color are based on your choice in the setup."..
  "\nThose options are set by default if you choose one of the recommended settings.\n"..
  "(|cff0d75d4Classic|r / |cfff2dc7fModern|r)\n\n"..
  "Check the options by clicking in the (+) button on the left.")
  --Special Thanks
  local Frame = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUIClassic_Config.panel)
  Frame:SetPoint("BOTTOMLEFT", AbyssUIClassic_Config.panel, "BOTTOMLEFT", 10, 70)
  Frame:SetHeight(24)
  Frame:SetWidth(200)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("LEFT")
  Frame:SetText("|cff0d75d4Special Thanks|r")
  local Frame1 = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUIClassic_Config.panel)
  Frame1:SetPoint("BOTTOMLEFT", AbyssUIClassic_Config.panel, "BOTTOMLEFT", 10, 50)
  Frame1:SetHeight(24)
  Frame1:SetWidth(200)
  Frame1:SetScale(1)
  Frame1 = Frame1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame1:SetPoint("LEFT")
  Frame1:SetText("|cfff2dc7fFizzlemizz|r for helping me with programming questions.")
  local Frame2 = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUIClassic_Config.panel)
  Frame2:SetPoint("BOTTOMLEFT", AbyssUIClassic_Config.panel, "BOTTOMLEFT", 10, 30)
  Frame2:SetHeight(24)
  Frame2:SetWidth(200)
  Frame2:SetScale(1)
  Frame2 = Frame2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame2:SetPoint("LEFT")
  Frame2:SetText("|cfff2dc7fFry|r for helping me with grammatical errors.")
  local Frame3 = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUIClassic_Config.panel)
  Frame3:SetPoint("BOTTOMLEFT", AbyssUIClassic_Config.panel, "BOTTOMLEFT", 10, 10)
  Frame3:SetHeight(24)
  Frame3:SetWidth(200)
  Frame3:SetScale(1)
  Frame3 = Frame3:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame3:SetPoint("LEFT")
  Frame3:SetText("|cfff2dc7fKawF|r for UnitFrame Improved, so I could create a really nice"..
  " UnitFrame for AbyssUI.")
  -- Panel 01 (ActionBar)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel01", AbyssUIClassic_Config.childpanel1)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel1, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("AbyssUI|cff0d75d4Classic|r Actionbar")
  -- Panel 02 (HideElements)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel02", AbyssUIClassic_Config.childpanel2)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel2, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Hide Elements")
  -- Panel 03 (Miscellaneous)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel03", AbyssUIClassic_Config.childpanel3)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel3, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Miscellaneous")
  -- Panel 03.01 (Miscellaneous)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel041", AbyssUIClassic_Config.childpanel3)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel3, "TOP", -290, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- General")
  -- Panel 03.01 (Miscellaneous)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel041", AbyssUIClassic_Config.childpanel3)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel3, "TOP", 100, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Frames")
  -- Panel 04 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel04", AbyssUIClassic_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel4, "TOP", -150, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Player Portrait")
  -- Panel 04.01 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel041", AbyssUIClassic_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel4, "TOP", -285, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Portrait Art")
  -- Panel 05 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel05", AbyssUIClassic_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel4, "TOP", 120, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Frame Colorization")
  -- Panel 05.01 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel051", AbyssUIClassic_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel4, "TOP", 110, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Preset Colors")
  -- Panel 05.02 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel052", AbyssUIClassic_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel4, "CENTER", 98, -40)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Choose a Color")
  -- Panel 06 (Extra)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel06", AbyssUIClassic_Config.childpanel5)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel5, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Extras")
  -- Panel 06.01 (Extra)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel061", AbyssUIClassic_Config.childpanel5)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel5, "TOP", -290, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- General")
  -- Panel 06.02 (Extra)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel062", AbyssUIClassic_Config.childpanel5)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel5, "TOP", 100, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Frames")
  -- Panel 07 (Icons)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel07", AbyssUIClassic_Config.childpanel7)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel7, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Icons")
  -- Panel 06.01 (Extra)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel071", AbyssUIClassic_Config.childpanel7)
  Frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel7, "TOP", -300, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Icons")
  --------------------------------- Buttons ---------------------------------
  local _G = _G
  local levelString       = _G["LEVEL"]
  local versionString     = _G["GAME_VERSION_LABEL"]
  local latestString      = _G["KBASE_RECENTLY_UPDATED"] 
  local timeStringLabel   = _G["TIME_LABEL"]
  ----------------------------------------------------
  -- AbyssUIClassic Setup --
  local FrameButton = CreateFrame("Button","$parentExtraSetupButton", AbyssUIClassic_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUIClassic_Config.panel, "TOP", -200, -250)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("AbyssUI Setup")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
    AbyssUIClassicSecondFrame:Show()
  end)
  -- Clear Action Bar --
  local FrameButton = CreateFrame("Button","$parentExtraClearActionButton", AbyssUIClassic_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER",  AbyssUIClassic_Config.panel, "TOP", 0, -250)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("Clear Action Bar")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
    AbyssUIClassic_ActionBarCleaner:Show()
  end)
  -- AbyssUIClassic DailyInfo --
  local FrameButton = CreateFrame("Button","$parentExtraDailyInfoButton", AbyssUIClassic_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUIClassic_Config.panel, "TOP", 200, -250)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("AbyssUI DailyInfo")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
  C_WowTokenPublic.UpdateMarketPrice()
    C_Timer.After(0.5, function()
      local AddonVersion = GetAddOnMetadata("AbyssUIClassic", "Version")
      print("|cfff2dc7f~ AbyssUIClassic Daily Info ~|r")
      if ( AbyssUIClassicAddonSettings.ExtraFunctionAmericanClock == true ) then
        print("|cfff2dc7f"..timeStringLabel.."|r " .. date("%H:%M |cffffcc00%m/%d/%y|r "))
      else
        print("|cfff2dc7f"..timeStringLabel.."|r " .. date("%H:%M |cffffcc00%d/%m/%y|r "))
      end
      --print("|cfff2dc7f"..honorString.." "..levelString..": |r|cffffcc00"..HonorLevel.."|r")
      --print("|cfff2dc7fLocation: |r" .. GetMinimapZoneText() .. "|cffffcc00, " .. GetZoneText() .. "|r")
      print("|cfff2dc7fWoW "..versionString..":w |r|cffffcc00" .. select(1, GetBuildInfo()) .. "|r")
      print("|cfff2dc7fAbyssUIClassic "..versionString..": |r|cffffcc00" .. AddonVersion .. "|r")
      --print("|cfff2dc7f"..latestString.." TexturePack: |r|cffffcc001.0.1.1 (26/09/20)|r")
    end)
  end)
  -- Reload --
  local FrameButton = CreateFrame("Button","$parentExtraReloadInterfaceButton", AbyssUIClassic_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUIClassic_Config.panel, "TOP", -200, -300)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("Reload UI")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
    ReloadUI()
  end)
  -- GitHub --
  local f = CreateFrame("Frame", nil)
  f:RegisterEvent("PLAYER_ENTERING_WORLD")
  f:SetScript("OnEvent", function() 
    local FrameButton = CreateFrame("Button","$parentExtraGitButton", AbyssUIClassic_Config.panel, "UIPanelButtonTemplate")
    FrameButton:SetHeight(30)
    FrameButton:SetWidth(140)
    FrameButton:SetPoint("CENTER", AbyssUIClassic_Config.panel, "TOP", 0, -300)
    FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
    --FrameButton.text:SetFont(globalFont, 14)
    FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
    FrameButton.text:SetText("Github")
      if (AbyssUIClassicAddonSettings.FontsValue == true and AbyssUIClassicAddonSettings.ExtraFunctionDisableFontWhiteText ~= true) then
        AbyssUIClassic_ApplyFonts(FrameButton.text)
      else
        FrameButton.text:SetFont(globalFont, 12)
        FrameButton.text:SetTextColor(248/255, 248/255, 248/255)
        FrameButton.text:SetShadowColor(0, 0, 0)
        FrameButton.text:SetShadowOffset(1, -1)
      end
    FrameButton:SetScript("OnClick", function()
        AbyssUIClassic_EditBox:SetText("https://github.com/YugenMori/AbyssUIClassic")
        AbyssUIClassic_EditBox_Frame:Show()
    end)
  end)
  -- Ko-fi --
  local f = CreateFrame("Frame", nil)
  f:RegisterEvent("PLAYER_ENTERING_WORLD")
  f:SetScript("OnEvent", function() 
    local FrameButton = CreateFrame("Button","$parentExtraKofiButton", AbyssUIClassic_Config.panel, "UIPanelButtonTemplate")
    FrameButton:SetHeight(30)
    FrameButton:SetWidth(140)
    FrameButton:SetPoint("CENTER", AbyssUIClassic_Config.panel, "TOP", 200, -300)
    FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
    --FrameButton.text:SetFont(globalFont, 14)
    FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
    FrameButton.text:SetText("Ko-fi")
    if (AbyssUIClassicAddonSettings.FontsValue == true and AbyssUIClassicAddonSettings.ExtraFunctionDisableFontWhiteText ~= true) then
      AbyssUIClassic_ApplyFonts(FrameButton.text)
    else
      FrameButton.text:SetFont(globalFont, 12)
      FrameButton.text:SetTextColor(248/255, 248/255, 248/255)
      FrameButton.text:SetShadowColor(0, 0, 0)
      FrameButton.text:SetShadowOffset(1, -1)
    end
    FrameButton:SetScript("OnClick", function()
      AbyssUIClassic_EditBox:SetText("https://ko-fi.com/yugensan")
      AbyssUIClassic_EditBox_Frame:Show()
    end)
  end)
  -- Check InfoPanel AddOns
  -- Texture Trigger Function
  local function AbyssUIClassic_CheckTexturePack()
    local f  = CreateFrame('frame') -- Texture are created only when needed, should not be done like this without the function that control this
    local tx = f:CreateTexture()
    local c  = CastingBarFrame
    local c1 = MirrorTimer1StatusBar
    local c2 = MirrorTimer2StatusBar
    local c3 = MirrorTimer3StatusBar
    tx:SetPoint('TOPLEFT', nil, -500, -500) -- The texture has to be "visible", but not necessarily on-screen (you can also set its alpha to 0)
    tx:SetTexture('Interface\\TargetingFrame\\UI-CLASSES-CIRCLES_RETRO')
    tx:SetSize(0,0) -- Size must be set after every SetTexture
    tx:SetAlpha(0)
    f:SetAllPoints(tx)
    f:SetScript('OnSizeChanged', function(self, width, height)
        local size = format('%.0f%.0f', width, height) -- The floating point numbers need to be rounded or checked like "width < 8.1 and width > 7.9"
        if size == '11' then
          for i, v in pairs({ c, c1, c2, c3 }) do
            AbyssUIClassic_FrameSize(v, 200, 10)
            AbyssUIClassic_RegionListSize(v, 200, 10)
          end
          c.Icon:SetWidth(22)
          c.Icon:SetHeight(22)
          c.Icon:ClearAllPoints()
          c.Icon:SetPoint("LEFT", c, "LEFT", -25, 1)
        else
          return nil
        end
    end)
  end
  -- CheckFunction
  local Check = CreateFrame("Frame")
  Check:RegisterEvent("PLAYER_ENTERING_WORLD")
  Check:SetScript("OnEvent", function(self, event, arg1)
  AbyssUIClassic_CheckTexturePack()
  end)
  ----------------------------- AbyssUIClassic Actionbar -------------------------------
  -- AbyssUIClassic Action Bar --
  local AbyssUIClassicNewActionBar3x12_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicNewActionBar3x12_CheckButton", AbyssUIClassic_Config.childpanel1, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicNewActionBar3x12_CheckButton:SetPoint("TOPLEFT", 10, -140)
  AbyssUIClassicNewActionBar3x12_CheckButton.Text:SetText("3x12 Actionbar")
  AbyssUIClassicNewActionBar3x12_CheckButton.tooltip = "Adds a new bar above the Blizzard MainActionBar"
  AbyssUIClassicNewActionBar3x12_CheckButton:SetChecked(AbyssUIClassicAddonSettings.AbyssUIClassicNewActionBar3x12)
  -- OnClick Function
  AbyssUIClassicNewActionBar3x12_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.AbyssUIClassicNewActionBar3x12 = self:GetChecked()
    AbyssUIClassic_ActionBarInfo:Show()
  end)
  -- After Login/Reload
  AbyssUIClassicNewActionBar3x12_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUIClassicNewActionBar3x12_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( AbyssUIClassicAddonSettings.AbyssUIClassicNewActionBar3x12 == true ) then
      -- MainMenuBar
      MainMenuBar.ClearAllPoints = function() end
      MainMenuBar:SetPoint("BOTTOM", UIParent, "BOTTOM", 250, 10)
      MainMenuBar.SetPoint = function() end
      --MultiBarBottomRight
      MultiBarBottomRight.ClearAllPoints = function() end
      MultiBarBottomRight:SetPoint("TOPRIGHT", MainMenuBar, "BOTTOMLEFT", 9, 125)
      MultiBarBottomRight.SetPoint = function() end
      --MultiBarBottomLeft
      MultiBarBottomLeft.ClearAllPoints = function() end
      MultiBarBottomLeft:SetPoint("TOPRIGHT", MainMenuBar, "BOTTOMLEFT", 9, 45)
      MultiBarBottomLeft.SetPoint = function() end
      --PetBar
      PetActionBarFrame.ClearAllPoints = function() end
      PetActionBarFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", 0, 45)
      PetActionBarFrame:SetScale(0.85)
      PetActionBarFrame.SetPoint = function() end
      --StanceBar
      StanceBarFrame:ClearAllPoints()
      StanceBarFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 100, 0)
      StanceBarFrame.SetPoint = function() end
      --ExtraBar
      --ExtraActionBarFrame.ClearAllPoints = function() end
      --ExtraActionBarFrame:SetPoint("BOTTOMRIGHT", MainMenuBar, "BOTTOMRIGHT", 70, 30)
      --ExtraActionBarFrame.SetPoint = function() end
      --VehicleBar
      MainMenuBarVehicleLeaveButton.ClearAllPoints = function() end
      MainMenuBarVehicleLeaveButton:SetPoint("TOPLEFT", MainMenuBar, "TOPLEFT", -70, 70)
      MainMenuBarVehicleLeaveButton.SetPoint = function() end
      -- Hide Stuff for classic
      if AbyssUIClassicAddonSettings.AbyssUIClassicNewActionBar3x12 == true then
          C_Timer.After(1, function()
            for i, v in pairs ({
              MainMenuBarLeftEndCap,
              MainMenuBarRightEndCap,
              MainMenuBarTexture0,
              MainMenuBarTexture1,
              MainMenuBarTexture2,
              MainMenuBarTexture3,
              ActionBarUpButton,
              ActionBarDownButton,
              MainMenuBarPageNumber,
              CharacterMicroButton,
              SpellbookMicroButton,
              QuestLogMicroButton,
              SocialsMicroButton,
              WorldMapMicroButton,
              MainMenuMicroButton,
              HelpMicroButton,
              MainMenuBarBackpackButton,
              CharacterBag0Slot,
              CharacterBag1Slot,
              CharacterBag2Slot,
              CharacterBag3Slot,
              MainMenuBarPerformanceBar,
            }) do
              MainMenuExpBar:SetAlpha(0)
              ReputationWatchBar:SetAlpha(0)
              TalentMicroButton:SetAlpha(0)
              v:Hide()
            end
          end)
        else
          MainMenuExpBar:SetAlpha(1)
          ReputationWatchBar:SetAlpha(1)
          TalentMicroButton:SetAlpha(1)
        end
    end
  end)
end
-- End
------------------------------- Hide Elements ---------------------------------
local function HideElementsInit()
  local PSINFOHide_CheckButton = CreateFrame("Frame","$parentPSINFOHide_CheckButton", AbyssUIClassic_Config.childpanel2)
  PSINFOHide_CheckButton:SetPoint("BOTTOMLEFT", AbyssUIClassic_Config.childpanel2, "BOTTOMLEFT", 10, 10)
  PSINFOHide_CheckButton:SetHeight(24)
  PSINFOHide_CheckButton:SetWidth(200)
  PSINFOHide_CheckButton:SetScale(1)
  PSINFOHide_CheckButton = PSINFOHide_CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  PSINFOHide_CheckButton:SetPoint("LEFT")
  PSINFOHide_CheckButton:SetText("The symbol (*) in some options means that there is important information/instructions to be read.\n"..
    "Options with a different color are recommended settings (based on your choice in the setup).")
  -- MicroMenu/Bags --
  local MicroMenu_CheckButton = CreateFrame("CheckButton", "$parentMicroMenu_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  MicroMenu_CheckButton:SetPoint("TOPLEFT", 10, -80)
  MicroMenu_CheckButton.Text:SetText("Hide MicroMenu")
  MicroMenu_CheckButton.tooltip = "Hide the ActionBar MicroMenu"
  MicroMenu_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideMicroMenu)
  --  Hide
  local function AbyssUIClassic_HideMicroMenu_Function()
    for i, v in pairs({ 
        CharacterMicroButton,
        SpellbookMicroButton,
        QuestLogMicroButton,
        SocialsMicroButton,
        WorldMapMicroButton,
        MainMenuMicroButton,
        HelpMicroButton, }) do
        TalentMicroButton:SetAlpha(0)
        v:Hide()
    end
  end
  -- Show
  local function AbyssUIClassic_ShowMicroMenu_Function()
      for i, v in pairs({ 
        CharacterMicroButton,
        SpellbookMicroButton,
        QuestLogMicroButton,
        SocialsMicroButton,
        WorldMapMicroButton,
        MainMenuMicroButton,
        HelpMicroButton, }) do
        TalentMicroButton:SetAlpha(1)
        v:Show()
    end
  end
  -- OnClick Function
  MicroMenu_CheckButton:SetScript("OnClick", function(self)
  AbyssUIClassicAddonSettings.HideMicroMenu = self:GetChecked()
    if AbyssUIClassicAddonSettings.HideMicroMenu == true then
      AbyssUIClassic_HideMicroMenu_Function()
    else
      AbyssUIClassic_ShowMicroMenu_Function()
    end
  end)
  -- After Login/Reload
  MicroMenu_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  MicroMenu_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideMicroMenu == true then
        AbyssUIClassic_HideMicroMenu_Function()
      else
        AbyssUIClassic_ShowMicroMenu_Function()
      end
    end
  end)
  -- Gryphons Option --
  local Gryphons_CheckButton = CreateFrame("CheckButton", "$parentGryphons_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  Gryphons_CheckButton:SetPoint("TOPLEFT", 10, -110)
  Gryphons_CheckButton.Text:SetText("Hide Gryphons")
  Gryphons_CheckButton.tooltip = "Hide the ActionBar Gryphons"
  Gryphons_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideGryphons)
  -- OnClick Function
  Gryphons_CheckButton:SetScript("OnClick", function(self)
  AbyssUIClassicAddonSettings.HideGryphons = self:GetChecked()
    if AbyssUIClassicAddonSettings.HideGryphons == true then
      MainMenuBarRightEndCap:Hide()
      MainMenuBarLeftEndCap:Hide()
    else
      MainMenuBarRightEndCap:Show()
      MainMenuBarLeftEndCap:Show()
    end
  end)
  -- After Login/Reload
  Gryphons_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  Gryphons_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideGryphons == true then
        MainMenuBarRightEndCap:Hide()
        MainMenuBarLeftEndCap:Hide()
      else
        MainMenuBarRightEndCap:Show()
        MainMenuBarLeftEndCap:Show()
      end
    end
  end)
  -- Minimap
  local Minimap_CheckButton = CreateFrame("CheckButton", "$parentMinimap_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  Minimap_CheckButton:SetPoint("TOPLEFT", 10, -140)
  Minimap_CheckButton.Text:SetText("Hide Minimap")
  Minimap_CheckButton.tooltip = "Hide the Game Minimap"
  Minimap_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideMinimap)
  -- OnClick Function
  Minimap_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideMinimap = self:GetChecked()
    if AbyssUIClassicAddonSettings.HideMinimap == true then
      MinimapCluster:Hide()
    else
      MinimapCluster:Show()
    end
  end)
  -- After Login/Reload
  Minimap_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  Minimap_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideMinimap == true then
        MinimapCluster:Hide()
      else
        MinimapCluster:Show()
      end
    end
  end)
  -- Objective Tracker --
  local ObjTracker_CheckButton = CreateFrame("CheckButton", "$parentObjTracker_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  ObjTracker_CheckButton:SetPoint("TOPLEFT", 10, -170)
  ObjTracker_CheckButton.Text:SetText("Hide Objective Tracker")
  ObjTracker_CheckButton.tooltip = "Hide the Objective Tracker (Quest Frame)"
  ObjTracker_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideObjectiveTracker)
  -- OnClick Function
  ObjTracker_CheckButton:SetScript("OnClick", function(self)
    if (GetWoWVersion <= 30000) then
      AbyssUIClassicAddonSettings.HideObjectiveTracker = self:GetChecked()
      if AbyssUIClassicAddonSettings.HideObjectiveTracker == true then
        QuestWatchFrame:Hide()
      else
        QuestWatchFrame:Show()
      end
    end
  end)
  -- After Login/Reload
  ObjTracker_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  ObjTracker_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" and GetWoWVersion <= 30000) then
      if AbyssUIClassicAddonSettings.HideObjectiveTracker == true then
        QuestWatchFrame:Hide()
      else
        QuestWatchFrame:Show()
      end
    end
  end)
  -- Hide FPS/MS Frame --
  local FPSMSFrame_CheckButton = CreateFrame("CheckButton", "$parentFPSMSFrame_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  FPSMSFrame_CheckButton:SetPoint("TOPLEFT", 10, -200)
  FPSMSFrame_CheckButton.Text:SetText("|cff0d75d4Hide FPS/MS Frame (*)|r")
  FPSMSFrame_CheckButton.tooltip = "Hide the fps/ms frame (Top left frame)."
  .." *This will only work if you are using the default Blizzard Minimap"
  FPSMSFrame_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideFPSMSFrame)
  addonTable.FPSMSFrame = FPSMSFrame_CheckButton
  -- OnClick Function
  FPSMSFrame_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideFPSMSFrame = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- YouDied LevelUp Frame --
  local YouDiedLevelUpFrame_CheckButton = CreateFrame("CheckButton", "$parentYouDiedLevelUpFrame_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  YouDiedLevelUpFrame_CheckButton:SetPoint("TOPLEFT", 10, -230)
  YouDiedLevelUpFrame_CheckButton.Text:SetText("|cff0d75d4Hide YouDied/LevelUp Frame|r")
  YouDiedLevelUpFrame_CheckButton.tooltip = "Hide the 'You Died' and 'Level Up' frame when you"..
  " die/level in the game"
  YouDiedLevelUpFrame_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideYouDiedLevelUpFrame)
  addonTable.YouDiedLevelUpFrame = YouDiedLevelUpFrame_CheckButton
  -- OnClick Function
  YouDiedLevelUpFrame_CheckButton:SetScript("OnClick", function(self)
  AbyssUIClassicAddonSettings.HideYouDiedLevelUpFrame = self:GetChecked()
  end)
  -- Hide Macro Labels --
  local HideMacroLabels_CheckButton = CreateFrame("CheckButton", "$parentHideMacroLabels_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideMacroLabels_CheckButton:SetPoint("TOPLEFT", 10, -260)
  HideMacroLabels_CheckButton.Text:SetText("Hide Macro Labels")
  HideMacroLabels_CheckButton.tooltip = "Hide Macro Labels from Action Bar"
  HideMacroLabels_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideMacroLabels)
  -- OnClick Function
  HideMacroLabels_CheckButton:SetScript("OnClick", function(self)
  AbyssUIClassicAddonSettings.HideMacroLabels = self:GetChecked()
    if ( AbyssUIClassicAddonSettings.HideMacroLabels == true ) then
      for i = 1, 12 do
        _G["ActionButton"..i.."Name"]:SetAlpha(0)
        _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0)
        _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0)
        _G["MultiBarRightButton"..i.."Name"]:SetAlpha(0)
        --_G["MultibarLeftButton"..i.."Name"]:SetAlpha(0)
      end
    else
      for i = 1, 12 do
        _G["ActionButton"..i.."Name"]:SetAlpha(1)
        _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(1)
        _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(1)
        _G["MultiBarRightButton"..i.."Name"]:SetAlpha(1)
      --_G["MultibarLeftButton"..i.."Name"]:SetAlpha(1)
      end
    end
  end)
  -- After Login/Reload
  HideMacroLabels_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideMacroLabels_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideMacroLabels == true then
        for i = 1, 12 do
          _G["ActionButton"..i.."Name"]:SetAlpha(0)
          _G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0)
          _G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0)
          _G["MultiBarRightButton"..i.."Name"]:SetAlpha(0)
          --_G["MultibarLeftButton"..i.."Name"]:SetAlpha(0)
        end
      end
    end
  end)
  -- Hide Hotkeys --
  local HideHotkeysLabels_CheckButton = CreateFrame("CheckButton", "$parentHideHotkeysLabels_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideHotkeysLabels_CheckButton:SetPoint("TOPLEFT", 10, -290)
  HideHotkeysLabels_CheckButton.Text:SetText("Hide Hotkeys Labels")
  HideHotkeysLabels_CheckButton.tooltip = "Hide Hotkeys Labels from Action Bar"
  HideHotkeysLabels_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideHotkeysLabels)
  -- OnClick Function
  HideHotkeysLabels_CheckButton:SetScript("OnClick", function(self)
  AbyssUIClassicAddonSettings.HideHotkeysLabels = self:GetChecked()
     if ( AbyssUIClassicAddonSettings.HideHotkeysLabels == true ) then
       for i = 1, 12 do
         _G["ActionButton"..i.."HotKey"]:SetAlpha(0)
         _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0)
         _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0)
         _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0)
         --_G["MultibarLeftButton"..i.."HotKey"]:SetAlpha(0)
       end
     else
       for i = 1, 12 do
         _G["ActionButton"..i.."HotKey"]:SetAlpha(1)
         _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(1)
         _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(1)
         _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(1)
       --_G["MultibarLeftButton"..i.."HotKey"]:SetAlpha(1)
       end
     end
  end)
  -- After Login/Reload
  HideHotkeysLabels_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideHotkeysLabels_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideHotkeysLabels == true then
        for i = 1, 12 do
          _G["ActionButton"..i.."HotKey"]:SetAlpha(0)
          _G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0)
          _G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0)
          _G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0)
          --_G["MultibarLeftButton"..i.."HotKey"]:SetAlpha(0)
        end
      end
    end
  end)
  -- Hide StanceBar
  local HideStanceBar_CheckButton = CreateFrame("CheckButton", "$parentHideStanceBar_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideStanceBar_CheckButton:SetPoint("TOPLEFT", 10, -320)
  HideStanceBar_CheckButton.Text:SetText("Hide Stance Bar")
  HideStanceBar_CheckButton.tooltip = "Hide the Stance Bar (Druid forms, Rogue stealth, etc)"
  HideStanceBar_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideStanceBar)
  -- OnClick Function
  HideStanceBar_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideStanceBar = self:GetChecked()
     if ( AbyssUIClassicAddonSettings.HideStanceBar == true ) then
       StanceBarFrame:Hide()
     else
       return nil
     end
  end)
  -- After Login/Reload
  HideStanceBar_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideStanceBar_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideStanceBar == true then
        C_Timer.After(0.5, function()
          StanceBarFrame:SetScript("OnUpdate", function(self) self:Hide() end)
        end)
      end
    end
  end)
  -- Chat Hide Frame (needs to be here so the hide chat buttons works on this too)
  -- Thanks to Syncrow for part of this 
  local AbyssUIClassic_ChatHideFrame = CreateFrame("Button", "$parentChatHideFrame", UIParent)
  AbyssUIClassic_ChatHideFrame:SetSize(30, 30)
  AbyssUIClassic_ChatHideFrame.t = AbyssUIClassic_ChatHideFrame:CreateTexture(nil, "BORDER")
  AbyssUIClassic_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
  AbyssUIClassic_ChatHideFrame.t:SetAllPoints(AbyssUIClassic_ChatHideFrame)
  AbyssUIClassic_ChatHideFrame:SetPoint("BOTTOM","ChatFrame1ButtonFrame","BOTTOM",0,-35)
  if ( AbyssUIClassicAddonSettings.FadeUI ~= true ) then
    AbyssUIClassic_ChatHideFrame:Show()
  else
    AbyssUIClassic_ChatHideFrame:Hide()
  end

  local ChatHide = false
  AbyssUIClassic_ChatHideFrame:SetScript("OnMouseDown", function(self, Button)
    if ChatHide == false then
      if Button == "LeftButton" then
        AbyssUIClassic_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Down.blp")
      end
    elseif ChatHide == true then
      if Button == "LeftButton" then
        AbyssUIClassic_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Down.blp")
      end
    end
  end)

  AbyssUIClassic_ChatHideFrame:SetScript("OnMouseUp", function(self, Button)
    if ChatHide == false then
      if Button == "LeftButton" then
        AbyssUIClassic_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
      end
    elseif ChatHide == true then
      if Button == "LeftButton" then
        AbyssUIClassic_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
      end
    end
  end)

  AbyssUIClassic_ChatHideFrame:SetScript("OnClick", function(self, Button)
    if ChatHide == false then
      AbyssUIClassic_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
      --QuickJoinToastButton:Hide()
      GeneralDockManager:Hide()
      ChatFrameMenuButton:Hide()
      ChatFrameChannelButton:Hide()
      --ChatFrameToggleVoiceDeafenButton.Icon:Hide()
      --ChatFrameToggleVoiceMuteButton.Icon:Hide()
      ChatFrame1EditBox:Hide()

      for i = 1, NUM_CHAT_WINDOWS do
        _G["ChatFrame"..i..""]:SetAlpha(0)
        _G["ChatFrame"..i.."ButtonFrame"]:Hide()
        _G["ChatFrame"..i.."EditBox"]:SetAlpha(0)
      end
      ChatHide = true
    elseif ChatHide == true then
      AbyssUIClassic_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
      --QuickJoinToastButton:Show()
      GeneralDockManager:Show()
      ChatFrameMenuButton:Show()
      ChatFrameChannelButton:Show()
      --ChatFrameToggleVoiceDeafenButton.Icon:Show()
      --ChatFrameToggleVoiceMuteButton.Icon:Show()
      ChatFrame1EditBox:Show()

      for i = 1 , NUM_CHAT_WINDOWS do
        _G["ChatFrame"..i..""]:SetAlpha(1)
        _G["ChatFrame"..i.."ButtonFrame"]:Show()
        _G["ChatFrame"..i.."EditBox"]:SetAlpha(1)
      end
      ChatHide = false
    end
  end)
  -- Hide Chat Buttons
  local HideChatButtons_CheckButton = CreateFrame("CheckButton", "$parentHideStanceBar_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideChatButtons_CheckButton:SetPoint("TOPLEFT", 10, -350)
  HideChatButtons_CheckButton.Text:SetText("Hide Chat Buttons")
  HideChatButtons_CheckButton.tooltip = "Hide the Chat buttons (voice, social, etc)"
  HideChatButtons_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideChatButtons)
  -- OnClick Function
  HideChatButtons_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideChatButtons = self:GetChecked()
    if ( AbyssUIClassicAddonSettings.HideChatButtons == true ) then
      --QuickJoinToastButton:Hide()
      GeneralDockManager:SetAlpha(0)
      ChatFrameMenuButton:Hide()
      ChatFrameChannelButton:Hide()
      ChatFrame1ButtonFrame:SetAlpha(0)
      AbyssUIClassic_ChatHideFrame:Hide()
      --ChatFrameToggleVoiceDeafenButton:SetAlpha(0)
      --ChatFrameToggleVoiceMuteButton:SetAlpha(0)
    else 
      --QuickJoinToastButton:Show()
      GeneralDockManager:SetAlpha(1)
      ChatFrameMenuButton:Show()
      ChatFrameChannelButton:Show()
      ChatFrame1ButtonFrame:SetAlpha(1)
      AbyssUIClassic_ChatHideFrame:Show()
      --ChatFrameToggleVoiceDeafenButton:SetAlpha(1)
      --ChatFrameToggleVoiceMuteButton:SetAlpha(1)
    end
  end)
  -- After Login/Reload
  HideChatButtons_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideChatButtons_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideChatButtons == true then
        C_Timer.After(1, function()
          -- QuickJoinToastButton:Hide()
          GeneralDockManager:SetAlpha(0)
          ChatFrameMenuButton:Hide()
          ChatFrameChannelButton:Hide()
          ChatFrame1ButtonFrame:SetAlpha(0)
          AbyssUIClassic_ChatHideFrame:Hide()
          --ChatFrameToggleVoiceDeafenButton:SetAlpha(0)
          --ChatFrameToggleVoiceMuteButton:SetAlpha(0)
        end)
      end
    end
  end)
  -- AFKCammeraFrame --
  local AFKCammeraFrame_CheckButton = CreateFrame("CheckButton", "$parentAFKCammeraFrame_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  AFKCammeraFrame_CheckButton:SetPoint("TOPLEFT", 10, -380)
  AFKCammeraFrame_CheckButton.Text:SetText("Hide AFKMode Frame")
  AFKCammeraFrame_CheckButton.tooltip = "Hide the AFKMode when you are AFK"
  AFKCammeraFrame_CheckButton:SetChecked(AbyssUIClassicAddonSettings.AFKCammeraFrame)
  -- OnClick Function
  AFKCammeraFrame_CheckButton:SetScript("OnClick", function(self)
  AbyssUIClassicAddonSettings.AFKCammeraFrame = self:GetChecked()
  end)
  -- Faction/PvP icon --
  local FactionPvpIcon_CheckButton = CreateFrame("CheckButton", "$parentFactionPvpIcon_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  FactionPvpIcon_CheckButton:SetPoint("TOPLEFT", 10, -410)
  FactionPvpIcon_CheckButton.Text:SetText("Hide Faction/PvP Icon")
  FactionPvpIcon_CheckButton.tooltip = "Hide the player frame faction/PvP icon"
  FactionPvpIcon_CheckButton:SetChecked(AbyssUIClassicAddonSettings.FactionPvpIcon)
  -- OnClick Function
  FactionPvpIcon_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.FactionPvpIcon = self:GetChecked()
    if ( AbyssUIClassicAddonSettings.FactionPvpIcon == true ) then
      for i, v in pairs ({
      PlayerPVPIcon,
      TargetFrameTextureFramePVPIcon, }) do
        --v:Hide()
        v:SetAlpha(0)
      end
    else
      for i, v in pairs ({            
      PlayerPVPIcon,
      TargetFrameTextureFramePVPIcon, }) do
        --v:Show()
        v:SetAlpha(1)
      end
    end
  end)
  -- After Login/Reload
  FactionPvpIcon_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  FactionPvpIcon_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUIClassicAddonSettings.FactionPvpIcon == true ) then
        for i, v in pairs ({
        PlayerPVPIcon,
        TargetFrameTextureFramePVPIcon, }) do
          --v:Hide()
          v:SetAlpha(0)
        end
      else
        for i, v in pairs ({            
        PlayerPVPIcon,
        TargetFrameTextureFramePVPIcon, }) do
          --v:Show()
          v:SetAlpha(1)
        end
      end
    end
  end)
  -- Hide Helm --
  local HideHelm_CheckButton = CreateFrame("CheckButton", "$parentHideHelm_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideHelm_CheckButton:SetPoint("TOPLEFT", 10, -440)
  HideHelm_CheckButton.Text:SetText("Hide Helm")
  HideHelm_CheckButton.tooltip = "Hide the player helm"
  HideHelm_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideHelm)
  -- OnClick Function
  HideHelm_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideHelm = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- After Login/Reload
  HideHelm_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideHelm_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideHelm == true then
        ShowHelm(false)
      else
        ShowHelm(true)
      end
    end
  end)
  -- Hide Cloak --
  local HideCloak_CheckButton = CreateFrame("CheckButton", "$parentHideCloak_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideCloak_CheckButton:SetPoint("TOPLEFT", 10, -470)
  HideCloak_CheckButton.Text:SetText("Hide Cloak")
  HideCloak_CheckButton.tooltip = "Hide the player cloak"
  HideCloak_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideCloak)
  -- OnClick Function
  HideCloak_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideCloak = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- After Login/Reload
  HideCloak_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideCloak_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.HideCloak == true then
        ShowCloak(false)
      else
        ShowCloak(true)
      end
    end
  end)
  -- 2nd Collum
  -- Hide Cast Timer
  local HideCastTimer_CheckButton = CreateFrame("CheckButton", "$parentHideCastTimer_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideCastTimer_CheckButton:SetPoint("TOPRIGHT", -200, -80)
  HideCastTimer_CheckButton.Text:SetText("|cff0d75d4Hide CastBar Timer|r")
  HideCastTimer_CheckButton.tooltip = "Hide the timer below CastBar"
  HideCastTimer_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideCastTimer)
  addonTable.HideCastTimer = HideCastTimer_CheckButton
  -- OnClick Function
  HideCastTimer_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideCastTimer = self:GetChecked()
  end)
  -- Hide Group Frame
  local HideGroupFrame_CheckButton = CreateFrame("CheckButton", "$parentHideGroupFrame_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideGroupFrame_CheckButton:SetPoint("TOPRIGHT", -200, -110)
  HideGroupFrame_CheckButton.Text:SetText("|cfff2dc7fHide GroupFrame|r")
  HideGroupFrame_CheckButton.tooltip = "Hide the GroupFrame on the player portrait"
  HideGroupFrame_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideGroupFrame)
  addonTable.HideGroupFrame = HideGroupFrame_CheckButton
  -- OnClick Function
  HideGroupFrame_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideGroupFrame = self:GetChecked()
      if ( AbyssUIClassicAddonSettings.HideGroupFrame == true ) then
        PlayerFrameGroupIndicator:SetAlpha(0)
      else
        PlayerFrameGroupIndicator:SetAlpha(1)
      end
  end)
  -- After Login/Reload
  HideGroupFrame_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideGroupFrame_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUIClassicAddonSettings.HideGroupFrame == true ) then
        PlayerFrameGroupIndicator:SetAlpha(0)
      else
        PlayerFrameGroupIndicator:SetAlpha(1)
      end
    end
  end)
  -- Hide UnitImproved Faction Icons
  local HideUnitImprovedFaction_CheckButton = CreateFrame("CheckButton", "$parentHideUnitImprovedFaction_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideUnitImprovedFaction_CheckButton:SetPoint("TOPRIGHT", -200, -140)
  HideUnitImprovedFaction_CheckButton.Text:SetText("|cfff2dc7fHide UnitImproved Faction Icon|r")
  HideUnitImprovedFaction_CheckButton.tooltip = "Hide the Faction Icon (Ally/Horde) on players frames"
  HideUnitImprovedFaction_CheckButton:SetChecked(AbyssUIClassicAddonSettings.HideUnitImprovedFaction)
  addonTable.HideUnitImprovedFaction = HideUnitImprovedFaction_CheckButton
  -- OnClick Function
  HideUnitImprovedFaction_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.HideUnitImprovedFaction = self:GetChecked()
  end)
  -- Disable Tooltip Healthbar --
  local DisableTooltipHealth_CheckButton = CreateFrame("CheckButton", "$parentDisableTooltipHealth_CheckButton", AbyssUIClassic_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  DisableTooltipHealth_CheckButton:SetPoint("TOPRIGHT", -200, -170)
  DisableTooltipHealth_CheckButton.Text:SetText(L["|cff0d75d4Disable Tooltip Health|r"])
  local Frame = CreateFrame("Frame", nil, DisableTooltipHealth_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  DisableTooltipHealth_CheckButton.Text:SetAllPoints(Frame)
  DisableTooltipHealth_CheckButton.tooltip = L["Disable the tooltip healthBar from mouse hover functions"]
  DisableTooltipHealth_CheckButton:SetChecked(AbyssUIClassicAddonSettings.DisableTooltipHealth)
  addonTable.DisableTooltipHealth = DisableTooltipHealth_CheckButton
  -- OnClick Function
  DisableTooltipHealth_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.DisableTooltipHealth = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
end
-- End
local function Miscellaneous()
  ------------------------------- Miscellaneous -------------------------------
  local PSINFOHide_CheckButton = CreateFrame("Frame","$parentPSINFOHide_CheckButton", AbyssUIClassic_Config.childpanel3)
  PSINFOHide_CheckButton:SetPoint("BOTTOMLEFT", AbyssUIClassic_Config.childpanel3, "BOTTOMLEFT", 10, 10)
  PSINFOHide_CheckButton:SetHeight(24)
  PSINFOHide_CheckButton:SetWidth(200)
  PSINFOHide_CheckButton:SetScale(1)
  PSINFOHide_CheckButton = PSINFOHide_CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  PSINFOHide_CheckButton:SetPoint("LEFT")
  PSINFOHide_CheckButton:SetText("The symbol (*) in some options means that there is important information/instructions to be read.\n"..
    "Options with a different color are recommended settings (based on your choice in the setup).")
  -- Camera Pitch --
  -- Camera Pitch Function Option 50%
  local CameraSmooth50_CheckButton = CreateFrame("CheckButton", "$parentCameraSmooth50_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  CameraSmooth50_CheckButton:SetPoint("TOPLEFT", 10, -80)
  CameraSmooth50_CheckButton.Text:SetText("Smooth Camera\n   (50% Slower)")
  CameraSmooth50_CheckButton.tooltip = "Makes the Camera turns in a more smooth way"
  CameraSmooth50_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50)
  addonTable.CameraSmooth50 = CameraSmooth50_CheckButton
  -- OnClick Function
  CameraSmooth50_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth70 ~= true and AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
      AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 = self:GetChecked()
      if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 == true then
        ConsoleExec( "cameraYawMoveSpeed 50" )
        ConsoleExec( "cameraPitchMoveSpeed 50" )
      else
        ConsoleExec( "cameraYawMoveSpeed 100" )
        ConsoleExec( "cameraPitchMoveSpeed 100" )
        if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
          AbyssUIClassic_ReloadFrame:Show()
        end
      end
    else
      CameraSmooth50_CheckButton:SetChecked(nil)
    end
  end)
  -- After Login/Reload
  CameraSmooth50_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  CameraSmooth50_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 == true then
        ConsoleExec( "cameraYawMoveSpeed 50" )
        ConsoleExec( "cameraPitchMoveSpeed 50" )
      end
    end
  end)
  -- Camera Pitch Function Option 70%
  local CameraSmooth70_CheckButton = CreateFrame("CheckButton", "$parentCameraSmooth70_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  CameraSmooth70_CheckButton:SetPoint("TOPLEFT", 10, -110)
  CameraSmooth70_CheckButton.Text:SetText("Smooth Camera\n   (70% Slower)")
  CameraSmooth70_CheckButton.tooltip = "Makes the Camera turns in a more smooth way"
  CameraSmooth70_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth70)
  -- OnClick Function
  CameraSmooth70_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
      AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth70 = self:GetChecked()
      if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth70 == true then
        ConsoleExec( "cameraYawMoveSpeed 30" )
        ConsoleExec( "cameraPitchMoveSpeed 30" )
      else
        ConsoleExec( "cameraYawMoveSpeed 100" )
        ConsoleExec( "cameraPitchMoveSpeed 100" )
        if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
          AbyssUIClassic_ReloadFrame:Show()
        end
      end
    else
      CameraSmooth70_CheckButton:SetChecked(nil)
    end
  end)
  -- After Login/Reload
  CameraSmooth70_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  CameraSmooth70_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth70 == true then
        ConsoleExec( "cameraYawMoveSpeed 30" )
        ConsoleExec( "cameraPitchMoveSpeed 30" )
      end
    end
  end)
  -- Camera Pitch Function Option 90%
  local CameraSmooth90_CheckButton = CreateFrame("CheckButton", "$parentCameraSmooth90_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  CameraSmooth90_CheckButton:SetPoint("TOPLEFT", 10, -140)
  CameraSmooth90_CheckButton.Text:SetText("Smooth Camera\n   (90% Slower)")
  CameraSmooth90_CheckButton.tooltip = "Makes the Camera turns in a more smooth way"
  CameraSmooth90_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90)
  -- OnClick Function
  CameraSmooth90_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth70 ~= true then
      AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90 = self:GetChecked()
      if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90 == true then
        ConsoleExec( "cameraYawMoveSpeed 10" )
        ConsoleExec( "cameraPitchMoveSpeed 10" )
      else
        ConsoleExec( "cameraYawMoveSpeed 100" )
        ConsoleExec( "cameraPitchMoveSpeed 100" )
        if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth70 ~= true then
          AbyssUIClassic_ReloadFrame:Show()
        end
      end
    else
      CameraSmooth90_CheckButton:SetChecked(nil)
    end
  end)
  -- After Login/Reload
  CameraSmooth90_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  CameraSmooth90_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.ExtraFunctionCameraSmooth90 == true then
        ConsoleExec( "cameraYawMoveSpeed 10" )
        ConsoleExec( "cameraPitchMoveSpeed 10" )
      end
    end
  end)
  -- Inspect Target
  local InspectTarget_CheckButton = CreateFrame("CheckButton", "$parentInspectTarget_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  InspectTarget_CheckButton:SetPoint("TOPLEFT", 10, -170)
  InspectTarget_CheckButton.Text:SetText("|cfff2dc7fInspect Target (Shift + ')|r")
  InspectTarget_CheckButton.tooltip = "When you have a target or your mouse is over someone character,"..
  " to inspect this player press the keys Shift + '"
  InspectTarget_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionInspectTarget)
  addonTable.InspectTarget = InspectTarget_CheckButton
  -- OnClick Function
  InspectTarget_CheckButton:SetScript("OnClick", function(self)
      AbyssUIClassicAddonSettings.ExtraFunctionInspectTarget = self:GetChecked()
  end)
  -- Spell on KeyUp
  local ActionButtonKeyUP_CheckButton = CreateFrame("CheckButton", "$parentActionButtonKeyUP_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  ActionButtonKeyUP_CheckButton:SetPoint("TOPLEFT", 10, -200)
  ActionButtonKeyUP_CheckButton.Text:SetText("ActionButton on KeyUp")
  ActionButtonKeyUP_CheckButton.tooltip = "With this option spells can be cast just when the"..
  " keybind are released"
  ActionButtonKeyUP_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ActionButtonKeyDown)
  -- OnClick Function
  ActionButtonKeyUP_CheckButton:SetScript("OnClick", function(self)
      AbyssUIClassicAddonSettings.ActionButtonKeyDown = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
  end)
  -- After Login/Reload
  ActionButtonKeyUP_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  ActionButtonKeyUP_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.ActionButtonKeyDown == true then
        SetCVar('ActionButtonUseKeyDown', 0)
      else
        SetCVar('ActionButtonUseKeyDown', 1)
      end
    else
      return nil
    end
  end)
  -- Screenshot when you level up --
  local AbyssUIClassic_ScreenshotLevelUp_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_ScreenshotLevelUp_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_ScreenshotLevelUp_CheckButton:SetPoint("TOPLEFT", 10, -230)
  AbyssUIClassic_ScreenshotLevelUp_CheckButton.Text:SetText("Auto Screenshot")
  AbyssUIClassic_ScreenshotLevelUp_CheckButton.tooltip = "Automatically takes a screenshot when you level up"
  AbyssUIClassic_ScreenshotLevelUp_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionScreenshotLevelUp)
  -- OnClick Function
  AbyssUIClassic_ScreenshotLevelUp_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionScreenshotLevelUp = self:GetChecked()
  end)
  -- Action Cam --
  local AbyssUIClassicActionCam_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicActionCam_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicActionCam_CheckButton:SetPoint("TOPLEFT", 10, -260)
  AbyssUIClassicActionCam_CheckButton.Text:SetText("Combat Cursor Mode")
  AbyssUIClassicActionCam_CheckButton.tooltip = "Makes the camera turns with your mouse when in"..
  " combat (right-click to show cursor)"
  AbyssUIClassicActionCam_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionActionCam)
  -- OnClick Function
  AbyssUIClassicActionCam_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionActionCam = self:GetChecked()
  end)
  -- Update
  AbyssUIClassicActionCam_CheckButton:RegisterEvent("PLAYER_REGEN_ENABLED")
  AbyssUIClassicActionCam_CheckButton:RegisterEvent("PLAYER_REGEN_DISABLED")
  AbyssUIClassicActionCam_CheckButton:SetScript("OnEvent", function(self, event, ...)
    local IsMouseLooking = IsMouselooking()
    if ( event == "PLAYER_REGEN_DISABLED" and IsMouseLooking == false ) then
      if AbyssUIClassicAddonSettings.ExtraFunctionActionCam == true then
        MouselookStart()
      else
        MouselookStop()
      end
    end
  --[[
    if ( event == "PLAYER_REGEN_ENABLED" ) then
      MouselookStop()
    end
  --]]
  end)
  -- Auto Repair--
  local AbyssUIClassicAutoRepair_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicAutoRepair_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicAutoRepair_CheckButton:SetPoint("TOPLEFT", 10, -290)
  AbyssUIClassicAutoRepair_CheckButton.Text:SetText("|cfff2dc7fAuto Repair|r")
  AbyssUIClassicAutoRepair_CheckButton.tooltip = "When you open a Merchant shop auto repair items"
  AbyssUIClassicAutoRepair_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionRepair)
  addonTable.AutoRepair = AbyssUIClassicAutoRepair_CheckButton
  -- OnClick Function
  AbyssUIClassicAutoRepair_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionRepair = self:GetChecked()
  end)
  -- Auto Sell Gray --
  local AbyssUIClassicAutoSellGray_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicAutoSellGray_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicAutoSellGray_CheckButton:SetPoint("TOPLEFT", 10, -320)
  AbyssUIClassicAutoSellGray_CheckButton.Text:SetText("|cfff2dc7fAuto Sell Gray Items|r")
  AbyssUIClassicAutoSellGray_CheckButton.tooltip = "When you open a Merchant shop, auto sell gray"
  AbyssUIClassicAutoSellGray_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionSellGray)
  addonTable.AutoSellGray = AbyssUIClassicAutoSellGray_CheckButton
  -- OnClick Function
  AbyssUIClassicAutoSellGray_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionSellGray = self:GetChecked()
  end)
  -- Auto Gamma Day/Night
  local AbyssUIClassicAutoGamma_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicAutoGamma_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicAutoGamma_CheckButton:SetPoint("TOPLEFT", 10, -350)
  AbyssUIClassicAutoGamma_CheckButton.Text:SetText("Auto Gamma\n(Day and Night Mode)")
  AbyssUIClassicAutoGamma_CheckButton.tooltip = "Automatically change the gamma when is day to"..
  " 1.2 (brighter) and to 1.0 (default) at night based on the local time"
  AbyssUIClassicAutoGamma_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionAutoGamma)
  -- OnClick Function
  AbyssUIClassicAutoGamma_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionAutoGamma = self:GetChecked()
    --local dataTime = GetGameTime()
    local dataTime = tonumber(date("%H"))
    if ( dataTime >= 6 and dataTime < 18 ) then
      ConsoleExec( "Gamma 1.2" )
    elseif ( dataTime >= 18 ) then
      ConsoleExec( "Gamma 1.0" )
    end
  end)
  -- After Login/Reload
  AbyssUIClassicAutoGamma_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUIClassicAutoGamma_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.ExtraFunctionAutoGamma == true then
        C_Timer.After(0.5, function ()
          local dataTime = tonumber(date("%H"))
          if ( dataTime >= 6 and dataTime < 18 ) then
            ConsoleExec( "Gamma 1.2" )
          elseif ( dataTime >= 18 ) then
            ConsoleExec( "Gamma 1.0" )
          end
        end)  
      end
    end
  end)
  -- American Clock Style --
  local AbyssUIClassic_AmericanClock_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_AmericanClock_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_AmericanClock_CheckButton:SetPoint("TOPLEFT", 10, -380)
  AbyssUIClassic_AmericanClock_CheckButton.Text:SetText("American Date Style")
  AbyssUIClassic_AmericanClock_CheckButton.tooltip = "Change the date format of the whole UI to"..
  " the American style"
  AbyssUIClassic_AmericanClock_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionAmericanClock)
  -- OnClick Function
  AbyssUIClassic_AmericanClock_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionAmericanClock = self:GetChecked()
  end)
  -- Disable healing spam over player --
  local AbyssUIClassic_DisableHealingSpam_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_DisableHealingSpam_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_DisableHealingSpam_CheckButton:SetPoint("TOPLEFT", 10, -410)
  AbyssUIClassic_DisableHealingSpam_CheckButton.Text:SetText("|cfff2dc7fDisable Portrait Text Spam|r")
  AbyssUIClassic_DisableHealingSpam_CheckButton.tooltip = "Disable healing/damage spam over player"..
  " and pet portraits"
  AbyssUIClassic_DisableHealingSpam_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionDisableHealingSpam)
  addonTable.DisableHealingSpam = AbyssUIClassic_DisableHealingSpam_CheckButton
  -- OnClick Function
  AbyssUIClassic_DisableHealingSpam_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionDisableHealingSpam = self:GetChecked()
    PlayerHitIndicator:SetText(nil)
    PlayerHitIndicator.SetText = function() end

    PetHitIndicator:SetText(nil)
    PetHitIndicator.SetText = function() end
  end)
  -- After Login/Reload
  AbyssUIClassic_DisableHealingSpam_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUIClassic_DisableHealingSpam_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUIClassicAddonSettings.ExtraFunctionDisableHealingSpam == true ) then
        PlayerHitIndicator:SetText(nil)
        PlayerHitIndicator.SetText = function() end

        PetHitIndicator:SetText(nil)
        PetHitIndicator.SetText = function() end
      end
    end
  end)
  -- Shaman Pink --
  local AbyssUIClassic_ShamanPink_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_ShamanPink_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_ShamanPink_CheckButton:SetPoint("TOPLEFT", 10, -440)
  AbyssUIClassic_ShamanPink_CheckButton.Text:SetText("Shaman Pink")
  AbyssUIClassic_ShamanPink_CheckButton.tooltip = "Keep the color pink for Shaman health bars"..
  " (portrait and tooltip)"
  AbyssUIClassic_ShamanPink_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionShamanPink)
  -- OnClick Function
  AbyssUIClassic_ShamanPink_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionShamanPink = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Friendly Green --
  local AbyssUIClassic_FriendlyHealthGreen_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_FriendlyHealthGreen_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_FriendlyHealthGreen_CheckButton:SetPoint("TOPLEFT", 10, -470)
  AbyssUIClassic_FriendlyHealthGreen_CheckButton.Text:SetText("Default Friendly Health")
  AbyssUIClassic_FriendlyHealthGreen_CheckButton.tooltip = "Friendly unit health bars in the default color"
  AbyssUIClassic_FriendlyHealthGreen_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionFriendlyHealthGreen)
  -- OnClick Function
  AbyssUIClassic_FriendlyHealthGreen_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionFriendlyHealthGreen = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Transparent Background Name --
  local AbyssUIClassic_TransparentName_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_TransparentName_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_TransparentName_CheckButton:SetPoint("TOPLEFT", 10, -500)
  AbyssUIClassic_TransparentName_CheckButton.Text:SetText("Transparent Name BKGD")
  AbyssUIClassic_TransparentName_CheckButton.tooltip = "Remove any color in the target name background"
  AbyssUIClassic_TransparentName_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionTransparentName)
  -- OnClick Function
  AbyssUIClassic_TransparentName_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionTransparentName = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Instance Leave --
  local AbyssUIClassic_InstanceLeave_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_InstanceLeave_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_InstanceLeave_CheckButton:SetPoint("TOPLEFT", 10, -530)
  AbyssUIClassic_InstanceLeave_CheckButton.Text:SetText("|cff848484Instance Leave Frame *Retail|r")
  AbyssUIClassic_InstanceLeave_CheckButton.tooltip = "A dynamic frame that pop-up when you"..
  " complete a LFG (dungeon, raid, etc)"
  --AbyssUIClassic_InstanceLeave_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionInstanceLeave)
  -- OnClick Function
  AbyssUIClassic_InstanceLeave_CheckButton:SetScript("OnClick", function(self)
    --AbyssUIClassicAddonSettings.ExtraFunctionInstanceLeave = self:GetChecked()
    AbyssUIClassic_InstanceLeave_CheckButton:SetChecked(nil)
  end)
  -- 2nd Column
  -- CTRL + ' to confirm  --
  local AbyssUIClassic_ConfirmPopUps_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_ConfirmPopUps_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_ConfirmPopUps_CheckButton:SetPoint("TOPLEFT", 400, -80)
  AbyssUIClassic_ConfirmPopUps_CheckButton.Text:SetText("|cfff2dc7fConfirm Pop-Ups (CTRL + ')|r")
  AbyssUIClassic_ConfirmPopUps_CheckButton.tooltip = "When this is active you can confirm almost"..
  " any pop-ups (release, quests, stacks, etc) pressing the keys Ctrl + '"
  AbyssUIClassic_ConfirmPopUps_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionConfirmPopUps)
  addonTable.ConfirmPopUps = AbyssUIClassic_ConfirmPopUps_CheckButton
  -- OnClick Function
  AbyssUIClassic_ConfirmPopUps_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionConfirmPopUps = self:GetChecked()
  end)
  -- Hide in Combat --
  local AbyssUIClassic_HideInCombat_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_HideInCombat_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_HideInCombat_CheckButton:SetPoint("TOPLEFT", 400, -110)
  AbyssUIClassic_HideInCombat_CheckButton.Text:SetText("|cfff2dc7fDynamic ObjectiveTrack Hide|r")
  AbyssUIClassic_HideInCombat_CheckButton.tooltip = "Hide some parts of the interface when you"..
  " are in combat or in a PVP instance"
  AbyssUIClassic_HideInCombat_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionHideInCombat)
  addonTable.HideInCombat = AbyssUIClassic_HideInCombat_CheckButton
  -- OnClick Function
  AbyssUIClassic_HideInCombat_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionHideInCombat = self:GetChecked()
  end)
  -- Better Fonts --
  local AbyssUIClassic_BetterFonts_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_BetterFonts_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_BetterFonts_CheckButton:SetPoint("TOPLEFT", 400, -140)
  AbyssUIClassic_BetterFonts_CheckButton.Text:SetText("RPG chat fonts")
  AbyssUIClassic_BetterFonts_CheckButton.tooltip = "Change the chat fonts to a RPG look-alike style"
  AbyssUIClassic_BetterFonts_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionBetterFonts)
  -- OnClick Function
  AbyssUIClassic_BetterFonts_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionBetterFonts = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
  end)
  -- After Login/Reload
  AbyssUIClassic_BetterFonts_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUIClassic_BetterFonts_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUIClassicAddonSettings.ExtraFunctionBetterFonts == true ) then
        ChatFrame1:SetFont(subFont, 13, "THINOUTLINE")
        ChatFrame1.editBox.header:SetFont(subFont, 13, "THINOUTLINE")
      else 
        return nil
      end
    end
  end)
  -- Better WorldMap --
  local AbyssUIClassic_BetterWorldMap_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_BetterWorldMap_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_BetterWorldMap_CheckButton:SetPoint("TOPLEFT", 400, -170)
  AbyssUIClassic_BetterWorldMap_CheckButton.Text:SetText("Better World Map")
  AbyssUIClassic_BetterWorldMap_CheckButton.tooltip = "Makes the worldmap minimalist/clean"
  AbyssUIClassic_BetterWorldMap_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionBetterWorldMap)
  -- OnClick Function
  AbyssUIClassic_BetterWorldMap_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionBetterWorldMap = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- After Login/Reload
  AbyssUIClassic_BetterWorldMap_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUIClassic_BetterWorldMap_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUIClassicAddonSettings.ExtraFunctionBetterWorldMap == true ) then
        WorldMapFrame.BlackoutFrame:Hide()
        WorldMapFrame.BlackoutFrame:EnableMouse(false)
      else 
        WorldMapFrame.BlackoutFrame:Show()
        WorldMapFrame.BlackoutFrame:EnableMouse(true)
      end
    end
  end)
  -- WorldMap Fader --
  -- Thanks to Ketho for the fader
  local AbyssUIClassic_WorldMapFade_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_WorldMapFade_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_WorldMapFade_CheckButton:SetPoint("TOPLEFT", 400, -200)
  AbyssUIClassic_WorldMapFade_CheckButton.Text:SetText("World Map Fader")
  AbyssUIClassic_WorldMapFade_CheckButton.tooltip = "Makes the worldmap fade while you move"
  AbyssUIClassic_WorldMapFade_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionWorldMapFade)
  -- OnClick Function
  AbyssUIClassic_WorldMapFade_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionWorldMapFade = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- After Login/Reload
  AbyssUIClassic_WorldMapFade_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUIClassic_WorldMapFade_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUIClassicAddonSettings.ExtraFunctionWorldMapFade == true ) then
        PlayerMovementFrameFader.AddDeferredFrame(WorldMapFrame, .60, 1.0, .60)
      end
    end
  end)
  -- Default Nameplate Range --
  local AbyssUIClassic_DefaultNameplate_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_DefaultNameplate_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_DefaultNameplate_CheckButton:SetPoint("TOPLEFT", 400, -230)
  AbyssUIClassic_DefaultNameplate_CheckButton.Text:SetText("Default Nameplate Range")
  AbyssUIClassic_DefaultNameplate_CheckButton.tooltip = "Disable the double range of"..
  " nameplates to Blizzard default value"
  AbyssUIClassic_DefaultNameplate_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionDefaultNameplate)
  -- OnClick Function
  AbyssUIClassic_DefaultNameplate_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionDefaultNameplate = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable Guild Name on Tooltip --
  local AbyssUIClassic_DisableGuildTooltip_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_HideBackgroundClassColor_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_DisableGuildTooltip_CheckButton:SetPoint("TOPLEFT", 400, -260)
  AbyssUIClassic_DisableGuildTooltip_CheckButton.Text:SetText("Disable Guild Tooltip")
  AbyssUIClassic_DisableGuildTooltip_CheckButton.tooltip = "Remove the guild name from tooltips"
  AbyssUIClassic_DisableGuildTooltip_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionDisableGuildTootip)
  -- OnClick Function
  AbyssUIClassic_DisableGuildTooltip_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionDisableGuildTootip = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Remove Background class color --
  local AbyssUIClassic_HideBackgroundClassColor_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_HideBackgroundClassColor_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_HideBackgroundClassColor_CheckButton:SetPoint("TOPLEFT", 400, -290)
  AbyssUIClassic_HideBackgroundClassColor_CheckButton.Text:SetText("Default Background")
  AbyssUIClassic_HideBackgroundClassColor_CheckButton.tooltip = "Remove the class color background behind"..
  " the player names to default values (Transparent Name needs to be unchecked)"
  AbyssUIClassic_HideBackgroundClassColor_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionHideBackgroundClassColor)
  -- OnClick Function
  AbyssUIClassic_HideBackgroundClassColor_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionHideBackgroundClassColor = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable Nameplate Changes --
  local AbyssUIClassic_NameplateChanges_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_NameplateChanges_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_NameplateChanges_CheckButton:SetPoint("TOPLEFT", 400, -320)
  AbyssUIClassic_NameplateChanges_CheckButton.Text:SetText("Disable Nameplate Changes")
  AbyssUIClassic_NameplateChanges_CheckButton.tooltip = "This option will remove any change that was made to the nameplates (the bar above mobs and players)"
  AbyssUIClassic_NameplateChanges_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionNameplateChanges)
  addonTable.NameplateChanges = AbyssUIClassic_NameplateChanges_CheckButton
  -- OnClick Function
  AbyssUIClassic_NameplateChanges_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionNameplateChanges = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable ChatBubble Changes --
  local AbyssUIClassic_ChatBubbleChanges_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_NameplateChanges_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_ChatBubbleChanges_CheckButton:SetPoint("TOPLEFT", 400, -350)
  AbyssUIClassic_ChatBubbleChanges_CheckButton.Text:SetText("|cff0d75d4Disable ChatBubble Changes|r")
  AbyssUIClassic_ChatBubbleChanges_CheckButton.tooltip = "This option will remove any change that was made to the chatbubbles (the frame text above players)"
  AbyssUIClassic_ChatBubbleChanges_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionChatBubbleChanges)
  addonTable.ChatBubbleChanges = AbyssUIClassic_ChatBubbleChanges_CheckButton
  -- OnClick Function
  AbyssUIClassic_ChatBubbleChanges_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionChatBubbleChanges = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable Damage Font --
  local AbyssUIClassic_DamageFont_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_DamageFont_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_DamageFont_CheckButton:SetPoint("TOPLEFT", 400, -380)
  AbyssUIClassic_DamageFont_CheckButton.Text:SetText("Disable Damage Font (*)")
  AbyssUIClassic_DamageFont_CheckButton.tooltip = "This option will remove any change to the damage font text."..
  "\n*You need to restart the game so the font can be reloaded. You can change it to any font, "..
  "go to Textures->font and replace the file keeping the same name"
  AbyssUIClassic_DamageFont_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionDamageFont)
  -- OnClick Function
  AbyssUIClassic_DamageFont_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionDamageFont = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable font white text --
  local AbyssUIClassic_FontWhiteText_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_FontWhiteText_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_FontWhiteText_CheckButton:SetPoint("TOPLEFT", 400, -410)
  AbyssUIClassic_FontWhiteText_CheckButton.Text:SetText("Disable Font White Text")
  AbyssUIClassic_FontWhiteText_CheckButton.tooltip = "Disable the font white text colorization"..
  "back to the default yellow font color"
  AbyssUIClassic_FontWhiteText_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ExtraFunctionDisableFontWhiteText)
  -- OnClick Function
  AbyssUIClassic_FontWhiteText_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ExtraFunctionDisableFontWhiteText = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable character name color --
  local AbyssUIClassic_CharacterText_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassic_CharacterText_CheckButton", AbyssUIClassic_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUIClassic_CharacterText_CheckButton:SetPoint("TOPLEFT", 400, -440)
  AbyssUIClassic_CharacterText_CheckButton.Text:SetText("|cff0d75d4Default CharacterNameText|r")
  AbyssUIClassic_CharacterText_CheckButton.tooltip = "Disable the character name colorization"..
  "back to the default font color"
  AbyssUIClassic_CharacterText_CheckButton:SetChecked(AbyssUIClassicAddonSettings.DisableCharacterText)
  addonTable.DisableCharacterText = AbyssUIClassic_CharacterText_CheckButton
  -- OnClick Function
  AbyssUIClassic_CharacterText_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.DisableCharacterText = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
end
--End
local function TweaksExtra()
  ----------------------------------- Extras  -----------------------------------
  -- Read tooltip--
  local PSINFO_CheckButton = CreateFrame("Frame","$parentPSINFO_CheckButton", AbyssUIClassic_Config.childpanel5)
  PSINFO_CheckButton:SetPoint("BOTTOMLEFT", AbyssUIClassic_Config.childpanel5, "BOTTOMLEFT", 10, 10)
  PSINFO_CheckButton:SetHeight(24)
  PSINFO_CheckButton:SetWidth(200)
  PSINFO_CheckButton:SetScale(1)
  PSINFO_CheckButton = PSINFO_CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  PSINFO_CheckButton:SetPoint("LEFT")
  PSINFO_CheckButton:SetText("The symbol (*) in some options means that there is important information/instructions to be read.\n"..
    "Options with a different color are recommended settings (based on your choice in the setup).")
  -- Keep UnitFrame Dark --
  local KeepUnitDark_CheckButton = CreateFrame("CheckButton", "$parentKeepUnitDark_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  KeepUnitDark_CheckButton:SetPoint("TOPLEFT", 10, -80)
  KeepUnitDark_CheckButton.Text:SetText("Keep UnitFrame Dark")
  KeepUnitDark_CheckButton.tooltip = "Even if you change theme, this will keep UnitFrame Dark"..
  " (Player Frame, Boss, etc)."
  KeepUnitDark_CheckButton:SetChecked(AbyssUIClassicAddonSettings.KeepUnitDark)
  -- OnClick Function
  KeepUnitDark_CheckButton:SetScript("OnClick", function(self)
   if AbyssUIClassicAddonSettings.KeepUnitBlizzard == true then
     KeepUnitDark_CheckButton:SetChecked(nil)
   else
     AbyssUIClassicAddonSettings.KeepUnitDark = self:GetChecked()
     AbyssUIClassic_ReloadFrame:Show()
   end
  end)
   -- After Login/Reload
  KeepUnitDark_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  KeepUnitDark_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.KeepUnitDark == true then
        AbyssUIClassicAddonSettings.KeepUnitDark = self:GetChecked()
      else
        KeepUnitDark_CheckButton:SetChecked(nil)
      end
    end
  end)
  -- Keep UnitFrame Blizzard Like --
  local KeepUnitBlizzard_CheckButton = CreateFrame("CheckButton", "$parentKeepUnitBlizzard_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  KeepUnitBlizzard_CheckButton:SetPoint("TOPLEFT", 10, -110)
  KeepUnitBlizzard_CheckButton.Text:SetText("Keep UnitFrame Blizzard Like")
  KeepUnitBlizzard_CheckButton.tooltip = "Even if you change theme, this will keep UnitFrame"..
  " Blizzard like (Player Frame, Boss, etc)."
  KeepUnitBlizzard_CheckButton:SetChecked(AbyssUIClassicAddonSettings.KeepUnitBlizzard)
  -- OnClick Function
  KeepUnitBlizzard_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.KeepUnitDark == true then
      KeepUnitBlizzard_CheckButton:SetChecked(nil)
    else
      AbyssUIClassicAddonSettings.KeepUnitBlizzard = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    end
  end)
  -- After Login/Reload
  KeepUnitBlizzard_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  KeepUnitBlizzard_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUIClassicAddonSettings.KeepUnitBlizzard == true then
        AbyssUIClassicAddonSettings.KeepUnitBlizzard = self:GetChecked()
      else
        KeepUnitBlizzard_CheckButton:SetChecked(nil)
      end
    end
  end)
  -- Fade UI --
  local FadeUI_CheckButton = CreateFrame("CheckButton", "$parentFadeUI_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  FadeUI_CheckButton:SetPoint("TOPLEFT", 10, -140)
  FadeUI_CheckButton.Text:SetText("Fade UI")
  FadeUI_CheckButton.tooltip = "Fade the UI when you are out of combat ('ATL-CTRL-P' to show frames)"
  FadeUI_CheckButton:SetChecked(AbyssUIClassicAddonSettings.FadeUI)
  -- OnClick Function
  FadeUI_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.FadeUI = self:GetChecked()
    AbyssUIClassic_ReloadFrameFadeUI:Show()
  end)
  -- Disable Square Minimap --
  local DisableSquareMinimap_CheckButton = CreateFrame("CheckButton", "$parentUnitFrameImproved_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  DisableSquareMinimap_CheckButton:SetPoint("TOPLEFT", 10, -170)
  DisableSquareMinimap_CheckButton.Text:SetText("|cff0d75d4Disable Square Minimap|r")
  DisableSquareMinimap_CheckButton.tooltip = "This option will get you back to the"..
  " Blizzard default minimap style (round). *You need to restart the game so round textures can be re-loaded"
  DisableSquareMinimap_CheckButton:SetChecked(AbyssUIClassicAddonSettings.DisableSquareMinimap)
  addonTable.DisableSquareMinimap = DisableSquareMinimap_CheckButton
  -- OnClick Function
  DisableSquareMinimap_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.DisableSquareMinimap = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Minimal ActionBar --
  local MinimalActionBar_CheckButton = CreateFrame("CheckButton", "$parentMinimalActionBar_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  MinimalActionBar_CheckButton:SetPoint("TOPLEFT", 10, -200)
  MinimalActionBar_CheckButton.Text:SetText("Minimal ActionBar")
  MinimalActionBar_CheckButton.tooltip = "Minimalist actionbar, hide all the textures"
  MinimalActionBar_CheckButton:SetChecked(AbyssUIClassicAddonSettings.MinimalActionBar)
  -- OnClick Function
  MinimalActionBar_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.MinimalActionBar = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable UnitFrame Smoke --
  local DisableUnitFrameSmoke_CheckButton = CreateFrame("CheckButton", "$parentDisableUnitFrameSmoke_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  DisableUnitFrameSmoke_CheckButton:SetPoint("TOPLEFT", 10, -230)
  DisableUnitFrameSmoke_CheckButton.Text:SetText("|cff0d75d4Disable Smoke Texture|r")
  DisableUnitFrameSmoke_CheckButton.tooltip = "It will disable the 'smoke' texture around the portrait in "..
  "the UnitFrame Improved version of it"
  DisableUnitFrameSmoke_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UnitFrameImprovedDefaultTexture)
  addonTable.DisableUnitFrameSmoke = DisableUnitFrameSmoke_CheckButton
  -- OnClick Function
  DisableUnitFrameSmoke_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.UnitFrameImprovedDefaultTexture = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Disable Kill Announcer --
  local KillAnnouncer_CheckButton = CreateFrame("CheckButton", "$parentKillAnnouncer_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  KillAnnouncer_CheckButton:SetPoint("TOPLEFT", 10, -260)
  KillAnnouncer_CheckButton.Text:SetText("Disable Kill Announcer")
  KillAnnouncer_CheckButton.tooltip = "Disable the Kill Announcer frame that show up when you kill someone"
  KillAnnouncer_CheckButton:SetChecked(AbyssUIClassicAddonSettings.DisableKillAnnouncer)
  -- OnClick Function
  KillAnnouncer_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.DisableKillAnnouncer = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Silence Kill Announcer --
  local SilenceKillAnnouncer_CheckButton = CreateFrame("CheckButton", "$parentSilenceKillAnnouncer_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  SilenceKillAnnouncer_CheckButton:SetPoint("TOPLEFT", 10, -290)
  SilenceKillAnnouncer_CheckButton.Text:SetText("Silence Kill Announcer")
  SilenceKillAnnouncer_CheckButton.tooltip = "Remove boss/kill sounds from the Kill Announcer frame"
  SilenceKillAnnouncer_CheckButton:SetChecked(AbyssUIClassicAddonSettings.SilenceKillAnnouncer)
  -- OnClick Function
  SilenceKillAnnouncer_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.SilenceKillAnnouncer = self:GetChecked()
  end)
  -- TooltipOnCursor --
  local TooltipOnCursor_CheckButton = CreateFrame("CheckButton", "$parentTooltipOnCursor_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  TooltipOnCursor_CheckButton:SetPoint("TOPLEFT", 10, -320)
  TooltipOnCursor_CheckButton.Text:SetText("|cfff2dc7fTooltip on Cursor|r")
  TooltipOnCursor_CheckButton.tooltip = "Tooltips will appear close to the mouse cursor position"
  TooltipOnCursor_CheckButton:SetChecked(AbyssUIClassicAddonSettings.TooltipOnCursor)
  addonTable.TooltipOnCursor = TooltipOnCursor_CheckButton
  -- OnClick Function
  TooltipOnCursor_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.TooltipOnCursor = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- Always show clock --
  local AlwaysShowClock_CheckButton = CreateFrame("CheckButton", "$parentAlwaysShowClock_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  AlwaysShowClock_CheckButton:SetPoint("TOPLEFT", 10, -350)
  AlwaysShowClock_CheckButton.Text:SetText("|cff0d75d4"..L["Show Minimap Clock"].."|r")
  AlwaysShowClock_CheckButton.tooltip = L["This will always show the minimap clock, instead of showing on hover"]
  AlwaysShowClock_CheckButton:SetChecked(AbyssUIClassicAddonSettings.AlwaysShowClock)
  addonTable.AlwaysShowClock = AlwaysShowClock_CheckButton
  -- OnClick Function
  AlwaysShowClock_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.AlwaysShowClock = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  --- Frames ---
  -- Elite Portrait --
  local ElitePortrait_CheckButton = CreateFrame("CheckButton", "$parentElitePortrait_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  ElitePortrait_CheckButton:SetPoint("TOPLEFT", 400, -80)
  ElitePortrait_CheckButton.Text:SetText("|cfff2dc7fElite Portrait|r")
  ElitePortrait_CheckButton.tooltip = "Add a elite texture to the portraits (high recommended the use of this option with portrait class icons)"
  ElitePortrait_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ElitePortrait)
  addonTable.ElitePortrait = ElitePortrait_CheckButton
  -- OnClick Function
  ElitePortrait_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.ElitePortrait = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
  -- UnitFrame Improved --
  local UnitFrameImproved_CheckButton = CreateFrame("CheckButton", "$parentUnitFrameImproved_CheckButton", AbyssUIClassic_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  UnitFrameImproved_CheckButton:SetPoint("TOPLEFT", 400, -110)
  UnitFrameImproved_CheckButton.Text:SetText("|cfff2dc7fUnitFrame Improved|r")
  UnitFrameImproved_CheckButton.tooltip = "This is a improved version of unitframes,"..
  " it changes those frames to a more beautiful and complete version (recommended use)"
  UnitFrameImproved_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UnitFrameImproved)
  addonTable.UnitFrameImproved = UnitFrameImproved_CheckButton
  -- OnClick Function
  UnitFrameImproved_CheckButton:SetScript("OnClick", function(self)
    AbyssUIClassicAddonSettings.UnitFrameImproved = self:GetChecked()
    AbyssUIClassic_ReloadFrame:Show()
  end)
end
-- End
local function IconsFonts ()
----------------------------------- Icons  -----------------------------------
-- Icon Border --
  -- Gloss
  local GlossIconBorder_CheckButton = CreateFrame("CheckButton", "$parentGlossIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  GlossIconBorder_CheckButton:SetPoint("TOPLEFT", 10, -80)
  GlossIconBorder_CheckButton.Text:SetText(L["Class Color"])
  local Frame = CreateFrame("Frame", nil, GlossIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  GlossIconBorder_CheckButton.Text:SetAllPoints(Frame)
  GlossIconBorder_CheckButton.tooltip = L["Change icon border to a class colored theme"]
  GlossIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.GlossIconBorder)
  -- OnClick Function
  GlossIconBorder_CheckButton:SetScript("OnClick", function(self)
   if AbyssUIClassicAddonSettings.CrispIconBorder     ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true and
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true and
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true then 
      AbyssUIClassicAddonSettings.GlossIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      GlossIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Crisp
  local CrispIconBorder_CheckButton = CreateFrame("CheckButton", "$parentCrispIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  CrispIconBorder_CheckButton:SetPoint("TOPLEFT", 10, -110)
  CrispIconBorder_CheckButton.Text:SetText(L["Crisp"])
  local Frame = CreateFrame("Frame", nil, CrispIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  CrispIconBorder_CheckButton.Text:SetAllPoints(Frame)
  CrispIconBorder_CheckButton.tooltip = L["Change icon border to a crisp theme"]
  CrispIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.CrispIconBorder)
  -- OnClick Function
  CrispIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.GlossIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true and
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true and  
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true then 
      AbyssUIClassicAddonSettings.CrispIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      CrispIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Original
  local OriginalIconBorder_CheckButton = CreateFrame("CheckButton", "$parentOriginalIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  OriginalIconBorder_CheckButton:SetPoint("TOPLEFT", 10, -140)
  OriginalIconBorder_CheckButton.Text:SetText(L["Original"])
  local Frame = CreateFrame("Frame", nil, OriginalIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  OriginalIconBorder_CheckButton.Text:SetAllPoints(Frame)
  OriginalIconBorder_CheckButton.tooltip = L["Change icon border to a original theme"]
  OriginalIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.OriginalIconBorder)
  -- OnClick Function
  OriginalIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlossIconBorder     ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true and
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true and
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true then 
      AbyssUIClassicAddonSettings.OriginalIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      OriginalIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Square
  local SquareIconBorder_CheckButton = CreateFrame("CheckButton", "$parentSquareIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  SquareIconBorder_CheckButton:SetPoint("TOPLEFT", 10, -170)
  SquareIconBorder_CheckButton.Text:SetText(L["Square"])
  local Frame = CreateFrame("Frame", nil, SquareIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  SquareIconBorder_CheckButton.Text:SetAllPoints(Frame)
  SquareIconBorder_CheckButton.tooltip = L["Change icon border to a square theme"]
  SquareIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.SquareIconBorder)
  -- OnClick Function
  SquareIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.GlossIconBorder     ~= true and 
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true and 
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true and
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true then 
      AbyssUIClassicAddonSettings.SquareIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      SquareIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Thin
  local ThinIconBorder_CheckButton = CreateFrame("CheckButton", "$parentThinIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  ThinIconBorder_CheckButton:SetPoint("TOPLEFT", 10, -200)
  ThinIconBorder_CheckButton.Text:SetText(L["Thin"])
  local Frame = CreateFrame("Frame", nil, ThinIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  ThinIconBorder_CheckButton.Text:SetAllPoints(Frame)
  ThinIconBorder_CheckButton.tooltip = L["Change icon border to a thin theme"]
  ThinIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ThinIconBorder)
  -- OnClick Function
  ThinIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true and
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true and 
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.GlossIconBorder     ~= true then 
      AbyssUIClassicAddonSettings.ThinIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      ThinIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Glass
  local GlassIconBorder_CheckButton = CreateFrame("CheckButton", "$parentGlassIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  GlassIconBorder_CheckButton:SetPoint("TOPLEFT", 180, -80)
  GlassIconBorder_CheckButton.Text:SetText(L["Glass"])
  local Frame = CreateFrame("Frame", nil, GlassIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  GlassIconBorder_CheckButton.Text:SetAllPoints(Frame)
  GlassIconBorder_CheckButton.tooltip = L["Change the icon to a glass theme"]
  GlassIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.GlassIconBorder)
  -- OnClick Function
  GlassIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlossIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true and
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true and
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true then 
      AbyssUIClassicAddonSettings.GlassIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      GlassIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Classic Theme
  local ClassicIconBorder_CheckButton = CreateFrame("CheckButton", "$parentClassicIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  ClassicIconBorder_CheckButton:SetPoint("TOPLEFT", 180, -110)
  ClassicIconBorder_CheckButton.Text:SetText("Classic")
  local Frame = CreateFrame("Frame", nil, ClassicIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  ClassicIconBorder_CheckButton.Text:SetAllPoints(Frame)
  ClassicIconBorder_CheckButton.tooltip = "Classic"
  ClassicIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.ClassicIconBorder)
  -- OnClick Function
  ClassicIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlossIconBorder     ~= true and
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true and
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true then 
      AbyssUIClassicAddonSettings.ClassicIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      ClassicIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Default Theme
  local DefaultIconBorder_CheckButton = CreateFrame("CheckButton", "$parentDefaultIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  DefaultIconBorder_CheckButton:SetPoint("TOPLEFT", 180, -140)
  DefaultIconBorder_CheckButton.Text:SetText("Default (Blizzard)")
  local Frame = CreateFrame("Frame", nil, DefaultIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  DefaultIconBorder_CheckButton.Text:SetAllPoints(Frame)
  DefaultIconBorder_CheckButton.tooltip = "Default (Blizzard)"
  DefaultIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.DefaultIconBorder)
  -- OnClick Function
  DefaultIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlossIconBorder     ~= true and
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and 
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true and 
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.AbyssIconBorder     ~= true and
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true then
      AbyssUIClassicAddonSettings.DefaultIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      DefaultIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Oldschool Theme
  local OldSchoolIconBorder_CheckButton = CreateFrame("CheckButton", "$parentOldSchoolIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  OldSchoolIconBorder_CheckButton:SetPoint("TOPLEFT", 180, -170)
  OldSchoolIconBorder_CheckButton.Text:SetText("Old School")
  local Frame = CreateFrame("Frame", nil, OldSchoolIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  OldSchoolIconBorder_CheckButton.Text:SetAllPoints(Frame)
  OldSchoolIconBorder_CheckButton.tooltip = "Old School"
  OldSchoolIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.OldSchoolIconBorder)
  -- OnClick Function
  OldSchoolIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder   ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder   ~= true and 
      AbyssUIClassicAddonSettings.GlossIconBorder    ~= true and
      AbyssUIClassicAddonSettings.GlassIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.ThinIconBorder     ~= true and 
      AbyssUIClassicAddonSettings.ClassicIconBorder  ~= true and
      AbyssUIClassicAddonSettings.AbyssIconBorder    ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder  ~= true then
      AbyssUIClassicAddonSettings.OldSchoolIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      OldSchoolIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  -- Abyss Theme
  local AbyssIconBorder_CheckButton = CreateFrame("CheckButton", "$parentAbyssIconBorder_CheckButton", AbyssUIClassic_Config.childpanel7, "ChatConfigCheckButtonTemplate")
  AbyssIconBorder_CheckButton:SetPoint("TOPLEFT", 180, -200)
  AbyssIconBorder_CheckButton.Text:SetText("|cff0d75d4".."AbyssUI Classic".."|r")
  local Frame = CreateFrame("Frame", nil, AbyssIconBorder_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  AbyssIconBorder_CheckButton.Text:SetAllPoints(Frame)
  AbyssIconBorder_CheckButton.tooltip = "AbyssUI Classic icon borders, a Blizzard Default enchanced theme"
  AbyssIconBorder_CheckButton:SetChecked(AbyssUIClassicAddonSettings.AbyssIconBorder)
  addonTable.AbyssIconBorder = AbyssIconBorder_CheckButton
  -- OnClick Function
  AbyssIconBorder_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.CrispIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.OriginalIconBorder  ~= true and 
      AbyssUIClassicAddonSettings.SquareIconBorder    ~= true and 
      AbyssUIClassicAddonSettings.GlossIconBorder     ~= true and
      AbyssUIClassicAddonSettings.GlassIconBorder     ~= true and 
      AbyssUIClassicAddonSettings.ThinIconBorder      ~= true and 
      AbyssUIClassicAddonSettings.ClassicIconBorder   ~= true and
      AbyssUIClassicAddonSettings.OldSchoolIconBorder ~= true and
      AbyssUIClassicAddonSettings.DefaultIconBorder   ~= true then
      AbyssUIClassicAddonSettings.AbyssIconBorder = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      UIErrorsFrame:AddMessage(L["You need to select just one of those options so they don't overlap"], 1.0, 0.1, 0.1, 1.0)
      AbyssIconBorder_CheckButton:SetChecked(nil)
    end
  end)
  --[[
  --Fonts
  -- Create a frame to hold the dropdown
  --Global
  local frame = CreateFrame("Frame", "$parentFontSelectionFrameGlobal", AbyssUIClassic_Config.childpanel7, "UIDropDownMenuTemplate")
  frame:SetPoint("CENTER", AbyssUIClassic_Config.childpanel7, "CENTER")
  frame:SetSize(200, 30)

  -- Create a function to be called when a font is selected
  local function OnFontSelected(self, fontName)
    UIDropDownMenu_SetText(frame, fontName)
    -- Do something with the selected font, like updating a font for a specific frame or element
    local newglobalFont = fontName
  end

  -- Initialize the dropdown menu
  UIDropDownMenu_Initialize(frame, function(self, level, menuList)
      local info = UIDropDownMenu_CreateInfo()
      local mediaFolder = "Interface\\AddOns\\AbyssUIClassic\\Textures\\font\\"
      local newglobalFont = mediaFolder.."global.tff"
      info.func = OnFontSelected

      local fonts = {
          "Blizzard Default",
          "Open Sans",
          "Monstserrat",
          "Oswald",
          "Nikkyou",
          "Rocker",
          "Immortal",
          -- Add more fonts as needed
      }

      for _, fontName in ipairs(fonts) do
          info.text = fontName
          info.arg1 = fontName
          UIDropDownMenu_AddButton(info)
      end
  end)

  -- Set the default text
  UIDropDownMenu_SetText(frame, "Select Font")

  -- Add the dropdown to your UI frame or wherever you need it
  -- Your code to add the frame to your UI goes here
  if (fontName == "Blizzard Default") then
    newglobalFont = "Fonts\\FRIZQT__.TTF"
    AbyssUIClassic_ReloadFrame()
  elseif (fontName == "Open Sans") then
    newglobalFont = mediaFolder.."global.tff"
    AbyssUIClassic_ReloadFrame()
  elseif (fontName == "Monstserrat") then
    newglobalFont = mediaFolder.."globalsmall.tff"
    AbyssUIClassic_ReloadFrame()
  elseif (fontName == "Oswald") then
    newglobalFont = mediaFolder.."npcfont.tff"
    AbyssUIClassic_ReloadFrame()
  elseif (fontName == "Nikkyou") then
    newglobalFont = mediaFolder.."npcfont_fat.tff"
    AbyssUIClassic_ReloadFrame()
  elseif (fontName == "Rocker") then
    newglobalFont = mediaFolder.."damagefont.tff"
    AbyssUIClassic_ReloadFrame()
  elseif (fontName == "Nikkyou") then
    newglobalFont = mediaFolder.."damagefont_classic.tff"
    AbyssUIClassic_ReloadFrame()
  else
    return nil
  end
  --]]
end
--End
local function Stylization()
  ----------------------------- AbyssUIClassic Stylization ------------------------------
  -- Player Portrait Style --
  -- AbyssUIClassicClassCircles01_CheckButton
  local AbyssUIClassicClassCircles01_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles01_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles01_CheckButton:SetPoint("TOPLEFT", 10, -80)
  AbyssUIClassicClassCircles01_CheckButton.Text:SetText("Artistic")
  AbyssUIClassicClassCircles01_CheckButton.tooltip = "A artistic version of UnitPlayerFrame"
  AbyssUIClassicClassCircles01_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles01)
  -- OnClick Function
  AbyssUIClassicClassCircles01_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles01 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles01_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles02_CheckButton
  local AbyssUIClassicClassCircles02_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles02_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles02_CheckButton:SetPoint("TOPLEFT", 10, -110)
  AbyssUIClassicClassCircles02_CheckButton.Text:SetText("Bright")
  AbyssUIClassicClassCircles02_CheckButton.tooltip = "A bright version of UnitPlayerFrame"
  AbyssUIClassicClassCircles02_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles02)
  -- OnClick Function
  AbyssUIClassicClassCircles02_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles02 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles02_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles03_CheckButton
  local AbyssUIClassicClassCircles03_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles03_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles03_CheckButton:SetPoint("TOPLEFT", 10, -140)
  AbyssUIClassicClassCircles03_CheckButton.Text:SetText("Classic")
  AbyssUIClassicClassCircles03_CheckButton.tooltip = "A classic version of UnitPlayerFrame"
  AbyssUIClassicClassCircles03_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles03)
  -- OnClick Function
  AbyssUIClassicClassCircles03_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles03 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles03_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles04_CheckButton
  local AbyssUIClassicClassCircles04_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles04_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles04_CheckButton:SetPoint("TOPLEFT", 10, -170)
  AbyssUIClassicClassCircles04_CheckButton.Text:SetText("Artistic_V2")
  AbyssUIClassicClassCircles04_CheckButton.tooltip = "Version two of artistic UnitPlayerFrame"
  AbyssUIClassicClassCircles04_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles04)
  -- OnClick Function
  AbyssUIClassicClassCircles04_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles04 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles04_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles05_CheckButton
  local AbyssUIClassicClassCircles05_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles05_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles05_CheckButton:SetPoint("TOPLEFT", 180 , -80)
  AbyssUIClassicClassCircles05_CheckButton.Text:SetText("Dark")
  AbyssUIClassicClassCircles05_CheckButton.tooltip = "A dark version of UnitPlayerFrame"
  AbyssUIClassicClassCircles05_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles05)
  -- OnClick Function
  AbyssUIClassicClassCircles05_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles05 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles05_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles06_CheckButton
  local AbyssUIClassicClassCircles06_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles06_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles06_CheckButton:SetPoint("TOPLEFT", 180, -110)
  AbyssUIClassicClassCircles06_CheckButton.Text:SetText("Dark_Gray")
  AbyssUIClassicClassCircles06_CheckButton.tooltip = "A dark gray version of UnitPlayerFrame"
  AbyssUIClassicClassCircles06_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles06)
  -- OnClick Function
  AbyssUIClassicClassCircles06_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles06 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles06_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles07_CheckButton
  local AbyssUIClassicClassCircles07_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles07_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles07_CheckButton:SetPoint("TOPLEFT", 180, -140)
  AbyssUIClassicClassCircles07_CheckButton.Text:SetText("Dark_V2")
  AbyssUIClassicClassCircles07_CheckButton.tooltip = "Version 2 of the dark UnitPlayerFrame"
  AbyssUIClassicClassCircles07_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles07)
  -- OnClick Function
  AbyssUIClassicClassCircles07_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles07 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles07_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles08_CheckButton
  local AbyssUIClassicClassCircles08_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles08_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles08_CheckButton:SetPoint("TOPLEFT", 180, -170)
  AbyssUIClassicClassCircles08_CheckButton.Text:SetText("Grayscale")
  AbyssUIClassicClassCircles08_CheckButton.tooltip = "A grayscale version of UnitPlayerFrame"
  AbyssUIClassicClassCircles08_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles08)
  -- OnClick Function
  AbyssUIClassicClassCircles08_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles08 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles08_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles09_CheckButton
  local AbyssUIClassicClassCircles09_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles09_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles09_CheckButton:SetPoint("TOPLEFT", 10, -200)
  AbyssUIClassicClassCircles09_CheckButton.Text:SetText("Light_Gray")
  AbyssUIClassicClassCircles09_CheckButton.tooltip = "A light gray version of UnitPlayerFrame"
  AbyssUIClassicClassCircles09_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles09)
  -- OnClick Function
  AbyssUIClassicClassCircles09_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles09 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles09_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles10_CheckButton
  local AbyssUIClassicClassCircles10_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles10_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles10_CheckButton:SetPoint("TOPLEFT", 180, -200)
  AbyssUIClassicClassCircles10_CheckButton.Text:SetText("Medium_Gray")
  AbyssUIClassicClassCircles10_CheckButton.tooltip = "A medium gray version of UnitPlayerFrame"
  AbyssUIClassicClassCircles10_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles10)
  -- OnClick Function
  AbyssUIClassicClassCircles10_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles10 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles10_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles11_CheckButton
  local AbyssUIClassicClassCircles11_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles11_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles11_CheckButton:SetPoint("TOPLEFT", 10, -230)
  AbyssUIClassicClassCircles11_CheckButton.Text:SetText("Minimal_Blue")
  AbyssUIClassicClassCircles11_CheckButton.tooltip = "A blue version of UnitPlayerFrame"
  AbyssUIClassicClassCircles11_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles11)
  -- OnClick Function
  AbyssUIClassicClassCircles11_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles11 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles11_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles12_CheckButton
  local AbyssUIClassicClassCircles12_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles12_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles12_CheckButton:SetPoint("TOPLEFT", 180, -230)
  AbyssUIClassicClassCircles12_CheckButton.Text:SetText("Minimal_Red")
  AbyssUIClassicClassCircles12_CheckButton.tooltip = "A red version of UnitPlayerFrame"
  AbyssUIClassicClassCircles12_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles12)
  -- OnClick Function
  AbyssUIClassicClassCircles12_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles12 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles12_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles13_CheckButton
  local AbyssUIClassicClassCircles13_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles13_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles13_CheckButton:SetPoint("TOPLEFT", 10, -260)
  AbyssUIClassicClassCircles13_CheckButton.Text:SetText("Muted")
  AbyssUIClassicClassCircles13_CheckButton.tooltip = "A muted version of UnitPlayerFrame"
  AbyssUIClassicClassCircles13_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles13)
  -- OnClick Function
  AbyssUIClassicClassCircles13_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles13 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles13_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles14_CheckButton
  local AbyssUIClassicClassCircles14_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles14_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles14_CheckButton:SetPoint("TOPLEFT", 180, -260)
  AbyssUIClassicClassCircles14_CheckButton.Text:SetText("Psychedelic")
  AbyssUIClassicClassCircles14_CheckButton.tooltip = "A psychedelic version of UnitPlayerFrame"
  AbyssUIClassicClassCircles14_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles14)
  -- OnClick Function
  AbyssUIClassicClassCircles14_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles14 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles14_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles15_CheckButton
  local AbyssUIClassicClassCircles15_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles14_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles15_CheckButton:SetPoint("TOPLEFT", 10, -290)
  AbyssUIClassicClassCircles15_CheckButton.Text:SetText("Retro")
  AbyssUIClassicClassCircles15_CheckButton.tooltip = "A retrowave version of UnitPlayerFrame"
  AbyssUIClassicClassCircles15_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles15)
  -- OnClick Function
  AbyssUIClassicClassCircles15_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles16 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles15 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles15_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicClassCircles16_CheckButton
  local AbyssUIClassicClassCircles16_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicClassCircles14_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicClassCircles16_CheckButton:SetPoint("TOPLEFT", 180, -290)
  AbyssUIClassicClassCircles16_CheckButton.Text:SetText("Vibrant")
  AbyssUIClassicClassCircles16_CheckButton.tooltip = "A vibrant version of UnitPlayerFrame"
  AbyssUIClassicClassCircles16_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIClassCircles16)
  -- OnClick Function
  AbyssUIClassicClassCircles16_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIClassCircles01 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles02 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles03 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles04 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles05 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles06 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles07 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles08 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles09 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles10 ~= true and 
       AbyssUIClassicAddonSettings.UIClassCircles11 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles12 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles13 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles14 ~= true and
       AbyssUIClassicAddonSettings.UIClassCircles15 ~= true then
      AbyssUIClassicAddonSettings.UIClassCircles16 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicClassCircles16_CheckButton:SetChecked(nil)
    end
  end)
  -- Frame Colorization --
  -- AbyssUIClassicVertexColorFrames01_CheckButton
  local AbyssUIClassicVertexColorFrames01_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames01_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames01_CheckButton:SetPoint("TOPRIGHT", -250, -80)
  AbyssUIClassicVertexColorFrames01_CheckButton.Text:SetText("|cffc0c0c0Blizzard (Default)|r")
  AbyssUIClassicVertexColorFrames01_CheckButton.tooltip = "Blizzard Silver Colorization for Frames"
  AbyssUIClassicVertexColorFrames01_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames01)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames01_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames01 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames01_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames02_CheckButton
  local AbyssUIClassicVertexColorFrames02_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames02_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames02_CheckButton:SetPoint("TOPRIGHT", -80, -80)
  AbyssUIClassicVertexColorFrames02_CheckButton.Text:SetText("|cff636363Blackout|r")
  AbyssUIClassicVertexColorFrames02_CheckButton.tooltip = "A completely Dark Frame Colorization"
  AbyssUIClassicVertexColorFrames02_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames02)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames02_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames02 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames02_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames03_CheckButton
  local AbyssUIClassicVertexColorFrames03_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames03_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames03_CheckButton:SetPoint("TOPRIGHT", -250, -110)
  AbyssUIClassicVertexColorFrames03_CheckButton.Text:SetText("|cffb62a25Blood|r")
  AbyssUIClassicVertexColorFrames03_CheckButton.tooltip = "A Dark Red Frame Colorization"
  AbyssUIClassicVertexColorFrames03_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames03)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames03_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames03 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames03_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames04_CheckButton
  local AbyssUIClassicVertexColorFrames04_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames04_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames04_CheckButton:SetPoint("TOPRIGHT", -80, -110)
  AbyssUIClassicVertexColorFrames04_CheckButton.Text:SetText("|cffecc13cGold|r")
  AbyssUIClassicVertexColorFrames04_CheckButton.tooltip = "A Golden Frame Colorization"
  AbyssUIClassicVertexColorFrames04_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames04)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames04_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames04 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames04_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames05_CheckButton
  local AbyssUIClassicVertexColorFrames05_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames05_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames05_CheckButton:SetPoint("TOPRIGHT", -250, -140)
  AbyssUIClassicVertexColorFrames05_CheckButton.Text:SetText("|cffc41F3BDeath Knight|r")
  AbyssUIClassicVertexColorFrames05_CheckButton.tooltip = "DK Class Frame Colorization"
  AbyssUIClassicVertexColorFrames05_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames05)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames05_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames05 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames05_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames06_CheckButton
  local AbyssUIClassicVertexColorFrames06_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames06_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames06_CheckButton:SetPoint("TOPRIGHT", -80, -140)
  AbyssUIClassicVertexColorFrames06_CheckButton.Text:SetText("|cffA330C9Demon\nHunter|r")
  AbyssUIClassicVertexColorFrames06_CheckButton.tooltip = "DH Class Frame Colorization"
  AbyssUIClassicVertexColorFrames06_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames06)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames06_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames06 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames06_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames07_CheckButton
  local AbyssUIClassicVertexColorFrames07_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames07_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames07_CheckButton:SetPoint("TOPRIGHT", -250, -170)
  AbyssUIClassicVertexColorFrames07_CheckButton.Text:SetText("|cffFF7D0ADruid|r")
  AbyssUIClassicVertexColorFrames07_CheckButton.tooltip = "Druid Class Frame Colorization"
  AbyssUIClassicVertexColorFrames07_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames07)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames07_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames07 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames07_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames08_CheckButton
  local AbyssUIClassicVertexColorFrames08_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames08_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames08_CheckButton:SetPoint("TOPRIGHT", -80, -170)
  AbyssUIClassicVertexColorFrames08_CheckButton.Text:SetText("|cffABD473Hunter|r")
  AbyssUIClassicVertexColorFrames08_CheckButton.tooltip = "Hunter Class Frame Colorization"
  AbyssUIClassicVertexColorFrames08_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames08)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames08_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames08 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames08_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames09_CheckButton
  local AbyssUIClassicVertexColorFrames09_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames09_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames09_CheckButton:SetPoint("TOPRIGHT", -250, -200)
  AbyssUIClassicVertexColorFrames09_CheckButton.Text:SetText("|cff69CCF0Mage|r")
  AbyssUIClassicVertexColorFrames09_CheckButton.tooltip = "Mage Class Frame Colorization"
  AbyssUIClassicVertexColorFrames09_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames09)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames09_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames09 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames09_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames10_CheckButton
  local AbyssUIClassicVertexColorFrames10_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames10_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames10_CheckButton:SetPoint("TOPRIGHT", -80, -200)
  AbyssUIClassicVertexColorFrames10_CheckButton.Text:SetText("|cff00FF96Monk|r")
  AbyssUIClassicVertexColorFrames10_CheckButton.tooltip = "Monk Class Frame Colorization"
  AbyssUIClassicVertexColorFrames10_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames10)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames10_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames10 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames10_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames11_CheckButton
  local AbyssUIClassicVertexColorFrames11_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames11_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames11_CheckButton:SetPoint("TOPRIGHT", -250, -230)
  AbyssUIClassicVertexColorFrames11_CheckButton.Text:SetText("|cffF58CBAPaladin|r")
  AbyssUIClassicVertexColorFrames11_CheckButton.tooltip = "Paladin Class Frame Colorization"
  AbyssUIClassicVertexColorFrames11_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames11)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames11_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames11 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames11_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames12_CheckButton
  local AbyssUIClassicVertexColorFrames12_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames12_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames12_CheckButton:SetPoint("TOPRIGHT", -80, -230)
  AbyssUIClassicVertexColorFrames12_CheckButton.Text:SetText("Priest")
  AbyssUIClassicVertexColorFrames12_CheckButton.tooltip = "Priest Class Frame Colorization (Shadow Priest)"
  AbyssUIClassicVertexColorFrames12_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames12)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames12_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames12 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames12_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames13_CheckButton
  local AbyssUIClassicVertexColorFrames13_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames13_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames13_CheckButton:SetPoint("TOPRIGHT", -250, -260)
  AbyssUIClassicVertexColorFrames13_CheckButton.Text:SetText("|cffFFF569Rogue|r")
  AbyssUIClassicVertexColorFrames13_CheckButton.tooltip = "Rogue Class Frame Colorization"
  AbyssUIClassicVertexColorFrames13_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames13)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames13_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames13 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames13_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames14_CheckButton
  local AbyssUIClassicVertexColorFrames14_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames14_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames14_CheckButton:SetPoint("TOPRIGHT", -80, -260)
  AbyssUIClassicVertexColorFrames14_CheckButton.Text:SetText("|cff0070DEShaman|r")
  AbyssUIClassicVertexColorFrames14_CheckButton.tooltip = "Shaman Class Frame Colorization"
  AbyssUIClassicVertexColorFrames14_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames14)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames14_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames14 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames14_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames15_CheckButton
  local AbyssUIClassicVertexColorFrames15_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames15_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames15_CheckButton:SetPoint("TOPRIGHT", -250, -290)
  AbyssUIClassicVertexColorFrames15_CheckButton.Text:SetText("|cff9482C9Warlock|r")
  AbyssUIClassicVertexColorFrames15_CheckButton.tooltip = "Warlock Class Frame Colorization"
  AbyssUIClassicVertexColorFrames15_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames15)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames15_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames15 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames15_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUIClassicVertexColorFrames16_CheckButton
  local AbyssUIClassicVertexColorFrames16_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFrames16_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFrames16_CheckButton:SetPoint("TOPRIGHT", -80, -290)
  AbyssUIClassicVertexColorFrames16_CheckButton.Text:SetText("|cffC79C6EWarrior|r")
  AbyssUIClassicVertexColorFrames16_CheckButton.tooltip = "Warrior Class Frame Colorization"
  AbyssUIClassicVertexColorFrames16_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFrames16)
  -- OnClick Function
  AbyssUIClassicVertexColorFrames16_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFrames16 = self:GetChecked()
      AbyssUIClassic_ReloadFrame:Show()
    else
      AbyssUIClassicVertexColorFrames16_CheckButton:SetChecked(nil)
    end
  end)
  -- Choose a Color (Color Picker)
  local AbyssUIClassicVertexColorFramesColorPicker_Button = CreateFrame("Button", "$parentAbyssUIClassicVertexColorFramesColorPicker_Button", AbyssUIClassic_Config.childpanel4, "UIPanelButtonTemplate")
  AbyssUIClassicVertexColorFramesColorPicker_Button:SetPoint("TOPRIGHT", -150, -350)
  AbyssUIClassicVertexColorFramesColorPicker_Button:SetHeight(30)
  AbyssUIClassicVertexColorFramesColorPicker_Button:SetWidth(120)
  AbyssUIClassicVertexColorFramesColorPicker_Button.text = AbyssUIClassicVertexColorFramesColorPicker_Button.text or AbyssUIClassicVertexColorFramesColorPicker_Button:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  AbyssUIClassicVertexColorFramesColorPicker_Button.text:SetFont(globalFont, 12)
  AbyssUIClassicVertexColorFramesColorPicker_Button.text:SetPoint("CENTER", AbyssUIClassicVertexColorFramesColorPicker_Button, "CENTER", 0, 0)
  AbyssUIClassicVertexColorFramesColorPicker_Button.text:SetText(colorString)
  AbyssUIClassicVertexColorFramesColorPicker_Button.text:SetTextColor(229/255, 229/255, 229/255)
  AbyssUIClassicVertexColorFramesColorPicker_Button.text:SetShadowColor(0, 0, 0)
  AbyssUIClassicVertexColorFramesColorPicker_Button.text:SetShadowOffset(1, -1)
  -- OnClick Function
  AbyssUIClassicVertexColorFramesColorPicker_Button:SetScript("OnClick", function(self)
    AbyssUIClassic_ShowColorPicker()
  end)
  -- Apply Color
  local AbyssUIClassicVertexColorFramesColorPicker_CheckButton = CreateFrame("CheckButton", "$parentAbyssUIClassicVertexColorFramesColorPicker_CheckButton", AbyssUIClassic_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUIClassicVertexColorFramesColorPicker_CheckButton:SetPoint("CENTER", 200, -70)
  AbyssUIClassicVertexColorFramesColorPicker_CheckButton.Text:SetText(applyString.." "..colorColorString)
  local character = UnitName("player").."-"..GetRealmName()
  AbyssUIClassicVertexColorFramesColorPicker_CheckButton.Text:SetTextColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)
  AbyssUIClassicVertexColorFramesColorPicker_CheckButton.tooltip = "Apply the color you choose from the ColorPicker"
  AbyssUIClassicVertexColorFramesColorPicker_CheckButton:SetChecked(AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker)
  -- OnClick Function
  AbyssUIClassicVertexColorFramesColorPicker_CheckButton:SetScript("OnClick", function(self)
    if AbyssUIClassicAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUIClassicAddonSettings.UIVertexColorFrames16 ~= true then
      AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker = self:GetChecked()
      if ( AbyssUIClassicAddonSettings.UIVertexColorFramesColorPicker == true ) then
        AbyssUIClassicVertexColorFramesColorPicker_CheckButton.Text:SetTextColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)
        ReloadUI()
      end
    else
      AbyssUIClassicVertexColorFramesColorPicker_CheckButton:SetChecked(nil)
    end
  end)
end
-- End
--------------------------------- Save ---------------------------------
--This starts things off and once we're far enough into the game
--to check our SavedVariables and initialises if required
local f = CreateFrame("Frame", "AbyssUIClassic_Config", UIParent)
f:SetSize(50, 50)
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event, ...)
  if not AbyssUIClassicAddonSettings then
    AbyssUIClassicAddonSettings = {}
  end
  -- Now we have SavedVarialbe loaded, create the interface options frame
  InitSettings()
  HideElementsInit()
  Miscellaneous()
  TweaksExtra()
  IconsFonts()
  Stylization()
end)
----------------------------------------------------
-- End
