  --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
  --						Release 1							  --
  -- 						06.04.2011							  --
  -- 				 Protonova of Rexxar - US					  --
  --															  --
  --   This is a LibDataBroker that displays healer relevant 	  --
  --   stats such as:										 	  --
  --   Spell Power			Spell Crit				Spell Hit	  --
  --   Spell Healing		Spell Haste						  	  --
  --   Mp5					Spirit					Mastery		  --
  --															  --
  --   Original Concept derived from Broker_StatsNow by		  --
  --   WNxSajuukCor.											  --
  -- Credits: The "window" icons are from GoSquared. They're public domain, and this credit isn't
	-- necessary; it's just a courtesy:
	-- http://www.gosquared.com/liquidicity/archives/314
  --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

--[[ Local Vars ]]
local icon = [=[Interface\AddOns\Broker_meekaScrModes\Media\MSMIcon3.tga]=]		-- Windowed Mode
local icon2 = [=[Interface\AddOns\Broker_meekaScrModes\Media\MSMIcon1.tga]=]	-- FullScreen
local icon3 = [=[Interface\AddOns\Broker_meekaScrModes\Media\MSMIcon2.tga]=]	-- Windowed FullScreen
local shown
  
--[[ Load Libraries ]]
local dataobj = LibStub("LibDataBroker-1.1"):NewDataObject("meekaScrModes", {
icon = icon,
label = "",
text = "Loading...",
type = "launcher"})

--[[ Create Frame ]]
local Screen_Mode = CreateFrame("frame")

--[[ Define Window Modes ]]
Screen_Mode:SetScript("OnUpdate", function(self, elap)
	if GetCVarBool("gxWindow") and not GetCVarBool("gxMaximize") then
		dataobj.icon = icon
		dataobj.text = "|cff0070deWindowed|r Mode"
	elseif not GetCVarBool("gxWindow") and not GetCVarBool("gxMaximize") then
		dataobj.icon = icon2
		dataobj.text = "|cff0070deFullScreen|r Mode"
	elseif GetCVarBool("gxWindow") and GetCVarBool("gxMaximize") then
		dataobj.icon = icon3
		dataobj.text = "|cff0070deWindowed FullScreen|r Mode"
	end
end)

--[[ Define Clicks ]]
function dataobj.OnClick(self, button)
	if button == "LeftButton" then
		SetCVar("gxWindow", "1")
		SetCVar("gxMaximize", "0")
		RestartGx()
	elseif button == "MiddleButton" then
		SetCVar("gxWindow", "1")
		SetCVar("gxMaximize", "1")
		RestartGx()
	elseif button == "RightButton" then
		SetCVar("gxWindow", "0")
		SetCVar("gxMaximize", "0")
		RestartGx()
	elseif IsAltKeyDown() then
		RestartGx()
	end
end

--[[ Create Tooltip ]]
function dataobj.OnTooltipShow(tooltip)
	tooltip:AddLine("meekaScrModes")
	tooltip:AddLine(" ")
	tooltip:AddDoubleLine("|cff69b950Left-Click:|r", "|cffeeeeeeWindowed Mode|r")
	tooltip:AddDoubleLine("|cff69b950Middle-Click:|r", "|cffeeeeeeWindowed FullScreen|r")
	tooltip:AddDoubleLine("|cff69b950Right-Click:|r", "|cffeeeeeeFullScreen Mode|r")
	tooltip:AddDoubleLine("|cff69b950Alt-Click:|r", "|cffeeeeee Restart Gfx|r")
end