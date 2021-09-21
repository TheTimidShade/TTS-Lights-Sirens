if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Lights + Sirens", "Change Lights",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle")) exitWith {
			["Must be placed on a aircraft/land vehicle!"] call zen_common_fnc_showMessage;
		};
		
		if (!(_attachedObject getVariable ["tts_lns_hasSiren", false])) exitWith {
			["No lights/siren detected on this vehicle!"] call zen_common_fnc_showMessage;
		};

		private _patternTypeValues = [];
		{_patternTypeValues pushBack _forEachIndex;} forEach (_attachedObject getVariable ["tts_lns_patternTypes", ["Alternating", "DoubleFlash", "RapidAlt"]]);
		[
			"Configure Lights", // title
		 	[ // array of controls for dialog
				["CHECKBOX", ["Lights on", "Sets the state of the vehicle's light bar"],
					[ // control args
						_attachedObject getVariable ["tts_lns_lightsOn", false]
					],
					true // force default
				],
				["COMBO", ["Light pattern", "Changes the pattern of the vehicle's light bar"],
					[ // control args
						_patternTypeValues, // return values
						_attachedObject getVariable ["tts_lns_patternTypes", ["Alternating", "DoubleFlash", "RapidAlt"]], // labels
						_attachedObject getVariable ["tts_lns_lightMode", 0]
					],
					true // force default
				]
			],
			{ // code run on dialog closed (only run if OK is clicked)
				params ["_dialogResult", "_args"];
				_args params ["_attachedObject"];
				_dialogResult params ["_lightsOn", "_lightsMode"];
				
				// set light state
				if (_lightsOn && !(_attachedObject getVariable ["tts_lns_lightsOn", false])) then {
					_attachedObject setVariable ["tts_lns_lightsOn", true, true];
					[_attachedObject] remoteExec ["tts_lns_fnc_turnLightsOn", 0, false];
				};
				if (!_lightsOn && _attachedObject getVariable ["tts_lns_lightsOn", false]) then {
					_attachedObject setVariable ["tts_lns_lightsOn", false, true];
				};

				// set light mode
				_attachedObject setVariable ["tts_lns_lightMode", _lightsMode, true];
				["Lights updated!"] call zen_common_fnc_showMessage;

			}, {}, [_attachedObject] // args
		] call zen_dialog_fnc_create;
	}, "scripts\tts_lns\icons\tts_settings.paa"] call zen_custom_modules_fnc_register;
};