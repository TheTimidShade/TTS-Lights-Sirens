/*
    Author: TheTimidShade

    Description:
        Creates light/sphere objects for fn_turnLightsOn

    Parameters:
        0: OBJECT - Vehicle to attach lights/spheres to
    
    Returns:
        ARRAY - [_leftLight, _leftSphere, _rightLight, _rightSphere]

*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (!hasInterface) exitWith {};
if (!alive _vehicle) exitWith {};

private _returnValues = [];

private _lightBarColours = _vehicle getVariable ["tts_lns_lightBarColours", [[0,0,1], [1,0,0]]];
private _lightBarOffset = _vehicle getVariable ["tts_lns_lightBarOffset", [-0.035,0.02,0.6]];
private _lightOffset = _vehicle getVariable ["tts_lns_lightOffset", 0.4];

private _leftLight = "#lightpoint" createVehicleLocal (getPosATL _vehicle);
_leftLight setLightIntensity 0;
_leftLight setLightAttenuation [0, 4, 0.1, 0.001, 5];
_leftLight setLightUseFlare true;
_leftLight setLightFlareSize 1;
_leftLight setLightFlareMaxDistance 3000;
_leftLight setLightDayLight true;
_leftLight setLightColor _lightBarColours#0;
_leftLight lightAttachObject [_vehicle, [(_lightBarOffset#0) - _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];
_returnValues pushBack _leftLight;

private _leftSphere = "Sign_Sphere25cm_F" createVehicleLocal (getPosATL _vehicle);
private _leftColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,1,ca)", (_lightBarColours#0)#0, (_lightBarColours#0)#1, (_lightBarColours#0)#2];
_leftSphere setObjectTexture [0, _leftColourTexture];
_leftSphere attachTo [_vehicle, [(_lightBarOffset#0) - _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];
_leftSphere hideObject true;
_returnValues pushBack _leftSphere;

private _rightLight = "#lightpoint" createVehicleLocal (getPosATL _vehicle);
_rightLight setLightIntensity 0;
_rightLight setLightAttenuation [0, 4, 0.1, 0.001, 5];
_rightLight setLightUseFlare true;
_rightLight setLightFlareSize 1;
_rightLight setLightFlareMaxDistance 3000;
_rightLight setLightDayLight true;
_rightLight setLightColor _lightBarColours#1;
_rightLight lightAttachObject [_vehicle, [(_lightBarOffset#0) + _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];
_returnValues pushBack _rightLight;

private _rightSphere = "Sign_Sphere25cm_F" createVehicleLocal (getPosATL _vehicle);
private _rightColourTexture = format ["#(argb,8,8,3)color(%1,%2,%3,1,ca)", (_lightBarColours#1)#0, (_lightBarColours#1)#1, (_lightBarColours#1)#2];
_rightSphere setObjectTexture [0, _rightColourTexture];
_rightSphere attachTo [_vehicle, [(_lightBarOffset#0) + _lightOffset, _lightBarOffset#1, _lightBarOffset#2]];
_rightSphere hideObject true;
_returnValues pushBack _rightSphere;

_returnValues