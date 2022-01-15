local curPing = 0
local pingLimit = 0

local function IsPingOverLimit() return curPing >= pingLimit and true or false end

local function DrawTextOnScreen(text, x, y)
	if IsPingOverLimit() == false then
		SetTextColour(255, 255, 255, 255)
	else
		SetTextColour(255, 0, 0, 255)
	end

	SetTextFont(4)
	SetTextScale(0, 0.3)
	SetTextDropShadow(1, 0, 0, 0, 255)
	SetTextOutline()
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
end

RegisterNetEvent('ping:receive', function(what, value)
	if what == 'ping' then
		curPing = value
	elseif what == 'limit' then
		pingLimit = value
	end
end)

TriggerServerEvent('ping:request', 'limit')

Citizen.CreateThread(function() -- Get ping from server every 5s
	while true do
		TriggerServerEvent('ping:request', 'ping')
		Citizen.Wait(5000)
	end
end)

Citizen.CreateThread(function() -- Update Ping on Screen
	while true do
		Citizen.Wait(5)
		DrawTextOnScreen(curPing .. 'ms' .. (IsPingOverLimit() and (' (Limite: %dms)'):format(pingLimit) or ''), 0.0009, 0.9798)
	end
end)