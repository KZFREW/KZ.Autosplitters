// Miami Vice autosplitter
// by KZ_FREW
// Contributions from Makkebakke and Mr. Mary

state("MiamiVice")
{
	// Dutch Language
	//string2 level : "MiamiVice.exe", 0x1F7C67; // Level value stored in plaintext
	
	// English Language
	string2 level    : "MiamiVice.exe", 0x1F7C68; // Level value stored in plaintext
	
	byte menu 	     : "MiamiVice.exe", 0x13E073; // 1 when ingame, 0 when in menu
	bool isLoading   : 0x15AD10; // thanks Mr Mary!
	bool saveMenu 	 : "MiamiVice.exe", 0x15AC79;
	bool endRun	  	 : "MiamiVice.exe", 0x15AC3F; // timing end test
	bool saveConfirm : "MiamiVice.exe", 0x15A89C;
}

init
{
	// Empty list to add split values
	vars.splits = new List<string>();
	vars.loadValue = 0;
}

start
{
	// If: in-game -- just left the menu -- and loading into the first level, start timer & clear splits list
	if(current.menu == 1 && current.level == "1:") {
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
	
	// If on final level and objective screen appears, split for the end of the game
	if(current.level == "9b" && !vars.splits.Contains(current.level + "End")) {
		if (current.endRun) {
			vars.splits.Add(current.level + "End");
			return true;
		}
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
	return (current.isLoading && !current.saveMenu && !current.saveConfirm);
}
