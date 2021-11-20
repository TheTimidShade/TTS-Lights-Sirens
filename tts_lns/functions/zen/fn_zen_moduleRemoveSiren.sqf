["TTS Lights + Sirens", "STR_tts_lns_moduleRemoveSiren_title",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	if (isNull _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle" || _attachedObject isKindOf "Ship")) exitWith {
		["STR_tts_lns_moduleAddSiren_warning"] call zen_common_fnc_showMessage;
	};

	if (!(_attachedObject getVariable ["tts_lns_hasSiren", false])) then {
		["STR_tts_lns_moduleChangeLights_warning"] call zen_common_fnc_showMessage;
	} else {
		[_attachedObject] remoteExecCall ["tts_lns_fnc_removeSiren", 2];
		["STR_tts_lns_moduleRemoveSiren_completeMessage"] call zen_common_fnc_showMessage;
	};
}, "\tts_lns\icons\lns_remove_icon_64px.paa"] call zen_custom_modules_fnc_register;