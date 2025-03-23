ESX = nil
Index = 0 
Uidisplay = false 
delay = false 
local FirstLoad = false 
local Keys 					  = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local MythemesData = {}
local firstLoad = false 
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while not ESX.IsPlayerLoaded() do 

		Wait(0)
	end
	Wait(2000)
	if not firstLoad then 
		TriggerServerEvent('xxx_themes:loadData')

		while not firstLoad do 
			Wait(100)
		end 
	end 
end)

RegisterNetEvent('xxx_themes:LoadDataClient' )
AddEventHandler('xxx_themes:LoadDataClient', function(DATA)
	MythemesData = DATA
	SendNUIMessage({
		action = 'syncData',
		mydata = MythemesData, 
		all = Config.Themes
	})
	firstLoad = true 
end)
RegisterNetEvent('xxx_themes:LoadDataClient_NEW' )
AddEventHandler('xxx_themes:LoadDataClient_NEW', function(typec,themes)
	if typec == 'ADD' then 
		table.insert(MythemesData.data,themes)
	elseif typec == 'REMOVE' then 
		for _ ,v in pairs(MythemesData.data) do 
			if v == themes then 
				table.remove(MythemesData.data,_)
			end 
		end
	end 
	SendNUIMessage({
		action = 'updateThemes',
		typeAdd = typec, 
		themes = themes,
		newdata = MythemesData.data
	})
end)

exports('OpenSetThemes',function ( )
	-- body
	if not firstLoad then return end
	SetNuiFocus(true,true)
	SendNUIMessage({
		action = 'display',
		bool = true 
	})
end)


RegisterCommand("xxx_themes", function()
	exports['xxx_themes']:OpenSetThemes()

end, true)

exports('setThemes',function (themes)
	if MythemesData then 
		if MythemesData.use ~= themes then 
			MythemesData.use = themes
			SendNUIMessage({
				action = 'use',
				themes = themes
		
			})
			TriggerServerEvent('xxx_themes:setthemes',themes)
		end 
	end 
end)
RegisterNUICallback('exit',function (  )
	SetNuiFocus(false,false)
	SendNUIMessage({
		action ='display',
		bool= false 
	})
	exports['xxx_menu_all']:BackToOpenMenu()
end)
RegisterNUICallback('select',function (data)
	local themes = data.key
	if MythemesData then 
		if MythemesData.use ~= themes then 
			MythemesData.use = themes
			SendNUIMessage({
				action = 'use',
				themes = themes
		
			})
			TriggerServerEvent('xxx_themes:setthemes',themes)
		end 
	end 
end)
exports('getthemesdata',function ()
	
	return MythemesData or false 

end)
