/*
    Author: TheTimidShade

    Description:
        Module function for Add Lights/Siren module.

    Parameters:
        0: OBJECT - Placed module.
        1: ARRAY - Objects that can be affected by the module.
        2: BOOL - Whether module is activated (synced triggers are active)
        
    Returns:
        NONE
*/

params [
    ["_module", objNull, [objNull]],
    ["_units", [], [[]]],
    ["_activated", true, [true]]
];

if (!isServer) exitWith {};

if (_activated) then {
    private _sirenTypes = _module getVariable ["SirenTypes", "Wail,Yelp,Phaser"];
    private _lightPatterns = _module getVariable ["LightPatterns", "Alternating,DoubleFlash,RapidAlt"];
    private _leftColour = _module getVariable ["LeftLightColour", "red"];
    private _rightColour = _module getVariable ["RightLightColour", "blue"];
    private _preset = _module getVariable ["OffsetPreset", "None"];
    private _lightBarOffset = _module getVariable ["LightBarOffset", "[-0.035,0.02,0.6]"];
    private _lightCentreOffset = _module getVariable ["LightCentreOffset", "0.4"];
    private _useFakeLightBar = _module getVariable ["UseFakeLightBar", false];

    _sirenTypes = _sirenTypes splitString ",";
    _lightPatterns = _lightPatterns splitString ",";
    
    if (_preset != "None") then {
        private _parsedOffset = [_preset, _preset] call tts_lns_fnc_parsePresets;
        _lightBarOffset = _parsedOffset#0;
        _lightCentreOffset = _parsedOffset#1;
    };

    {
        if (!(_x isKindOf "EmptyDetector")) then {
            [_x, _sirenTypes, _lightPatterns, [_leftColour, _rightColour], _lightBarOffset, _lightCentreOffset, _useFakeLightBar] call tts_lns_fnc_addSiren;
        };
    } forEach _units;
};