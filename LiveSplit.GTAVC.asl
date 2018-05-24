// Original autosplitter by zoton2 and pitpo, contributions by MHMD_FVC.

// KZ_FREW changes:
// Added side missions and collectibles
// Prevented splitting after loading a save mid-run
// Cleaned up the settings list in LiveSplit
// 
// To do:
// Clean up the split logic a bit
// Test with the experimental "split on mission start" setting

// I borrowed a lot of code from tduva -- really helped me out, so credit where it's due. Thanks tduva.

state("gta-vc")
{
	byte gameVersion : 0x208578;  // Used to detect the version (works for all versions beside Steam).
}

state("gta-vc", "1.0")
{
	int islandLoad : 0x305310;
	int loadSaveLoad : 0x38D724;
	int replayLoad : 0x38A72C;
	byte genLoad : 0x2F7759;
}

state("gta-vc", "1.1")
{
	int islandLoad : 0x305310;
	int loadSaveLoad : 0x38D72C;
	int replayLoad : 0x38A72C;
	byte genLoad : 0x2F7759;
}

state("gta-vc", "Steam")
{
	int islandLoad : 0x304310;
	int loadSaveLoad : 0x38E71C;
	int replayLoad : 0x389734;
	byte genLoad : 0x2F6759;
}

//state("testapp", "Steam") {} // needs properly implementing

state("gta-vc", "Japanese")
{
	int islandLoad : 0x302310;
	int loadSaveLoad : 0x38A72C;
	int replayLoad : 0x387734;
	byte genLoad : 0x2F4759;
}

