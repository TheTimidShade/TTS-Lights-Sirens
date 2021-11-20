/*
    Author: TheTimidShade

    Description:
        Module function for Set Light/Siren State module.

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
    private _lightsOn = _module getVariable ["LightsOn", false];
    private _lightMode = _module getVariable ["LightMode", 0];
    private _sirenOn = _module getVariable ["SirenOn", false];
    private _sirenMode = _module getVariable ["SirenMode", 0];

    {
        if (!(_x isKindOf "EmptyDetector") && _x getVariable ["tts_lns_hasSiren", false]) then {
            // set light state
            if (_lightsOn && !(_x getVariable ["tts_lns_lightsOn", false])) then {
                _x setVariable ["tts_lns_lightsOn", true, true];
                [_x] remoteExec ["tts_lns_fnc_turnLightsOn", 0, false];
            };
            if (!_lightsOn && _x getVariable ["tts_lns_lightsOn", false]) then {
                _x setVariable ["tts_lns_lightsOn", false, true];
            };

            // set light mode
			_x setVariable ["tts_lns_lightMode", _lightMode, true];

            // set siren state
			if (_sirenOn && !(_x getVariable ["tts_lns_sirenOn", false])) then {
				_x setVariable ["tts_lns_sirenOn", true, true];
				[_x] remoteExec ["tts_lns_fnc_turnSirenOn", 0, false];
			};
			if (!_sirenOn && _x getVariable ["tts_lns_sirenOn", false]) then {
				_x setVariable ["tts_lns_sirenOn", false, true];
			};

			// set siren mode
			_x setVariable ["tts_lns_sirenMode", _sirenMode, true];
        };
    } forEach _units;
};