-- Author: Yugen
--
-- Classic
--
-- Hope you like my addOn ^^
--
-- Configuration page for AbyssUILight
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
    globalFont  = mediaFolder.."zhCN-TW\\senty.ttf"
    subFont   = mediaFolder.."zhCN-TW\\senty.ttf"
    damageFont  = mediaFolder.."zhCN-TW\\senty.ttf"
  elseif ( locale == "zhTW" ) then
    globalFont  = mediaFolder.."zhCN-TW\\senty.ttf"
    subFont   = mediaFolder.."zhCN-TW\\senty.ttf"
    damageFont  = mediaFolder.."zhCN-TW\\senty.ttf"
  elseif ( locale == "ruRU" ) then
    globalFont  = mediaFolder.."ruRU\\dejavu.ttf"
    subFont   = mediaFolder.."ruRU\\dejavu.ttf"
    damageFont  = mediaFolder.."ruRU\\dejavu.ttf"
  elseif ( locale == "koKR" ) then
    globalFont  = mediaFolder.."koKR\\dxlbab.ttf"
    subFont   = mediaFolder.."koKR\\dxlbab.ttf"
    damageFont  = mediaFolder.."koKR\\dxlbab.ttf"
  elseif ( locale == "frFR" or locale == "deDE" or locale == "enGB" or locale == "enUS" or locale == "itIT" or
    locale == "esES" or locale == "esMX" or locale == "ptBR") then
    globalFont  = mediaFolder.."global.ttf"
    subFont   = mediaFolder.."npcfont.ttf"
    damageFont  = mediaFolder.."damagefont_classic.ttf"
  else
    globalFont  = fontName
    subFont   = fontName
    damageFont  = fontName
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
local confirmString     = _G["OKAY"]
local colorString       = _G["COLOR_PICKER"]
local colorColorString  = _G["COLOR"]
local applyString       = _G["APPLY"]
--------------------------------------------------------------
local function InitSettings()
  AbyssUILight_Config.panel = CreateFrame( "Frame", "$parentAbyssUILight_Config", InterfaceOptionsFramePanelContainer)
  -- Register in the Interface Addon Options GUI
  -- Set the name for the Category for the Options Panel1
  AbyssUILight_Config.panel.name = "AbyssUI|cff0d75d4Light|r"
  -- Add the panel to the Interface Options
  InterfaceOptions_AddCategory(AbyssUILight_Config.panel, addonName)
  --Child Panels
  AbyssUILight_Config.childpanel1 = CreateFrame( "Frame", "$parentConfigChild_ActionBar", AbyssUILight_Config.panel)
  AbyssUILight_Config.childpanel1.name = "ActionBar"
  AbyssUILight_Config.childpanel1.parent = AbyssUILight_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUILight_Config.childpanel1)
  --
  AbyssUILight_Config.childpanel2 = CreateFrame( "Frame", "$parentConfigChild_HideElements", AbyssUILight_Config.panel)
  AbyssUILight_Config.childpanel2.name = "Hide Elements"
  AbyssUILight_Config.childpanel2.parent = AbyssUILight_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUILight_Config.childpanel2)
  --
  AbyssUILight_Config.childpanel3 = CreateFrame( "Frame", "$parentConfigChild_Miscellaneous", AbyssUILight_Config.panel)
  AbyssUILight_Config.childpanel3.name = "Miscellaneous"
  AbyssUILight_Config.childpanel3.parent = AbyssUILight_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUILight_Config.childpanel3)
  --
  AbyssUILight_Config.childpanel4 = CreateFrame( "Frame", "$parentConfigChild_Themes", AbyssUILight_Config.panel)
  AbyssUILight_Config.childpanel4.name = "Themes"
  AbyssUILight_Config.childpanel4.parent = AbyssUILight_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUILight_Config.childpanel4)
  --
  AbyssUILight_Config.childpanel5 = CreateFrame( "Frame", "$parentConfigChild_Extras", AbyssUILight_Config.panel)
  AbyssUILight_Config.childpanel5.name = "Tweaks & Extra"
  AbyssUILight_Config.childpanel5.parent = AbyssUILight_Config.panel.name
  InterfaceOptions_AddCategory(AbyssUILight_Config.childpanel5)
  -- Title
  local Frame = CreateFrame("Frame","$parentFrameButtonTitle", AbyssUILight_Config.panel)
  Frame:SetPoint("CENTER", AbyssUILight_Config.panel, "TOP", 0, -20)
  Frame:SetHeight(24)
  Frame:SetWidth(70)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("AbyssUI|cff0d75d4Light|r")
  -- SubTittle
  local Frame = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUILight_Config.panel)
  Frame:SetPoint("CENTER", AbyssUILight_Config.panel, "TOP", 0, -120)
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
  local Frame = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUILight_Config.panel)
  Frame:SetPoint("BOTTOMLEFT", AbyssUILight_Config.panel, "BOTTOMLEFT", 10, 70)
  Frame:SetHeight(24)
  Frame:SetWidth(200)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("LEFT")
  Frame:SetText("|cff0d75d4Special Thanks|r")
  local Frame1 = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUILight_Config.panel)
  Frame1:SetPoint("BOTTOMLEFT", AbyssUILight_Config.panel, "BOTTOMLEFT", 10, 50)
  Frame1:SetHeight(24)
  Frame1:SetWidth(200)
  Frame1:SetScale(1)
  Frame1 = Frame1:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame1:SetPoint("LEFT")
  Frame1:SetText("|cfff2dc7fFizzlemizz|r for helping me with programming questions.")
  local Frame2 = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUILight_Config.panel)
  Frame2:SetPoint("BOTTOMLEFT", AbyssUILight_Config.panel, "BOTTOMLEFT", 10, 30)
  Frame2:SetHeight(24)
  Frame2:SetWidth(200)
  Frame2:SetScale(1)
  Frame2 = Frame2:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame2:SetPoint("LEFT")
  Frame2:SetText("|cfff2dc7fFry|r for helping me with grammatical errors.")
  local Frame3 = CreateFrame("Frame","$parentFrameButtonSubTitle", AbyssUILight_Config.panel)
  Frame3:SetPoint("BOTTOMLEFT", AbyssUILight_Config.panel, "BOTTOMLEFT", 10, 10)
  Frame3:SetHeight(24)
  Frame3:SetWidth(200)
  Frame3:SetScale(1)
  Frame3 = Frame3:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame3:SetPoint("LEFT")
  Frame3:SetText("|cfff2dc7fKawF|r for UnitFrame Improved, so I could create a really nice"..
  " UnitFrame for AbyssUI.")
  -- Panel 01 (ActionBar)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel01", AbyssUILight_Config.childpanel1)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel1, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("AbyssUI|cff0d75d4Light|r Actionbar")
  -- Panel 02 (HideElements)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel02", AbyssUILight_Config.childpanel2)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel2, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Hide Elements")
  -- Panel 03 (Miscellaneous)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel03", AbyssUILight_Config.childpanel3)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel3, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Miscellaneous")
  -- Panel 03.01 (Miscellaneous)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel041", AbyssUILight_Config.childpanel3)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel3, "TOP", -265, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- General")
  -- Panel 03.01 (Miscellaneous)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel041", AbyssUILight_Config.childpanel3)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel3, "TOP", 125, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Frames")
  -- Panel 04 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel04", AbyssUILight_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel4, "TOP", -150, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Player Portrait")
  -- Panel 04.01 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel041", AbyssUILight_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel4, "TOP", -255, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Portrait Art")
  -- Panel 05 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel05", AbyssUILight_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel4, "TOP", 120, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Frame Colorization")
  -- Panel 05.01 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel051", AbyssUILight_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel4, "TOP", 90, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Preset Colors")
  -- Panel 05.02 (Themes)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel052", AbyssUILight_Config.childpanel4)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel4, "CENTER", 98, -40)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Choose a Color")
  -- Panel 06 (Extra)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel06", AbyssUILight_Config.childpanel5)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel5, "TOP", 0, -20)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1.5)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("Extras")
  -- Panel 06.01 (Extra)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel061", AbyssUILight_Config.childpanel5)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel5, "TOP", -265, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- General")
  -- Panel 06.02 (Extra)
  local Frame = CreateFrame("Frame","$parentFrameButtonPanel062", AbyssUILight_Config.childpanel5)
  Frame:SetPoint("CENTER", AbyssUILight_Config.childpanel5, "TOP", 125, -70)
  Frame:SetWidth(120)
  Frame:SetHeight(24)
  Frame:SetScale(1)
  Frame = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  Frame:SetPoint("CENTER")
  Frame:SetText("- Frames")
  --------------------------------- Buttons ---------------------------------
  local _G = _G
  local levelString       = _G["LEVEL"]
  local versionString     = _G["GAME_VERSION_LABEL"]
  local latestString      = _G["KBASE_RECENTLY_UPDATED"] 
  local timeStringLabel   = _G["TIME_LABEL"]
  ----------------------------------------------------
  -- AbyssUILight Setup --
  local FrameButton = CreateFrame("Button","$parentExtraSetupButton", AbyssUILight_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUILight_Config.panel, "TOP", -200, -250)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("AbyssUI Setup")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
    AbyssUILightSecondFrame:Show()
  end)
  -- Clear Action Bar --
  local FrameButton = CreateFrame("Button","$parentExtraClearActionButton", AbyssUILight_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER",  AbyssUILight_Config.panel, "TOP", 0, -250)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("Clear Action Bar")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
    AbyssUILight_ActionBarCleaner:Show()
  end)
  -- AbyssUILight DailyInfo --
  local FrameButton = CreateFrame("Button","$parentExtraDailyInfoButton", AbyssUILight_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUILight_Config.panel, "TOP", 200, -250)
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
      local AddonVersion = GetAddOnMetadata("AbyssUILight", "Version")
      print("|cfff2dc7f~ AbyssUILight Daily Info ~|r")
      if ( AbyssUILightAddonSettings.ExtraFunctionAmericanClock == true ) then
        print("|cfff2dc7f"..timeStringLabel.."|r " .. date("%H:%M |cffffcc00%m/%d/%y|r "))
      else
        print("|cfff2dc7f"..timeStringLabel.."|r " .. date("%H:%M |cffffcc00%d/%m/%y|r "))
      end
      --print("|cfff2dc7f"..honorString.." "..levelString..": |r|cffffcc00"..HonorLevel.."|r")
      --print("|cfff2dc7fLocation: |r" .. GetMinimapZoneText() .. "|cffffcc00, " .. GetZoneText() .. "|r")
      print("|cfff2dc7fWoW "..versionString..":w |r|cffffcc00" .. select(1, GetBuildInfo()) .. "|r")
      print("|cfff2dc7fAbyssUILight "..versionString..": |r|cffffcc00" .. AddonVersion .. "|r")
      --print("|cfff2dc7f"..latestString.." TexturePack: |r|cffffcc001.0.1.1 (26/09/20)|r")
    end)
  end)
  -- Reload --
  local FrameButton = CreateFrame("Button","$parentExtraReloadInterfaceButton", AbyssUILight_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUILight_Config.panel, "TOP", -200, -300)
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
  local FrameButton = CreateFrame("Button","$parentExtraGitButton", AbyssUILight_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUILight_Config.panel, "TOP", 0, -300)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("Github")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
    AbyssUILight_EditBox:SetText("https://github.com/YugenMori/AbyssUILight")
    AbyssUILight_EditBox_Frame:Show()
  end)
  -- Ko-fi --
  local FrameButton = CreateFrame("Button","$parentExtraKofiButton", AbyssUILight_Config.panel, "UIPanelButtonTemplate")
  FrameButton:SetHeight(30)
  FrameButton:SetWidth(140)
  FrameButton:SetPoint("CENTER", AbyssUILight_Config.panel, "TOP", 200, -300)
  FrameButton.text = FrameButton.text or FrameButton:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  FrameButton.text:SetFont(globalFont, 12)
  FrameButton.text:SetPoint("CENTER", FrameButton, "CENTER", 0, -1)
  FrameButton.text:SetText("Ko-fi")
  FrameButton.text:SetTextColor(229/255, 229/255, 229/255)
  FrameButton.text:SetShadowColor(0, 0, 0)
  FrameButton.text:SetShadowOffset(1, -1)
  FrameButton:SetScript("OnClick", function()
    AbyssUILight_EditBox:SetText("https://ko-fi.com/yugensan")
    AbyssUILight_EditBox_Frame:Show()
  end)
  -- Check InfoPanel AddOns
  -- Texture Trigger Function
  local function AbyssUILight_CheckTexturePack()
    local f  = CreateFrame('frame') -- Don't create a new frame for every texture, this is just an example
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
            AbyssUILight_FrameSize(v, 200, 10)
            AbyssUILight_RegionListSize(v, 200, 10)
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
  AbyssUILight_CheckTexturePack()
  end)
  ----------------------------- AbyssUILight Actionbar -------------------------------
  -- AbyssUILight Action Bar --
  local AbyssUILightNewActionBar3x12_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightNewActionBar3x12_CheckButton", AbyssUILight_Config.childpanel1, "ChatConfigCheckButtonTemplate")
  AbyssUILightNewActionBar3x12_CheckButton:SetPoint("TOPLEFT", 10, -140)
  AbyssUILightNewActionBar3x12_CheckButton.Text:SetText("3x12 Actionbar")
  AbyssUILightNewActionBar3x12_CheckButton.tooltip = "Adds a new bar above the Blizzard MainActionBar"
  AbyssUILightNewActionBar3x12_CheckButton:SetChecked(AbyssUILightAddonSettings.AbyssUILightNewActionBar3x12)
  -- OnClick Function
  AbyssUILightNewActionBar3x12_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.AbyssUILightNewActionBar3x12 = self:GetChecked()
    AbyssUILight_ActionBarInfo:Show()
  end)
  -- After Login/Reload
  AbyssUILightNewActionBar3x12_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUILightNewActionBar3x12_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( AbyssUILightAddonSettings.AbyssUILightNewActionBar3x12 == true ) then
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
      if AbyssUILightAddonSettings.AbyssUILightNewActionBar3x12 == true then
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
  local PSINFOHide_CheckButton = CreateFrame("Frame","$parentPSINFOHide_CheckButton", AbyssUILight_Config.childpanel2)
  PSINFOHide_CheckButton:SetPoint("BOTTOMLEFT", AbyssUILight_Config.childpanel2, "BOTTOMLEFT", 10, 10)
  PSINFOHide_CheckButton:SetHeight(24)
  PSINFOHide_CheckButton:SetWidth(200)
  PSINFOHide_CheckButton:SetScale(1)
  PSINFOHide_CheckButton = PSINFOHide_CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  PSINFOHide_CheckButton:SetPoint("LEFT")
  PSINFOHide_CheckButton:SetText("The symbol (*) in some options means that there is important information/instructions to be read.\n"..
    "Options with a different color are recommended settings (based on your choice in the setup).")
  -- MicroMenu/Bags --
  local MicroMenu_CheckButton = CreateFrame("CheckButton", "$parentMicroMenu_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  MicroMenu_CheckButton:SetPoint("TOPLEFT", 10, -80)
  MicroMenu_CheckButton.Text:SetText("Hide MicroMenu")
  MicroMenu_CheckButton.tooltip = "Hide the ActionBar MicroMenu"
  MicroMenu_CheckButton:SetChecked(AbyssUILightAddonSettings.HideMicroMenu)
  --  Hide
  local function AbyssUILight_HideMicroMenu_Function()
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
  local function AbyssUILight_ShowMicroMenu_Function()
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
  AbyssUILightAddonSettings.HideMicroMenu = self:GetChecked()
    if AbyssUILightAddonSettings.HideMicroMenu == true then
      AbyssUILight_HideMicroMenu_Function()
    else
      AbyssUILight_ShowMicroMenu_Function()
    end
  end)
  -- After Login/Reload
  MicroMenu_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  MicroMenu_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.HideMicroMenu == true then
        AbyssUILight_HideMicroMenu_Function()
      else
        AbyssUILight_ShowMicroMenu_Function()
      end
    end
  end)
  -- Gryphons Option --
  local Gryphons_CheckButton = CreateFrame("CheckButton", "$parentGryphons_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  Gryphons_CheckButton:SetPoint("TOPLEFT", 10, -110)
  Gryphons_CheckButton.Text:SetText("Hide Gryphons")
  Gryphons_CheckButton.tooltip = "Hide the ActionBar Gryphons"
  Gryphons_CheckButton:SetChecked(AbyssUILightAddonSettings.HideGryphons)
  -- OnClick Function
  Gryphons_CheckButton:SetScript("OnClick", function(self)
  AbyssUILightAddonSettings.HideGryphons = self:GetChecked()
    if AbyssUILightAddonSettings.HideGryphons == true then
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
      if AbyssUILightAddonSettings.HideGryphons == true then
        MainMenuBarRightEndCap:Hide()
        MainMenuBarLeftEndCap:Hide()
      else
        MainMenuBarRightEndCap:Show()
        MainMenuBarLeftEndCap:Show()
      end
    end
  end)
  -- Minimap
  local Minimap_CheckButton = CreateFrame("CheckButton", "$parentMinimap_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  Minimap_CheckButton:SetPoint("TOPLEFT", 10, -140)
  Minimap_CheckButton.Text:SetText("Hide Minimap")
  Minimap_CheckButton.tooltip = "Hide the Game Minimap"
  Minimap_CheckButton:SetChecked(AbyssUILightAddonSettings.HideMinimap)
  -- OnClick Function
  Minimap_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideMinimap = self:GetChecked()
    if AbyssUILightAddonSettings.HideMinimap == true then
      MinimapCluster:Hide()
    else
      MinimapCluster:Show()
    end
  end)
  -- After Login/Reload
  Minimap_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  Minimap_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.HideMinimap == true then
        MinimapCluster:Hide()
      else
        MinimapCluster:Show()
      end
    end
  end)
  -- Objective Tracker --
  local ObjTracker_CheckButton = CreateFrame("CheckButton", "$parentObjTracker_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  ObjTracker_CheckButton:SetPoint("TOPLEFT", 10, -170)
  ObjTracker_CheckButton.Text:SetText("Hide Objective Tracker")
  ObjTracker_CheckButton.tooltip = "Hide the Objective Tracker (Quest Frame)"
  ObjTracker_CheckButton:SetChecked(AbyssUILightAddonSettings.HideObjectiveTracker)
  -- OnClick Function
  ObjTracker_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideObjectiveTracker = self:GetChecked()
    if AbyssUILightAddonSettings.HideObjectiveTracker == true then
      QuestWatchFrame:Hide()
    else
      QuestWatchFrame:Show()
    end
  end)
  -- After Login/Reload
  ObjTracker_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  ObjTracker_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.HideObjectiveTracker == true then
        QuestWatchFrame:Hide()
      else
        QuestWatchFrame:Show()
      end
    end
  end)
  -- Hide FPS/MS Frame --
  local FPSMSFrame_CheckButton = CreateFrame("CheckButton", "$parentFPSMSFrame_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  FPSMSFrame_CheckButton:SetPoint("TOPLEFT", 10, -200)
  FPSMSFrame_CheckButton.Text:SetText("|cff0d75d4Hide FPS/MS Frame (*)|r")
  FPSMSFrame_CheckButton.tooltip = "Hide the fps/ms frame (Top left frame)."
  .." *This will only work if you are using the default Blizzard Minimap"
  FPSMSFrame_CheckButton:SetChecked(AbyssUILightAddonSettings.HideFPSMSFrame)
  addonTable.FPSMSFrame = FPSMSFrame_CheckButton
  -- OnClick Function
  FPSMSFrame_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideFPSMSFrame = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- YouDied LevelUp Frame --
  local YouDiedLevelUpFrame_CheckButton = CreateFrame("CheckButton", "$parentYouDiedLevelUpFrame_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  YouDiedLevelUpFrame_CheckButton:SetPoint("TOPLEFT", 10, -230)
  YouDiedLevelUpFrame_CheckButton.Text:SetText("|cff0d75d4Hide YouDied/LevelUp Frame|r")
  YouDiedLevelUpFrame_CheckButton.tooltip = "Hide the 'You Died' and 'Level Up' frame when you"..
  " die/level in the game"
  YouDiedLevelUpFrame_CheckButton:SetChecked(AbyssUILightAddonSettings.HideYouDiedLevelUpFrame)
  addonTable.YouDiedLevelUpFrame = YouDiedLevelUpFrame_CheckButton
  -- OnClick Function
  YouDiedLevelUpFrame_CheckButton:SetScript("OnClick", function(self)
  AbyssUILightAddonSettings.HideYouDiedLevelUpFrame = self:GetChecked()
  end)
  -- Hide Macro Labels --
  local HideMacroLabels_CheckButton = CreateFrame("CheckButton", "$parentHideMacroLabels_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideMacroLabels_CheckButton:SetPoint("TOPLEFT", 10, -260)
  HideMacroLabels_CheckButton.Text:SetText("Hide Macro Labels")
  HideMacroLabels_CheckButton.tooltip = "Hide Macro Labels from Action Bar"
  HideMacroLabels_CheckButton:SetChecked(AbyssUILightAddonSettings.HideMacroLabels)
  -- OnClick Function
  HideMacroLabels_CheckButton:SetScript("OnClick", function(self)
  AbyssUILightAddonSettings.HideMacroLabels = self:GetChecked()
    if ( AbyssUILightAddonSettings.HideMacroLabels == true ) then
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
      if AbyssUILightAddonSettings.HideMacroLabels == true then
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
  local HideHotkeysLabels_CheckButton = CreateFrame("CheckButton", "$parentHideHotkeysLabels_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideHotkeysLabels_CheckButton:SetPoint("TOPLEFT", 10, -290)
  HideHotkeysLabels_CheckButton.Text:SetText("Hide Hotkeys Labels")
  HideHotkeysLabels_CheckButton.tooltip = "Hide Hotkeys Labels from Action Bar"
  HideHotkeysLabels_CheckButton:SetChecked(AbyssUILightAddonSettings.HideHotkeysLabels)
  -- OnClick Function
  HideHotkeysLabels_CheckButton:SetScript("OnClick", function(self)
  AbyssUILightAddonSettings.HideHotkeysLabels = self:GetChecked()
     if ( AbyssUILightAddonSettings.HideHotkeysLabels == true ) then
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
      if AbyssUILightAddonSettings.HideHotkeysLabels == true then
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
  local HideStanceBar_CheckButton = CreateFrame("CheckButton", "$parentHideStanceBar_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideStanceBar_CheckButton:SetPoint("TOPLEFT", 10, -320)
  HideStanceBar_CheckButton.Text:SetText("Hide Stance Bar")
  HideStanceBar_CheckButton.tooltip = "Hide the Stance Bar (Druid forms, Rogue stealth, etc)"
  HideStanceBar_CheckButton:SetChecked(AbyssUILightAddonSettings.HideStanceBar)
  -- OnClick Function
  HideStanceBar_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideStanceBar = self:GetChecked()
     if ( AbyssUILightAddonSettings.HideStanceBar == true ) then
       StanceBarFrame:Hide()
     else
       return nil
     end
  end)
  -- After Login/Reload
  HideStanceBar_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideStanceBar_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.HideStanceBar == true then
        C_Timer.After(0.5, function()
          StanceBarFrame:SetScript("OnUpdate", function(self) self:Hide() end)
        end)
      end
    end
  end)
  -- Chat Hide Frame (needs to be here so the hide chat buttons works on this too)
  -- Thanks to Syncrow for part of this 
  local AbyssUILight_ChatHideFrame = CreateFrame("Button", "$parentChatHideFrame", UIParent)
  AbyssUILight_ChatHideFrame:SetSize(30, 30)
  AbyssUILight_ChatHideFrame.t = AbyssUILight_ChatHideFrame:CreateTexture(nil, "BORDER")
  AbyssUILight_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
  AbyssUILight_ChatHideFrame.t:SetAllPoints(AbyssUILight_ChatHideFrame)
  AbyssUILight_ChatHideFrame:SetPoint("BOTTOM","ChatFrame1ButtonFrame","BOTTOM",0,-35)
  if ( AbyssUILightAddonSettings.FadeUI ~= true ) then
    AbyssUILight_ChatHideFrame:Show()
  else
    AbyssUILight_ChatHideFrame:Hide()
  end

  local ChatHide = false
  AbyssUILight_ChatHideFrame:SetScript("OnMouseDown", function(self, Button)
    if ChatHide == false then
      if Button == "LeftButton" then
        AbyssUILight_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Down.blp")
      end
    elseif ChatHide == true then
      if Button == "LeftButton" then
        AbyssUILight_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Down.blp")
      end
    end
  end)

  AbyssUILight_ChatHideFrame:SetScript("OnMouseUp", function(self, Button)
    if ChatHide == false then
      if Button == "LeftButton" then
        AbyssUILight_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
      end
    elseif ChatHide == true then
      if Button == "LeftButton" then
        AbyssUILight_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
      end
    end
  end)

  AbyssUILight_ChatHideFrame:SetScript("OnClick", function(self, Button)
    if ChatHide == false then
      AbyssUILight_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp")
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
      AbyssUILight_ChatHideFrame.t:SetTexture("Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp")
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
  local HideChatButtons_CheckButton = CreateFrame("CheckButton", "$parentHideStanceBar_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideChatButtons_CheckButton:SetPoint("TOPLEFT", 10, -350)
  HideChatButtons_CheckButton.Text:SetText("Hide Chat Buttons")
  HideChatButtons_CheckButton.tooltip = "Hide the Chat buttons (voice, social, etc)"
  HideChatButtons_CheckButton:SetChecked(AbyssUILightAddonSettings.HideChatButtons)
  -- OnClick Function
  HideChatButtons_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideChatButtons = self:GetChecked()
    if ( AbyssUILightAddonSettings.HideChatButtons == true ) then
      --QuickJoinToastButton:Hide()
      GeneralDockManager:SetAlpha(0)
      ChatFrameMenuButton:Hide()
      ChatFrameChannelButton:Hide()
      ChatFrame1ButtonFrame:SetAlpha(0)
      AbyssUILight_ChatHideFrame:Hide()
      --ChatFrameToggleVoiceDeafenButton:SetAlpha(0)
      --ChatFrameToggleVoiceMuteButton:SetAlpha(0)
    else 
      --QuickJoinToastButton:Show()
      GeneralDockManager:SetAlpha(1)
      ChatFrameMenuButton:Show()
      ChatFrameChannelButton:Show()
      ChatFrame1ButtonFrame:SetAlpha(1)
      AbyssUILight_ChatHideFrame:Show()
      --ChatFrameToggleVoiceDeafenButton:SetAlpha(1)
      --ChatFrameToggleVoiceMuteButton:SetAlpha(1)
    end
  end)
  -- After Login/Reload
  HideChatButtons_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideChatButtons_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.HideChatButtons == true then
        C_Timer.After(1, function()
          -- QuickJoinToastButton:Hide()
          GeneralDockManager:SetAlpha(0)
          ChatFrameMenuButton:Hide()
          ChatFrameChannelButton:Hide()
          ChatFrame1ButtonFrame:SetAlpha(0)
          AbyssUILight_ChatHideFrame:Hide()
          --ChatFrameToggleVoiceDeafenButton:SetAlpha(0)
          --ChatFrameToggleVoiceMuteButton:SetAlpha(0)
        end)
      end
    end
  end)
  -- AFKCammeraFrame --
  local AFKCammeraFrame_CheckButton = CreateFrame("CheckButton", "$parentAFKCammeraFrame_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  AFKCammeraFrame_CheckButton:SetPoint("TOPLEFT", 10, -380)
  AFKCammeraFrame_CheckButton.Text:SetText("Hide AFKMode Frame")
  AFKCammeraFrame_CheckButton.tooltip = "Hide the AFKMode when you are AFK"
  AFKCammeraFrame_CheckButton:SetChecked(AbyssUILightAddonSettings.AFKCammeraFrame)
  -- OnClick Function
  AFKCammeraFrame_CheckButton:SetScript("OnClick", function(self)
  AbyssUILightAddonSettings.AFKCammeraFrame = self:GetChecked()
  end)
  -- Faction/PvP icon --
  local FactionPvpIcon_CheckButton = CreateFrame("CheckButton", "$parentFactionPvpIcon_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  FactionPvpIcon_CheckButton:SetPoint("TOPLEFT", 10, -410)
  FactionPvpIcon_CheckButton.Text:SetText("Hide Faction/PvP Icon")
  FactionPvpIcon_CheckButton.tooltip = "Hide the player frame faction/PvP icon"
  FactionPvpIcon_CheckButton:SetChecked(AbyssUILightAddonSettings.FactionPvpIcon)
  -- OnClick Function
  FactionPvpIcon_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.FactionPvpIcon = self:GetChecked()
    if ( AbyssUILightAddonSettings.FactionPvpIcon == true ) then
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
      if ( AbyssUILightAddonSettings.FactionPvpIcon == true ) then
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
  local HideHelm_CheckButton = CreateFrame("CheckButton", "$parentHideHelm_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideHelm_CheckButton:SetPoint("TOPLEFT", 10, -440)
  HideHelm_CheckButton.Text:SetText("Hide Helm")
  HideHelm_CheckButton.tooltip = "Hide the player helm"
  HideHelm_CheckButton:SetChecked(AbyssUILightAddonSettings.HideHelm)
  -- OnClick Function
  HideHelm_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideHelm = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- After Login/Reload
  HideHelm_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideHelm_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.HideHelm == true then
        ShowHelm(false)
      else
        ShowHelm(true)
      end
    end
  end)
  -- Hide Cloak --
  local HideCloak_CheckButton = CreateFrame("CheckButton", "$parentHideCloak_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideCloak_CheckButton:SetPoint("TOPLEFT", 10, -470)
  HideCloak_CheckButton.Text:SetText("Hide Cloak")
  HideCloak_CheckButton.tooltip = "Hide the player cloak"
  HideCloak_CheckButton:SetChecked(AbyssUILightAddonSettings.HideCloak)
  -- OnClick Function
  HideCloak_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideCloak = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- After Login/Reload
  HideCloak_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideCloak_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.HideCloak == true then
        ShowCloak(false)
      else
        ShowCloak(true)
      end
    end
  end)
  -- 2nd Collum
  -- Hide Cast Timer
  local HideCastTimer_CheckButton = CreateFrame("CheckButton", "$parentHideCastTimer_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideCastTimer_CheckButton:SetPoint("TOPRIGHT", -200, -80)
  HideCastTimer_CheckButton.Text:SetText("|cff0d75d4Hide CastBar Timer|r")
  HideCastTimer_CheckButton.tooltip = "Hide the timer below CastBar"
  HideCastTimer_CheckButton:SetChecked(AbyssUILightAddonSettings.HideCastTimer)
  addonTable.HideCastTimer = HideCastTimer_CheckButton
  -- OnClick Function
  HideCastTimer_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideCastTimer = self:GetChecked()
  end)
  -- Hide Group Frame
  local HideGroupFrame_CheckButton = CreateFrame("CheckButton", "$parentHideGroupFrame_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideGroupFrame_CheckButton:SetPoint("TOPRIGHT", -200, -110)
  HideGroupFrame_CheckButton.Text:SetText("|cfff2dc7fHide GroupFrame|r")
  HideGroupFrame_CheckButton.tooltip = "Hide the GroupFrame on the player portrait"
  HideGroupFrame_CheckButton:SetChecked(AbyssUILightAddonSettings.HideGroupFrame)
  addonTable.HideGroupFrame = HideGroupFrame_CheckButton
  -- OnClick Function
  HideGroupFrame_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideGroupFrame = self:GetChecked()
      if ( AbyssUILightAddonSettings.HideGroupFrame == true ) then
        PlayerFrameGroupIndicator:SetAlpha(0)
      else
        PlayerFrameGroupIndicator:SetAlpha(1)
      end
  end)
  -- After Login/Reload
  HideGroupFrame_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  HideGroupFrame_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUILightAddonSettings.HideGroupFrame == true ) then
        PlayerFrameGroupIndicator:SetAlpha(0)
      else
        PlayerFrameGroupIndicator:SetAlpha(1)
      end
    end
  end)
  -- Hide UnitImproved Faction Icons
  local HideUnitImprovedFaction_CheckButton = CreateFrame("CheckButton", "$parentHideUnitImprovedFaction_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  HideUnitImprovedFaction_CheckButton:SetPoint("TOPRIGHT", -200, -140)
  HideUnitImprovedFaction_CheckButton.Text:SetText("|cfff2dc7fHide UnitImproved Faction Icon|r")
  HideUnitImprovedFaction_CheckButton.tooltip = "Hide the Faction Icon (Ally/Horde) on players frames"
  HideUnitImprovedFaction_CheckButton:SetChecked(AbyssUILightAddonSettings.HideUnitImprovedFaction)
  addonTable.HideUnitImprovedFaction = HideUnitImprovedFaction_CheckButton
  -- OnClick Function
  HideUnitImprovedFaction_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.HideUnitImprovedFaction = self:GetChecked()
  end)
  -- Disable Tooltip Healthbar --
  local DisableTooltipHealth_CheckButton = CreateFrame("CheckButton", "$parentDisableTooltipHealth_CheckButton", AbyssUILight_Config.childpanel2, "ChatConfigCheckButtonTemplate")
  DisableTooltipHealth_CheckButton:SetPoint("TOPRIGHT", -200, -170)
  DisableTooltipHealth_CheckButton.Text:SetText(L["|cff0d75d4Disable Tooltip Health|r"])
  local Frame = CreateFrame("Frame", nil, DisableTooltipHealth_CheckButton)
  Frame:SetWidth(180)
  Frame:SetHeight(40)
  Frame:SetPoint("LEFT", 25, 0)
  DisableTooltipHealth_CheckButton.Text:SetAllPoints(Frame)
  DisableTooltipHealth_CheckButton.tooltip = L["Disable the tooltip healthBar from mouse hover functions"]
  DisableTooltipHealth_CheckButton:SetChecked(AbyssUILightAddonSettings.DisableTooltipHealth)
  addonTable.DisableTooltipHealth = DisableTooltipHealth_CheckButton
  -- OnClick Function
  DisableTooltipHealth_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.DisableTooltipHealth = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
end
-- End
local function Miscellaneous()
  ------------------------------- Miscellaneous -------------------------------
  local PSINFOHide_CheckButton = CreateFrame("Frame","$parentPSINFOHide_CheckButton", AbyssUILight_Config.childpanel3)
  PSINFOHide_CheckButton:SetPoint("BOTTOMLEFT", AbyssUILight_Config.childpanel3, "BOTTOMLEFT", 10, 10)
  PSINFOHide_CheckButton:SetHeight(24)
  PSINFOHide_CheckButton:SetWidth(200)
  PSINFOHide_CheckButton:SetScale(1)
  PSINFOHide_CheckButton = PSINFOHide_CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  PSINFOHide_CheckButton:SetPoint("LEFT")
  PSINFOHide_CheckButton:SetText("The symbol (*) in some options means that there is important information/instructions to be read.\n"..
    "Options with a different color are recommended settings (based on your choice in the setup).")
  -- Camera Pitch --
  -- Camera Pitch Function Option 50%
  local CameraSmooth50_CheckButton = CreateFrame("CheckButton", "$parentCameraSmooth50_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  CameraSmooth50_CheckButton:SetPoint("TOPLEFT", 10, -80)
  CameraSmooth50_CheckButton.Text:SetText("Smooth Camera\n   (50% Slower)")
  CameraSmooth50_CheckButton.tooltip = "Makes the Camera turns in a more smooth way"
  CameraSmooth50_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50)
  addonTable.CameraSmooth50 = CameraSmooth50_CheckButton
  -- OnClick Function
  CameraSmooth50_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth70 ~= true and AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
      AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 = self:GetChecked()
      if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 == true then
        ConsoleExec( "cameraYawMoveSpeed 50" )
        ConsoleExec( "cameraPitchMoveSpeed 50" )
      else
        ConsoleExec( "cameraYawMoveSpeed 100" )
        ConsoleExec( "cameraPitchMoveSpeed 100" )
        if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
          AbyssUILight_ReloadFrame:Show()
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
      if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 == true then
        ConsoleExec( "cameraYawMoveSpeed 50" )
        ConsoleExec( "cameraPitchMoveSpeed 50" )
      end
    end
  end)
  -- Camera Pitch Function Option 70%
  local CameraSmooth70_CheckButton = CreateFrame("CheckButton", "$parentCameraSmooth70_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  CameraSmooth70_CheckButton:SetPoint("TOPLEFT", 10, -110)
  CameraSmooth70_CheckButton.Text:SetText("Smooth Camera\n   (70% Slower)")
  CameraSmooth70_CheckButton.tooltip = "Makes the Camera turns in a more smooth way"
  CameraSmooth70_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionCameraSmooth70)
  -- OnClick Function
  CameraSmooth70_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
      AbyssUILightAddonSettings.ExtraFunctionCameraSmooth70 = self:GetChecked()
      if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth70 == true then
        ConsoleExec( "cameraYawMoveSpeed 30" )
        ConsoleExec( "cameraPitchMoveSpeed 30" )
      else
        ConsoleExec( "cameraYawMoveSpeed 100" )
        ConsoleExec( "cameraPitchMoveSpeed 100" )
        if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90 ~= true then
          AbyssUILight_ReloadFrame:Show()
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
      if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth70 == true then
        ConsoleExec( "cameraYawMoveSpeed 30" )
        ConsoleExec( "cameraPitchMoveSpeed 30" )
      end
    end
  end)
  -- Camera Pitch Function Option 90%
  local CameraSmooth90_CheckButton = CreateFrame("CheckButton", "$parentCameraSmooth90_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  CameraSmooth90_CheckButton:SetPoint("TOPLEFT", 10, -140)
  CameraSmooth90_CheckButton.Text:SetText("Smooth Camera\n   (90% Slower)")
  CameraSmooth90_CheckButton.tooltip = "Makes the Camera turns in a more smooth way"
  CameraSmooth90_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90)
  -- OnClick Function
  CameraSmooth90_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUILightAddonSettings.ExtraFunctionCameraSmooth70 ~= true then
      AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90 = self:GetChecked()
      if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90 == true then
        ConsoleExec( "cameraYawMoveSpeed 10" )
        ConsoleExec( "cameraPitchMoveSpeed 10" )
      else
        ConsoleExec( "cameraYawMoveSpeed 100" )
        ConsoleExec( "cameraPitchMoveSpeed 100" )
        if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth50 ~= true and AbyssUILightAddonSettings.ExtraFunctionCameraSmooth70 ~= true then
          AbyssUILight_ReloadFrame:Show()
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
      if AbyssUILightAddonSettings.ExtraFunctionCameraSmooth90 == true then
        ConsoleExec( "cameraYawMoveSpeed 10" )
        ConsoleExec( "cameraPitchMoveSpeed 10" )
      end
    end
  end)
  -- Inspect Target
  local InspectTarget_CheckButton = CreateFrame("CheckButton", "$parentInspectTarget_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  InspectTarget_CheckButton:SetPoint("TOPLEFT", 10, -170)
  InspectTarget_CheckButton.Text:SetText("|cfff2dc7fInspect Target (Shift + ')|r")
  InspectTarget_CheckButton.tooltip = "When you have a target or your mouse is over someone character,"..
  " to inspect this player press the keys Shift + '"
  InspectTarget_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionInspectTarget)
  addonTable.InspectTarget = InspectTarget_CheckButton
  -- OnClick Function
  InspectTarget_CheckButton:SetScript("OnClick", function(self)
      AbyssUILightAddonSettings.ExtraFunctionInspectTarget = self:GetChecked()
  end)
  -- Spell on KeyUp
  local ActionButtonKeyUP_CheckButton = CreateFrame("CheckButton", "$parentActionButtonKeyUP_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  ActionButtonKeyUP_CheckButton:SetPoint("TOPLEFT", 10, -200)
  ActionButtonKeyUP_CheckButton.Text:SetText("ActionButton on KeyUp")
  ActionButtonKeyUP_CheckButton.tooltip = "With this option spells can be cast just when the"..
  " keybind are released"
  ActionButtonKeyUP_CheckButton:SetChecked(AbyssUILightAddonSettings.ActionButtonKeyDown)
  -- OnClick Function
  ActionButtonKeyUP_CheckButton:SetScript("OnClick", function(self)
      AbyssUILightAddonSettings.ActionButtonKeyDown = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
  end)
  -- After Login/Reload
  ActionButtonKeyUP_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  ActionButtonKeyUP_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.ActionButtonKeyDown == true then
        SetCVar('ActionButtonUseKeyDown', 0)
      else
        SetCVar('ActionButtonUseKeyDown', 1)
      end
    else
      return nil
    end
  end)
  -- Screenshot when you level up --
  local AbyssUILight_ScreenshotLevelUp_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_ScreenshotLevelUp_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_ScreenshotLevelUp_CheckButton:SetPoint("TOPLEFT", 10, -230)
  AbyssUILight_ScreenshotLevelUp_CheckButton.Text:SetText("Auto Screenshot")
  AbyssUILight_ScreenshotLevelUp_CheckButton.tooltip = "Automatically takes a screenshot when you level up"
  AbyssUILight_ScreenshotLevelUp_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionScreenshotLevelUp)
  -- OnClick Function
  AbyssUILight_ScreenshotLevelUp_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionScreenshotLevelUp = self:GetChecked()
  end)
  -- Action Cam --
  local AbyssUILightActionCam_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightActionCam_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILightActionCam_CheckButton:SetPoint("TOPLEFT", 10, -260)
  AbyssUILightActionCam_CheckButton.Text:SetText("Combat Cursor Mode")
  AbyssUILightActionCam_CheckButton.tooltip = "Makes the camera turns with your mouse when in"..
  " combat (right-click to show cursor)"
  AbyssUILightActionCam_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionActionCam)
  -- OnClick Function
  AbyssUILightActionCam_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionActionCam = self:GetChecked()
  end)
  -- Update
  AbyssUILightActionCam_CheckButton:RegisterEvent("PLAYER_REGEN_ENABLED")
  AbyssUILightActionCam_CheckButton:RegisterEvent("PLAYER_REGEN_DISABLED")
  AbyssUILightActionCam_CheckButton:SetScript("OnEvent", function(self, event, ...)
    local IsMouseLooking = IsMouselooking()
    if ( event == "PLAYER_REGEN_DISABLED" and IsMouseLooking == false ) then
      if AbyssUILightAddonSettings.ExtraFunctionActionCam == true then
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
  -- Auto Repair/Sell Gray --
  local AbyssUILightAutoSellGray_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightAutoSellGray_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILightAutoSellGray_CheckButton:SetPoint("TOPLEFT", 10, -290)
  AbyssUILightAutoSellGray_CheckButton.Text:SetText("|cfff2dc7fAuto Repair\nSell Gray Items|r")
  AbyssUILightAutoSellGray_CheckButton.tooltip = "When you open a Merchant shop, auto sell gray"..
  " and repair items"
  AbyssUILightAutoSellGray_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionSellGray)
  addonTable.AutoSellGray = AbyssUILightAutoSellGray_CheckButton
  -- OnClick Function
  AbyssUILightAutoSellGray_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionSellGray = self:GetChecked()
  end)
  -- Auto Gamma Day/Night
  local AbyssUILightAutoGamma_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightAutoGamma_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILightAutoGamma_CheckButton:SetPoint("TOPLEFT", 10, -320)
  AbyssUILightAutoGamma_CheckButton.Text:SetText("Auto Gamma\n(Day and Night Mode)")
  AbyssUILightAutoGamma_CheckButton.tooltip = "Automatically change the gamma when is day to"..
  " 1.2 (brighter) and to 1.0 (default) at night based on the local time"
  AbyssUILightAutoGamma_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionAutoGamma)
  -- OnClick Function
  AbyssUILightAutoGamma_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionAutoGamma = self:GetChecked()
    --local dataTime = GetGameTime()
    local dataTime = tonumber(date("%H"))
    if ( dataTime >= 6 and dataTime < 18 ) then
      ConsoleExec( "Gamma 1.2" )
    elseif ( dataTime >= 18 ) then
      ConsoleExec( "Gamma 1.0" )
    end
  end)
  -- After Login/Reload
  AbyssUILightAutoGamma_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUILightAutoGamma_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.ExtraFunctionAutoGamma == true then
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
  local AbyssUILight_AmericanClock_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_AmericanClock_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_AmericanClock_CheckButton:SetPoint("TOPLEFT", 10, -350)
  AbyssUILight_AmericanClock_CheckButton.Text:SetText("American Date Style")
  AbyssUILight_AmericanClock_CheckButton.tooltip = "Change the date format of the whole UI to"..
  " the American style"
  AbyssUILight_AmericanClock_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionAmericanClock)
  -- OnClick Function
  AbyssUILight_AmericanClock_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionAmericanClock = self:GetChecked()
  end)
  -- Disable healing spam over player --
  local AbyssUILight_DisableHealingSpam_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_DisableHealingSpam_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_DisableHealingSpam_CheckButton:SetPoint("TOPLEFT", 10, -380)
  AbyssUILight_DisableHealingSpam_CheckButton.Text:SetText("|cfff2dc7fDisable Portrait Text Spam|r")
  AbyssUILight_DisableHealingSpam_CheckButton.tooltip = "Disable healing/damage spam over player"..
  " and pet portraits"
  AbyssUILight_DisableHealingSpam_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionDisableHealingSpam)
  addonTable.DisableHealingSpam = AbyssUILight_DisableHealingSpam_CheckButton
  -- OnClick Function
  AbyssUILight_DisableHealingSpam_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionDisableHealingSpam = self:GetChecked()
    PlayerHitIndicator:SetText(nil)
    PlayerHitIndicator.SetText = function() end

    PetHitIndicator:SetText(nil)
    PetHitIndicator.SetText = function() end
  end)
  -- After Login/Reload
  AbyssUILight_DisableHealingSpam_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUILight_DisableHealingSpam_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUILightAddonSettings.ExtraFunctionDisableHealingSpam == true ) then
        PlayerHitIndicator:SetText(nil)
        PlayerHitIndicator.SetText = function() end

        PetHitIndicator:SetText(nil)
        PetHitIndicator.SetText = function() end
      end
    end
  end)
  -- Shaman Pink --
  local AbyssUILight_ShamanPink_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_ShamanPink_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_ShamanPink_CheckButton:SetPoint("TOPLEFT", 10, -410)
  AbyssUILight_ShamanPink_CheckButton.Text:SetText("Shaman Pink")
  AbyssUILight_ShamanPink_CheckButton.tooltip = "Keep the color pink for Shaman health bars"..
  " (portrait and tooltip)"
  AbyssUILight_ShamanPink_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionShamanPink)
  -- OnClick Function
  AbyssUILight_ShamanPink_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionShamanPink = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Friendly Green --
  local AbyssUILight_FriendlyHealthGreen_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_FriendlyHealthGreen_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_FriendlyHealthGreen_CheckButton:SetPoint("TOPLEFT", 10, -440)
  AbyssUILight_FriendlyHealthGreen_CheckButton.Text:SetText("Default Friendly Health")
  AbyssUILight_FriendlyHealthGreen_CheckButton.tooltip = "Friendly unit health bars in the default color"
  AbyssUILight_FriendlyHealthGreen_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionFriendlyHealthGreen)
  -- OnClick Function
  AbyssUILight_FriendlyHealthGreen_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionFriendlyHealthGreen = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Transparent Background Name --
  local AbyssUILight_TransparentName_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_TransparentName_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_TransparentName_CheckButton:SetPoint("TOPLEFT", 10, -470)
  AbyssUILight_TransparentName_CheckButton.Text:SetText("Transparent Name BKGD")
  AbyssUILight_TransparentName_CheckButton.tooltip = "Remove any color in the target name background"
  AbyssUILight_TransparentName_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionTransparentName)
  -- OnClick Function
  AbyssUILight_TransparentName_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionTransparentName = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Instance Leave --
  local AbyssUILight_InstanceLeave_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_InstanceLeave_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_InstanceLeave_CheckButton:SetPoint("TOPLEFT", 10, -500)
  AbyssUILight_InstanceLeave_CheckButton.Text:SetText("|cff848484Instance Leave Frame *Retail|r")
  AbyssUILight_InstanceLeave_CheckButton.tooltip = "A dynamic frame that pop-up when you"..
  " complete a LFG (dungeon, raid, etc)"
  --AbyssUILight_InstanceLeave_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionInstanceLeave)
  -- OnClick Function
  AbyssUILight_InstanceLeave_CheckButton:SetScript("OnClick", function(self)
    --AbyssUILightAddonSettings.ExtraFunctionInstanceLeave = self:GetChecked()
    AbyssUILight_InstanceLeave_CheckButton:SetChecked(nil)
  end)
  -- 2nd Column
  -- CTRL + ' to confirm  --
  local AbyssUILight_ConfirmPopUps_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_ConfirmPopUps_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_ConfirmPopUps_CheckButton:SetPoint("TOPLEFT", 400, -80)
  AbyssUILight_ConfirmPopUps_CheckButton.Text:SetText("|cfff2dc7fConfirm Pop-Ups (CTRL + ')|r")
  AbyssUILight_ConfirmPopUps_CheckButton.tooltip = "When this is active you can confirm almost"..
  " any pop-ups (release, quests, stacks, etc) pressing the keys Ctrl + '"
  AbyssUILight_ConfirmPopUps_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionConfirmPopUps)
  addonTable.ConfirmPopUps = AbyssUILight_ConfirmPopUps_CheckButton
  -- OnClick Function
  AbyssUILight_ConfirmPopUps_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionConfirmPopUps = self:GetChecked()
  end)
  -- Hide in Combat --
  local AbyssUILight_HideInCombat_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_HideInCombat_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_HideInCombat_CheckButton:SetPoint("TOPLEFT", 400, -110)
  AbyssUILight_HideInCombat_CheckButton.Text:SetText("|cfff2dc7fDynamic ObjectiveTrack Hide|r")
  AbyssUILight_HideInCombat_CheckButton.tooltip = "Hide some parts of the interface when you"..
  " are in combat or in a PVP instance"
  AbyssUILight_HideInCombat_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionHideInCombat)
  addonTable.HideInCombat = AbyssUILight_HideInCombat_CheckButton
  -- OnClick Function
  AbyssUILight_HideInCombat_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionHideInCombat = self:GetChecked()
  end)
  -- Better Fonts --
  local AbyssUILight_BetterFonts_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_BetterFonts_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_BetterFonts_CheckButton:SetPoint("TOPLEFT", 400, -140)
  AbyssUILight_BetterFonts_CheckButton.Text:SetText("RPG chat fonts")
  AbyssUILight_BetterFonts_CheckButton.tooltip = "Change the chat fonts to a RPG look-alike style"
  AbyssUILight_BetterFonts_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionBetterFonts)
  -- OnClick Function
  AbyssUILight_BetterFonts_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionBetterFonts = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
  end)
  -- After Login/Reload
  AbyssUILight_BetterFonts_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUILight_BetterFonts_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUILightAddonSettings.ExtraFunctionBetterFonts == true ) then
         ChatFrame1:SetFont("Fonts\\MORPHEUS.TTF", 13)
         ChatFrame1.editBox.header:SetFont("Fonts\\MORPHEUS.TTF", 13)
      else 
        return nil
      end
    end
  end)
  -- Better WorldMap --
  local AbyssUILight_BetterWorldMap_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_BetterWorldMap_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_BetterWorldMap_CheckButton:SetPoint("TOPLEFT", 400, -170)
  AbyssUILight_BetterWorldMap_CheckButton.Text:SetText("Better World Map")
  AbyssUILight_BetterWorldMap_CheckButton.tooltip = "Makes the worldmap minimalist/clean"
  AbyssUILight_BetterWorldMap_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionBetterWorldMap)
  -- OnClick Function
  AbyssUILight_BetterWorldMap_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionBetterWorldMap = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- After Login/Reload
  AbyssUILight_BetterWorldMap_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUILight_BetterWorldMap_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUILightAddonSettings.ExtraFunctionBetterWorldMap == true ) then
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
  local AbyssUILight_WorldMapFade_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_WorldMapFade_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_WorldMapFade_CheckButton:SetPoint("TOPLEFT", 400, -200)
  AbyssUILight_WorldMapFade_CheckButton.Text:SetText("World Map Fader")
  AbyssUILight_WorldMapFade_CheckButton.tooltip = "Makes the worldmap fade while you move"
  AbyssUILight_WorldMapFade_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionWorldMapFade)
  -- OnClick Function
  AbyssUILight_WorldMapFade_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionWorldMapFade = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- After Login/Reload
  AbyssUILight_WorldMapFade_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  AbyssUILight_WorldMapFade_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if ( AbyssUILightAddonSettings.ExtraFunctionWorldMapFade == true ) then
        PlayerMovementFrameFader.AddDeferredFrame(WorldMapFrame, .60, 1.0, .60)
      end
    end
  end)
  -- Default Nameplate Range --
  local AbyssUILight_DefaultNameplate_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_DefaultNameplate_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_DefaultNameplate_CheckButton:SetPoint("TOPLEFT", 400, -230)
  AbyssUILight_DefaultNameplate_CheckButton.Text:SetText("Default Nameplate Range")
  AbyssUILight_DefaultNameplate_CheckButton.tooltip = "Disable the double range of"..
  " nameplates to Blizzard default value"
  AbyssUILight_DefaultNameplate_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionDefaultNameplate)
  -- OnClick Function
  AbyssUILight_DefaultNameplate_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionDefaultNameplate = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable Guild Name on Tooltip --
  local AbyssUILight_DisableGuildTooltip_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_HideBackgroundClassColor_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_DisableGuildTooltip_CheckButton:SetPoint("TOPLEFT", 400, -260)
  AbyssUILight_DisableGuildTooltip_CheckButton.Text:SetText("Disable Guild Tooltip")
  AbyssUILight_DisableGuildTooltip_CheckButton.tooltip = "Remove the guild name from tooltips"
  AbyssUILight_DisableGuildTooltip_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionDisableGuildTootip)
  -- OnClick Function
  AbyssUILight_DisableGuildTooltip_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionDisableGuildTootip = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Remove Background class color --
  local AbyssUILight_HideBackgroundClassColor_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_HideBackgroundClassColor_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_HideBackgroundClassColor_CheckButton:SetPoint("TOPLEFT", 400, -290)
  AbyssUILight_HideBackgroundClassColor_CheckButton.Text:SetText("Default Background")
  AbyssUILight_HideBackgroundClassColor_CheckButton.tooltip = "Remove the class color background behind"..
  " the player names to default values (Transparent Name needs to be unchecked)"
  AbyssUILight_HideBackgroundClassColor_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionHideBackgroundClassColor)
  -- OnClick Function
  AbyssUILight_HideBackgroundClassColor_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionHideBackgroundClassColor = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable Nameplate Changes --
  local AbyssUILight_NameplateChanges_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_NameplateChanges_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_NameplateChanges_CheckButton:SetPoint("TOPLEFT", 400, -320)
  AbyssUILight_NameplateChanges_CheckButton.Text:SetText("Disable Nameplate Changes")
  AbyssUILight_NameplateChanges_CheckButton.tooltip = "This option will remove any change that was made to the nameplates (the bar above mobs and players)"
  AbyssUILight_NameplateChanges_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionNameplateChanges)
  addonTable.NameplateChanges = AbyssUILight_NameplateChanges_CheckButton
  -- OnClick Function
  AbyssUILight_NameplateChanges_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionNameplateChanges = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable ChatBubble Changes --
  local AbyssUILight_ChatBubbleChanges_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_NameplateChanges_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_ChatBubbleChanges_CheckButton:SetPoint("TOPLEFT", 400, -350)
  AbyssUILight_ChatBubbleChanges_CheckButton.Text:SetText("|cff0d75d4Disable ChatBubble Changes|r")
  AbyssUILight_ChatBubbleChanges_CheckButton.tooltip = "This option will remove any change that was made to the chatbubbles (the frame text above players)"
  AbyssUILight_ChatBubbleChanges_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionChatBubbleChanges)
  addonTable.ChatBubbleChanges = AbyssUILight_ChatBubbleChanges_CheckButton
  -- OnClick Function
  AbyssUILight_ChatBubbleChanges_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionChatBubbleChanges = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable Damage Font --
  local AbyssUILight_DamageFont_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_DamageFont_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_DamageFont_CheckButton:SetPoint("TOPLEFT", 400, -380)
  AbyssUILight_DamageFont_CheckButton.Text:SetText("Disable Damage Font (*)")
  AbyssUILight_DamageFont_CheckButton.tooltip = "This option will remove any change to the damage font text."..
  "\n*You need to restart the game so the font can be reloaded. You can change it to any font, "..
  "go to Textures->font and replace the file keeping the same name"
  AbyssUILight_DamageFont_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionDamageFont)
  -- OnClick Function
  AbyssUILight_DamageFont_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionDamageFont = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable font white text --
  local AbyssUILight_FontWhiteText_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_FontWhiteText_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_FontWhiteText_CheckButton:SetPoint("TOPLEFT", 400, -410)
  AbyssUILight_FontWhiteText_CheckButton.Text:SetText("Disable Font White Text")
  AbyssUILight_FontWhiteText_CheckButton.tooltip = "Disable the font white text colorization"..
  "back to the default yellow font color"
  AbyssUILight_FontWhiteText_CheckButton:SetChecked(AbyssUILightAddonSettings.ExtraFunctionDisableFontWhiteText)
  -- OnClick Function
  AbyssUILight_FontWhiteText_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ExtraFunctionDisableFontWhiteText = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable character name color --
  local AbyssUILight_CharacterText_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILight_CharacterText_CheckButton", AbyssUILight_Config.childpanel3, "ChatConfigCheckButtonTemplate")
  AbyssUILight_CharacterText_CheckButton:SetPoint("TOPLEFT", 400, -440)
  AbyssUILight_CharacterText_CheckButton.Text:SetText("|cff0d75d4Default CharacterNameText|r")
  AbyssUILight_CharacterText_CheckButton.tooltip = "Disable the character name colorization"..
  "back to the default font color"
  AbyssUILight_CharacterText_CheckButton:SetChecked(AbyssUILightAddonSettings.DisableCharacterText)
  addonTable.DisableCharacterText = AbyssUILight_CharacterText_CheckButton
  -- OnClick Function
  AbyssUILight_CharacterText_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.DisableCharacterText = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
