/*
	Author: TheTimidShade

	Description:
		Removes light bar and siren from provided vehicle (if it has them)

	Parameters:
		0: OBJECT - Vehicle to remove lights/siren from

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]]
];

if (!isServer) exitWith {};
if (isNull _vehicle) exitWith {};
if (!(_vehicle getVariable ["tts_lns_hasSirenActions", false])) exitWith {}; // no need to remove anything if the vehicle has no siren

// cleanup fake light bar if there is one
private _fakeLights = _vehicle getVariable ["tts_lns_fakeLightBarObjs", [objNull, objNull]];
{if (!isNull _x) then {deleteVehicle _x;};} forEach _fakeLights;
_vehicle setVariable ["tts_lns_fakeLightBarObjs", [objNull, objNull], true];

_vehicle setVariable ["tts_lns_lightsOn", false, true];
_vehicle setVariable ["tts_lns_lightMode", 0, true];
_vehicle setVariable ["tts_lns_sirenOn", false, true];
_vehicle setVariable ["tts_lns_sirenMode", 0, true];
_vehicle setVariable ["tts_lns_hasSiren", false, true];