startup
{
	// List of mission memory addresses (for 1.0, see below for where offsets get added)
	
	// Collectible addresses
	vars.collectibles = new Dictionary<string, int> {
		{"Packages", 0x4226E8},
		{"Stunt Jumps", 0x421EDC},
		{"Rampages", 0x42286C},
		{"Robberies", 0x422A6C}
	};
	
	// Assets/missions with only one objective (sans Kent Paul)
	vars.mission2 = new Dictionary<string, int> {
		{"Checkpoint Charlie (Boatyard)", 0x421BFC},
		{"Distribution (Cherry Poppers)", 0x421C10},
		{"Pole Position ($300 Spent)", 0x4223A0},
		{"Rifle Range (45 Points)", 0x421430}
	};
	
	// Main story/asset mission addresses
	vars.missionAddresses = new Dictionary<string, Dictionary<int, string>> {
		{"Ken Rosenberg", new Dictionary<int, string> {
	  		{0x4215F8, "An Old Friend"},
			{0x421600, "The Party"},
			{0x421604, "Back Alley Brawl"},
			{0x421608, "Jury Fury"},
			{0x42160C, "Riot"}
		}},
		{"Avery", new Dictionary<int, string> {
			{0x421650, "Four Iron"},
			{0x421654, "Demolition Man"},
			{0x421658, "Two Bit Hit"}
		}},			
	    {"Cortez", new Dictionary<int, string> {
			{0x421614, "Treacherous Swine"},
			{0x421618, "Mall Shootout"},
			{0x42161C, "Guardian Angels"},
			{0x421620, "Sir, Yes, Sir!"},
			{0x421624, "All Hands On Deck!"}
		}},
		{"Diaz", new Dictionary<int, string> {
			{0x42162C, "The Chase"},
			{0x421630, "Phnom Penh '86"},
			{0x421634, "The Fastest Boat"},
			{0x421638, "Supply and Demand"}
		}},
		{"Kent Paul", new Dictionary<int, string> {
			{0x421648, "Death Row"}
		}},
		{"Vercetti", new Dictionary<int, string> {
			{0x42163C, "Rub Out"},
			{0x4216B8, "Keep Your Friends Close..."}
		}},
		{"Umberto Robina", new Dictionary<int, string> {
			{0x4216DC, "Stunt Boat Challenge"},		
			{0x4216E0, "Cannon Fodder"},
			{0x4216E4, "Naval Engagement"},
			{0x4216E8, "Trojan Voodoo"}		
		}},
		{"Auntie Poulet", new Dictionary<int, string> {
			{0x4216F0, "Juju Scramble"},
			{0x4216F4, "Bombs Away!"},
			{0x4216F8, "Dirty Lickin's"}
		}},
		{"Mitch Baker", new Dictionary<int, string> {
			{0x4216CC, "Alloy Wheels Of Steel"},
			{0x4216D0, "Messing With The Man"},
			{0x4216D4, "Hog Tied"}
		}},
		{"Love Fist", new Dictionary<int, string> {
			{0x421700, "Love Juice"},
			{0x421704, "Psycho Killer"},
			{0x421708, "Publicity Tour"}
		}},
		{"Phil Cassidy", new Dictionary<int, string> {
			{0x421678, "Gun Runner"},
			{0x42167C, "Boomshine Saigon"}
		}},
		{"Mr. Black", new Dictionary<int, string> {
			{0x421728, "Road Kill"},
			{0x42172C, "Waste The Wife"},
			{0x421730, "Autocide"},
			{0x421734, "Check Out At The Check In"},
			{0x421738, "Loose Ends"}
		}},
		{"Vercetti Mansion", new Dictionary<int, string> {
			{0x4216A8, "Shakedown"},
			{0x4216AC, "Bar Brawl"},
			{0x4216B0, "Cop Land"}
		}},
		{"Printworks", new Dictionary<int, string> {
			{0x4216C0, "Spilling the Beans"},
			{0x4216C4, "Hit the Courier"},
			{0x4216B4, "Cap the Collector"}
		}},			
		{"Sunshine Autos Imports", new Dictionary<int, string> {
			{0x422414, "List 1"},
			{0x422418, "List 2"},
			{0x42241C, "List 3"},
			{0x422420, "List 4"}
		}},
		{"Sunshine Autos Races", new Dictionary<int, string> {
			{0x422B50, "Terminal Velocity"},
			{0x422B54, "Ocean Drive"},
			{0x422B58, "Border Run"},
			{0x422B5C, "Capital Cruise"},
			{0x422B60, "Tour!"},
			{0x422B64, "VC Endurance"},
		}},
		{"Film Studio", new Dictionary<int, string> {
			{0x421684, "Recruitment Drive"},
			{0x421688, "Dildo Dodo"},
			{0x42168C, "Martha's Mug Shot"},
			{0x421690, "G-Spotlight"}
		}},
		{"Kaufman Cabs", new Dictionary<int, string> {
			{0x421750, "V.I.P."},
			{0x421754, "Friendly Rivalry"},
			{0x421758, "Cabmaggedon"}
		}},
		{"Malibu", new Dictionary<int, string> {
			{0x421660, "No Escape?"},
			{0x421664, "The Shootist"},
			{0x421668, "The Driver"},
			{0x42166C, "The Job"}
		}},
		{"Stadium Events", new Dictionary<int, string> {
			{0x422B74, "Hotring"},
			{0x422B78, "Bloodring"},
			{0x42135C, "Dirtring"}
		}},
		{"Chopper Checkpoints", new Dictionary<int, string> { // some of these don't work
			{0x422B44, "Ocean Beach"},
			{0x422B48, "Vice Point"},
			{0x422B4C, "Little Haiti"},
			{0x422B40, "Downtown"}
		}},
		{"Off-Road Challenges", new Dictionary<int, string> {
			{0x4217CC, "PCJ Playground"},
			{0x4217FC, "Cone Crazy"},
			{0x42182C, "Trial By Dirt"},
			{0x421830, "Test Track"}
		}},
		{"RC Top-Fun", new Dictionary<int, string> {
			{0x4291F0, "RC Raider"},
			{0x429344, "RC Bandit"},
			{0x429714, "RC Baron"}
		}},
		{"Vehicle Missions", new Dictionary<int, string> {
			{0x422B34, "Paramedic (Level 12)"},
			{0x422B3C, "Firefighter (Level 12)"},
			{0x421894, "Pizza Boy (Level 10)"},
			{0x422B38, "Vigilante (Level 12)"},
			{0x421854, "Taxi (100 Fares)"}
		}},
		{"Safehouses", new Dictionary<int, string> {
			{0x4226D4, "1102 Washington Street"},
			{0x4226D8, "3321 Vice Point"},
			{0x4226DC, "El Swanko Casa"},
			{0x4226D0, "Hyman Condo"},
			{0x4226E0, "Links View"},
			{0x4226E4, "Ocean Heights"},
			{0x4226CC, "Skumole Shack"}
		}},
	};
	
	// Creating separate lists for easier checking later.
	vars.missionList = new List<string>();
	vars.collectibleList = new List<string>();
	vars.stadList = new List<string>(); // stadium missions list
	
	// Inserts split into settings and adds the mission to our separate list.
	Action<string, bool> addMissionChain = (missions, defaultValue) => {
		var parent = missions;
		foreach (var address in vars.missionAddresses[missions]) {
			settings.Add(address.Value, defaultValue, address.Value, parent);
			// Adding a separate check for stadium to be able to split for all three.
			if (address.Value == "Hotring" || address.Value == "Bloodring" || address.Value == "Dirtring") {
				vars.stadList.Add(address.Value);
			}
			vars.missionList.Add(address.Value);
		}
	};
	
	// Inserts header (i.e. mission giver) into settings.
	Action<string, bool, string> addMissionHeader = (missions, defaultValue, header) => {
		var parent = missions;
		settings.Add(parent, defaultValue, header);
		addMissionChain(missions, defaultValue);
	};
		
	// Settings Page
	// -------------
	
	// Parent settings.
	settings.Add("OMFSplit", false, "Split on Start of Next Mission (experimental)");
	settings.Add("Missions", true, "Missions");
	settings.Add("Assets", true, "Assets");
	settings.Add("Sunshine Autos", false, "Sunshine Autos", "Assets");
	settings.Add("Odd Jobs", false, "Odd Jobs");
	settings.Add("Collectibles", false, "Collectibles");
	
	// Adding mission headers
	settings.CurrentDefaultParent = "Missions";
	addMissionHeader("Ken Rosenberg", true, "Lawyer");
	addMissionHeader("Avery", false, "Avery");
	addMissionHeader("Cortez", true, "Cortez");
	addMissionHeader("Diaz", true, "Diaz");
	
	addMissionHeader("Kent Paul", true, "Kent Paul");
	addMissionHeader("Vercetti", true, "Vercetti");
	addMissionHeader("Umberto Robina", false, "Umberto Robina");
	addMissionHeader("Auntie Poulet", false, "Auntie Poulet");
	
	addMissionHeader("Mitch Baker", false, "Mitch Baker");
	addMissionHeader("Love Fist", false, "Love Fist");
	addMissionHeader("Phil Cassidy", false, "Phil Cassidy");
	addMissionHeader("Mr. Black", false, "Mr. Black");
	
	// Asset headers (includes mansion and printworks).
	settings.CurrentDefaultParent = "Assets";
	addMissionHeader("Vercetti Mansion", true, "Vercetti Mansion");
	addMissionHeader("Printworks", true, "Printworks");
	addMissionHeader("Film Studio", false, "Film Studio");
	addMissionHeader("Kaufman Cabs", false, "Kaufman Cabs");
	addMissionHeader("Malibu", false, "Malibu");
	
	// Adding settings for "mission2" list and storing in missionList.
	foreach (var mission in vars.mission2)
	{
		settings.CurrentDefaultParent = "Assets";
		// Seperate check for Rifle Range to categorize it appropriately
		if (mission.Key == "Rifle Range (45 Points)") {
			settings.CurrentDefaultParent = "Odd Jobs";
		}
		settings.Add(mission.Key, false, mission.Key);
		vars.missionList.Add(mission.Key);
	}
	
	// Both SSA objectives
	settings.CurrentDefaultParent = "Sunshine Autos";
	addMissionHeader("Sunshine Autos Imports", false, "Imports");
	addMissionHeader("Sunshine Autos Races", false, "Races");
	
	// And everything else
	settings.CurrentDefaultParent = "Odd Jobs";
	addMissionHeader("Stadium Events", false, "Stadium Events");
	settings.Add("stadAll", false, "Stadium Events (All Done)", "Stadium Events"); // setting used later to split for all 3 stadium missions
	addMissionHeader("Chopper Checkpoints", false, "Chopper Checkpoints");
	addMissionHeader("Off-Road Challenges", false, "Off-Road Challenges");
	addMissionHeader("RC Top-Fun", false, "RC Top-Fun");
	addMissionHeader("Vehicle Missions", false, "Vehicle Missions");
	
	// Collectibles (Packages, Rampages, USJs, Robberies, and Properties/Safehouses).
	settings.CurrentDefaultParent = "Collectibles";
	addMissionHeader("Safehouses", false, "Safehouses");
	foreach (var item in vars.collectibles)
	{
		// Add seperate settings depending on player preference. Split for each collectible gathered, or when all are gathered.
		settings.Add(item.Key+"All", false, item.Key+" (All Done)");
		settings.Add(item.Key+"Each", false, item.Key+" (Each)");
		vars.collectibleList.Add(item.Key);
	}
	settings.CurrentDefaultParent = null;	
	
	// Setting for final split of Any%.
	settings.Add("btgFinalSplit", false, "Any% Final Split");
	settings.SetToolTip("btgFinalSplit", "Splits once you lose control on \"Keep Your Friends Close\".");
	
	// State checking
	// --------------
	
	// Used later to track last loadtime.
	vars.lastLoad = 0;
	
	// Used to prevent splitting if the game was loaded recently
	vars.waiting = false;
	
	// Setting a check later for timer phase.
	vars.PrevPhase = null;
	
	// Used later to count stadium missions.
	vars.stadAllCount = 0;
	
}

