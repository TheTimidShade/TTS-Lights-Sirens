/*
	Author: TheTimidShade

	Description:
		Creates siren sound then waits until the vehicle is destroyed, siren is changed, or the siren is turned off

	Parameters:
		0: OBJECT - Vehicle the lightbar is attached to

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]],
	["_lightBarOffset", [0,0,0], [], [3]],
	["_sirenMode", 0, [0]]
];

if (!hasInterface) exitWith {};
if (isNull _vehicle) exitWith {};

private _sirenTypes = _vehicle getVariable ['tts_lns_sirenTypes', ['Wail']];
private _sirenString = _sirenTypes#_sirenMode;

private _soundName = "";
private _soundLoopDelay = 10;
switch (_sirenString) do {
	case "Wail": {_soundName = "tts_lns_sirenWail"; _soundLoopDelay = 6.18;};
	case "Yelp": {_soundName = "tts_lns_sirenYelp"; _soundLoopDelay = 0.99;};
	case "Phaser": {_soundName = "tts_lns_sirenPhaser"; _soundLoopDelay = 1;};
	case "TwoTone": {_soundName = "tts_lns_sirenTwoTone"; _soundLoopDelay = 2;};
};

private _soundSource = "#particlesource" createVehicleLocal (getPosATL _vehicle);
_soundSource attachTo [_vehicle, _lightBarOffset];

[_soundSource, _soundName, _soundLoopDelay] spawn {
	params ["_soundSource", "_soundName", "_soundLoopDelay"];
	while {alive _soundSource} do {
		_soundSource say3D [_soundName, 800];
		sleep _soundLoopDelay;
	};
};

waitUntil {!alive _vehicle || !(_vehicle getVariable ['tts_lns_hasSiren', false]) || _vehicle getVariable ['tts_lns_sirenMode', 0] != _sirenMode || !(_vehicle getVariable ['tts_lns_sirenOn', false])};

deleteVehicle _soundSource;