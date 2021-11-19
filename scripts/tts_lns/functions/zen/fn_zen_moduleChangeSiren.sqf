["TTS Lights + Sirens", "STR_tts_lns_moduleChangeSiren_title",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	if (isNull _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle" || _attachedObject isKindOf "Ship")) exitWith {
		["STR_tts_lns_moduleAddSiren_warning"] call zen_common_fnc_showMessage;
	};
	
	if (!(_attachedObject getVariable ["tts_lns_hasSiren", false])) exitWith {
		["STR_tts_lns_moduleChangeLights_warning"] call zen_common_fnc_showMessage;
	};

	private _sirenModeValues = [];
	{_sirenModeValues pushBack _forEachIndex;} forEach (_attachedObject getVariable ["tts_lns_sirenTypes", ["Wail", "Yelp", "Phaser"]]);
	[
		"STR_tts_lns_moduleChangeSiren_title", // title
		[ // array of controls for dialog
			["CHECKBOX", ["STR_tts_lns_moduleChangeSiren_sirenOn", "STR_tts_lns_moduleChangeSiren_sirenOn_desc"],
				[ // control args
					_attachedObject getVariable ["tts_lns_sirenOn", false]
				],
				true // force default
			],
			["COMBO", ["STR_tts_lns_moduleChangeSirens_sirenMode", "STR_tts_lns_moduleChangeSirens_sirenMode_desc"],
				[ // control args
					_sirenModeValues, // return values
					_attachedObject getVariable ["tts_lns_sirenTypes", ["Wail", "Yelp", "Phaser"]], // labels
					_attachedObject getVariable ["tts_lns_sirenMode", 0]
				],
				true // force default
			]
		],
		{ // code run on dialog closed (only run if OK is clicked)
			params ["_dialogResult", "_args"];
			_args params ["_attachedObject"];
			_dialogResult params ["_sirenOn", "_sirenMode"];
			
			// set siren state
			if (_sirenOn && !(_attachedObject getVariable ["tts_lns_sirenOn", false])) then {
				_attachedObject setVariable ["tts_lns_sirenOn", true, true];
				[_attachedObject] remoteExec ["tts_lns_fnc_turnSirenOn", 0, false];
			};
			if (!_sirenOn && _attachedObject getVariable ["tts_lns_sirenOn", false]) then {
				_attachedObject setVariable ["tts_lns_sirenOn", false, true];
			};

			// set siren mode
			_attachedObject setVariable ["tts_lns_sirenMode", _sirenMode, true];
			["STR_tts_lns_moduleChangeSiren_completeMessage"] call zen_common_fnc_showMessage;

		}, {}, [_attachedObject] // args
	] call zen_dialog_fnc_create;
}, "scripts\tts_lns\icons\lns_edit_sound_icon_64px.paa"] call zen_custom_modules_fnc_register;