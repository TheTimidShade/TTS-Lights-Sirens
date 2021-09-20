if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Lights + Sirens", "Change Siren",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle")) exitWith {
			["Must be placed on a aircraft/land vehicle!"] call zen_common_fnc_showMessage;
		};
		
		if (!(_attachedObject getVariable ["tts_lns_hasSiren", false])) exitWith {
			["No lights/siren detected on this vehicle!"] call zen_common_fnc_showMessage;
		};

		private _sirenModeValues = [];
		{_sirenModeValues pushBack _forEachIndex;} forEach (_attachedObject getVariable ["tts_lns_sirenTypes", ["Wail", "Yelp", "Phaser"]]);
		[
			"Configure Siren", // title
		 	[ // array of controls for dialog
				["CHECKBOX", ["Siren on", "Sets the state of the vehicle's siren"],
					[ // control args
						_attachedObject getVariable ["tts_lns_sirenOn", false]
					],
					true // force default
				],
				["COMBO", ["Siren mode", "Changes the sound emitted by the vehicle's siren\nOnly siren types available to the vehicle are shown (defined by addSiren parameters)"],
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
				["Siren updated!"] call zen_common_fnc_showMessage;

			}, {}, [_attachedObject] // args
		] call zen_dialog_fnc_create;
	}, "scripts\tts_lns\icons\tts_settings.paa"] call zen_custom_modules_fnc_register;
};