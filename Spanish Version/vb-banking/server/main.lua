ESX = nil

TriggerEvent('esx:getSantaFeObjectnohack', function(obj) ESX = obj end)

ESX.RegisterServerCallback('vb-banking:server:GetPlayerName', function(source, cb)
	local _char = ESX.GetPlayerFromId(source)
	local _charname = _char.getName()
	cb(_charname)
end)

RegisterServerEvent('vb-banking:server:depositvb')
AddEventHandler('vb-banking:server:depositvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	amount = tonumber(amount)
	Citizen.Wait(50)
	if inMenu then
		if amount == nil or amount <= 0 or amount > _char.getMoney() then
			TriggerClientEvent('chatMessage', _src, "Cantidad Inválida.")
		else
			_char.removeMoney(amount)
			_char.addAccountMoney('bank', tonumber(amount))
			_char.showNotification("Has ingresado $"..amount)
		end
	else
		DropPlayer(_src, "Te Pillé! Nospera, a la calle. [Lealtad-Banking] NUI_Devtools Infinite Money Exploit was Detected.")
	end
end)

RegisterServerEvent('vb-banking:server:withdrawvb')
AddEventHandler('vb-banking:server:withdrawvb', function(amount, inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	local _base = 0
	amount = tonumber(amount)
	_base = _char.getAccount('bank').money
	if inMenu then
		Citizen.Wait(100)
		if amount == nil or amount <= 0 or amount > _base then
			TriggerClientEvent('chatMessage', _src, "Cantidad Invalida")
		else
			_char.removeAccountMoney('bank', amount)
			_char.addMoney(amount)
			_char.showNotification("Has retirado $"..amount)
		end
	else
		DropPlayer(_src, "Te Pillé! Nospera, a la calle. [Lealtad-Banking] NUI_Devtools Infinite Money Exploit was Detected.")
	end
end)

RegisterServerEvent('vb-banking:server:balance')
AddEventHandler('vb-banking:server:balance', function(inMenu)
	local _src = source
	local _char = ESX.GetPlayerFromId(_src)
	if inMenu then
		local balance = _char.getAccount('bank').money
		TriggerClientEvent('vb-banking:client:refreshbalance', _src, balance)
	else
		DropPlayer(_src, "Te Pillé! Nospera, a la calle. [Lealtad-Banking] NUI_Devtools Infinite Money Exploit was Detected.")
	end
end)

RegisterServerEvent('vb-banking:server:transfervb')
AddEventHandler('vb-banking:server:transfervb', function(to, amountt, inMenu)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(tonumber(to))
	local balance = 0
	if inMenu then
		if zPlayer ~= nil then
			balance = xPlayer.getAccount('bank').money
			if tonumber(_source) == tonumber(to) then
				TriggerClientEvent('chatMessage', _source, "No te puedes transferir dinero a ti mismo")	
			else
				if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
					TriggerClientEvent('chatMessage', _source, "No tienes suficiente dinero en el banco.")
				else
					xPlayer.removeAccountMoney('bank', tonumber(amountt))
					zPlayer.addAccountMoney('bank', tonumber(amountt))
					zPlayer.showNotification("Te han enviado una transferencia de "..amountt.."€ por parte de la ID: ".._source)
					xPlayer.showNotification("Has enviado una transferencia de "..amountt.."€ a la ID: "..to)
				end
			end
		else
			TriggerClientEvent('chatMessage', _source, "That Wallet ID is invalid or doesn't exist")
		end
	else
		DropPlayer(_source, "Te Pillé! Nospera, a la calle. [Lealtad-Banking] NUI_Devtools Infinite Money Exploit was Detected.")
	end
end)