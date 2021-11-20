/*
	Author: TheTimidShade

	Description:
		Handles lights on vehicles that have tts light bars, executed client side

	Parameters:
		0: OBJECT - Vehicle the lightbar is attached to

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]]
];

if (!hasInterface) exitWith {};
if (!alive _vehicle) exitWith {};
if (!(_vehicle getVariable ["tts_lns_hasSiren", false])) exitWith {};

// set up lights/objects/variables
private _patternTypes = _vehicle getVariable ["tts_lns_patternTypes", ["Alternating"]];

private _lightObjs = _vehicle call tts_lns_fnc_createLightObjects;
_lightObjs params ["_leftLight", "_leftSphere", "_rightLight", "_rightSphere"];

// start light loop
while {alive _vehicle && _vehicle getVariable ["tts_lns_lightsOn", false]} do {
	private _currentLightMode = _vehicle getVariable ["tts_lns_lightMode", 0];
	if (_patternTypes#_currentLightMode == "Alternating") then {
		// alternate
		[_rightLight, _rightSphere, true] call tts_lns_fnc_flashLight;
		[_leftLight, _leftSphere, false] call tts_lns_fnc_flashLight;
		
		sleep 0.3;
		
		[_rightLight, _rightSphere, false] call tts_lns_fnc_flashLight;
		[_leftLight, _leftSphere, true] call tts_lns_fnc_flashLight;
		
		sleep 0.3;
	};
	if (_patternTypes#_currentLightMode == "DoubleFlash") then {
		// double flash
		[_rightLight, _rightSphere, false] call tts_lns_fnc_flashLight;
		[_leftLight, _leftSphere, false] call tts_lns_fnc_flashLight;
		for "_i" from 1 to 2 do {
			[_rightLight, _rightSphere, true] call tts_lns_fnc_flashLight;
			
			sleep 0.1;
			
			[_rightLight, _rightSphere, false] call tts_lns_fnc_flashLight;
			
			sleep 0.1;
		};
		for "_i" from 1 to 2 do {
			[_leftLight, _leftSphere, true] call tts_lns_fnc_flashLight;
			
			sleep 0.1;
			
			[_leftLight, _leftSphere, false] call tts_lns_fnc_flashLight;
			
			sleep 0.1;
		};
	};
	if (_patternTypes#_currentLightMode == "RapidAlt") then {
		// rapid alternate
		[_rightLight, _rightSphere, true] call tts_lns_fnc_flashLight;
		[_leftLight, _leftSphere, false] call tts_lns_fnc_flashLight;
		
		sleep 0.15;
		
		[_rightLight, _rightSphere, false] call tts_lns_fnc_flashLight;
		[_leftLight, _leftSphere, true] call tts_lns_fnc_flashLight;
		
		sleep 0.15;
	};
};

{deleteVehicle _x} forEach [_rightLight, _rightSphere, _leftLight, _leftSphere];