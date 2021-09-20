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
{_vehicle removeAction _x;} forEach (_vehicle getVariable ["tts_lns_sirenActionIDs", []]);

_vehicle setVariable ["tts_lns_sirenActionIDs", []];
_vehicle setVariable ["tts_lns_hasSirenActions", false];