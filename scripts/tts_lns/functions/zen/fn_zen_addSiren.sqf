if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Lights + Sirens", "Add Lights/Siren",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle")) exitWith {
			["Must be placed on a aircraft/land vehicle!"] call zen_common_fnc_showMessage;
		};

		[
			"Configure Lights/Siren", // title
		 	[ // array of controls for dialog
				["EDIT", ["Siren types", "Siren types this vehicle has access to seperated by commas. Valid options are 'Wail', 'Yelp' and 'Phaser'\nDefault is 'Wail,Yelp,Phaser'"],
					[ // control args
						"Wail,Yelp,Phaser"
					],
					false // force default
				],
				["COMBO", ["Left light colour", "Colour of the left light in the light bar"],
					[ // control args
						["red", "blue", "amber", "yellow", "green", "white", "magenta"], // return values
						["Red", "Blue", "Amber", "Yellow", "Green", "White", "Magenta"], // labels
						0 // element 0 is default selected
					],
					false // force default
				],
				["COMBO", ["Right light colour", "Colour of the right light in the light bar"],
					[ // control args
						["red", "blue", "amber", "yellow", "green", "white", "magenta"], // return values
						["Red", "Blue", "Amber", "Yellow", "Green", "White", "Magenta"], // labels
						1 // element 0 is default selected
					],
					false // force default
				],
				["EDIT", ["Light bar offset", "The offset (in m) from the vehicle's position the light bar is attached"],
					[ // control args
						str [-0.035,0.02,0.6]
					],
					false // force default
				],
				["SLIDER", ["Light centre offset", "The horizontal offset (in m) from the vehicle centre the lights on the light bar are placed"],
					[ // control args
						0, // min
						10, // max
						0.4, // default
						2 // 2 decimal places
					],
					false // force default
				],
				["CHECKBOX", ["Use fake light bar", "If checked this will attach a fake light bar to the vehicle at the light bar offset"],
					[ // control args
						false
					],
					false // force default
				],
				["CHECKBOX", ["Disable light pattern change", "If checked this will disable the action to change light pattern"],
					[ // control args
						false
					],
					false // force default
				]
			],
			{ // code run on dialog closed (only run if OK is clicked)
				params ["_dialogResult", "_args"];
				_args params ["_attachedObject"];
				_dialogResult params ["_sirenTypes", "_leftColour", "_rightColour", "_lightBarOffset", "_lightCentreOffset", "_fakeLightBar", "_disableLightChange"];
				_sirenTypes = _sirenTypes splitString ",";
				_lightBarOffset = parseSimpleArray _lightBarOffset;
				
				[_attachedObject, _sirenTypes, [_leftColour, _rightColour], _lightBarOffset, _lightCentreOffset, _fakeLightBar, _disableLightChange] remoteExecCall ["tts_lns_fnc_addSiren", 2];
				["Added lights/siren!"] call zen_common_fnc_showMessage;
			}, {}, [_attachedObject] // args
		] call zen_dialog_fnc_create;
	}, "scripts\tts_lns\icons\tts_settings.paa"] call zen_custom_modules_fnc_register;
};