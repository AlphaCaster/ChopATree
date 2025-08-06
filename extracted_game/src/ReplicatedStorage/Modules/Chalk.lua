-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local fontTags = {
	FONT_COLOR_RGB = {
		Start = "<font color=\"rgb(%s,%s,%s)\">", 
		End = "</font>"
	}, 
	FONT_COLOR_HEX = {
		Start = "<font color=\"#%s\">", 
		End = "</font>"
	}, 
	FONT_SIZE = {
		Start = "<font size=\"%d\">", 
		End = "</font>"
	}, 
	FONT_FACE = {
		Start = "<font face=\"%s\">", 
		End = "</font>"
	}, 
	FONT_FAMILY = {
		Start = "<font family=\"%s\">", 
		End = "</font>"
	}, 
	FONT_WEIGHT = {
		Start = "<font weight=\"%s\">", 
		End = "</font>"
	}, 
	FONT_TRANSPARENCY = {
		Start = "<font transparency=\"%s\">", 
		End = "</font>"
	}, 
	STROKE = {
		Start = "<stroke color=\"#%s\" joins=\"%s\" thickness=\"%s\" transparency=\"%s\">", 
		End = "</stroke>"
	}, 
	BOLD = {
		Start = "<b>", 
		End = "</b>"
	}, 
	ITALIC = {
		Start = "<i>", 
		End = "</i>"
	}, 
	UNDERLINE = {
		Start = "<u>", 
		End = "</u>"
	}, 
	STRIKETHROUGH = {
		Start = "<s>", 
		End = "</s>"
	}, 
	UPPERCASE = {
		Start = "<uppercase>", 
		End = "</uppercase>"
	}, 
	SMALLCAPS = {
		Start = "<smallcaps>", 
		End = "</smallcaps>"
	}
};
local stringFormatters = {};
local richTextFormatter = {};
richTextFormatter.__index = richTextFormatter;
local function _(formatIndex) --[[ Line: 92 ]] --[[ Name: GenerateCustomHandlerFunction ]]
	-- upvalues: v0 (copy)
	return function(startValue) --[[ Line: 93 ]]
		-- upvalues: v0 (ref), v3 (copy)
		local formattedStartTag = fontTags[formatIndex].Start:format(startValue);
		return function(endValue) --[[ Line: 96 ]]
			-- upvalues: v5 (copy), v0 (ref), v3 (ref)
			return (("%*%*%*"):format(formattedStartTag, endValue, fontTags[formatIndex].End));
		end;
	end;
end;
local function _(dataIndex) --[[ Line: 102 ]] --[[ Name: GenerateChalkDataFunction ]]
	-- upvalues: v0 (copy)
	return function(endValue) --[[ Line: 103 ]]
		-- upvalues: v0 (ref), v8 (copy)
		local fontTagData = fontTags[dataIndex];
		return (("%*%*%*"):format(fontTagData.Start, endValue, fontTagData.End));
	end;
end;
local function _(color) --[[ Line: 109 ]] --[[ Name: GenerateColorFunction ]]
	-- upvalues: v0 (copy)
	return function(fontColorRGBEnd) --[[ Line: 110 ]]
		-- upvalues: v12 (copy), v0 (ref)
		local redValue = math.floor(color.r * 255);
		local greenValue = math.floor(color.g * 255);
		local blueValue = math.floor(color.b * 255);
		return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue, greenValue, blueValue), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
	end;
end;
local function _(hexColorString) --[[ Line: 121 ]] --[[ Name: ValidateHex ]]
	if typeof(hexColorString) ~= "string" then
		return;
	else
		hexColorString = hexColorString:gsub("#", "");
		return string.match(hexColorString, "^%x%x%x%x%x%x$");
	end;
end;
local textFormatters = {};
local fontStyle = "FONT_SIZE";
local fontSizeStyle = fontStyle --[[ copy: 9 -> 10 ]];
textFormatters.size = function(startValue0) --[[ Line: 93 ]]
	-- upvalues: v0 (copy), l_v21_0 (copy)
	local formattedFontSizeStartTag = fontTags[fontSizeStyle].Start:format(startValue0);
	return function(endValue0) --[[ Line: 96 ]]
		-- upvalues: v24 (copy), v0 (ref), l_v21_0 (ref)
		return (("%*%*%*"):format(formattedFontSizeStartTag, endValue0, fontTags[fontSizeStyle].End));
	end;
