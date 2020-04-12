local cfg = {}

cfg.factions = {
---911----
   ["Emergency"] = {
		fType = "Lege", --Type 'Lege' is governmental faction
		fSlots = 10, -- slots limit
		fRanks = {
			[1] = {rank = "Asistent", salary = 40001},
			[2] = {rank = "Paramedic", salary = 65001},
			[3] = {rank = "Doctor Chirurg", salary = 80001},
			[4] = {rank = "Sef de Tura", salary = 90001},
			[5] = {rank = "Sef Spital", salary = 100001},
			[6] = {rank = "Director", salary = 120001}
		}
	},
---Police---
   ["Police"] = {
	fType = "Lege",
	fSlots = 10,
	fRanks = {
		[1] = {rank = "Police Cadet", salary = 15001},
		[2] = {rank = "Police Officer", salary = 30001},
		[3] = {rank = "Police Sergeant", salary = 50001},
		[4] = {rank = "Police Locotenent", salary = 65001},
		[5] = {rank = "Police Serif", salary = 75001},
		[6] = {rank = "Police Chestor Adjunct", salary = 80001},
		[7] = {rank = "Police Chestor", salary = 95001}
	}
},
--SWAT
	["SWAT"] = {
		fSlots = 10,
		fType = "Lege",
		fRanks = {
			[1] = {rank = "SWAT Agent", salary = 45001},
			[2] = {rank = "SWAT Agent Special", salary = 58001},
			[3] = {rank = "SWAT Agent de Elita ", salary = 62001},
			[4] = {rank = "SWAT Sef", salary = 85001},
			[5] = {rank = "SWAT Director ", salary = 110001},
			[6] = {rank = "SWAT Director Executiv", salary = 125001}
		}
	},
	--FBI
	["FBI"] = {
		fSlots = 10,
		fType = "Lege",
		fRanks = {
		    [1] = {rank = "FBI Special Agent", salary = 35001},
			[2] = {rank = "FBI Professional Agent", salary = 45001},
			[3] = {rank = "FBI Supervisor", salary = 60001},
			[4] = {rank = "FBI Supervisor+", salary = 90001},
			[5] = {rank = "FBI Tester", salary = 120001},
			[6] = {rank = "Director Departament FBI", salary = 150001},
		}
	},


	--Mafia Faction--
	["Mafia Name"] = {
		fSlots = 7, --Limit Slots 
		fType = "Mafie", -- 'Mafie' is type of Mafia Faction
		fRanks = {
		    [1] = {rank = "Rank 1", salary = 10001},
			[2] = {rank = "Rank 2", salary = 20001},
			[3] = {rank = "Rank 3", salary = 35001},
			[4] = {rank = "Rank 4", salary = 45001}
		}
	},

	-- to add more mafia copy and paste this line and change this name

}

return cfg