init
{
	vars.offset = 0;
	vars.split = new List<string>(); // to keep a list of split splits.
	
	// Detects current game version if Steam.
	if (modules.First().ModuleMemorySize == 6905856)
	{
		version = "Steam";
		vars.offset = -0xFF8;
	}
	
	// Detects current game version if RU Steam (also maybe detects 1.1?).
	// Russian Steam version uses the same stuff as 1.1.
	else if (modules.First().ModuleMemorySize == 6840320)
	{
		version = "1.1";
		vars.offset = 8;
	}
	
	else {
		// Detects current game version if not Steam.
		switch ((int)current.gameVersion)
		{
			case 93:
				version = "1.0";
				vars.offset = 0;
				break;
			case 129:
				version = "1.1";
				vars.offset = 8;
				break;
			case 68:
				version = "Japanese";
				vars.offset = -0x2FF8;
				break;
		}
	}
	
	// Adds mission memory addresses (with the correct offset) to the watcher list.
	vars.memoryWatchers = new MemoryWatcherList();

	foreach (var address in vars.missionAddresses) {
		foreach (var m in address.Value) {
					if (address.Key == "RC Top-Fun" && vars.offset == -0x2FF8) { // RC mission offsets are different from all other addresses in JP
					vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(m.Key+vars.offset+8)) { Name = m.Value });
					}
					else {
					vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(m.Key+vars.offset)) { Name = m.Value });
					}
		}
	}
	
	// More...
	foreach (var address in vars.mission2) {
		vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(address.Value+vars.offset)) { Name = address.Key });
	}
	
	// ...and even more.
	foreach (var item in vars.collectibles) {
		var type = item.Key;
		var addr = item.Value+vars.offset;
		vars.memoryWatchers.Add(
			new MemoryWatcher<int>(
				new DeepPointer(addr)
			) { Name = type }
		);
	}
	
	// Add correct memory address for the "game state" to the watcher list.
	var gameStateAddress = (version == "Japanese") ? 0x5B2F18 : 0x5B5F08+vars.offset;
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(gameStateAddress)) { Name = "gameState" });
	
	// Japanese game state is shifted by +4 (due to more intro movies) so needs to be taken into account later.
	vars.gameStateShift = (version == "Japanese") ? 4 : 0;
	
	// Used to know when the player loads a saved game. 0 if so and 1 if not.
	// This is needed so the timer doesn't start if you load a save game after the initial boot up.
	vars.memoryWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x574B74+vars.offset)) { Name = "notLoadingCheck" });
	
	// Memory addresses used for the final split of Any% (see below).
	vars.memoryWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x426104+vars.offset)) { Name = "kyfc1" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x425DAC+vars.offset)) { Name = "kyfc2" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x426100+vars.offset)) { Name = "kyfc3" });
	
	// This is all "split at start of mission" address tracking.
	// ---------------------------------------------------------
	
	// A list of names and memory addresses for OMFs, both the main one and ones for side missions and such.
	vars.OMFList = new List<string> {"OMFParamedic", "OMFFirefighter", "OMFTaxi", "OMFRampage", "OMFPhonecall", "OMFSaveGame"};
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x421764+vars.offset)) { Name = "OMF" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x42177C+vars.offset)) { Name = "OMFParamedic" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x421784+vars.offset)) { Name = "OMFFirefighter" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x421768+vars.offset)) { Name = "OMFTaxi" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x3E2B2C+vars.offset)) { Name = "OMFRampage" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x4224F0+vars.offset)) { Name = "OMFPhonecall" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x60D228+vars.offset)) { Name = "OMFSaveGame" });
	
	// This address will be 0 if vigilante is currently running or it was never started, or 1 if started once and not running.
	var OMFVigilanteAddress = (version == "Japanese") ? 0x424E68 : 0x427E58+vars.offset;
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(OMFVigilanteAddress)) { Name = "OMFVigilante" });
	
	// This address will be 0 if vigilante has never been started, -100 on start and then a high number that decreases while on vigilante.
	// The high number will then freeze if vigilante is cancelled.
	var VigilanteTimerAddress = (version == "Japanese") ? 0x424E60 : 0x427E50+vars.offset;
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(VigilanteTimerAddress)) { Name = "VigilanteTimer" });
	// End "split at start of mission" address tracking.
	// ---------------------------------------------------------
	
	// Watch for load/saving to prevent splitting after load (this can happen if memory addresses change)
	vars.memoryWatchers.Add(new MemoryWatcher<bool>(new DeepPointer(0x38D724+vars.offset)) { Name = "Loading" });
}

