ESX               = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT `xp` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)

			local xpbd = {}

			if result[1].xp ~= nil then
				xpbd = json.decode(result[1].xp)
			end
			   Wait(0)
    TriggerClientEvent('XNL_NET:AddPlayerXP', _source , xpbd)

		end
	)

end)

		
RegisterServerEvent('AddXp')
AddEventHandler('AddXp',function(value)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT `xp` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        -- print(result[1].rank)
       local xpbd = result[1].xp
   
	
	MySQL.Async.fetchAll("UPDATE users SET xp = @xp WHERE identifier = @identifier",
                {
                 ['@identifier'] = xPlayer.identifier,
				 ['@xp'] = xpbd + (value)
                }
                )
	
	
	 end)
end)


RegisterServerEvent('RemoveXp')
AddEventHandler('RemoveXp',function(value)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT `xp` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        -- print(result[1].rank)
       local xpbd = result[1].xp
   
	if xpbd >= (value) then
	MySQL.Async.fetchAll("UPDATE users SET xp = @xp WHERE identifier = @identifier",
                {
                 ['@identifier'] = xPlayer.identifier,
				 ['@xp'] = xpbd - (value)
                }
                )
	
	else 
	MySQL.Async.fetchAll("UPDATE users SET xp = @xp WHERE identifier = @identifier",
                {
                 ['@identifier'] = xPlayer.identifier,
				 ['@xp'] = 0
                }
                )
				end
	 end)
end)