end;
fontStyle = "FONT_FACE";
local fontFaceStyle = fontStyle --[[ copy: 9 -> 11 ]];
textFormatters.face = function(startValue1) --[[ Line: 93 ]]
	-- upvalues: v0 (copy), l_v21_1 (copy)
	local formattedFontFaceStartTag = fontTags[fontFaceStyle].Start:format(startValue1);
	return function(endValue1) --[[ Line: 96 ]]
		-- upvalues: v28 (copy), v0 (ref), l_v21_1 (ref)
		return (("%*%*%*"):format(formattedFontFaceStartTag, endValue1, fontTags[fontFaceStyle].End));
	end;
end;
fontStyle = "FONT_FAMILY";
local fontFamilyStyle = fontStyle --[[ copy: 9 -> 12 ]];
textFormatters.family = function(startValue2) --[[ Line: 93 ]]
	-- upvalues: v0 (copy), l_v21_2 (copy)
	local formattedFontFamilyStartTag = fontTags[fontFamilyStyle].Start:format(startValue2);
	return function(endValue2) --[[ Line: 96 ]]
		-- upvalues: v32 (copy), v0 (ref), l_v21_2 (ref)
		return (("%*%*%*"):format(formattedFontFamilyStartTag, endValue2, fontTags[fontFamilyStyle].End));
	end;
end;
fontStyle = "FONT_WEIGHT";
local fontWeightStyle = fontStyle --[[ copy: 9 -> 13 ]];
textFormatters.weight = function(startValue3) --[[ Line: 93 ]]
	-- upvalues: v0 (copy), l_v21_3 (copy)
	local formattedFontWeightStartTag = fontTags[fontWeightStyle].Start:format(startValue3);
	return function(endValue3) --[[ Line: 96 ]]
		-- upvalues: v36 (copy), v0 (ref), l_v21_3 (ref)
		return (("%*%*%*"):format(formattedFontWeightStartTag, endValue3, fontTags[fontWeightStyle].End));
	end;
end;
fontStyle = "FONT_TRANSPARENCY";
local fontTransparencyStyle = fontStyle --[[ copy: 9 -> 14 ]];
textFormatters.transparency = function(startValue4) --[[ Line: 93 ]]
	-- upvalues: v0 (copy), l_v21_4 (copy)
	local formattedFontTransparencyStartTag = fontTags[fontTransparencyStyle].Start:format(startValue4);
	return function(endValue4) --[[ Line: 96 ]]
		-- upvalues: v40 (copy), v0 (ref), l_v21_4 (ref)
		return (("%*%*%*"):format(formattedFontTransparencyStartTag, endValue4, fontTags[fontTransparencyStyle].End));
	end;
end;
textFormatters.stroke = function(strokeProperties) --[[ Line: 135 ]]
	-- upvalues: v0 (copy)
	local strokeColorHex = strokeProperties.Color or "#FFFFFF";
	local strokeJoins = strokeProperties.Joins or "Round";
	local strokeThickness = strokeProperties.Thickness or 1;
	local strokeTransparency = strokeProperties.Transparency or 0;
	local formattedStrokeStartTag = fontTags.STROKE.Start:format(strokeColorHex, strokeJoins, strokeThickness, strokeTransparency);
	return function(endStrokeValue) --[[ Line: 143 ]]
		-- upvalues: v47 (copy), v0 (ref)
		return (("%*%*%*"):format(formattedStrokeStartTag, endStrokeValue, fontTags.STROKE.End));
	end;
