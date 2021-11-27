["TTS Lights + Sirens", "STR_tts_lns_moduleChangeLightsSiren_title",
{
    params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

    if (isNull _attachedObject || !(_attachedObject isKindOf "Air" || _attachedObject isKindOf "LandVehicle" || _attachedObject isKindOf "Ship")) exitWith {
        ["STR_tts_lns_moduleAddSiren_warning"] call zen_common_fnc_showMessage;
    };
    
    if (!(_attachedObject getVariable ["tts_lns_hasSiren", false])) exitWith {
        ["STR_tts_lns_moduleChangeLightsSiren_warning"] call zen_common_fnc_showMessage;
    };

    private _patternTypeValues = [];
    {_patternTypeValues pushBack _forEachIndex;} forEach (_attachedObject getVariable ["tts_lns_patternTypes", ["Alternating", "DoubleFlash", "RapidAlt"]]);
    private _sirenModeValues = [];
    {_sirenModeValues pushBack _forEachIndex;} forEach (_attachedObject getVariable ["tts_lns_sirenTypes", ["Wail", "Yelp", "Phaser"]]);
    [
        "STR_tts_lns_moduleChangeLightsSiren_title", // title
        [ // array of controls for dialog
            ["CHECKBOX", ["Lights on", "Sets the state of the vehicle's light bar"],
                [ // control args
                    _attachedObject getVariable ["tts_lns_lightsOn", false]
                ],
                true // force default
            ],
            ["COMBO", ["STR_tts_lns_moduleChangeLightsSiren_lightPattern", "STR_tts_lns_moduleChangeLightsSiren_lightPattern_desc"],
                [ // control args
                    _patternTypeValues, // return values
                    _attachedObject getVariable ["tts_lns_patternTypes", ["Alternating", "DoubleFlash", "RapidAlt"]], // labels
                    _attachedObject getVariable ["tts_lns_lightMode", 0]
                ],
                true // force default
            ],
            ["CHECKBOX", ["STR_tts_lns_moduleChangeLightsSiren_sirenOn", "STR_tts_lns_moduleChangeLightsSiren_sirenOn_desc"],
                [ // control args
                    _attachedObject getVariable ["tts_lns_sirenOn", false]
                ],
                true // force default
            ],
            ["COMBO", ["STR_tts_lns_moduleChangeLightsSiren_sirenMode", "STR_tts_lns_moduleChangeLightsSiren_sirenMode_desc"],
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
            _dialogResult params ["_lightsOn", "_lightsMode", "_sirenOn", "_sirenMode"];
            
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
            ["STR_tts_lns_moduleChangeLightsSiren_completeMessage"] call zen_common_fnc_showMessage;

        }, {}, [_attachedObject] // args
    ] call zen_dialog_fnc_create;
}, "scripts\tts_lns\icons\lns_icon_64px.paa"] call zen_custom_modules_fnc_register;