/*
	Author: TheTimidShade

	Description:
		Initialises custom modules for ZEN if enabled

	Parameters:
		NONE
		
	Returns:
		NONE
*/

[] spawn {

waitUntil {sleep 1; player == player && !isNull getAssignedCuratorLogic player};

[] call tts_lns_fnc_zen_addSiren;
[] call tts_lns_fnc_zen_removeSiren;
[] call tts_lns_fnc_zen_changeLights;
[] call tts_lns_fnc_zen_changeSiren;

};