end;
textFormatters.color = function(...) --[[ Line: 147 ]]
	-- upvalues: v0 (copy)
	local colorValues = {
		...
	};
	local hexColorString = colorValues[1];
	local isHexColorValid;
	if typeof(hexColorString) ~= "string" then
		isHexColorValid = nil;
	else
		hexColorString = hexColorString:gsub("#", "");
		isHexColorValid = string.match(hexColorString, "^%x%x%x%x%x%x$");
	end;
	hexColorString = typeof(colorValues[1]) == "Color3";
	local firstColorValue = colorValues[1];
	local finalColor = hexColorString and firstColorValue or Color3.fromRGB(firstColorValue, colorValues[2], colorValues[3]);
	local formattedColorTag = isHexColorValid and fontTags.FONT_COLOR_HEX.Start:format(firstColorValue:gsub("#", "")) or fontTags.FONT_COLOR_RGB.Start:format(math.floor(finalColor.R * 255), math.floor(finalColor.G * 255), (math.floor(finalColor.B * 255)));
	return function(fontColorRGBEnd) --[[ Line: 161 ]]
		-- upvalues: v54 (copy), v0 (ref)
		return (("%*%*%*"):format(formattedColorTag, fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
	end;
end;
fontStyle = "BOLD";
local fontBoldStyle = fontStyle --[[ copy: 9 -> 15 ]];
stringFormatters.bold = function(endValue) --[[ Line: 103 ]]
	-- upvalues: v0 (copy), l_v21_5 (copy)
	local fontBoldData = fontTags[fontBoldStyle];
	return (("%*%*%*"):format(fontBoldData.Start, endValue, fontBoldData.End));
end;
fontStyle = "ITALIC";
local fontItalicStyle = fontStyle --[[ copy: 9 -> 16 ]];
stringFormatters.italic = function(endValue) --[[ Line: 103 ]]
	-- upvalues: v0 (copy), l_v21_6 (copy)
	local fontItalicData = fontTags[fontItalicStyle];
	return (("%*%*%*"):format(fontItalicData.Start, endValue, fontItalicData.End));
end;
fontStyle = "UNDERLINE";
local fontUnderlineStyle = fontStyle --[[ copy: 9 -> 17 ]];
stringFormatters.underline = function(endValue) --[[ Line: 103 ]]
	-- upvalues: v0 (copy), l_v21_7 (copy)
	local fontUnderlineData = fontTags[fontUnderlineStyle];
	return (("%*%*%*"):format(fontUnderlineData.Start, endValue, fontUnderlineData.End));
end;
fontStyle = "STRIKETHROUGH";
local fontStrikethroughStyle = fontStyle --[[ copy: 9 -> 18 ]];
stringFormatters.strikethrough = function(endValue) --[[ Line: 103 ]]
	-- upvalues: v0 (copy), l_v21_8 (copy)
	local timeRange = fontTags[fontStrikethroughStyle];
	return (("%*%*%*"):format(timeRange.Start, endValue, timeRange.End));
end;
fontStyle = "UPPERCASE";
local index9 = fontStyle --[[ copy: 9 -> 19 ]];
stringFormatters.uppercase = function(endValue) --[[ Line: 103 ]]
	-- upvalues: v0 (copy), l_v21_9 (copy)
	local timeRange9 = fontTags[index9];
	return (("%*%*%*"):format(timeRange9.Start, endValue, timeRange9.End));
end;
fontStyle = "SMALLCAPS";
local index10 = fontStyle --[[ copy: 9 -> 20 ]];
stringFormatters.smallcaps = function(endValue) --[[ Line: 103 ]]
	-- upvalues: v0 (copy), l_v21_10 (copy)
	local timeRange10 = fontTags[index10];
	return (("%*%*%*"):format(timeRange10.Start, endValue, timeRange10.End));
end;
fontStyle = Color3.fromRGB(255, 255, 255);
local colorValue11 = fontStyle --[[ copy: 9 -> 21 ]];
stringFormatters.white = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_11 (copy), v0 (copy)
	local redValue11 = math.floor(colorValue11.r * 255);
	local greenValue11 = math.floor(colorValue11.g * 255);
	local blueValue11 = math.floor(colorValue11.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue11, greenValue11, blueValue11), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(0, 0, 0);
local colorValue12 = fontStyle --[[ copy: 9 -> 22 ]];
stringFormatters.black = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_12 (copy), v0 (copy)
	local redValue12 = math.floor(colorValue12.r * 255);
	local greenValue12 = math.floor(colorValue12.g * 255);
	local blueValue12 = math.floor(colorValue12.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue12, greenValue12, blueValue12), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(255, 0, 0);
local colorValue13 = fontStyle --[[ copy: 9 -> 23 ]];
stringFormatters.red = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_13 (copy), v0 (copy)
	local redValue13 = math.floor(colorValue13.r * 255);
	local greenValue13 = math.floor(colorValue13.g * 255);
	local blueValue13 = math.floor(colorValue13.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue13, greenValue13, blueValue13), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(153, 51, 0);
local colorValue14 = fontStyle --[[ copy: 9 -> 24 ]];
stringFormatters.brown = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_14 (copy), v0 (copy)
	local redValue14 = math.floor(colorValue14.r * 255);
	local greenValue14 = math.floor(colorValue14.g * 255);
	local blueValue14 = math.floor(colorValue14.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue14, greenValue14, blueValue14), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(255, 153, 0);
local colorValue15 = fontStyle --[[ copy: 9 -> 25 ]];
stringFormatters.orange = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_15 (copy), v0 (copy)
	local redValue15 = math.floor(colorValue15.r * 255);
	local greenValue15 = math.floor(colorValue15.g * 255);
	local blueValue15 = math.floor(colorValue15.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue15, greenValue15, blueValue15), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(255, 255, 0);
local colorValue16 = fontStyle --[[ copy: 9 -> 26 ]];
stringFormatters.yellow = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_16 (copy), v0 (copy)
	local redValue16 = math.floor(colorValue16.r * 255);
	local greenValue16 = math.floor(colorValue16.g * 255);
	local blueValue16 = math.floor(colorValue16.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue16, greenValue16, blueValue16), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(153, 255, 0);
local colorValue17 = fontStyle --[[ copy: 9 -> 27 ]];
stringFormatters.lime = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_17 (copy), v0 (copy)
	local redValue17 = math.floor(colorValue17.r * 255);
	local greenValue17 = math.floor(colorValue17.g * 255);
	local blueValue17 = math.floor(colorValue17.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue17, greenValue17, blueValue17), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(0, 255, 0);
local colorValue18 = fontStyle --[[ copy: 9 -> 28 ]];
stringFormatters.green = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_18 (copy), v0 (copy)
	local redValue18 = math.floor(colorValue18.r * 255);
	local greenValue18 = math.floor(colorValue18.g * 255);
	local blueValue18 = math.floor(colorValue18.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue18, greenValue18, blueValue18), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(0, 0, 255);
local colorValue19 = fontStyle --[[ copy: 9 -> 29 ]];
stringFormatters.blue = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_19 (copy), v0 (copy)
	local redValue19 = math.floor(colorValue19.r * 255);
	local greenValue19 = math.floor(colorValue19.g * 255);
	local blueValue19 = math.floor(colorValue19.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue19, greenValue19, blueValue19), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(102, 0, 153);
local colorValue20 = fontStyle --[[ copy: 9 -> 30 ]];
stringFormatters.purple = function(fontColorRGBEnd) --[[ Line: 110 ]]
	-- upvalues: l_v21_20 (copy), v0 (copy)
	local redValue20 = math.floor(colorValue20.r * 255);
	local greenValue20 = math.floor(colorValue20.g * 255);
	local blueValue20 = math.floor(colorValue20.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue20, greenValue20, blueValue20), fontColorRGBEnd, fontTags.FONT_COLOR_RGB.End));
