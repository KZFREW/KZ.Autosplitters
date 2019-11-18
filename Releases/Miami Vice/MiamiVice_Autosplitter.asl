// Miami Vice autosplitter
// by KZ_FREW
// Contributions from Makkebakke and Mr. Mary

state("MiamiVice") // Tell the autosplitter which process to hook into. In this case, SheepD3D.exe.
{
	string10 levelStr	: "MiamiVice.exe", 0x1F7C60;				// Level value stored in plaintext
	byte menu		: "MiamiVice.exe", 0x13E073;				// 1 when ingame, 0 when in menu
	int juanHealth		: "MiamiVice.exe", 0x14F4EC, 0x220, 0x4C, 0x30, 0x44;	// final boss HP, 34 when "dead"
	bool endRun		: "MiamiVice.exe", 0x15AC3F;				// timing end test
	bool isLoading		: 0x15AD10;						// thanks Mr Mary!
}

init
{
	vars.cindex = 0;
	vars.oldLevel = "";
	vars.currentLevel = "";
	
	// List to add split values, include level 1 string
	vars.splits = new List<string>(){
		"1:"
	};
}

update
{
	// Extract the level id from the level string
	vars.cindex = old.levelStr.IndexOf(' ');
	if (vars.cindex >= 0) vars.oldLevel = old.levelStr.Substring(vars.cindex + 1, 2);
	
	vars.cindex = current.levelStr.IndexOf(' ');
	if (vars.cindex >= 0) vars.currentLevel = current.levelStr.Substring(vars.cindex + 1, 2);
}

start
{
	// If: in-game -- just left the menu -- and loading into the first level, start timer & clear splits list
	if(current.menu == 1 && vars.currentLevel == "1:") {
		vars.splits.Clear();
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
	return (current.isLoading && !current.saveMenu);
}
