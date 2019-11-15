// Miami Vice autosplitter
// by KZ_FREW

state("MiamiVice") // Tell the autosplitter which process to hook into. In this case, SheepD3D.exe.
{
	string2 level : 0x1F7C68; // Level value stored in plaintext
	byte menu 	  : 0x13E073; // 1 when ingame, 0 when in menu
	int JuanHealth: 0x14F4EC, 0x220, 0x4C, 0x30, 0x44; // final boss HP, 34 when "dead"
	bool isLoading : 0x15AD10; // thanks Mr Mary!
}

init
{
	// Empty list to add split values
	vars.splits = new List<string>();
}

start
{
	// If: in-game -- just left the menu -- and loading into the first level, start timer & clear splits list
	if(current.menu == 1 && current.menu != old.menu && current.level == "1:") {	
		vars.splits.Clear();
		return true;
	}
}

split
{
	// Standard level splitting, check if level value updated and if we have already split for it. If not, split
	if(current.level != old.level && current.level != "1:" && !vars.splits.Contains(current.level)) {
		vars.splits.Add(current.level);
		return true;	
	}
	
	// If on final level and boss just died, split for the end of the game
	if(current.level == "9b" && current.JuanHealth == 34 && !vars.splits.Contains(current.level + "End")) {
		vars.splits.Add(current.level + "End");
		return true;
	}
}

reset
{
	if(current.menu == 0 && old.menu != current.menu) {
		return true;
	}
}

isLoading
{
	return current.isLoading;
}
