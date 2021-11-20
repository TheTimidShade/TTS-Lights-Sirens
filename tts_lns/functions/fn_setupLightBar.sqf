/*
	Author: TheTimidShade

	Description:
		Sets up vehicle light bar using the passed parameters

	Parameters:
		0: OBJECT - Vehicle to add light bar to
		1: ARRAY - Array of light colours in format [_leftLightColour, _rightLightColour]. Default: [[1,0,0], [0,0,1]]
		2: ARRAY - Offset position of light bar placement on vehicle
		3: NUMBER - Offset of light bar light points from model centre pos

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]],
	["_lightBarColours", ["red", "blue"], [[]], [2]],
	["_lightBarOffset", [-0.035,0.02,0.6], [[]], [3]],
	["_lightOffset", 0.4, [0]]
];

if (!isServer) exitWith {};
if (isNull _vehicle) exitWith {};
if (!(_vehicle isKindOf "Air" || _vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Ship")) exitWith {};

private _rgbColours = _vehicle getVariable ["tts_lns_lightBarColours", [[1,0,0], [0,0,1]]];

private _leftLight = "Land_TentLamp_01_suspended_F" createVehicle (getPosATL _vehicle);
private _leftColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,0.2,ca)", (_rgbColours#0)#0, (_rgbColours#0)#1, (_rgbColours#0)#2];
_leftLight attachTo [_vehicle, [_lightBarOffset#0 - _lightOffset, _lightBarOffset#1, _lightBarOffset#2-0.06]];
_leftLight setVectorDirAndUp [[1,0,0], [0,-1,0]];
for "_i" from 5 to 1 step -1 do {_leftLight setHit [format["light_%1_hitpoint",_i],1];}; // disable lamp light
_leftLight setObjectTextureGlobal [0, "\tts_lns\textures\lamp_" + _lightBarColours#0 + ".paa"];
_leftLight setObjectTextureGlobal [1, _leftColourTexture];
_leftLight allowDamage false;

private _rightLight = "Land_TentLamp_01_suspended_F" createVehicle (getPosATL _vehicle);
private _rightColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,0.2,ca)", (_rgbColours#1)#0, (_rgbColours#1)#1, (_rgbColours#1)#2];
_rightLight attachTo [_vehicle, [_lightBarOffset#0 + _lightOffset, _lightBarOffset#1, _lightBarOffset#2-0.06]];
_rightLight setVectorDirAndUp [[1,0,0], [0,-1,0]];
for "_i" from 5 to 1 step -1 do {_rightLight setHit [format["light_%1_hitpoint",_i],1];}; // disable lamp light
_rightLight setObjectTextureGlobal [0, "\tts_lns\textures\lamp_" + _lightBarColours#1 + ".paa"];
_rightLight setObjectTextureGlobal [1, _rightColourTexture];
_rightLight allowDamage false;

_vehicle setVariable ["tts_lns_fakeLightBarObjs", [_rightLight, _leftLight], true];
_vehicle spawn tts_lns_fnc_handleLightBarCleanup; // clean up light bar if vehicle is deleted