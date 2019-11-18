// Miami Vice autosplitter
// by KZ_FREW
// Contributions from Makkebakke and Mr. Mary

state("MiamiVice")
{
	string10 levelStr : "MiamiVice.exe", 0x1F7C60; // Level value stored in plaintext
	byte menu         : "MiamiVice.exe", 0x13E073; // 1 when ingame, 0 when in menu
	bool endRun       : "MiamiVice.exe", 0x15AC3F;
	bool saveMenu     : "MiamiVice.exe", 0x15AC79;
	bool saveConfirm  : "MiamiVice.exe", 0x15A89C;
	bool isLoading    : 0x15AD10; // thanks Mr Mary!
}

init
{
	vars.readyToStart = false;
	
	vars.cindex = 0;
	vars.oldLevel = "";
	vars.currentLevel = "";
	
	// List to add split values, include level 1 string
	vars.splits = new List<string>();
	vars.loadValue = 0;
}

update
{
	// Extract the level id from the level string
	vars.cindex = old.levelStr.IndexOf(' ');
	if( vars.cindex >= 0 ) vars.oldLevel = old.levelStr.Substring(vars.cindex + 1, 2);
	
	vars.cindex = current.levelStr.IndexOf(' ');
	if( vars.cindex >= 0 ) vars.currentLevel = current.levelStr.Substring(vars.cindex + 1, 2);
	
	if (!vars.readyToStart && timer.CurrentPhase == TimerPhase.NotRunning) {
		vars.readyToStart = (current.menu == 0 ? true : false);
	}
}

start
{
	// If: in-game and loading into the first level, start timer & clear splits list
	if(vars.readyToStart && current.menu == 1 && vars.currentLevel == "1:") {
		vars.readyToStart = false;
		vars.splits.Clear();
		vars.splits.Add("1:");
		return true;
	}
}

split
{
	// Standard level splitting, check if level value updated and if we have already split for it. If not, split
	if(current.levelStr != old.levelStr && !vars.splits.Contains(vars.currentLevel)) {
		vars.splits.Add(vars.currentLevel);
		return true;
	}
	
	// If on final level and objective screen appears, split for the end of the game
	if(vars.currentLevel == "9b") return current.endRun;
}

reset
{
	if(current.menu == 0 && old.menu != current.menu) {
		return true;
	}
}

isLoading
{
	return (current.isLoading && !current.saveMenu && !current.saveConfirm);
}
