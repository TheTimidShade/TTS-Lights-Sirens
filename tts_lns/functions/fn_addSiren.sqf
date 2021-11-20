/*
	Author: TheTimidShade

	Description:
		Adds light bar and siren to provided vehicle

	Parameters:
		0: OBJECT - Vehicle to add lights/siren to
		1: ARRAY (OPTIONAL) - * Array of strings containing available siren types. Default: ["Wail", "Yelp", "Phaser", "TwoTone"]
		2: ARRAY (OPTIONAL) - * Array of strings containing available light patterns. Default: ["Alternating", "DoubleFlash", "RapidAlt"]
		3: ARRAY (OPTIONAL) - Array of light colours in format [_leftLightColour, _rightLightColour]. Default: ["red", "blue"]
		4: ARRAY (OPTIONAL) - Offset position of light bar placement on vehicle
		5: NUMBER (OPTIONAL) - Offset of light bar light points from model centre pos
		6: BOOL (OPTIONAL) - Whether or not to add fake lightbar to vehicle (i.e. if you want to use a vehicle that doesn't normally have a light bar)
		
		* - If the array is left empty the lights/siren will be disabled. Can use this if you don't want to use both the lights & sirens,
			e.g. if you had a vehicle that already had a lightbar or siren on it.

		// OFFSET FOR VANILLA VEHICLES:
		Offroad: 	[-0.035,0.02,0.6], 0.4
		Van: 		[-0.028,1.6,1.16], 0.4
		Hatchback: 	[-0.010,-0.019,0.28], 0.3

	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]],
	["_sirenTypes", ["Wail", "Yelp", "Phaser", "TwoTone"], [[]]],
	["_patternTypes", ["Alternating", "DoubleFlash", "RapidAlt"], [[]]],
	["_lightBarColours", ["red", "blue"], [[]], [2]],
	["_lightBarOffset", [-0.035,0.02,0.6], [[]], [3]],
	["_lightOffset", 0.4, [0]],
	["_fakeLightBar", false, [true]]
];

if (!isServer) exitWith {};
if (!alive _vehicle || !(_vehicle isKindOf "Air" || _vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Ship")) exitWith {};

// validate parameters
private _validSirens = []; private _validPatterns = [];
{if (_x in ["Wail", "Yelp", "Phaser", "TwoTone"]) then {_validSirens pushBack _x;};} forEach _sirenTypes;
{if (_x in ["Alternating", "DoubleFlash", "RapidAlt"]) then {_validPatterns pushBack _x;};} forEach _patternTypes;

private _validColours = ["red", "blue", "amber", "yellow", "green", "white", "magenta"];
private _colourValues = [[1,0,0], [0,0,1], [1,0.62,0.13], [1,1,0], [0,0.3,0], [1,1,1], [0.78,0,1]];
if (!(_lightBarColours#0 in _validColours)) then {_lightBarColours set [0, "red"];};
if (!(_lightBarColours#1 in _validColours)) then {_lightBarColours set [1, "blue"];};

private _rgbColours = [_colourValues#(_validColours find _lightBarColours#0), _colourValues#(_validColours find _lightBarColours#1)];
_vehicle setVariable ["tts_lns_lightBarColours", _rgbColours, true];

_vehicle setVariable ["tts_lns_sirenTypes", _validSirens, true];
_vehicle setVariable ["tts_lns_patternTypes", _validPatterns, true];
_vehicle setVariable ["tts_lns_lightBarOffset", _lightBarOffset, true];
_vehicle setVariable ["tts_lns_lightOffset", _lightOffset, true];

// only add lights and sirens if the vehicle does not already have them
if (!(_vehicle getVariable ["tts_lns_hasSiren", false])) then
{
	_vehicle setVariable ["tts_lns_hasSiren", true, true];
	_vehicle setVariable ["tts_lns_fakeLightBarObjs", [objNull, objNull], true];

	// compatibility for JIP
	private _messagePrefix = format ["%1_", _vehicle];
	private _jipMessages = [];
	_jipMessages pushBack ([_vehicle] remoteExec ["tts_lns_fnc_addSirenActions", 0, _messagePrefix + "actions"]);
	_jipMessages pushBack ([_vehicle] remoteExec ["tts_lns_fnc_handleSirenJIP", 0, _messagePrefix + "jipToggle"]);
	_vehicle setVariable ["tts_lns_jipMessages", _jipMessages, true];

	// add fake light bar
	if (_fakeLightBar) then {
		[_vehicle, _lightBarColours, _lightBarOffset, _lightOffset] call tts_lns_fnc_setupLightBar;
	};
}
// vehicle already has a siren, remove old one then re-call the function
else
{ 
	[_vehicle] call tts_lns_fnc_removeSiren;
	[_vehicle, _sirenTypes, _patternTypes, _lightBarColours, _lightBarOffset, _lightOffset, _fakeLightBar] call tts_lns_fnc_addSiren;
};