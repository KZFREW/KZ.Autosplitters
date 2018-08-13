// Sheep Raider autosplitter
// by KZ_FREW

state("SheepD3D") // Tell the autosplitter which process to hook into. In this case, SheepD3D.exe.
{
	int start : 0x2CFC18; // value is zero at menu, nonzero after selecting "new game"
	byte sheep : 0x2CFBFA; // value that tracks sheep remaining, is set to 17 on the menu
	byte lvlid : 0x2CFC1E; // unique identifier for each level
	byte bonuspts : 0x2CFBFB; // amount of current bonus points (updates when time clock used)
	byte btgvalue : 0x31C44A; // changes from 0 to 1 when entering Lucky Goal
}

startup
{
	
	vars.splits = new List<string>(); // used to track all splits we have already done during the run.
	vars.leveltrack = new List<byte>(); // keeps track of every level ID. Used for checking later.
	
	vars.levelNow = null; // var that stores level IDs.
	vars.PrevPhase = null; // var that stores last "phase" (running/paused/not running). Used for housekeeping later.
	
	//settings.Add("sheepsplit", true, "Sheep Collect");
	settings.Add("levelcat", true, "Levels");
	settings.Add("bonuscat", false, "Bonus Levels");
	settings.Add("clocksplit", false, "Time Clock Used");
	settings.Add("btgFinal", true, "Lucky Goal (Final Split)");

	vars.levelTags = new Dictionary<byte,string>
	{
		{0, "ACME Training"},
		{1, "Level 01"},
		{2, "Level 02"},
		{3, "Level 03"},
		{4, "Level 04"},
		{5, "Level B1"},
		{6, "Level 05"},
		{7, "Level 06"},
		{8, "Level 07"},
		{9, "Level 08"},
		{10, "Level B2"},
		{11, "Level 09"},
		{12, "Level 10"},
		{13, "Level 11"},
		{14, "Level 12"},
		{15, "Level 13"},
		{16, "Level 14"},
		{17, "Level 15"}
	};


	
	foreach (var Tag in vars.levelTags)
	{
		var parCategory = "levelcat";
		var catEnabled = true;
		if (Tag.Key == 5 || Tag.Key == 10)
		{
			parCategory = "bonuscat";
			catEnabled = false;
		}
		settings.Add(Tag.Key.ToString(), catEnabled, Tag.Value, parCategory);
		vars.leveltrack.Add(Tag.Key);
	}
	
	// Easier debugging.
	Action<string> DebugOutput = (text) =>
	{
		print("[Sheep Raider Autosplitter] "+text);
	};
	
	vars.DebugOutput = DebugOutput;

}

start
{
	// Starts the timer when our 'start' value has updated from nonzero (upon creating a new file)
	// Also checks sheep value to be extra sure we are starting a new game :)
	if (current.start > old.start && old.start == 0 && current.sheep == 17)
	{
		return true;
	}
}

update
{
	// In order to make each split "unique" (as in, not just split whenever a sheep is collected) we store the value of the level we are currently in.
	// The "level ID" value is checked against all values we track, and if it exists in our list and is also enabled in the settings by the player.
	// We store the value for checking later, because splitting actually happens in the "overworld" and for some reason using the old.lvlid value doesn't work.
	if (vars.levelNow != current.lvlid && vars.leveltrack.Contains(current.lvlid) && settings[current.lvlid.ToString()])
	{
		vars.levelNow = current.lvlid;
		vars.DebugOutput("Level updated: " + vars.levelNow.ToString());
	}
	
	// Housekeeping done in here so that we don't have to rely on the start/reset functions.
	// Check if the timer state has changed. If it has, and it is paused, clear out all completed splits and reset other important vars.
	if (timer.CurrentPhase != vars.PrevPhase)
	{
		if (timer.CurrentPhase == TimerPhase.NotRunning)
		{
			vars.splits.Clear();
			vars.levelNow = null;
			vars.DebugOutput("Cleared completed splits");
		}
		vars.PrevPhase = timer.CurrentPhase;
	}
}

split
{
	// Time Clock Splitting
	if (current.bonuspts > old.bonuspts && current.start != 0 && !vars.splits.Contains(current.bonuspts.ToString() + " Points") && settings["clocksplit"])
	{
		vars.splits.Add(current.bonuspts.ToString() + " Points");
		return true;
	}
	
	// Basic level splitting
	if (old.sheep > current.sheep && current.start != 0 && vars.leveltrack.Contains(vars.levelNow) && !vars.splits.Contains(vars.levelNow.ToString() + " Level") && settings[vars.levelNow.ToString()])
	{
		vars.splits.Add(vars.levelNow.ToString() + " Level");
		vars.DebugOutput("Split complete: " + vars.levelNow.ToString() + " Level");
		return true;
	}
	
	// Level 17 Splitting
	if (settings[vars.levelNow.ToString()] && current.lvlid == 251 && vars.levelNow == 17 && !vars.splits.Contains(vars.levelNow.ToString() + " Level"))
	{
		vars.splits.Add(vars.levelNow.ToString() + " Level");
		vars.DebugOutput("Split complete: " + vars.levelNow.ToString() + " Level");
		return true;
	}
	
	// Lucky Goal Splitting
	if (settings["btgFinal"] && current.btgvalue > old.btgvalue && current.lvlid == 251 && !vars.splits.Contains("btgSplit"))
	{
		vars.splits.Add("btgSplit");
		vars.DebugOutput("Final split. GG!");
		return true;
	}
}

reset
{
	if (old.start > current.start && current.start == 0 && current.sheep == 17)
	{
		return true;
	}
}
