/*
	Author: TheTimidShade

	Description:
		Handles siren sound loop on vehicle that have turned on siren, executed client side

	Parameters:
		0: OBJECT - Vehicle the siren is attached to

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]]
];

if (!hasInterface) exitWith {};
if (!alive _vehicle) exitWith {};
if (!(_vehicle getVariable ["tts_lns_hasSiren", false])) exitWith {};

private _lightBarOffset = _vehicle getVariable ["tts_lns_lightBarOffset", [-0.035,0.02,0.6]];

private ["_sirenMode", "_soundName", "_loopDelay", "_handle"];
while {alive _vehicle && _vehicle getVariable ["tts_lns_sirenOn", false]} do {
	_sirenMode = _vehicle getVariable ["tts_lns_sirenMode", 0];
	_handle = [_vehicle, _lightBarOffset, _sirenMode] spawn tts_lns_fnc_createSirenSound;
	waitUntil {!alive _vehicle || !(_vehicle getVariable ['tts_lns_hasSiren', false]) || _vehicle getVariable ['tts_lns_sirenMode', 0] != _sirenMode || !(_vehicle getVariable ['tts_lns_sirenOn', false])};
};