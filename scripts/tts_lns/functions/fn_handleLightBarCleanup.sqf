/*
    Author: TheTimidShade

    Description:
        Executed on server, waits until vehicle with light bar attached no longer exists then deletes them

    Parameters:
        0: OBJECT - Vehicle light bar is attached to

    Returns:
        NOTHING

*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (isNull _vehicle) exitWith {};

private _fakeLights = _vehicle getVariable ["tts_lns_fakeLightBarObjs", [objNull, objNull]];

waitUntil {!alive _vehicle || (isNull (_fakeLights#0) && isNull (_fakeLights#1))};

{if (!isNull _x) then {deleteVehicle _x;};} forEach _fakeLights;