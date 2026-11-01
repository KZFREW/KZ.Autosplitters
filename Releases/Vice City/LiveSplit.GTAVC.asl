// Original autosplitter by zoton2 and pitpo.
// Current iteration originally built by KZ_FREW, based off San Andreas script by tduva, memory addresses borrowed from Lighnat0r.
// Contributions by Mhmd_FVC, iguaan, hoXyy, Anti, NABN00B, dezodor.
// Maintained (feature parity) by hoXyy.

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

//state("testapp", "Steam") {} // Needs proper implementation.

state("gta-vc", "Japanese")
{
	int islandLoad : 0x302310;
	int loadSaveLoad : 0x38A72C;
	int replayLoad : 0x387734;
	byte genLoad : 0x2F4759;
	float camX : 0x3006B0;
	float camY : 0x3006B4;
	float camZ : 0x3006B8;
	bool tswineCall : 0x41F460;
	bool sysCall : 0x41F4AC;
	bool ctcCall: 0x41F430;
}

startup
{
	// Set the autosplitter refresh rate.
	// Lower = less CPU and less accurate, higher = more CPU usage and more accurate, default: 60.
	refreshRate = 30;

	// Memory Addresses
	// ----------------------------------------
	// For 1.0, see init{} for where offsets get added.

	// Collectible addresses.
	vars.collectibles = new Dictionary<string, int> {
		{"Packages", 0x54ADD0},
		{"Rampages", 0x42286C},
		{"Robberies", 0x422A6C},
		{"Stunt Jumps", 0x421EDC}
	};

	// Single objective asset/mission addresses (sans Kent Paul).
	vars.mission2 = new Dictionary<string, int> {
		{"Checkpoint Charlie (Boatyard)", 0x421BFC},
		{"Distribution (Cherry Poppers)", 0x421C10},
		{"Pole Position ($300 Spent)", 0x4223A0},
		{"Rifle Range (45 Points)", 0x421430}
	};

	// Story, asset and side mission addresses.
	vars.missionAddresses = new Dictionary<string, Dictionary<int, string>> {
		{"Ken Rosenberg", new Dictionary<int, string> {
			{0x4215F8, "An Old Friend"},
			{0x421600, "The Party"},
			{0x421604, "Back Alley Brawl"},
			{0x421608, "Jury Fury"},
			{0x42160C, "Riot"}
		}},
		{"Cortez", new Dictionary<int, string> {
			{0x421614, "Treacherous Swine"},
			{0x421618, "Mall Shootout"},
			{0x42161C, "Guardian Angels"},
			{0x421620, "Sir, Yes Sir!"},
			{0x421624, "All Hands On Deck!"}
		}},
		{"Diaz", new Dictionary<int, string> {
			{0x42162C, "The Chase"},
			{0x421630, "Phnom Penh '86"},
			{0x421634, "The Fastest Boat"},
			{0x421638, "Supply & Demand"},
			{0x42163C, "Rub Out"}
		}},
		{"Kent Paul", new Dictionary<int, string> {
			{0x421648, "Death Row"}
		}},
		{"Mr. Black", new Dictionary<int, string> {
			{0x421728, "Road Kill"},
			{0x42172C, "Waste the Wife"},
			{0x421730, "Autocide"},
			{0x421734, "Check Out at the Check In"},
			{0x421738, "Loose Ends"}
		}},
		{"Avery", new Dictionary<int, string> {
			{0x421650, "Four Iron"},
			{0x421654, "Demolition Man"},
			{0x421658, "Two Bit Hit"}
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
		{"Love Fist", new Dictionary<int, string> {
			{0x421700, "Love Juice"},
			{0x421704, "Psycho Killer"},
			{0x421708, "Publicity Tour"}
		}},
		{"Mitch Baker", new Dictionary<int, string> {
			{0x4216CC, "Alloy Wheels of Steel"},
			{0x4216D0, "Messing with the Man"},
			{0x4216D4, "Hog Tied"}
		}},
		{"Vercetti Mansion", new Dictionary<int, string> {
			{0x4216A8, "Shakedown"},
			{0x4216AC, "Bar Brawl"},
			{0x4216B0, "Cop Land"},
			{0x4216B8, "Keep your Friends Close..."}
		}},
		{"Printworks", new Dictionary<int, string> {
			{0x4216C0, "Spilling the Beans"},
			{0x4216C4, "Hit the Courier"},
			{0x4216B4, "Cap the Collector"}
		}},
		{"Film Studio", new Dictionary<int, string> {
			{0x421684, "Recruitment Drive"},
			{0x421688, "Dildo Dodo"},
			{0x42168C, "Martha's Mug Shot"},
			{0x421690, "G-spotlight"}
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
		{"Phil Cassidy", new Dictionary<int, string> {
			{0x421678, "Gun Runner"},
			{0x42167C, "Boomshine Saigon"}
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
		{"Stadium Events", new Dictionary<int, string> {
			{0x422B74, "Hotring"},
			{0x422B78, "Bloodring"},
			{0x42135C, "Dirtring"}
		}},
		{"Chopper Checkpoints", new Dictionary<int, string> { // Some of these don't work.
			{0x422B44, "Ocean Beach Chopper Checkpoint"},
			{0x422B48, "Vice Point Chopper Checkpoint"},
			{0x422B4C, "Little Haiti Chopper Checkpoint"},
			{0x422B40, "Downtown Chopper Checkpoint"}
		}},
		{"Off-Road Challenges", new Dictionary<int, string> {
			{0x4217FC, "Cone Crazy"},
			{0x4217CC, "PCJ Playground"},
			{0x421830, "Test Track"},
			{0x42182C, "Trial By Dirt"}
		}},
		{"RC Top-Fun", new Dictionary<int, string> {
			{0x429344, "RC Bandit"},
			{0x429714, "RC Baron"},
			{0x4291F0, "RC Raider"}
		}},
		{"Vehicle Missions", new Dictionary<int, string> {
			{0x422B3C, "Firefighter (Level 12)"},
			{0x422B34, "Paramedic (Level 12)"},
			{0x421894, "Pizza Boy (Level 10)"},
			{0x421854, "Taxi (100 Fares)"},
			{0x422B38, "Vigilante (Level 12)"}
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

	// Story, asset and side mission script names.
	vars.missionScripts = new Dictionary<int, string> {
		// Ken Rosenberg
		{0x4215F8, "HOTEL"}, // An Old Friend
		{0x421600, "LAWYER1"}, // The Party
		{0x421604, "LAWYER2"}, // Back Alley Brawl
		{0x421608, "LAWYER3"}, // Jury Fury
		{0x42160C, "LAWYER4"}, // Riot

		// Cortez
		{0x421614, "GENERL1"}, // Treacherous Swine
		{0x421618, "COL2"}, // Mall Shootout
		{0x42161C, "GENERL3"}, // Guardian Angels
		{0x421620, "COL_4"}, // Sir, Yes Sir!
		{0x421624, "COL_5"}, // All Hands On Deck!

		// Diaz
		{0x42162C, "BARON1"}, // The Chase
		{0x421630, "BARON2"}, // Phnom Penh '86
		{0x421634, "BARON3"}, // The Fastest Boat
		{0x421638, "BARON4"}, // Supply & Demand
		{0x42163C, "BARON5"}, // Rub Out

		// Kent Paul
		{0x421648, "KENT1"}, // Death Row

		// Mr. Black
		{0x421728, "ASSIN1"}, // Road Kill
		{0x42172C, "ASSIN2"}, // Waste the Wife
		{0x421730, "ASSIN3"}, // Autocide
		{0x421734, "ASSIN4"}, // Check Out at the Check In
		{0x421738, "ASSIN5"}, // Loose Ends

		// Avery
		{0x421650, "SERG1"}, // Four Iron
		{0x421654, "SERG3"}, // Demolition Man
		{0x421658, "SERG2"}, // Two Bit Hit

		// Umberto Robina
		{0x4216DC, "CUBAN1"}, // Stunt Boat Challenge
		{0x4216E0, "CUBAN2"}, // Cannon Fodder
		{0x4216E4, "CUBAN3"}, // Naval Engagement
		{0x4216E8, "CUBAN4"}, // Trojan Voodoo

		// Auntie Poulet
		{0x4216F0, "HAIT1"}, // Juju Scramble
		{0x4216F4, "HAIT2"}, // Bombs Away!
		{0x4216F8, "HAIT3"}, // Dirty Lickin's

		// Love Fist
		{0x421700, "ROCKB1"}, // Love Juice
		{0x421704, "ROCKB2"}, // Psycho Killer
		{0x421708, "ROCKB3"}, // Publicity Tour

		// Mitch Baker
		{0x4216CC, "BIKE1"}, // Alloy Wheels of Steel
		{0x4216D0, "BIKE2"}, // Messing with the Man
		{0x4216D4, "BIKE3"}, // Hog Tied

		// Vercetti Mansion
		{0x4216A8, "PROTEC1"}, // Shakedown
		{0x4216AC, "PROTEC2"}, // Bar Brawl
		{0x4216B0, "PROTEC3"}, // Cop Land
		{0x4216B8, "FIN_1"}, // Keep your Friends Close...

		// Printworks
		{0x4216C0, "COUNT1"}, // Spilling the Beans
		{0x4216C4, "COUNT2"}, // Hit the Courier
		{0x4216B4, "CAP_1"}, // Cap the Collector

		// Film Studio
		{0x421684, "PORNO1"}, // Recruitment Drive
		{0x421688, "PORNO2"}, // Dildo Dodo
		{0x42168C, "PORNO3"}, // Martha's Mug Shot
		{0x421690, "PORNO4"}, // G-spotlight

		// Kaufman Cabs
		{0x421750, "TAXWAR1"}, // V.I.P.
		{0x421754, "TAXWAR2"}, // Friendly Rivalry
		{0x421758, "TAXWAR3"}, // Cabmaggedon

		// Malibu
		{0x421660, "BANKJO1"}, // No Escape?
		{0x421664, "BANKJO2"}, // The Shootist
		{0x421668, "BANKJO3"}, // The Driver
		{0x42166C, "BANKJO4"}, // The Job

		// Phil Cassidy
		{0x421678, "PHIL1"}, // Gun Runner
		{0x42167C, "PHIL2"}, // Boomshine Saigon

		// Stadium Events
		{0x422B74, "OVALRNG"}, // Hotring
		{0x422B78, "MM"}, // Bloodring
		{0x42135C, "KICKST"}, // Dirtring

		// Chopper Checkpoints
		{0x422B44, "HELI2SC"}, // Ocean Beach Chopper Checkpoint
		{0x422B48, "HELI3SC"}, // Vice Point Chopper Checkpoint
		{0x422B4C, "HELI4SC"}, // Little Haiti Chopper Checkpoint
		{0x422B40, "HELI1SC"}, // Downtown Chopper Checkpoint

		// Off-Road Challenges
		{0x4217FC, "CARPRK1"}, // Cone Crazy
		{0x4217CC, "T4X4_1"}, // PCJ Playground
		{0x421830, "BMX_2"}, // Test Track
		{0x42182C, "BMX_1"}, // Trial By Dirt

		// RC Top-Fun
		{0x429344, "RCRACE1"}, // RC Bandit
		{0x429714, "RCPLNE1"}, // RC Baron
		{0x4291F0, "RCHELI"}, // RC Raider

		// Vehicle Missions
		{0x422B3C, "FIRETRU"}, // Firefighter
		{0x422B34, "AMBULAN"}, // Paramedic
		{0x421894, "PIZZA"}, // Pizza Boy
		{0x421854, "TAXI"}, // Taxi
		{0x422B38, "COPCAR"} // Vigilante
	};

	// Collections
	// ----------------------------------------

	// Creating separate collections for easier checking later.
	vars.missionList = new List<string>();
	// Mission-start setting IDs mapped to script names.
	vars.missionStarts = new Dictionary<string, string>();
	vars.collectibleList = new List<string>();
	vars.stadList = new List<string>(); // Stadium missions list

	// Setting and Collection Filling Functions
	// ----------------------------------------

	// Inserts split into settings and adds the mission to our separate list.
	Action<string, bool> addMissionChain = (missions, defaultValue) => {
		var parent = missions;
		foreach (var address in vars.missionAddresses[missions]) {
			bool isEnabled = defaultValue;
			if (address.Value == "An Old Friend" || address.Value == "All Hands On Deck!") {
				isEnabled = false; // Force disable the settings for these missions.
			}
			settings.Add(address.Value, isEnabled, address.Value, parent);
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

	// Copy of above functions for mission/asset start.
	Action<string, bool> addMissionChainStart = (missions, defaultValue) => {
		var parent = missions;
		foreach (var address in vars.missionAddresses[missions]) {
			bool isEnabled = defaultValue;
			if (address.Value == "An Old Friend" || address.Value == "The Party" || address.Value == "All Hands On Deck!") {
				isEnabled = false; // Force disable the settings for these missions.
			}
			var missionName = address.Value;
			if (parent == "Vehicle Missions") {
				// Start labels do not need completion targets such as "(Level 12)".
				missionName = missionName.Substring(0, missionName.LastIndexOf(" ("));
			}
			settings.Add(missionName + " (start)", isEnabled, missionName, parent + " (start)");
			vars.missionStarts.Add(missionName + " (start)", vars.missionScripts[address.Key]);
		}
	};

	Action<string, bool, string> addMissionHeaderStart = (missions, defaultValue, header) => {
		var parent = missions;
		settings.Add(parent + " (start)", defaultValue, header);
		addMissionChainStart(missions, defaultValue);
	};

	// Settings Page
	// ----------------------------------------

	// Parent settings.
	settings.Add("Missions (end)", true, "Missions (end)");
	settings.Add("Assets (end)", true, "Assets (end)");
	settings.Add("Missions (start)", false, "Missions (start)");
	settings.Add("Assets (start)", false, "Assets (start)");
	settings.Add("Odd Jobs", false, "Odd Jobs (end)");
	settings.Add("Odd Jobs (start)", false, "Odd Jobs (start)");
	settings.Add("Collectibles", false, "Collectibles");
	settings.Add("No SSU Specific", false, "Any% No SSU traditional segments");

	// Settings for Any% No SSU traditional segment splits by Anti.
	settings.CurrentDefaultParent = "No SSU Specific";
	settings.Add("Tswine", true, "Treacherous Swine start");
	settings.Add("StarIsland", true, "The Chase start");
	settings.Add("SYS", true, "Sir, Yes Sir! start");
	settings.Add("DiazDed", true, "Diaz Dead");
	settings.Add("CopLandEnd", true, "Cop Land fadeout");
	settings.Add("CTC", true, "Cap the Collector start");

	// Adding mission headers for mission end.
	settings.CurrentDefaultParent = "Missions (end)";
	addMissionHeader("Ken Rosenberg", true, "Lawyer");
	addMissionHeader("Cortez", true, "Cortez");
	addMissionHeader("Diaz", true, "Diaz");
	addMissionHeader("Kent Paul", true, "Kent Paul");

	addMissionHeader("Mr. Black", false, "Mr. Black");
	addMissionHeader("Avery", false, "Avery");
	addMissionHeader("Umberto Robina", false, "Umberto Robina");
	addMissionHeader("Auntie Poulet", false, "Auntie Poulet");
	addMissionHeader("Love Fist", false, "Love Fist");
	addMissionHeader("Mitch Baker", false, "Mitch Baker");

	// Asset (end) headers (includes Mansion and Printworks).
	settings.CurrentDefaultParent = "Assets (end)";
	addMissionHeader("Vercetti Mansion", true, "Vercetti Mansion");
	addMissionHeader("Printworks", true, "Printworks");
	addMissionHeader("Film Studio", false, "Film Studio");
	addMissionHeader("Kaufman Cabs", false, "Kaufman Cabs");
	addMissionHeader("Malibu", false, "Malibu");
	addMissionHeader("Phil Cassidy", false, "Phil Cassidy");

	// Adding headers for both SSA objectives.
	settings.Add("Sunshine Autos", false, "Sunshine Autos");
	settings.CurrentDefaultParent = "Sunshine Autos";
	addMissionHeader("Sunshine Autos Imports", false, "Imports");
	addMissionHeader("Sunshine Autos Races", false, "Races");

	// Adding mission end settings for "mission2" list and storing in missionList.
	foreach (var mission in vars.mission2) {
		settings.CurrentDefaultParent = "Assets (end)";
		// Seperate check for Rifle Range to categorize it appropriately.
		if (mission.Key == "Rifle Range (45 Points)") {
			settings.CurrentDefaultParent = "Odd Jobs";
		}
		settings.Add(mission.Key, false, mission.Key);
		vars.missionList.Add(mission.Key);
	}

	// Adding mission headers for mission start.
	settings.CurrentDefaultParent = "Missions (start)";
	addMissionHeaderStart("Ken Rosenberg", true, "Lawyer");
	addMissionHeaderStart("Cortez", true, "Cortez");
	addMissionHeaderStart("Diaz", true, "Diaz");
	addMissionHeaderStart("Kent Paul", true, "Kent Paul");

	addMissionHeaderStart("Mr. Black", false, "Mr. Black");
	addMissionHeaderStart("Avery", false, "Avery");
	addMissionHeaderStart("Umberto Robina", false, "Umberto Robina");
	addMissionHeaderStart("Auntie Poulet", false, "Auntie Poulet");
	addMissionHeaderStart("Love Fist", false, "Love Fist");
	addMissionHeaderStart("Mitch Baker", false, "Mitch Baker");

	// Asset (start) headers (includes Mansion and Printworks).
	settings.CurrentDefaultParent = "Assets (start)";
	addMissionHeaderStart("Vercetti Mansion", true, "Vercetti Mansion");
	addMissionHeaderStart("Printworks", true, "Printworks");
	addMissionHeaderStart("Film Studio", false, "Film Studio");
	addMissionHeaderStart("Kaufman Cabs", false, "Kaufman Cabs");
	addMissionHeaderStart("Malibu", false, "Malibu");
	addMissionHeaderStart("Phil Cassidy", false, "Phil Cassidy");

	// Adding mission start settings for singleton assets and storing in missionStarts.
	settings.Add("Checkpoint Charlie (start)", false, "Checkpoint Charlie (Boatyard)");
	vars.missionStarts.Add("Checkpoint Charlie (start)", "COKERUN");
	settings.Add("Distribution (start)", false, "Distribution (Cherry Poppers)");
	vars.missionStarts.Add("Distribution (start)", "ICECRE1");

	// Adding asset purchase settings and storing in missionStarts.
	foreach (var asset in new Dictionary<string, string> {
		{"Sunshine Autos (purchase)", "CARBUY1"},
		{"Boatyard (purchase)", "BOATBY"},
		{"Printworks (purchase)", "BUYPRO1"},
		{"Film Studio (purchase)", "BUYPRO2"},
		{"Malibu (purchase)", "BUYPRO3"},
		{"Pole Position (purchase)", "BUYPRO4"},
		{"Cherry Poppers (purchase)", "ICECUT"},
		{"Kaufman Cabs (purchase)", "TAXCUT"},
	}) {
		settings.Add(asset.Key, false);
		vars.missionStarts.Add(asset.Key, asset.Value);
	}

	// Adding mission end setting for every other side mission.
	settings.CurrentDefaultParent = "Odd Jobs";
	addMissionHeader("Stadium Events", false, "Stadium Events");
	settings.Add("stadAll", false, "Stadium Events (All Done)", "Stadium Events"); // Setting used later to split for all 3 stadium missions.
	addMissionHeader("Chopper Checkpoints", false, "Chopper Checkpoints");
	addMissionHeader("Off-Road Challenges", false, "Off-Road Challenges");
	addMissionHeader("RC Top-Fun", false, "RC Top-Fun");
	addMissionHeader("Vehicle Missions", false, "Vehicle Missions");

	// Adding mission start setting for every other side mission.
	settings.CurrentDefaultParent = "Odd Jobs (start)";
	settings.Add("Rifle Range (start)", false, "Rifle Range");
	vars.missionStarts.Add("Rifle Range (start)", "RANGE");
	addMissionHeaderStart("Stadium Events", false, "Stadium Events");
	addMissionHeaderStart("Chopper Checkpoints", false, "Chopper Checkpoints");
	addMissionHeaderStart("Off-Road Challenges", false, "Off-Road Challenges");
	addMissionHeaderStart("RC Top-Fun", false, "RC Top-Fun");
	addMissionHeaderStart("Vehicle Missions", false, "Vehicle Missions");
	settings.SetToolTip("Vehicle Missions (start)", "WARNING: Only first vehicle mission start will be splitted");

	// Collectibles (Packages, Rampages, USJs, Robberies, and Properties/Safehouses).
	settings.CurrentDefaultParent = "Collectibles";
	addMissionHeader("Safehouses", false, "Safehouses");
	foreach (var item in vars.collectibles) {
		// Add seperate settings depending on player preference. Split for each collectible gathered, or when all are gathered.
		settings.Add(item.Key + "All", false, item.Key + " (All Done)");
		settings.Add(item.Key + "Each", false, item.Key + " (Each)");
		vars.collectibleList.Add(item.Key);
	}

	// Setting for final split of Any%.
	settings.CurrentDefaultParent = null;
	settings.Add("btgFinalSplit", true, "Any% Final Split");
	settings.SetToolTip("btgFinalSplit", "Splits once you lose control on \"Keep Your Friends Close\".");

	// State Checking
	// ----------------------------------------

	// Used later to track last loadtime.
	vars.lastLoad = 0;

	// Used to prevent splitting if the game was loaded recently.
	vars.waiting = false;

	// Setting a check later for timer phase.
	vars.prevPhase = null;

	// Used later to count stadium missions.
	vars.stadAllCount = 0;

	vars.cameraAt = (Func<float, float, float, float, float, float, bool>)((camX, camY, camZ, x, y, z) =>
		Math.Abs(camX - x) < 0.01f &&
		Math.Abs(camY - y) < 0.01f &&
		Math.Abs(camZ - z) < 0.01f
	);
	
}

init
{
	vars.offset = 0;
	vars.split = new List<string>(); // To keep a list of split splits.

	// Version Detection
	// ----------------------------------------

	// Detects current game version if Steam.
	if (modules.First().ModuleMemorySize == 6905856) {
		version = "Steam";
		vars.offset = -0xFF8;
	}

	else if (modules.First().ModuleMemorySize == 6553600) {
		version = "Steam";
		vars.offset = -0xFF8;
	}

	// Detects current game version if RU Steam (also maybe detects 1.1?).
	// Russian Steam version uses the same stuff as 1.1.
	else if (modules.First().ModuleMemorySize == 6840320) {
		version = "1.1";
		vars.offset = 8;
	}

	// Detects current game version if not Steam.
	else {
		switch ((int)current.gameVersion) {
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
	
	// Memory Watchers
	// ----------------------------------------
	
	// Adds mission memory addresses (with the correct offset) to the watcher list.
	vars.memoryWatchers = new MemoryWatcherList();

	foreach (var address in vars.missionAddresses) {
		foreach (var m in address.Value) {
			if (address.Key == "RC Top-Fun" && vars.offset == -0x2FF8) { // RC mission offsets are different from all other addresses in JP.
				vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(m.Key + vars.offset + 8)) { Name = m.Value });
			}
			else {
				vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(m.Key + vars.offset)) { Name = m.Value });
			}
		}
	}

	// Standalone mission addresses...
	foreach (var address in vars.mission2) {
		vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(address.Value + vars.offset)) { Name = address.Key });
	}

	// ...and collectible addresses.
	foreach (var item in vars.collectibles) {
		var type = item.Key;
		var addr = item.Value + vars.offset;
		vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(addr)) { Name = type });
	}

	// Add correct memory address for the "game state" to the watcher list.
	var gameStateAddress = (version == "Japanese") ? 0x5B2F18 : 0x5B5F08 + vars.offset;
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(gameStateAddress)) { Name = "gameState" });

	// Japanese game state is shifted by +4 (due to more intro movies) so needs to be taken into account later.
	vars.gameStateShift = (version == "Japanese") ? 4 : 0;

	// Used to know when the player loads a saved game. 0 if so and 1 if not.
	// This is needed so the timer doesn't start if you load a save game after the initial boot up.
	vars.memoryWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x574B74 + vars.offset)) { Name = "notLoadingCheck" });

	// Memory addresses used for the final split of Any% (see below).
	vars.memoryWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x426104 + vars.offset)) { Name = "kyfc1" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x425DAC + vars.offset)) { Name = "kyfc2" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x426100 + vars.offset)) { Name = "kyfc3" });

	// This is all "split at start of mission" address tracking.
	// ---------------------------------------------------------
	vars.scriptPoolAddress = IntPtr.Add(modules.First().BaseAddress, 0x3DFC40 + vars.offset);

