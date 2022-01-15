local pingLimit = GetConvarInt('pingkick', 150)

RegisterNetEvent('ping:request', function(what) TriggerClientEvent('ping:receive', source, what, what == 'ping' and GetPlayerPing(source) or pingLimit) end)