/*
    Author: TheTimidShade

    Description:
        Handles light/siren status for JIP players

    Parameters:
        0: OBJECT - Vehicle to check for status

    Returns:
        NOTHING

*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (isNull _vehicle) exitWith {};

if (_vehicle getVariable ["tts_lns_lightsOn", false]) then {_vehicle spawn tts_lns_fnc_turnLightsOn;};
if (_vehicle getVariable ["tts_lns_sirenOn", false]) then {_vehicle spawn tts_lns_fnc_turnSirenOn;};