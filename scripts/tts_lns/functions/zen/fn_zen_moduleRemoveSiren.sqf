["TTS Lights + Sirens", "Remove Lights/Siren",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	if (isNull _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle")) exitWith {
		["Must be placed on an aircraft/land vehicle!"] call zen_common_fnc_showMessage;
	};

	if (!(_attachedObject getVariable ["tts_lns_hasSiren", false])) then {
		["No lights/siren detected on this vehicle!"] call zen_common_fnc_showMessage;
	} else {
		[_attachedObject] remoteExecCall ["tts_lns_fnc_removeSiren", 2];
		["Removed lights/siren!"] call zen_common_fnc_showMessage;
	};
}, "scripts\tts_lns\icons\lns_remove_icon_64px.paa"] call zen_custom_modules_fnc_register;