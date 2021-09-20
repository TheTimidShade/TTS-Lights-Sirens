/*
	Author: TheTimidShade

	Description:
		Adds light bar and siren to provided vehicle

	Parameters:
		0: OBJECT - Vehicle to add lights/siren to
		1: ARRAY (OPTIONAL) - Array of strings containing available siren types. Default: ["standard"]
		2: ARRAY (OPTIONAL) - Array of light colours in format [_rightLightColour, _leftLightColour]. Default: [[1,0,0], [0,0,1]]
		3: ARRAY (OPTIONAL) - Offset position of light bar placement on vehicle
		5: NUMBER (OPTIONAL) - Offset of light bar light points from model centre pos
		6: BOOL (OPTIONAL) - Whether or not to add fake lightbar to vehicle (i.e. if you want to use a vehicle that doesn't normally have a light bar)
		7: BOOL (OPTIONAL) - If set to true, disables the action to change light patterns
		
		// OFFSET FOR VANILLA VEHICLES:
		Offroad: 	[-0.035,0.02,0.6], 0.4
		Van: 		[-0.028,1.6,1.16], 0.4
		Hatchback: 	[-0.010,-0.019,0.28], 0.3

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]],
	["_sirenTypes", ["Wail", "Yelp", "Phaser"], [[]]],
	["_lightBarColours", ["red", "blue"], [[]], [2]],
	["_lightBarOffset", [-0.035,0.02,0.6], [[]], [3]],
	["_lightOffset", 0.4, [0]],
	["_fakeLightBar", false, [true]],
	["_disableLightChange", true, [true]]
];

if (!isServer) exitWith {};
if (isNull _vehicle) exitWith {};
if (!(_vehicle isKindOf "Air" || _vehicle isKindOf "LandVehicle")) exitWith {};

{if (!(_x in ["Wail", "Yelp", "Phaser"])) then {_sirenTypes set [_forEachIndex, "Wail"];};} forEach _sirenTypes;

private _validColours = ["red", "blue", "amber", "yellow", "green", "white", "magenta"];
private _colourValues = [[1,0,0], [0,0,1], [1,0.62,0.13], [1,1,0], [0,0.3,0], [1,1,1], [0.78,0,1]];
if (!(_lightBarColours#0 in _validColours)) then {_lightBarColours set [0, "red"];};
if (!(_lightBarColours#1 in _validColours)) then {_lightBarColours set [1, "blue"];};

private _rgbColours = [_colourValues#(_validColours find _lightBarColours#0), _colourValues#(_validColours find _lightBarColours#1)];
_vehicle setVariable ["tts_lns_lightBarColours", _rgbColours, true];

_vehicle setVariable ["tts_lns_sirenTypes", _sirenTypes, true];
_vehicle setVariable ["tts_lns_lightBarOffset", _lightBarOffset, true];
_vehicle setVariable ["tts_lns_lightOffset", _lightOffset, true];
_vehicle setVariable ["tts_lns_disableLightChange", _disableLightChange, true];

if (!(_vehicle getVariable ["tts_lns_hasSiren", false])) then {
	_vehicle setVariable ["tts_lns_hasSiren", true, true];
	_vehicle setVariable ["tts_lns_fakeLightBarObjs", [objNull, objNull], true];

	private _messagePrefix = format ["%1_", _vehicle];
	private _jipMessages = [];
	_jipMessages pushBack ([_vehicle] remoteExec ["tts_lns_fnc_addSirenActions", 0, _messagePrefix + "actions"]);
	_jipMessages pushBack ([_vehicle] remoteExec ["tts_lns_fnc_handleSirenJIP", 0, _messagePrefix + "jipToggle"]);
	_vehicle setVariable ["tts_lns_jipMessages", _jipMessages, true];

	if (_fakeLightBar) then {
		private _leftLight = "Land_TentLamp_01_suspended_F" createVehicle (getPosATL _vehicle);
		private _leftColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,0.2,ca)", (_rgbColours#0)#0, (_rgbColours#0)#1, (_rgbColours#0)#2];
		_leftLight attachTo [_vehicle, [_lightBarOffset#0 - _lightOffset, _lightBarOffset#1, _lightBarOffset#2-0.06]];
		_leftLight setVectorDirAndUp [[1,0,0], [0,-1,0]];
		for "_i" from 5 to 1 step -1 do {_leftLight setHit [format["light_%1_hitpoint",_i],1];}; // disable lamp light
		_leftLight setObjectTextureGlobal [0, "scripts\tts_lns\textures\lamp_" + _lightBarColours#0 + ".paa"];
		_leftLight setObjectTextureGlobal [1, _leftColourTexture];
		_leftLight allowDamage false;

		private _rightLight = "Land_TentLamp_01_suspended_F" createVehicle (getPosATL _vehicle);
		private _rightColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,0.2,ca)", (_rgbColours#1)#0, (_rgbColours#1)#1, (_rgbColours#1)#2];
		_rightLight attachTo [_vehicle, [_lightBarOffset#0 + _lightOffset, _lightBarOffset#1, _lightBarOffset#2-0.06]];
		_rightLight setVectorDirAndUp [[1,0,0], [0,-1,0]];
		for "_i" from 5 to 1 step -1 do {_rightLight setHit [format["light_%1_hitpoint",_i],1];}; // disable lamp light
		_rightLight setObjectTextureGlobal [0, "scripts\tts_lns\textures\lamp_" + _lightBarColours#1 + ".paa"];
		_rightLight setObjectTextureGlobal [1, _rightColourTexture];
		_rightLight allowDamage false;

		_vehicle setVariable ["tts_lns_fakeLightBarObjs", [_rightLight, _leftLight], true];
		_vehicle spawn tts_lns_fnc_handleLightBarCleanup; // clean up light bar if vehicle is deleted
	};
} else { // vehicle already has a siren, remove old one then re-call the function
	[_vehicle] call tts_lns_fnc_removeSiren;
	[_vehicle, _sirenTypes, _lightBarColours, _lightBarOffset, _lightOffset, _fakeLightBar] call tts_lns_fnc_addSiren;
};