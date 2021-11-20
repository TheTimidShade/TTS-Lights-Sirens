/*
	Author: TheTimidShade

	Description:
		Removes siren actions from vehicle

	Parameters:
		0: OBJECT - Vehicle to remove lights/siren from

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]]
];

if (isNull _vehicle) exitWith {};
if (!(_vehicle getVariable ["tts_lns_hasSirenActions", false])) exitWith {}; // no need to remove actions if vehicle doesn't have them

// remove actions
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then
{
	// remove actions
	{
		[_vehicle, 1, ["ACE_SelfActions", "tts_lns_actions", _x]] call ace_interact_menu_fnc_removeActionFromObject;
	} forEach ["ToggleLights", "ChangeLights", "ToggleSiren", "ChangeSiren"];
	// remove category
	[_vehicle, 1, ["ACE_SelfActions", "tts_lns_actions"]] call ace_interact_menu_fnc_removeActionFromObject;
}
else
{
	{_vehicle removeAction _x;} forEach (_vehicle getVariable ["tts_lns_sirenActionIDs", []]);
};

_vehicle setVariable ["tts_lns_sirenActionIDs", []];
_vehicle setVariable ["tts_lns_hasSirenActions", false];