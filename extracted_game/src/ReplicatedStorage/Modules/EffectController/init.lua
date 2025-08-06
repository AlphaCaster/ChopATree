-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local effectsFolder = script.Effects;
local librariesFolder = script.Libraries;
local effectRequestEvent = replicatedStorageService.GameEvents.EffectRequest;
local _ = require(script.Types);
local troveModule = require(replicatedStorageService.Modules.Trove);
local effectCache = {};
return {
	Init = function(effectHandler, _) --[[ Line: 25 ]] --[[ Name: Init ]]
		-- upvalues: l_Effects_0 (copy), l_Libraries_0 (copy), l_EffectRequest_0 (copy)
		effectHandler.Components = {};
		effectHandler.Libraries = {};
		for _, effectModule in effectsFolder:GetDescendants() do
			if effectModule.ClassName == "ModuleScript" then
				task.spawn(function() --[[ Line: 34 ]]
					-- upvalues: v10 (copy), v7 (copy)
					local moduleLoadStatus, moduleLoadResult = pcall(require, effectModule);
					if moduleLoadStatus then
						effectHandler.Components[effectModule.Name] = moduleLoadResult;
					end;
				end);
			end;
		end;
		for _, libraryModule in librariesFolder:GetChildren() do
			if libraryModule.ClassName == "ModuleScript" then
				task.spawn(function() --[[ Line: 48 ]]
					-- upvalues: v14 (copy), v7 (copy)
					local libraryLoadStatus, libraryLoadResult = pcall(require, libraryModule);
					if libraryLoadStatus then
						effectHandler.Libraries[libraryModule.Name] = libraryLoadResult;
					end;
				end);
			end;
		end;
		
		if game:GetService("RunService"):IsClient() then
			effectRequestEvent.OnClientEvent:Connect(function(effectData) --[[ Line: 57 ]]
				-- upvalues: v7 (copy)
				effectHandler:Play(effectData);
			end);
		end
	end, 
	SplitName = function(_, nameState) --[[ Line: 62 ]] --[[ Name: SplitName ]]
		local nameParts = nameState:split("/");
		if nameParts then
			return nameParts[1], nameParts[2];
		else
			return;
		end;
	end, 
	FetchComponent = function(effectComponentHandler, effectComponentName) --[[ Line: 72 ]] --[[ Name: FetchComponent ]]
		if not effectComponentHandler.Components[effectComponentName] then
			warn((("Invalid Effect Name: %*, Component not Found."):format(effectComponentName)));
			return nil;
		else
			return effectComponentHandler.Components[effectComponentName];
		end;
	end, 
	FetchCache = function(_, casterName, effectName) --[[ Line: 82 ]] --[[ Name: FetchCache ]]
		-- upvalues: v6 (copy), v5 (copy)
		if not effectCache[casterName] then
			effectCache[casterName] = {};
		end;
		if not effectCache[casterName][effectName] then
			effectCache[casterName][effectName] = {
				Cache = {}, 
				Container = troveModule.new()
			};
		end;
		return effectCache[casterName][effectName];
	end, 
	Play = function(effectCacheHandler, effectData) --[[ Line: 97 ]] --[[ Name: Play ]]
		if not effectData.caster then
			warn(("No caster found in data table %*."):format(effectData), effectData);
			return;
		else
			local componentName, callbackName = effectCacheHandler:SplitName(effectData.name_State);
			local component = effectCacheHandler:FetchComponent(componentName);
			local callbackFunction = component and component[callbackName];
			local cacheData = component and effectCacheHandler:FetchCache(effectData.caster, component);
			if not component or not callbackFunction or not cacheData then
				warn((("Component Found: %*, Callback Found: %*, Cache Found: %*."):format(component, callbackFunction, cacheData)));
				return false;
			else
				task.spawn(callbackFunction, {
					Caster = effectData.caster, 
					Parameters = effectData.parameters, 
					Libraries = effectCacheHandler.Libraries, 
					Default = effectCacheHandler.Libraries.Default, 
					Cache = cacheData.Cache, 
					Container = cacheData.Container
				});
				return true;
			end;
		end;
	end, 
	Request = function(effectObject, effectParameters) --[[ Line: 131 ]] --[[ Name: Request ]]
		-- upvalues: l_EffectRequest_0 (copy)
		if not effectParameters.caster then
			return;
		else
			if effectObject:Play(effectParameters) then
				effectRequestEvent:FireServer(effectParameters);
			end;
			return;
		end;
	end
};