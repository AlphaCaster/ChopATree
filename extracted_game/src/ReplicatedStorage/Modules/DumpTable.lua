-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

dump = function(arg) --[[ Line: 1 ]] --[[ Name: dump ]]
	local escapeCharacterMap = {
		["\a"] = "\\a", 
		["\b"] = "\\b", 
		["\f"] = "\\f", 
		["\n"] = "\\n", 
		["\r"] = "\\r", 
		["\t"] = "\\t", 
		["\v"] = "\\v", 
		["\000"] = "\\0"
	};
	local luaKeywordsMap = {
		["and"] = true, 
		["break"] = true, 
		["do"] = true, 
		["else"] = true, 
		["elseif"] = true, 
		["end"] = true, 
		["false"] = true, 
		["for"] = true, 
		["function"] = true, 
		["if"] = true, 
		["in"] = true, 
		["local"] = true, 
		["nil"] = true, 
		["not"] = true, 
		["or"] = true, 
		["repeat"] = true, 
		["return"] = true, 
		["then"] = true, 
		["true"] = true, 
		["until"] = true, 
		["while"] = true, 
		continue = true
	};
	local robloxApiMap = {
		[DockWidgetPluginGuiInfo.new] = "DockWidgetPluginGuiInfo.new", 
		[warn] = "warn", 
		[CFrame.fromMatrix] = "CFrame.fromMatrix", 
		[CFrame.fromAxisAngle] = "CFrame.fromAxisAngle", 
		[CFrame.fromOrientation] = "CFrame.fromOrientation", 
		[CFrame.fromEulerAnglesXYZ] = "CFrame.fromEulerAnglesXYZ", 
		[CFrame.Angles] = "CFrame.Angles", 
		[CFrame.fromEulerAnglesYXZ] = "CFrame.fromEulerAnglesYXZ", 
		[CFrame.new] = "CFrame.new", 
		[gcinfo] = "gcinfo", 
		[os.clock] = "os.clock", 
		[os.difftime] = "os.difftime", 
		[os.time] = "os.time", 
		[os.date] = "os.date", 
		[tick] = "tick", 
		[bit32.band] = "bit32.band", 
		[bit32.extract] = "bit32.extract", 
		[bit32.bor] = "bit32.bor", 
		[bit32.bnot] = "bit32.bnot", 
		[bit32.arshift] = "bit32.arshift", 
		[bit32.rshift] = "bit32.rshift", 
		[bit32.rrotate] = "bit32.rrotate", 
		[bit32.replace] = "bit32.replace", 
		[bit32.lshift] = "bit32.lshift", 
		[bit32.lrotate] = "bit32.lrotate", 
		[bit32.btest] = "bit32.btest", 
		[bit32.bxor] = "bit32.bxor", 
		[pairs] = "pairs", 
		[NumberSequence.new] = "NumberSequence.new", 
		[assert] = "assert", 
		[tonumber] = "tonumber", 
		[Color3.fromHSV] = "Color3.fromHSV", 
		[Color3.toHSV] = "Color3.toHSV", 
		[Color3.fromRGB] = "Color3.fromRGB", 
		[Color3.new] = "Color3.new", 
		[Delay] = "Delay", 
		[Stats] = "Stats", 
		[UserSettings] = "UserSettings", 
		[coroutine.resume] = "coroutine.resume", 
		[coroutine.yield] = "coroutine.yield", 
		[coroutine.running] = "coroutine.running", 
		[coroutine.status] = "coroutine.status", 
		[coroutine.wrap] = "coroutine.wrap", 
		[coroutine.create] = "coroutine.create", 
		[coroutine.isyieldable] = "coroutine.isyieldable", 
		[NumberRange.new] = "NumberRange.new", 
		[PhysicalProperties.new] = "PhysicalProperties.new", 
		[PluginManager] = "PluginManager", 
		[Ray.new] = "Ray.new", 
		[NumberSequenceKeypoint.new] = "NumberSequenceKeypoint.new", 
		[Version] = "Version", 
		[Vector2.new] = "Vector2.new", 
		[Instance.new] = "Instance.new", 
		[delay] = "delay", 
		[spawn] = "spawn", 
		[unpack] = "unpack", 
		[string.split] = "string.split", 
		[string.match] = "string.match", 
		[string.gmatch] = "string.gmatch", 
		[string.upper] = "string.upper", 
		[string.gsub] = "string.gsub", 
		[string.format] = "string.format", 
		[string.lower] = "string.lower", 
		[string.sub] = "string.sub", 
		[string.pack] = "string.pack", 
		[string.rep] = "string.rep", 
		[string.char] = "string.char", 
		[string.packsize] = "string.packsize", 
		[string.reverse] = "string.reverse", 
		[string.byte] = "string.byte", 
		[string.unpack] = "string.unpack", 
		[string.len] = "string.len", 
		[string.find] = "string.find", 
		[CellId.new] = "CellId.new", 
		[ypcall] = "ypcall", 
		[version] = "version", 
		[print] = "print", 
		[stats] = "stats", 
		[printidentity] = "printidentity", 
		[settings] = "settings", 
		[UDim2.fromOffset] = "UDim2.fromOffset", 
		[UDim2.fromScale] = "UDim2.fromScale", 
		[UDim2.new] = "UDim2.new", 
		[table.pack] = "table.pack", 
		[table.move] = "table.move", 
		[table.insert] = "table.insert", 
		[table.getn] = "table.getn", 
		[table.foreachi] = "table.foreachi", 
		[table.maxn] = "table.maxn", 
		[table.foreach] = "table.foreach", 
		[table.concat] = "table.concat", 
		[table.unpack] = "table.unpack", 
		[table.find] = "table.find", 
		[table.create] = "table.create", 
		[table.sort] = "table.sort", 
		[table.remove] = "table.remove", 
		[TweenInfo.new] = "TweenInfo.new", 
		[loadstring] = "loadstring", 
		[require] = "require", 
		[Vector3.FromNormalId] = "Vector3.FromNormalId", 
		[Vector3.FromAxis] = "Vector3.FromAxis", 
		[Vector3.fromAxis] = "Vector3.fromAxis", 
		[Vector3.fromNormalId] = "Vector3.fromNormalId", 
		[Vector3.new] = "Vector3.new", 
		[Vector3int16.new] = "Vector3int16.new", 
		[setmetatable] = "setmetatable", 
		[next] = "next", 
		[Wait] = "Wait", 
		[wait] = "wait", 
		[ipairs] = "ipairs", 
		[elapsedTime] = "elapsedTime", 
		[time] = "time", 
		[rawequal] = "rawequal", 
		[Vector2int16.new] = "Vector2int16.new", 
		[collectgarbage] = "collectgarbage", 
		[newproxy] = "newproxy", 
		[Spawn] = "Spawn", 
		[PluginDrag.new] = "PluginDrag.new", 
		[Region3.new] = "Region3.new", 
		[utf8.offset] = "utf8.offset", 
		[utf8.codepoint] = "utf8.codepoint", 
		[utf8.nfdnormalize] = "utf8.nfdnormalize", 
		[utf8.char] = "utf8.char", 
		[utf8.codes] = "utf8.codes", 
		[utf8.len] = "utf8.len", 
		[utf8.graphemes] = "utf8.graphemes", 
		[utf8.nfcnormalize] = "utf8.nfcnormalize", 
		[xpcall] = "xpcall", 
		[tostring] = "tostring", 
		[rawset] = "rawset", 
		[PathWaypoint.new] = "PathWaypoint.new", 
		[DateTime.fromUnixTimestamp] = "DateTime.fromUnixTimestamp", 
		[DateTime.now] = "DateTime.now", 
		[DateTime.fromIsoDate] = "DateTime.fromIsoDate", 
		[DateTime.fromUnixTimestampMillis] = "DateTime.fromUnixTimestampMillis", 
		[DateTime.fromLocalTime] = "DateTime.fromLocalTime", 
		[DateTime.fromUniversalTime] = "DateTime.fromUniversalTime", 
		[Random.new] = "Random.new", 
		[typeof] = "typeof", 
		[RaycastParams.new] = "RaycastParams.new", 
		[math.log] = "math.log", 
		[math.ldexp] = "math.ldexp", 
		[math.rad] = "math.rad", 
		[math.cosh] = "math.cosh", 
		[math.random] = "math.random", 
		[math.frexp] = "math.frexp", 
		[math.tanh] = "math.tanh", 
		[math.floor] = "math.floor", 
		[math.max] = "math.max", 
		[math.sqrt] = "math.sqrt", 
		[math.modf] = "math.modf", 
		[math.pow] = "math.pow", 
		[math.atan] = "math.atan", 
		[math.tan] = "math.tan", 
		[math.cos] = "math.cos", 
		[math.sign] = "math.sign", 
		[math.clamp] = "math.clamp", 
		[math.log10] = "math.log10", 
		[math.noise] = "math.noise", 
		[math.acos] = "math.acos", 
		[math.abs] = "math.abs", 
		[math.sinh] = "math.sinh", 
		[math.asin] = "math.asin", 
		[math.min] = "math.min", 
		[math.deg] = "math.deg", 
		[math.fmod] = "math.fmod", 
		[math.randomseed] = "math.randomseed", 
		[math.atan2] = "math.atan2", 
		[math.ceil] = "math.ceil", 
		[math.sin] = "math.sin", 
		[math.exp] = "math.exp", 
		[getfenv] = "getfenv", 
		[pcall] = "pcall", 
		[ColorSequenceKeypoint.new] = "ColorSequenceKeypoint.new", 
		[ColorSequence.new] = "ColorSequence.new", 
		[type] = "type", 
		[Region3int16.new] = "Region3int16.new", 
		[ElapsedTime] = "ElapsedTime", 
		[select] = "select", 
		[getmetatable] = "getmetatable", 
		[rawget] = "rawget", 
		[Faces.new] = "Faces.new", 
		[Rect.new] = "Rect.new", 
		[BrickColor.Blue] = "BrickColor.Blue", 
		[BrickColor.White] = "BrickColor.White", 
		[BrickColor.Yellow] = "BrickColor.Yellow", 
		[BrickColor.Red] = "BrickColor.Red", 
		[BrickColor.Gray] = "BrickColor.Gray", 
		[BrickColor.palette] = "BrickColor.palette", 
		[BrickColor.New] = "BrickColor.New", 
		[BrickColor.Black] = "BrickColor.Black", 
		[BrickColor.Green] = "BrickColor.Green", 
		[BrickColor.Random] = "BrickColor.Random", 
		[BrickColor.DarkGray] = "BrickColor.DarkGray", 
		[BrickColor.random] = "BrickColor.random", 
		[BrickColor.new] = "BrickColor.new", 
		[setfenv] = "setfenv", 
		[UDim.new] = "UDim.new", 
		[Axes.new] = "Axes.new", 
		[error] = "error", 
		[debug.traceback] = "debug.traceback", 
		[debug.profileend] = "debug.profileend", 
		[debug.profilebegin] = "debug.profilebegin"
	};
	local function getHierarchy(instance) --[[ Line: 6 ]] --[[ Name: GetHierarchy ]]
		-- upvalues: v1 (copy), v2 (copy)
		local hierarchyList = {};
		local hierarchyDepth = 1;
		local ancestorInstance = instance;
		while ancestorInstance do
			ancestorInstance = ancestorInstance.Parent;
			hierarchyDepth = hierarchyDepth + 1;
		end;
		ancestorInstance = instance;
		local instanceIndex = 0;
		while ancestorInstance do
			instanceIndex = instanceIndex + 1;
			local instanceName = string.gsub(ancestorInstance.Name, "[%c%z]", escapeCharacterMap);
			instanceName = ancestorInstance == game and "game" or instanceName;
			if luaKeywordsMap[instanceName] or not string.match(instanceName, "^[_%a][_%w]*$") then
				instanceName = "[\"" .. instanceName .. "\"]";
			elseif instanceIndex ~= hierarchyDepth - 1 then
				instanceName = "." .. instanceName;
			end;
			hierarchyList[hierarchyDepth - instanceIndex] = instanceName;
			ancestorInstance = ancestorInstance.Parent;
		end;
		return table.concat(hierarchyList);
	end;
	local function serializeType(value, dataType) --[[ Line: 37 ]] --[[ Name: SerializeType ]]
		-- upvalues: v1 (copy), v10 (copy), v3 (copy)
		if dataType == "string" then
			return string.format("\"%s\"", string.gsub(value, "[%c%z]", escapeCharacterMap));
		elseif dataType == "Instance" then
			return getHierarchy(value);
		elseif type(value) ~= dataType then
			return dataType .. ".new(" .. tostring(value) .. ")";
		elseif dataType == "function" then
			return robloxApiMap[value] or "'[Unknown " .. (pcall(setfenv, value, getfenv(value)) and "Lua" or "C") .. " " .. tostring(value) .. "]'";
		elseif dataType == "userdata" then
			return "newproxy(" .. tostring(not not getmetatable(value)) .. ")";
		elseif dataType == "thread" then
			return "'" .. tostring(value) .. ", status: " .. coroutine.status(value) .. "'";
		else
			return (tostring(value));
		end;
	end;
	local function tableToString(tableValue, visitedTablesMap, pathInfo, path) --[[ Line: 55 ]] --[[ Name: TableToString ]]
		-- upvalues: v1 (copy), v2 (copy), v14 (copy), v13 (copy)
		visitedTablesMap = visitedTablesMap or {};
		local cyclicReference = visitedTablesMap[tableValue];
		if cyclicReference then
			return (cyclicReference[1] == pathInfo[1] - 1 and "'[Cyclic Parent " or "'[Cyclic ") .. tostring(tableValue) .. ", path: " .. cyclicReference[2] .. "]'";
		else
			path = path or "ROOT";
			pathInfo = pathInfo or {
				0, 
				path
			};
			local depth = pathInfo[1] + 1;
			pathInfo[1] = depth;
			pathInfo[2] = path;
			visitedTablesMap[tableValue] = pathInfo;
			local indentation = string.rep("    ", depth);
			local parentIndentation = string.rep("    ", depth - 1);
			local tableString = "{";
			local newlineIndentation = "\n" .. indentation;
			local isKeyString = true;
			local keyIndex = 1;
			local isDataLoaded = true;
			for keyString, valueString in next, tableValue do
				isDataLoaded = false;
				if keyIndex ~= keyString then
					isKeyString = false;
				else
					keyIndex = keyIndex + 1;
				end;
				local keyType = typeof(keyString);
				local valueType = typeof(valueString);
				local isTableValid = false;
				if keyType == "string" then
					keyString = string.gsub(keyString, "[%c%z]", escapeCharacterMap);
					if luaKeywordsMap[keyString] or not string.match(keyString, "^[_%a][_%w]*$") then
						isTableValid = true;
						keyString = string.format("[\"%s\"]", keyString);
					end;
				else
					isTableValid = true;
					keyString = "[" .. (keyType == "table" and string.gsub(tableToString(keyString, visitedTablesMap, {
						depth, 
						path
					}), "^%s*(.-)%s*$", "%1") or serializeType(keyString, keyType)) .. "]";
				end;
				valueString = valueType == "table" and tableToString(valueString, visitedTablesMap, {
					depth, 
					path
				}, path .. (isTableValid and "" or ".") .. keyString) or serializeType(valueString, valueType);
				tableString = tableString .. newlineIndentation .. (isKeyString and valueString or keyString .. " = " .. valueString) .. ",";
			end;
			return isDataLoaded and tableString .. "}" or string.sub(tableString, 1, -2) .. "\n" .. parentIndentation .. "}";
		end;
	end;
	return tableToString(arg);
end;
return dump;