/* 	// A list of names and memory addresses for OMFs, both the main one and ones for side missions and such.
	vars.OMFList = new List<string> {"OMFParamedic", "OMFFirefighter", "OMFTaxi", "OMFRampage", "OMFPhonecall", "OMFSaveGame"};
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x421764 + vars.offset)) { Name = "OMF" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x42177C + vars.offset)) { Name = "OMFParamedic" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x421784 + vars.offset)) { Name = "OMFFirefighter" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x421768 + vars.offset)) { Name = "OMFTaxi" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x3E2B2C + vars.offset)) { Name = "OMFRampage" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x4224F0 + vars.offset)) { Name = "OMFPhonecall" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x60D228 + vars.offset)) { Name = "OMFSaveGame" });

	// This address will be 0 if vigilante is currently running or it was never started, or 1 if started once and not running.
	var OMFVigilanteAddress = (version == "Japanese") ? 0x424E68 : 0x427E58 + vars.offset;
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(OMFVigilanteAddress)) { Name = "OMFVigilante" });

	// This address will be 0 if vigilante has never been started, -100 on start and then a high number that decreases while on vigilante.
	// The high number will then freeze if vigilante is cancelled.
	var VigilanteTimerAddress = (version == "Japanese") ? 0x424E60 : 0x427E50 + vars.offset;
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(VigilanteTimerAddress)) { Name = "VigilanteTimer" }); */
	// End "split at start of mission" address tracking.
	// ---------------------------------------------------------

	// Watch for load/saving to prevent splitting after load (this can happen if memory addresses change)
	vars.memoryWatchers.Add(new MemoryWatcher<bool>(new DeepPointer(0x38D724 + vars.offset)) { Name = "Loading" });
	vars.useMissionScripts = null;
	vars.activeMissionScripts = null;
	vars.previousMissionScripts = null;
}

