["TTS Lights + Sirens", "STR_tts_lns_moduleAddSiren_title",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	if (!alive _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle" || _attachedObject isKindOf "Ship")) exitWith {
		["STR_tts_lns_moduleAddSiren_warning"] call zen_common_fnc_showMessage;
	};

	[
		"STR_tts_lns_moduleAddSiren_title", // title
		[ // array of controls for dialog
			["EDIT", ["STR_tts_lns_moduleAddSiren_sirenTypes", "STR_tts_lns_moduleAddSiren_sirenTypes_desc"],
				[ // control args
					"Wail,Yelp,Phaser"
				],
				false // force default
			],
			["EDIT", ["STR_tts_lns_moduleAddSiren_lightPatterns", "STR_tts_lns_moduleAddSiren_lightPatterns_desc"],
				[ // control args
					"Alternating,DoubleFlash,RapidAlt"
				],
				false // force default
			],
			["COMBO", ["STR_tts_lns_moduleAddSiren_leftLightColour", "STR_tts_lns_moduleAddSiren_leftLightColour_desc"],
				[ // control args
					["red", "blue", "amber", "yellow", "green", "white", "magenta"], // return values
					["STR_tts_lns_moduleAddSiren_colour_red", "STR_tts_lns_moduleAddSiren_colour_blue", "STR_tts_lns_moduleAddSiren_colour_amber", "STR_tts_lns_moduleAddSiren_colour_yellow", "STR_tts_lns_moduleAddSiren_colour_green", "STR_tts_lns_moduleAddSiren_colour_white", "STR_tts_lns_moduleAddSiren_colour_magenta"], // labels
					0 // element 0 is default selected
				],
				false // force default
			],
			["COMBO", ["STR_tts_lns_moduleAddSiren_rightLightColour", "STR_tts_lns_moduleAddSiren_rightLightColour_desc"],
				[ // control args
					["red", "blue", "amber", "yellow", "green", "white", "magenta"], // return values
					["STR_tts_lns_moduleAddSiren_colour_red", "STR_tts_lns_moduleAddSiren_colour_blue", "STR_tts_lns_moduleAddSiren_colour_amber", "STR_tts_lns_moduleAddSiren_colour_yellow", "STR_tts_lns_moduleAddSiren_colour_green", "STR_tts_lns_moduleAddSiren_colour_white", "STR_tts_lns_moduleAddSiren_colour_magenta"], // labels
					1 // element 0 is default selected
				],
				false // force default
			],
			["COMBO", ["STR_tts_lns_moduleAddSiren_preset", "STR_tts_lns_moduleAddSiren_preset_desc"],
				[ // control args
					["None", "Offroad", "Van", "Hatchback", "Hunter", "Ifrit"], // return values
					["STR_tts_lns_moduleAddSiren_preset_none", "STR_tts_lns_moduleAddSiren_preset_offroad", "STR_tts_lns_moduleAddSiren_preset_van", "STR_tts_lns_moduleAddSiren_preset_hatchback", "STR_tts_lns_moduleAddSiren_preset_hunter", "STR_tts_lns_moduleAddSiren_preset_ifrit"], // labels
					0 
				],
				false // force default
			],
			["EDIT", ["STR_tts_lns_moduleAddSiren_lightBarOffset", "STR_tts_lns_moduleAddSiren_lightBarOffset_desc"],
				[ // control args
					"[-0.035,0.02,0.6]"
				],
				false // force default
			],
			["EDIT", ["STR_tts_lns_moduleAddSiren_lightCentreOffset", "STR_tts_lns_moduleAddSiren_lightCentreOffset_desc"],
				[ // control args
					"0.4"
				],
				false // force default
			],
			["CHECKBOX", ["STR_tts_lns_moduleAddSiren_useFakeLightBar", "STR_tts_lns_moduleAddSiren_useFakeLightBar_desc"],
				[ // control args
					false
				],
				false // force default
			]
		],
		{ // code run on dialog closed (only run if OK is clicked)
			params ["_dialogResult", "_args"];
			_args params ["_attachedObject"];
			
			_dialogResult params ["_sirenTypes", "_patternTypes", "_leftColour", "_rightColour", "_preset", "_lightBarOffset", "_lightCentreOffset", "_fakeLightBar"];
			_sirenTypes = _sirenTypes splitString ",";
			_patternTypes = _patternTypes splitString ",";
			
			if (_preset != "None") then {
				private _parsedOffset = [_preset, _preset] call tts_lns_fnc_parsePresets;
				_lightBarOffset = _parsedOffset#0;
				_lightCentreOffset = _parsedOffset#1;
			};

			[_attachedObject, _sirenTypes, _patternTypes, [_leftColour, _rightColour], _lightBarOffset, _lightCentreOffset, _fakeLightBar] remoteExecCall ["tts_lns_fnc_addSiren", 2];
			["STR_tts_lns_moduleAddSiren_completeMessage"] call zen_common_fnc_showMessage;
		}, {}, [_attachedObject] // args
	] call zen_dialog_fnc_create;
}, "scripts\tts_lns\icons\lns_icon_64px.paa"] call zen_custom_modules_fnc_register;