end;
fontStyle = Color3.fromRGB(255, 0, 255);
stringFormatters.pink = function(fontColor) --[[ Line: 110 ]]
	-- upvalues: v21 (copy), v0 (copy)
	local redValue = math.floor(fontStyle.r * 255);
	local greenValue = math.floor(fontStyle.g * 255);
	local blueValue = math.floor(fontStyle.b * 255);
	return (("%*%*%*"):format(fontTags.FONT_COLOR_RGB.Start:format(redValue, greenValue, blueValue), fontColor, fontTags.FONT_COLOR_RGB.End));
end;
richTextFormatter.new = function(indexKey) --[[ Line: 186 ]] --[[ Name: new ]]
	-- upvalues: v20 (copy), v1 (copy)
	local formatter = {};
	local formatterMetatable = {};
	local formattersList = {};
	formatter.Formatters = formattersList;
	local formatterCallback = nil;
	local proxyTable = nil;
	formatterMetatable.__call = function(_, ...) --[[ Line: 194 ]] --[[ Name: __call ]]
		-- upvalues: v132 (ref), v131 (copy)
		local argumentsList = {
			...
		};
		if formatterCallback then
			local cachedFunction = formatterCallback;
			formatterCallback = nil;
			return cachedFunction(unpack(argumentsList));
		else
			local resultsList = {};
			for _, argument in argumentsList do
				for _, formatter in formattersList do
					argument = formatter(argument);
				end;
				table.insert(resultsList, argument);
			end;
			return unpack(resultsList);
		end;
	end;
	formatterMetatable.__index = function(formattedText, index) --[[ Line: 218 ]] --[[ Name: __index ]]
		-- upvalues: v20 (ref), v132 (ref), v131 (copy), v133 (ref), v1 (ref)
		local callbackFunction = textFormatters[index];
		if callbackFunction then
			formatterCallback = function(...) --[[ Line: 222 ]]
				-- upvalues: v144 (copy), v131 (ref), v133 (ref)
				local result = callbackFunction(...);
				table.insert(formattersList, result);
				return proxyTable;
			end;
			return proxyTable;
		else
			local value = stringFormatters[index];
			table.insert(formattersList, value);
			return formattedText;
		end;
	end;
	formatterMetatable:__index(indexKey);
	proxyTable = setmetatable(formatter, formatterMetatable);
	return proxyTable;
end;
return (setmetatable({}, {
	__index = function(_, value) --[[ Line: 247 ]] --[[ Name: __index ]]
		-- upvalues: v2 (copy)
		return richTextFormatter.new(value);
	end, 
	__newindex = function() --[[ Line: 250 ]] --[[ Name: __newindex ]]
		return error("Chalk is READONLY");
	end
}));