update
{
	// Disables all the action blocks below in the code if the user is using an unsupported version.
	if (version == "") {
		return false;
	}

	// Update all of the memory readings for the mission memory addresses.
	vars.memoryWatchers.UpdateAll(game);

	// Skip extra script checks when no mission-start splits are enabled.
	if (vars.useMissionScripts == null || timer.CurrentPhase == TimerPhase.NotRunning || vars.prevPhase == TimerPhase.NotRunning) {
		vars.useMissionScripts = false;
		foreach (var mission in vars.missionStarts) {
			if (settings[mission.Key]) {
				vars.useMissionScripts = true;
				break;
			}
		}
	}

	if (vars.useMissionScripts) {
		// Track loads while the timer is stopped to prevent an immediate split when it starts.
		if (vars.memoryWatchers["Loading"].Current) {
			vars.lastLoad = Environment.TickCount;
		}

		vars.previousMissionScripts = vars.activeMissionScripts;
		vars.activeMissionScripts = new HashSet<string>();

		// The game stores running scripts in a table of 128 reusable entries.
		// Missions have no fixed entry, so search the whole table to find active missions.
		const int scriptSize = 0x88;
		const int scriptNameOffset = 0x08;
		const int scriptNameLength = 8;
		const int activeFlagOffset = 0x78;
		IntPtr scriptPoolAddress = vars.scriptPoolAddress;

		for (int slot = 0; slot < 128; slot++) {
			IntPtr scriptAddress = scriptPoolAddress + slot * scriptSize;
			byte isActive;

			if (!game.ReadValue<byte>(scriptAddress + activeFlagOffset, out isActive)) {
				vars.activeMissionScripts = vars.previousMissionScripts;
				break;
			}

			if (isActive != 1) {
				continue;
			}

			var scriptName = game.ReadString(scriptAddress + scriptNameOffset, ReadStringType.ASCII, scriptNameLength);
			if (scriptName == null) {
				vars.activeMissionScripts = vars.previousMissionScripts;
				break;
			}

			scriptName = scriptName.ToUpperInvariant();
			if (vars.missionStarts.ContainsValue(scriptName)) {
				vars.activeMissionScripts.Add(scriptName);
			}
		}
	}
	else {
		vars.activeMissionScripts = null;
		vars.previousMissionScripts = null;
	}

	// Reset some variables when the timer is started, so we don't need to rely on the start action in this script.
	if (timer.CurrentPhase != vars.prevPhase) {
		if (timer.CurrentPhase == TimerPhase.NotRunning) {
			vars.split.Clear();
			vars.queuedSplit = false;
			vars.DebugOutput = ("Cleared completed splits");
		}
		vars.prevPhase = timer.CurrentPhase;
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
		if (!vars.waiting) {
			//print("Wait..");
			vars.waiting = true;
		}
		return false;
	}
	if (vars.waiting) {
		//print("Done waiting..");
		vars.waiting = false;
	}

	// Goes through all the missions in the list, checks if their setting is enabled, if the mission has just been passed
	// and also if we haven't split for this mission yet. If so, splits.
	foreach (var mission in vars.missionList) {
		// Seperate check if we are splitting for all stadium missions.
		if (settings["stadAll"]) {
			foreach (var stadEvent in vars.stadList) {
				if (vars.memoryWatchers[stadEvent].Current > vars.memoryWatchers[stadEvent].Old && !vars.split.Contains(stadEvent)) {
					// Add the completed stadium mission to splits list, and increment total counter by 1.
					vars.split.Add(stadEvent);
					vars.stadAllCount = vars.stadAllCount + 1;
					if (vars.stadAllCount == 3) {
						// When all 3 are done, split!
						vars.doSplit = true;
					}
				}
			}
		}
		if (settings[mission] && vars.memoryWatchers[mission].Current > vars.memoryWatchers[mission].Old && !vars.split.Contains(mission)) {
			vars.split.Add(mission);
			vars.doSplit = true;
		}
	}

	// Mission start splitting.
	if (vars.useMissionScripts) {
		foreach (var mission in vars.missionStarts) {
			var scriptName = mission.Value;
			bool missionStarted = vars.activeMissionScripts != null
				&& vars.previousMissionScripts != null
				&& vars.activeMissionScripts.Contains(scriptName)
				&& !vars.previousMissionScripts.Contains(scriptName);
			if (settings[mission.Key] && missionStarted && !vars.split.Contains(mission.Key)) {
				vars.split.Add(mission.Key);
				vars.doSplit = true;
			}
		}
	}

	// Collectible splitting.
	foreach (var item in vars.collectibleList) {
		var cvalue = vars.memoryWatchers[item.ToString()];
		if (cvalue.Current > cvalue.Old) {
			if (settings[item + "All"]) {
				// Adjusting the max count for each collectible type based on what we want to split.
				int max = 15;
				if (item == "Rampages") {
					max = 35;
				}
				if (item == "Stunt Jumps") {
					max = 36;
				}
				if (item == "Packages") {
					max = 100;
				}
				if (cvalue.Current == max && cvalue.Old == max - 1) {
					var splitName = item + " " + cvalue.Current;
					if (!vars.split.Contains(splitName)) {
						vars.split.Add(splitName);
						vars.doSplit = true;
					}
				}
			}
			if (settings[item + "Each"]) { // If it's each, add the collectible to splits list and try to split.
				var splitName = item + " " + cvalue.Current;
				if (!vars.split.Contains(splitName)) {
					vars.split.Add(splitName);
					vars.doSplit = true;
				}
			}
		}
	}
	
	// Any% No SSU traditional segment splits by Anti.
	// Remove this check for JP once support for cam variables is properly implemented in other versions.
	if (version == "Japanese") {
		if (settings["Tswine"]
				&& !vars.split.Contains("Tswine")
				&& vars.cameraAt(current.camX, current.camY, current.camZ, -229.438f, -1364.204f, 12.607f)
				&& current.tswineCall) {
			vars.split.Add("Tswine");
			vars.doSplit = true;
		}

		if (settings["StarIsland"]
				&& !vars.split.Contains("StarIsland")
				&& vars.cameraAt(current.camX, current.camY, current.camZ, -381.923f, -473.339f, 48.904f)) {
			vars.split.Add("StarIsland");
			vars.doSplit = true;
		}

		if (settings["SYS"]
				&& !vars.split.Contains("SYS")
				&& vars.cameraAt(current.camX, current.camY, current.camZ, -229.438f, -1364.204f, 12.607f)
				&& current.sysCall) {
			vars.split.Add("SYS");
			vars.doSplit = true;
		}

		if (settings["DiazDed"]
				&& !vars.split.Contains("DiazDed")
				&& Math.Abs(current.camX + 393.7734f) < 0.01f
				&& Math.Abs(current.camY + 555.7239f) < 0.01f
				&& current.camZ > 26.9f
				&& current.camZ < 27f) {
			vars.split.Add("DiazDed");
			vars.doSplit = true;
		}

		if (settings["CopLandEnd"]
				&& !vars.split.Contains("CopLandEnd")
				&& vars.cameraAt(current.camX, current.camY, current.camZ, -369.1f, -467.9f, 22.7f)) {
			vars.split.Add("CopLandEnd");
			vars.doSplit = true;
		}

		if (settings["CTC"]
				&& !vars.split.Contains("CTC")
				&& vars.cameraAt(current.camX, current.camY, current.camZ, -1039.093f, -293.828f, 27.81f)
				&& current.ctcCall) {
			vars.split.Add("CTC");
			vars.doSplit = true;
		}
	}

/* 	// more OMFSplit stuff.
	// If there is a queued split and the OMF has changed to 1, then check to see if we should split now or not.
	if (settings["OMFSplit"] && vars.queuedSplit && vars.memoryWatchers["OMF"].Current > vars.memoryWatchers["OMF"].Old) {
		vars.sideMissionOM = false;
		
		// Checks to see if the OMF change wasn't that of a side mission or similar.
		foreach (var sideMissionOMF in vars.OMFList) {
			if (vars.memoryWatchers[sideMissionOMF].Current > vars.memoryWatchers[sideMissionOMF].Old) {
				vars.sideMissionOM = true;
				//print("skipping split because side mission");
			}
		}
		
		// Vigilante requires a special check because of the way the addresses work.
		if (vars.memoryWatchers["OMFVigilante"].Current < vars.memoryWatchers["OMFVigilante"].Old
			|| (vars.memoryWatchers["VigilanteTimer"].Current == -100 && vars.memoryWatchers["VigilanteTimer"].Old != -100)) {
			vars.sideMissionOM = true;
			//print("skipping split because side mission");
		}
		
		// If the checks above returned nothing, then we will split.
		if (!vars.sideMissionOM) {
			vars.doSplit = true; vars.queuedSplit = false;
		}
	} */

	// Splits for the final split of Any%.
	if (settings["btgFinalSplit"] && vars.memoryWatchers["kyfc1"].Current == 245 && vars.memoryWatchers["kyfc2"].Current > vars.memoryWatchers["kyfc3"].Current && !vars.split.Contains("btgFinalSplit")) {
		vars.split.Add("btgFinalSplit");
		vars.doSplit = true;
	}

	// Finally, if any of the split conditions have been met, trigger the split action.
	return vars.doSplit;
}

start
{
	// Starts the splits when the new game load has been completed (and is not a save).
	return vars.memoryWatchers["gameState"].Old == 8 + vars.gameStateShift
		&& vars.memoryWatchers["gameState"].Current == 9 + vars.gameStateShift
		&& vars.memoryWatchers["notLoadingCheck"].Current == 1;
}

reset
{
	// Resets the timer when the new game load starts but only if the timer isn't over 19 seconds yet.
	return vars.memoryWatchers["gameState"].Old == 9 + vars.gameStateShift
		&& vars.memoryWatchers["gameState"].Current == 8 + vars.gameStateShift
		&& TimeSpan.Parse(timer.CurrentTime.RealTime.ToString()).TotalSeconds > 19;
}

isLoading
{
	// Load removing for loading screens in the game (found by Mhmd_FVC).
	return current.islandLoad > 0 || current.loadSaveLoad > 0 || current.replayLoad > 0 || current.genLoad > 0;
}