end
--End
local function TweaksExtra()
  ----------------------------------- Extras  -----------------------------------
  -- Read tooltip--
  local PSINFO_CheckButton = CreateFrame("Frame","$parentPSINFO_CheckButton", AbyssUILight_Config.childpanel5)
  PSINFO_CheckButton:SetPoint("BOTTOMLEFT", AbyssUILight_Config.childpanel5, "BOTTOMLEFT", 10, 10)
  PSINFO_CheckButton:SetHeight(24)
  PSINFO_CheckButton:SetWidth(200)
  PSINFO_CheckButton:SetScale(1)
  PSINFO_CheckButton = PSINFO_CheckButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  PSINFO_CheckButton:SetPoint("LEFT")
  PSINFO_CheckButton:SetText("The symbol (*) in some options means that there is important information/instructions to be read.\n"..
    "Options with a different color are recommended settings (based on your choice in the setup).")
  -- Keep UnitFrame Dark --
  local KeepUnitDark_CheckButton = CreateFrame("CheckButton", "$parentKeepUnitDark_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  KeepUnitDark_CheckButton:SetPoint("TOPLEFT", 10, -80)
  KeepUnitDark_CheckButton.Text:SetText("Keep UnitFrame Dark")
  KeepUnitDark_CheckButton.tooltip = "Even if you change theme, this will keep UnitFrame Dark"..
  " (Player Frame, Boss, etc)."
  KeepUnitDark_CheckButton:SetChecked(AbyssUILightAddonSettings.KeepUnitDark)
  -- OnClick Function
  KeepUnitDark_CheckButton:SetScript("OnClick", function(self)
   if AbyssUILightAddonSettings.KeepUnitBlizzard == true then
     KeepUnitDark_CheckButton:SetChecked(nil)
   else
     AbyssUILightAddonSettings.KeepUnitDark = self:GetChecked()
     AbyssUILight_ReloadFrame:Show()
   end
  end)
   -- After Login/Reload
  KeepUnitDark_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  KeepUnitDark_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.KeepUnitDark == true then
        AbyssUILightAddonSettings.KeepUnitDark = self:GetChecked()
      else
        KeepUnitDark_CheckButton:SetChecked(nil)
      end
    end
  end)
  -- Keep UnitFrame Blizzard Like --
  local KeepUnitBlizzard_CheckButton = CreateFrame("CheckButton", "$parentKeepUnitBlizzard_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  KeepUnitBlizzard_CheckButton:SetPoint("TOPLEFT", 10, -110)
  KeepUnitBlizzard_CheckButton.Text:SetText("Keep UnitFrame Blizzard Like")
  KeepUnitBlizzard_CheckButton.tooltip = "Even if you change theme, this will keep UnitFrame"..
  " Blizzard like (Player Frame, Boss, etc)."
  KeepUnitBlizzard_CheckButton:SetChecked(AbyssUILightAddonSettings.KeepUnitBlizzard)
  -- OnClick Function
  KeepUnitBlizzard_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.KeepUnitDark == true then
      KeepUnitBlizzard_CheckButton:SetChecked(nil)
    else
      AbyssUILightAddonSettings.KeepUnitBlizzard = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    end
  end)
  -- After Login/Reload
  KeepUnitBlizzard_CheckButton:RegisterEvent("PLAYER_ENTERING_WORLD")
  KeepUnitBlizzard_CheckButton:SetScript("OnEvent", function(self, event, ...)
    if ( event == "PLAYER_ENTERING_WORLD" ) then
      if AbyssUILightAddonSettings.KeepUnitBlizzard == true then
        AbyssUILightAddonSettings.KeepUnitBlizzard = self:GetChecked()
      else
        KeepUnitBlizzard_CheckButton:SetChecked(nil)
      end
    end
  end)
  -- Fade UI --
  local FadeUI_CheckButton = CreateFrame("CheckButton", "$parentFadeUI_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  FadeUI_CheckButton:SetPoint("TOPLEFT", 10, -140)
  FadeUI_CheckButton.Text:SetText("Fade UI")
  FadeUI_CheckButton.tooltip = "Fade the UI when you are out of combat ('ATL-CTRL-P' to show frames)"
  FadeUI_CheckButton:SetChecked(AbyssUILightAddonSettings.FadeUI)
  -- OnClick Function
  FadeUI_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.FadeUI = self:GetChecked()
    AbyssUILight_ReloadFrameFadeUI:Show()
  end)
  -- Disable Square Minimap --
  local DisableSquareMinimap_CheckButton = CreateFrame("CheckButton", "$parentUnitFrameImproved_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  DisableSquareMinimap_CheckButton:SetPoint("TOPLEFT", 10, -170)
  DisableSquareMinimap_CheckButton.Text:SetText("|cff0d75d4Disable Square Minimap|r")
  DisableSquareMinimap_CheckButton.tooltip = "This option will get you back to the"..
  " Blizzard default minimap style (round). *You need to restart the game so round textures can be re-loaded"
  DisableSquareMinimap_CheckButton:SetChecked(AbyssUILightAddonSettings.DisableSquareMinimap)
  addonTable.DisableSquareMinimap = DisableSquareMinimap_CheckButton
  -- OnClick Function
  DisableSquareMinimap_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.DisableSquareMinimap = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Minimal ActionBar --
  local MinimalActionBar_CheckButton = CreateFrame("CheckButton", "$parentMinimalActionBar_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  MinimalActionBar_CheckButton:SetPoint("TOPLEFT", 10, -200)
  MinimalActionBar_CheckButton.Text:SetText("Minimal ActionBar")
  MinimalActionBar_CheckButton.tooltip = "Minimalist actionbar, hide all the textures"
  MinimalActionBar_CheckButton:SetChecked(AbyssUILightAddonSettings.MinimalActionBar)
  -- OnClick Function
  MinimalActionBar_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.MinimalActionBar = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable UnitFrame Smoke --
  local DisableUnitFrameSmoke_CheckButton = CreateFrame("CheckButton", "$parentDisableUnitFrameSmoke_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  DisableUnitFrameSmoke_CheckButton:SetPoint("TOPLEFT", 10, -230)
  DisableUnitFrameSmoke_CheckButton.Text:SetText("|cff0d75d4Disable Smoke Texture|r")
  DisableUnitFrameSmoke_CheckButton.tooltip = "It will disable the 'smoke' texture around the portrait in "..
  "the UnitFrame Improved version of it"
  DisableUnitFrameSmoke_CheckButton:SetChecked(AbyssUILightAddonSettings.UnitFrameImprovedDefaultTexture)
  addonTable.DisableUnitFrameSmoke = DisableUnitFrameSmoke_CheckButton
  -- OnClick Function
  DisableUnitFrameSmoke_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.UnitFrameImprovedDefaultTexture = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Disable Kill Announcer --
  local KillAnnouncer_CheckButton = CreateFrame("CheckButton", "$parentKillAnnouncer_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  KillAnnouncer_CheckButton:SetPoint("TOPLEFT", 10, -260)
  KillAnnouncer_CheckButton.Text:SetText("Disable Kill Announcer")
  KillAnnouncer_CheckButton.tooltip = "Disable the Kill Announcer frame that show up when you kill someone"
  KillAnnouncer_CheckButton:SetChecked(AbyssUILightAddonSettings.DisableKillAnnouncer)
  -- OnClick Function
  KillAnnouncer_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.DisableKillAnnouncer = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- Silence Kill Announcer --
  local SilenceKillAnnouncer_CheckButton = CreateFrame("CheckButton", "$parentSilenceKillAnnouncer_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  SilenceKillAnnouncer_CheckButton:SetPoint("TOPLEFT", 10, -290)
  SilenceKillAnnouncer_CheckButton.Text:SetText("Silence Kill Announcer")
  SilenceKillAnnouncer_CheckButton.tooltip = "Remove boss/kill sounds from the Kill Announcer frame"
  SilenceKillAnnouncer_CheckButton:SetChecked(AbyssUILightAddonSettings.SilenceKillAnnouncer)
  -- OnClick Function
  SilenceKillAnnouncer_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.SilenceKillAnnouncer = self:GetChecked()
  end)
  -- TooltipOnCursor --
  local TooltipOnCursor_CheckButton = CreateFrame("CheckButton", "$parentTooltipOnCursor_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  TooltipOnCursor_CheckButton:SetPoint("TOPLEFT", 10, -320)
  TooltipOnCursor_CheckButton.Text:SetText("|cfff2dc7fTooltip on Cursor|r")
  TooltipOnCursor_CheckButton.tooltip = "Tooltips will appear close to the mouse cursor position"
  TooltipOnCursor_CheckButton:SetChecked(AbyssUILightAddonSettings.TooltipOnCursor)
  addonTable.TooltipOnCursor = TooltipOnCursor_CheckButton
  -- OnClick Function
  TooltipOnCursor_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.TooltipOnCursor = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- AlwaysShowClock --
  local AlwaysShowClock_CheckButton = CreateFrame("CheckButton", "$parentAlwaysShowClock_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  AlwaysShowClock_CheckButton:SetPoint("TOPLEFT", 10, -350)
  AlwaysShowClock_CheckButton.Text:SetText("Always Show Clock")
  AlwaysShowClock_CheckButton.tooltip = "Minimap clock will always show"
  AlwaysShowClock_CheckButton:SetChecked(AbyssUILightAddonSettings.AlwaysShowClock)
  -- OnClick Function
  AlwaysShowClock_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.AlwaysShowClock = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  --- Frames ---
  -- Elite Portrait --
  local ElitePortrait_CheckButton = CreateFrame("CheckButton", "$parentElitePortrait_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  ElitePortrait_CheckButton:SetPoint("TOPLEFT", 400, -80)
  ElitePortrait_CheckButton.Text:SetText("|cfff2dc7fElite Portrait|r")
  ElitePortrait_CheckButton.tooltip = "Add a elite texture to the portraits (high recommended the use of this option with portrait class icons)"
  ElitePortrait_CheckButton:SetChecked(AbyssUILightAddonSettings.ElitePortrait)
  addonTable.ElitePortrait = ElitePortrait_CheckButton
  -- OnClick Function
  ElitePortrait_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.ElitePortrait = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
  -- UnitFrame Improved --
  local UnitFrameImproved_CheckButton = CreateFrame("CheckButton", "$parentUnitFrameImproved_CheckButton", AbyssUILight_Config.childpanel5, "ChatConfigCheckButtonTemplate")
  UnitFrameImproved_CheckButton:SetPoint("TOPLEFT", 400, -110)
  UnitFrameImproved_CheckButton.Text:SetText("|cfff2dc7fUnitFrame Improved|r")
  UnitFrameImproved_CheckButton.tooltip = "This is a improved version of unitframes,"..
  " it changes those frames to a more beautiful and complete version (recommended use)"
  UnitFrameImproved_CheckButton:SetChecked(AbyssUILightAddonSettings.UnitFrameImproved)
  addonTable.UnitFrameImproved = UnitFrameImproved_CheckButton
  -- OnClick Function
  UnitFrameImproved_CheckButton:SetScript("OnClick", function(self)
    AbyssUILightAddonSettings.UnitFrameImproved = self:GetChecked()
    AbyssUILight_ReloadFrame:Show()
  end)
end
--End
local function Stylization()
  ----------------------------- AbyssUILight Stylization ------------------------------
  -- Player Portrait Style --
  -- AbyssUILightClassCircles01_CheckButton
  local AbyssUILightClassCircles01_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles01_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles01_CheckButton:SetPoint("TOPLEFT", 10, -80)
  AbyssUILightClassCircles01_CheckButton.Text:SetText("Artistic")
  AbyssUILightClassCircles01_CheckButton.tooltip = "A artistic version of UnitPlayerFrame"
  AbyssUILightClassCircles01_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles01)
  -- OnClick Function
  AbyssUILightClassCircles01_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles01 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles01_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles02_CheckButton
  local AbyssUILightClassCircles02_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles02_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles02_CheckButton:SetPoint("TOPLEFT", 10, -110)
  AbyssUILightClassCircles02_CheckButton.Text:SetText("Bright")
  AbyssUILightClassCircles02_CheckButton.tooltip = "A bright version of UnitPlayerFrame"
  AbyssUILightClassCircles02_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles02)
  -- OnClick Function
  AbyssUILightClassCircles02_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles02 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles02_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles03_CheckButton
  local AbyssUILightClassCircles03_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles03_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles03_CheckButton:SetPoint("TOPLEFT", 10, -140)
  AbyssUILightClassCircles03_CheckButton.Text:SetText("Classic")
  AbyssUILightClassCircles03_CheckButton.tooltip = "A classic version of UnitPlayerFrame"
  AbyssUILightClassCircles03_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles03)
  -- OnClick Function
  AbyssUILightClassCircles03_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles03 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles03_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles04_CheckButton
  local AbyssUILightClassCircles04_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles04_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles04_CheckButton:SetPoint("TOPLEFT", 10, -170)
  AbyssUILightClassCircles04_CheckButton.Text:SetText("Artistic_V2")
  AbyssUILightClassCircles04_CheckButton.tooltip = "Version two of artistic UnitPlayerFrame"
  AbyssUILightClassCircles04_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles04)
  -- OnClick Function
  AbyssUILightClassCircles04_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles04 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles04_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles05_CheckButton
  local AbyssUILightClassCircles05_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles05_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles05_CheckButton:SetPoint("TOPLEFT", 180 , -80)
  AbyssUILightClassCircles05_CheckButton.Text:SetText("Dark")
  AbyssUILightClassCircles05_CheckButton.tooltip = "A dark version of UnitPlayerFrame"
  AbyssUILightClassCircles05_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles05)
  -- OnClick Function
  AbyssUILightClassCircles05_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles05 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles05_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles06_CheckButton
  local AbyssUILightClassCircles06_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles06_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles06_CheckButton:SetPoint("TOPLEFT", 180, -110)
  AbyssUILightClassCircles06_CheckButton.Text:SetText("Dark_Gray")
  AbyssUILightClassCircles06_CheckButton.tooltip = "A dark gray version of UnitPlayerFrame"
  AbyssUILightClassCircles06_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles06)
  -- OnClick Function
  AbyssUILightClassCircles06_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles06 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles06_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles07_CheckButton
  local AbyssUILightClassCircles07_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles07_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles07_CheckButton:SetPoint("TOPLEFT", 180, -140)
  AbyssUILightClassCircles07_CheckButton.Text:SetText("Dark_V2")
  AbyssUILightClassCircles07_CheckButton.tooltip = "Version 2 of the dark UnitPlayerFrame"
  AbyssUILightClassCircles07_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles07)
  -- OnClick Function
  AbyssUILightClassCircles07_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles07 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles07_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles08_CheckButton
  local AbyssUILightClassCircles08_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles08_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles08_CheckButton:SetPoint("TOPLEFT", 180, -170)
  AbyssUILightClassCircles08_CheckButton.Text:SetText("Grayscale")
  AbyssUILightClassCircles08_CheckButton.tooltip = "A grayscale version of UnitPlayerFrame"
  AbyssUILightClassCircles08_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles08)
  -- OnClick Function
  AbyssUILightClassCircles08_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles08 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles08_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles09_CheckButton
  local AbyssUILightClassCircles09_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles09_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles09_CheckButton:SetPoint("TOPLEFT", 10, -200)
  AbyssUILightClassCircles09_CheckButton.Text:SetText("Light_Gray")
  AbyssUILightClassCircles09_CheckButton.tooltip = "A light gray version of UnitPlayerFrame"
  AbyssUILightClassCircles09_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles09)
  -- OnClick Function
  AbyssUILightClassCircles09_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles09 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles09_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles10_CheckButton
  local AbyssUILightClassCircles10_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles10_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles10_CheckButton:SetPoint("TOPLEFT", 180, -200)
  AbyssUILightClassCircles10_CheckButton.Text:SetText("Medium_Gray")
  AbyssUILightClassCircles10_CheckButton.tooltip = "A medium gray version of UnitPlayerFrame"
  AbyssUILightClassCircles10_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles10)
  -- OnClick Function
  AbyssUILightClassCircles10_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles10 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles10_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles11_CheckButton
  local AbyssUILightClassCircles11_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles11_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles11_CheckButton:SetPoint("TOPLEFT", 10, -230)
  AbyssUILightClassCircles11_CheckButton.Text:SetText("Minimal_Blue")
  AbyssUILightClassCircles11_CheckButton.tooltip = "A blue version of UnitPlayerFrame"
  AbyssUILightClassCircles11_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles11)
  -- OnClick Function
  AbyssUILightClassCircles11_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles11 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles11_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles12_CheckButton
  local AbyssUILightClassCircles12_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles12_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles12_CheckButton:SetPoint("TOPLEFT", 180, -230)
  AbyssUILightClassCircles12_CheckButton.Text:SetText("Minimal_Red")
  AbyssUILightClassCircles12_CheckButton.tooltip = "A red version of UnitPlayerFrame"
  AbyssUILightClassCircles12_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles12)
  -- OnClick Function
  AbyssUILightClassCircles12_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles12 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles12_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles13_CheckButton
  local AbyssUILightClassCircles13_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles13_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles13_CheckButton:SetPoint("TOPLEFT", 10, -260)
  AbyssUILightClassCircles13_CheckButton.Text:SetText("Muted")
  AbyssUILightClassCircles13_CheckButton.tooltip = "A muted version of UnitPlayerFrame"
  AbyssUILightClassCircles13_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles13)
  -- OnClick Function
  AbyssUILightClassCircles13_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles13 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles13_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles14_CheckButton
  local AbyssUILightClassCircles14_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles14_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles14_CheckButton:SetPoint("TOPLEFT", 180, -260)
  AbyssUILightClassCircles14_CheckButton.Text:SetText("Psychedelic")
  AbyssUILightClassCircles14_CheckButton.tooltip = "A psychedelic version of UnitPlayerFrame"
  AbyssUILightClassCircles14_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles14)
  -- OnClick Function
  AbyssUILightClassCircles14_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles14 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles14_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles15_CheckButton
  local AbyssUILightClassCircles15_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles14_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles15_CheckButton:SetPoint("TOPLEFT", 10, -290)
  AbyssUILightClassCircles15_CheckButton.Text:SetText("Retro")
  AbyssUILightClassCircles15_CheckButton.tooltip = "A retrowave version of UnitPlayerFrame"
  AbyssUILightClassCircles15_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles15)
  -- OnClick Function
  AbyssUILightClassCircles15_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles16 ~= true then
      AbyssUILightAddonSettings.UIClassCircles15 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles15_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightClassCircles16_CheckButton
  local AbyssUILightClassCircles16_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightClassCircles14_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightClassCircles16_CheckButton:SetPoint("TOPLEFT", 180, -290)
  AbyssUILightClassCircles16_CheckButton.Text:SetText("Vibrant")
  AbyssUILightClassCircles16_CheckButton.tooltip = "A vibrant version of UnitPlayerFrame"
  AbyssUILightClassCircles16_CheckButton:SetChecked(AbyssUILightAddonSettings.UIClassCircles16)
  -- OnClick Function
  AbyssUILightClassCircles16_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIClassCircles01 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles02 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles03 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles04 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles05 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles06 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles07 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles08 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles09 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles10 ~= true and 
       AbyssUILightAddonSettings.UIClassCircles11 ~= true and
       AbyssUILightAddonSettings.UIClassCircles12 ~= true and
       AbyssUILightAddonSettings.UIClassCircles13 ~= true and
       AbyssUILightAddonSettings.UIClassCircles14 ~= true and
       AbyssUILightAddonSettings.UIClassCircles15 ~= true then
      AbyssUILightAddonSettings.UIClassCircles16 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightClassCircles16_CheckButton:SetChecked(nil)
    end
  end)
  -- Frame Colorization --
  -- AbyssUILightVertexColorFrames01_CheckButton
  local AbyssUILightVertexColorFrames01_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames01_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames01_CheckButton:SetPoint("TOPRIGHT", -250, -80)
  AbyssUILightVertexColorFrames01_CheckButton.Text:SetText("|cffc0c0c0Blizzard (Default)|r")
  AbyssUILightVertexColorFrames01_CheckButton.tooltip = "Blizzard Silver Colorization for Frames"
  AbyssUILightVertexColorFrames01_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames01)
  -- OnClick Function
  AbyssUILightVertexColorFrames01_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames01 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames01_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames02_CheckButton
  local AbyssUILightVertexColorFrames02_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames02_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames02_CheckButton:SetPoint("TOPRIGHT", -80, -80)
  AbyssUILightVertexColorFrames02_CheckButton.Text:SetText("|cff636363Blackout|r")
  AbyssUILightVertexColorFrames02_CheckButton.tooltip = "A completely Dark Frame Colorization"
  AbyssUILightVertexColorFrames02_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames02)
  -- OnClick Function
  AbyssUILightVertexColorFrames02_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames02 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames02_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames03_CheckButton
  local AbyssUILightVertexColorFrames03_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames03_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames03_CheckButton:SetPoint("TOPRIGHT", -250, -110)
  AbyssUILightVertexColorFrames03_CheckButton.Text:SetText("|cffb62a25Blood|r")
  AbyssUILightVertexColorFrames03_CheckButton.tooltip = "A Dark Red Frame Colorization"
  AbyssUILightVertexColorFrames03_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames03)
  -- OnClick Function
  AbyssUILightVertexColorFrames03_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames03 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames03_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames04_CheckButton
  local AbyssUILightVertexColorFrames04_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames04_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames04_CheckButton:SetPoint("TOPRIGHT", -80, -110)
  AbyssUILightVertexColorFrames04_CheckButton.Text:SetText("|cffecc13cGold|r")
  AbyssUILightVertexColorFrames04_CheckButton.tooltip = "A Golden Frame Colorization"
  AbyssUILightVertexColorFrames04_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames04)
  -- OnClick Function
  AbyssUILightVertexColorFrames04_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames04 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames04_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames05_CheckButton
  local AbyssUILightVertexColorFrames05_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames05_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames05_CheckButton:SetPoint("TOPRIGHT", -250, -140)
  AbyssUILightVertexColorFrames05_CheckButton.Text:SetText("|cffc41F3BDeath Knight|r")
  AbyssUILightVertexColorFrames05_CheckButton.tooltip = "DK Class Frame Colorization"
  AbyssUILightVertexColorFrames05_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames05)
  -- OnClick Function
  AbyssUILightVertexColorFrames05_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames05 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames05_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames06_CheckButton
  local AbyssUILightVertexColorFrames06_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames06_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames06_CheckButton:SetPoint("TOPRIGHT", -80, -140)
  AbyssUILightVertexColorFrames06_CheckButton.Text:SetText("|cffA330C9Demon\nHunter|r")
  AbyssUILightVertexColorFrames06_CheckButton.tooltip = "DH Class Frame Colorization"
  AbyssUILightVertexColorFrames06_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames06)
  -- OnClick Function
  AbyssUILightVertexColorFrames06_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames06 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames06_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames07_CheckButton
  local AbyssUILightVertexColorFrames07_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames07_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames07_CheckButton:SetPoint("TOPRIGHT", -250, -170)
  AbyssUILightVertexColorFrames07_CheckButton.Text:SetText("|cffFF7D0ADruid|r")
  AbyssUILightVertexColorFrames07_CheckButton.tooltip = "Druid Class Frame Colorization"
  AbyssUILightVertexColorFrames07_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames07)
  -- OnClick Function
  AbyssUILightVertexColorFrames07_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames07 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames07_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames08_CheckButton
  local AbyssUILightVertexColorFrames08_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames08_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames08_CheckButton:SetPoint("TOPRIGHT", -80, -170)
  AbyssUILightVertexColorFrames08_CheckButton.Text:SetText("|cffABD473Hunter|r")
  AbyssUILightVertexColorFrames08_CheckButton.tooltip = "Hunter Class Frame Colorization"
  AbyssUILightVertexColorFrames08_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames08)
  -- OnClick Function
  AbyssUILightVertexColorFrames08_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames08 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames08_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames09_CheckButton
  local AbyssUILightVertexColorFrames09_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames09_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames09_CheckButton:SetPoint("TOPRIGHT", -250, -200)
  AbyssUILightVertexColorFrames09_CheckButton.Text:SetText("|cff69CCF0Mage|r")
  AbyssUILightVertexColorFrames09_CheckButton.tooltip = "Mage Class Frame Colorization"
  AbyssUILightVertexColorFrames09_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames09)
  -- OnClick Function
  AbyssUILightVertexColorFrames09_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames09 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames09_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames10_CheckButton
  local AbyssUILightVertexColorFrames10_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames10_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames10_CheckButton:SetPoint("TOPRIGHT", -80, -200)
  AbyssUILightVertexColorFrames10_CheckButton.Text:SetText("|cff00FF96Monk|r")
  AbyssUILightVertexColorFrames10_CheckButton.tooltip = "Monk Class Frame Colorization"
  AbyssUILightVertexColorFrames10_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames10)
  -- OnClick Function
  AbyssUILightVertexColorFrames10_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames10 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames10_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames11_CheckButton
  local AbyssUILightVertexColorFrames11_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames11_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames11_CheckButton:SetPoint("TOPRIGHT", -250, -230)
  AbyssUILightVertexColorFrames11_CheckButton.Text:SetText("|cffF58CBAPaladin|r")
  AbyssUILightVertexColorFrames11_CheckButton.tooltip = "Paladin Class Frame Colorization"
  AbyssUILightVertexColorFrames11_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames11)
  -- OnClick Function
  AbyssUILightVertexColorFrames11_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames11 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames11_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames12_CheckButton
  local AbyssUILightVertexColorFrames12_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames12_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames12_CheckButton:SetPoint("TOPRIGHT", -80, -230)
  AbyssUILightVertexColorFrames12_CheckButton.Text:SetText("Priest")
  AbyssUILightVertexColorFrames12_CheckButton.tooltip = "Priest Class Frame Colorization (Shadow Priest)"
  AbyssUILightVertexColorFrames12_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames12)
  -- OnClick Function
  AbyssUILightVertexColorFrames12_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames12 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames12_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames13_CheckButton
  local AbyssUILightVertexColorFrames13_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames13_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames13_CheckButton:SetPoint("TOPRIGHT", -250, -260)
  AbyssUILightVertexColorFrames13_CheckButton.Text:SetText("|cffFFF569Rogue|r")
  AbyssUILightVertexColorFrames13_CheckButton.tooltip = "Rogue Class Frame Colorization"
  AbyssUILightVertexColorFrames13_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames13)
  -- OnClick Function
  AbyssUILightVertexColorFrames13_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames13 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames13_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames14_CheckButton
  local AbyssUILightVertexColorFrames14_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames14_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames14_CheckButton:SetPoint("TOPRIGHT", -80, -260)
  AbyssUILightVertexColorFrames14_CheckButton.Text:SetText("|cff0070DEShaman|r")
  AbyssUILightVertexColorFrames14_CheckButton.tooltip = "Shaman Class Frame Colorization"
  AbyssUILightVertexColorFrames14_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames14)
  -- OnClick Function
  AbyssUILightVertexColorFrames14_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames14 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames14_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames15_CheckButton
  local AbyssUILightVertexColorFrames15_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames15_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames15_CheckButton:SetPoint("TOPRIGHT", -250, -290)
  AbyssUILightVertexColorFrames15_CheckButton.Text:SetText("|cff9482C9Warlock|r")
  AbyssUILightVertexColorFrames15_CheckButton.tooltip = "Warlock Class Frame Colorization"
  AbyssUILightVertexColorFrames15_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames15)
  -- OnClick Function
  AbyssUILightVertexColorFrames15_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames15 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames15_CheckButton:SetChecked(nil)
    end
  end)
  -- AbyssUILightVertexColorFrames16_CheckButton
  local AbyssUILightVertexColorFrames16_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFrames16_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFrames16_CheckButton:SetPoint("TOPRIGHT", -80, -290)
  AbyssUILightVertexColorFrames16_CheckButton.Text:SetText("|cffC79C6EWarrior|r")
  AbyssUILightVertexColorFrames16_CheckButton.tooltip = "Warrior Class Frame Colorization"
  AbyssUILightVertexColorFrames16_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFrames16)
  -- OnClick Function
  AbyssUILightVertexColorFrames16_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFramesColorPicker ~= true then
      AbyssUILightAddonSettings.UIVertexColorFrames16 = self:GetChecked()
      AbyssUILight_ReloadFrame:Show()
    else
      AbyssUILightVertexColorFrames16_CheckButton:SetChecked(nil)
    end
  end)
  -- Choose a Color (Color Picker)
  local AbyssUILightVertexColorFramesColorPicker_Button = CreateFrame("Button", "$parentAbyssUILightVertexColorFramesColorPicker_Button", AbyssUILight_Config.childpanel4, "UIPanelButtonTemplate")
  AbyssUILightVertexColorFramesColorPicker_Button:SetPoint("TOPRIGHT", -150, -350)
  AbyssUILightVertexColorFramesColorPicker_Button:SetHeight(30)
  AbyssUILightVertexColorFramesColorPicker_Button:SetWidth(120)
  AbyssUILightVertexColorFramesColorPicker_Button.text = AbyssUILightVertexColorFramesColorPicker_Button.text or AbyssUILightVertexColorFramesColorPicker_Button:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
  AbyssUILightVertexColorFramesColorPicker_Button.text:SetFont(globalFont, 12)
  AbyssUILightVertexColorFramesColorPicker_Button.text:SetPoint("CENTER", AbyssUILightVertexColorFramesColorPicker_Button, "CENTER", 0, 0)
  AbyssUILightVertexColorFramesColorPicker_Button.text:SetText(colorString)
  AbyssUILightVertexColorFramesColorPicker_Button.text:SetTextColor(229/255, 229/255, 229/255)
  AbyssUILightVertexColorFramesColorPicker_Button.text:SetShadowColor(0, 0, 0)
  AbyssUILightVertexColorFramesColorPicker_Button.text:SetShadowOffset(1, -1)
  -- OnClick Function
  AbyssUILightVertexColorFramesColorPicker_Button:SetScript("OnClick", function(self)
    AbyssUILight_ShowColorPicker()
  end)
  -- Apply Color
  local AbyssUILightVertexColorFramesColorPicker_CheckButton = CreateFrame("CheckButton", "$parentAbyssUILightVertexColorFramesColorPicker_CheckButton", AbyssUILight_Config.childpanel4, "ChatConfigCheckButtonTemplate")
  AbyssUILightVertexColorFramesColorPicker_CheckButton:SetPoint("CENTER", 200, -70)
  AbyssUILightVertexColorFramesColorPicker_CheckButton.Text:SetText(applyString.." "..colorColorString)
  local character = UnitName("player").."-"..GetRealmName()
  AbyssUILightVertexColorFramesColorPicker_CheckButton.Text:SetTextColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)
  AbyssUILightVertexColorFramesColorPicker_CheckButton.tooltip = "Apply the color you choose from the ColorPicker"
  AbyssUILightVertexColorFramesColorPicker_CheckButton:SetChecked(AbyssUILightAddonSettings.UIVertexColorFramesColorPicker)
  -- OnClick Function
  AbyssUILightVertexColorFramesColorPicker_CheckButton:SetScript("OnClick", function(self)
    if AbyssUILightAddonSettings.UIVertexColorFrames01 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames02 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames03 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames04 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames05 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames06 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames07 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames08 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames09 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames10 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames11 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames12 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames13 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames14 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames15 ~= true and
    AbyssUILightAddonSettings.UIVertexColorFrames16 ~= true then
      AbyssUILightAddonSettings.UIVertexColorFramesColorPicker = self:GetChecked()
      if ( AbyssUILightAddonSettings.UIVertexColorFramesColorPicker == true ) then
        AbyssUILightVertexColorFramesColorPicker_CheckButton.Text:SetTextColor(COLOR_MY_UI[character].Color.r, COLOR_MY_UI[character].Color.g, COLOR_MY_UI[character].Color.b)
        ReloadUI()
      end
    else
      AbyssUILightVertexColorFramesColorPicker_CheckButton:SetChecked(nil)
    end
  end)
end
-- End
--------------------------------- Save ---------------------------------
--This starts things off and once we're far enough into the game
--to check our SavedVariables and initialises if required
local f = CreateFrame("Frame", "AbyssUILight_Config", UIParent)
f:SetSize(50, 50)
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event, ...)
  if not AbyssUILightAddonSettings then
    AbyssUILightAddonSettings = {}
  end
  -- Now we have SavedVarialbe loaded, create the interface options frame
  InitSettings()
  HideElementsInit()
  Miscellaneous()
  TweaksExtra()
  Stylization()
end)
----------------------------------------------------
-- End
