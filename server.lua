ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerThemes = {}

RegisterServerEvent('xxx_themes:loadData')
AddEventHandler('xxx_themes:loadData', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier

    if not PlayerThemes[identifier] then
        PlayerThemes[identifier] = {
            data = {},
            use = 'default' -- ธีมที่ผู้เล่นใช้อยู่
        }
    end

    TriggerClientEvent('xxx_themes:LoadDataClient', src, PlayerThemes[identifier])
end)

RegisterServerEvent('xxx_themes:setthemes')
AddEventHandler('xxx_themes:setthemes', function(themes)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier

    if PlayerThemes[identifier] then
        PlayerThemes[identifier].use = themes
    end
end)

RegisterServerEvent('xxx_themes:updateThemes')
AddEventHandler('xxx_themes:updateThemes', function(typec, themes)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier

    if PlayerThemes[identifier] then
        if typec == 'ADD' then
            table.insert(PlayerThemes[identifier].data, themes)
        elseif typec == 'REMOVE' then
            for i, v in pairs(PlayerThemes[identifier].data) do
                if v == themes then
                    table.remove(PlayerThemes[identifier].data, i)
                    break
                end
            end
        end

        TriggerClientEvent('xxx_themes:LoadDataClient_NEW', src, typec, themes)
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
end)