update
{
	// Disables all the action blocks below in the code if the user is using an unsupported version.
	if (version == "")
		return false;
		
	// Update all of the memory readings for the mission memory addresses.
	vars.memoryWatchers.UpdateAll(game);
	
	// Reset some variables when the timer is started, so we don't need to rely on the start action in this script.
	if (timer.CurrentPhase != vars.PrevPhase)
	{
		if (timer.CurrentPhase == TimerPhase.NotRunning)
		{
			vars.split.Clear();
			vars.queuedSplit = false;
			vars.DebugOutput = ("Cleared completed splits");
		}
		vars.PrevPhase = timer.CurrentPhase;
	}
}

split
{
	vars.doSplit = false;
	
	if (vars.memoryWatchers["Loading"].Current) {
		vars.lastLoad = Environment.TickCount;
		return false;
	}
	
	if (Environment.TickCount - vars.lastLoad < 1000) {
		// Prevent splitting shortly after loading from a save, since this can
		// sometimes occur because memory values change
		if (!vars.waiting)
		{
			print("Wait..");
			vars.waiting = true;
		}
		return false;
	}
	if (vars.waiting)
	{
		print("Done waiting..");
		vars.waiting = false;
	}	
	
	// Goes through all the missions in the list, checks if their setting is enabled, if the mission has just been passed
	// and also if we haven't split for this mission yet. If so, splits.
	foreach (var mission in vars.missionList) {
		// seperate check if we are splitting for all stadium missions.
		if (settings["stadAll"]) {
			foreach (var stadEvent in vars.stadList) {
				if (vars.memoryWatchers[stadEvent].Current > vars.memoryWatchers[stadEvent].Old && !vars.split.Contains(stadEvent)) {
					vars.split.Add(stadEvent);
					// add the completed stadium mission to splits list, and increment total counter by 1.
					vars.stadAllCount = vars.stadAllCount + 1;
					if (vars.stadAllCount == 3) {
						// when all 3 are done, split!
						vars.doSplit = true;
					}
				}
			}
		}
		if (settings[mission] && vars.memoryWatchers[mission].Current > vars.memoryWatchers[mission].Old && !vars.split.Contains(mission)) {
			vars.split.Add(mission);
			
			// If the relevant setting is active, queues up the split to be done at a later time; if not, just splits now.
			if (settings["OMFSplit"]) {
				vars.queuedSplit = true;
			}
				vars.doSplit = true;
		}
	}
	
	// collectible splitting
	foreach (var item in vars.collectibleList) {
		var cvalue = vars.memoryWatchers[item.ToString()];
		if (cvalue.Current > cvalue.Old) {
			if (settings[item+"All"]) // adjusting the max count for each collectible type based on what we want to split.
			{
				int max = 15;
				if (item == "Rampages")	{
					max = 35;
				}
				if (item == "Stunt Jumps") {
					max = 36;
				}
				if (item == "Packages")	{
					max = 100;
				}
				if (cvalue.Current == max && cvalue.Old == max-1) {
					var splitName = item+" "+cvalue.Current;
					if (!vars.split.Contains(splitName)) {
						vars.split.Add(splitName);
						vars.doSplit = true;
					}
				}
			}
			if (settings[item+"Each"]) { // if it's each, add the collectible to splits list and try to split.
					var splitName = item+" "+cvalue.Current;
					if (!vars.split.Contains(splitName)) {
						vars.split.Add(splitName);
						vars.doSplit = true;
					}				
			}
		}
	}
	
	// more OMFSplit stuff.
	// If there is a queued split and the OMF has changed to 1, then check to see if we should split now or not.
	if (settings["OMFSplit"] && vars.queuedSplit && vars.memoryWatchers["OMF"].Current > vars.memoryWatchers["OMF"].Old) {
		vars.sideMissionOM = false;
		
		// Checks to see if the OMF change wasn't that of a side mission or similar.
		foreach (var sideMissionOMF in vars.OMFList) {
			if (vars.memoryWatchers[sideMissionOMF].Current > vars.memoryWatchers[sideMissionOMF].Old) {
				vars.sideMissionOM = true;
				print("skipping split because side mission");
			}
		}
		
		// Vigilante requires a special check because of the way the addresses work.
		if (vars.memoryWatchers["OMFVigilante"].Current < vars.memoryWatchers["OMFVigilante"].Old
			|| (vars.memoryWatchers["VigilanteTimer"].Current == -100 && vars.memoryWatchers["VigilanteTimer"].Old != -100)) {
			vars.sideMissionOM = true;
			print("skipping split because side mission");
		}
		
		// If the checks above returned nothing, then we will split.
		if (!vars.sideMissionOM) {
			vars.doSplit = true; vars.queuedSplit = false;
		}
	}

	// Splits for the final split of Any%.
	if (settings["btgFinalSplit"] && vars.memoryWatchers["kyfc1"].Current == 245 && vars.memoryWatchers["kyfc2"].Current > vars.memoryWatchers["kyfc3"].Current && !vars.Split.Contains("btgFinalSplit")) {
		vars.split.Add("btgFinalSplit");
		vars.doSplit = true;
	}
	
	if (vars.doSplit)
		return true;
}

start
{
	// Starts the splits when the new game load has been completed (and is not a save).
	return vars.memoryWatchers["gameState"].Old == 8+vars.gameStateShift
	&& vars.memoryWatchers["gameState"].Current == 9+vars.gameStateShift
	&& vars.memoryWatchers["notLoadingCheck"].Current == 1;
}

reset
{
	// Resets the timer when the new game load starts but only if the timer isn't over 19 seconds yet.
	return vars.memoryWatchers["gameState"].Old == 9+vars.gameStateShift
	&& vars.memoryWatchers["gameState"].Current == 8+vars.gameStateShift
	&& TimeSpan.Parse(timer.CurrentTime.RealTime.ToString()).TotalSeconds > 19;
}

isLoading
{
	// Load removing for loading screens in the game (found by Mhmd_FVC).
	return current.islandLoad > 0 || current.loadSaveLoad > 0 || current.replayLoad > 0 || current.genLoad > 0;
}
