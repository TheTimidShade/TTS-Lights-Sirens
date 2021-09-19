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
if (isNull _vehicle) exitWith {};

// set up lights/objects/variables
private _lightBarColours = _vehicle getVariable ["tts_lns_lightBarColours", [[0,0,1], [1,0,0]]];
private _lightBarOffset = _vehicle getVariable ["tts_lns_lightBarOffset", [-0.035,0.02,0.6]];
private _lightOffset = _vehicle getVariable ["tts_lns_lightOffset", 0.4];

private _leftLight = "#lightpoint" createVehicleLocal (getPosATL _vehicle);
_leftLight setLightIntensity 0;
_leftLight setLightAttenuation [0, 4, 0.1, 0.001, 5];
_leftLight setLightUseFlare true;
_leftLight setLightFlareSize 1;
_leftLight setLightFlareMaxDistance 500;
_leftLight setLightDayLight true;
_leftLight setLightColor _lightBarColours#0;
_leftLight lightAttachObject [_vehicle, [(_lightBarOffset#0) - _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];

private _leftSphere = "Sign_Sphere25cm_F" createVehicleLocal (getPosATL _vehicle);
private _leftColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,1,ca)", (_lightBarColours#0)#0, (_lightBarColours#0)#1, (_lightBarColours#0)#2];
_leftSphere setObjectTexture [0, _leftColourTexture];
_leftSphere attachTo [_vehicle, [(_lightBarOffset#0) - _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];
_leftSphere hideObject true;

private _rightLight = "#lightpoint" createVehicleLocal (getPosATL _vehicle);
_rightLight setLightIntensity 0;
_rightLight setLightAttenuation [0, 4, 0.1, 0.001, 5];
_rightLight setLightUseFlare true;
_rightLight setLightFlareSize 1;
_rightLight setLightFlareMaxDistance 500;
_rightLight setLightDayLight true;
_rightLight setLightColor _lightBarColours#1;
_rightLight lightAttachObject [_vehicle, [(_lightBarOffset#0) + _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];

private _rightSphere = "Sign_Sphere25cm_F" createVehicleLocal (getPosATL _vehicle);
private _rightColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,1,ca)", (_lightBarColours#1)#0, (_lightBarColours#1)#1, (_lightBarColours#1)#2];
_rightSphere setObjectTexture [0, _rightColourTexture];
_rightSphere attachTo [_vehicle, [(_lightBarOffset#0) + _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];
_rightSphere hideObject true;

// start light loop
while {alive _vehicle && _vehicle getVariable ["tts_lns_lightsOn", false]} do {
	if (_vehicle getVariable ["tts_lns_lightMode", 0] == 0) then {
		// alternate
		_rightLight setLightIntensity 150;
		if (sunOrMoon > 0) then {_rightSphere hideObject false;};
		
		_leftLight setLightIntensity 0;
		_leftSphere hideObject true;
		
		sleep 0.3;
		
		_rightLight setLightIntensity 0;
		_rightSphere hideObject true;
		
		_leftLight setLightIntensity 150;
		if (sunOrMoon > 0) then {_leftSphere hideObject false;};
		
		sleep 0.3;
	} else {
		// double flash
		_rightLight setLightIntensity 0;
		_leftLight setLightIntensity 0;
		_rightSphere hideObject true;
		_leftSphere hideObject true;
		for "_i" from 1 to 2 do {
			_rightLight setLightIntensity 150;
			if (sunOrMoon > 0) then {_rightSphere hideObject false;};
			
			sleep 0.1;
			
			_rightLight setLightIntensity 0;
			_rightSphere hideObject true;
			
			sleep 0.1;
		};
		for "_i" from 1 to 2 do {
			_leftLight setLightIntensity 150;
			if (sunOrMoon > 0) then {_leftSphere hideObject false;};
			
			sleep 0.1;
			
			_leftLight setLightIntensity 0;
			_leftSphere hideObject true;
			
			sleep 0.1;
		};
	};
};

{deleteVehicle _x} forEach [_rightLight, _rightSphere, _leftLight, _leftSphere];