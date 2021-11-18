/*
    Author: TheTimidShade

    Description:
        Adds siren/light actions + handles adding of actions for JIP players

    Parameters:
        0: OBJECT - Vehicle to add actions to

    Returns:
        NOTHING

*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (!hasInterface) exitWith {};
if (isNull _vehicle) exitWith {};

if (!(_vehicle getVariable ["tts_lns_hasSirenActions", false])) then // only add action if the vehicle doesn't already have it
{ 
    if (isClass(configFile >> "CfgPatches" >> "ace_main")) then
    {
        // initialise ACE actions
        private _category = ["tts_lns_actions", localize "STR_tts_lns_actionCategory", "scripts\tts_lns\icons\lns_icon_64px.paa",
            // statement
            {}, 
            // condition
            {
                driver _target == _player
                && _target getVariable ['tts_lns_hasSiren', false]
            } 
        ] call ace_interact_menu_fnc_createAction;

        private _toggleLights = ["ToggleLights", localize "STR_tts_lns_action_toggleLightBar", "scripts\tts_lns\icons\lns_edit_light_icon_64px.paa",
            // statement
            {
                params ["_target", "_player", "_params"];
                if (_target getVariable ["tts_lns_lightsOn", false]) then {
                    _target setVariable ["tts_lns_lightsOn", false, true];
                    hint localize "STR_tts_lns_action_lightsOff";
                } else {
                    _target setVariable ["tts_lns_lightsOn", true, true];
                    [_target] remoteExec ["tts_lns_fnc_turnLightsOn", 0, false];
                    hint localize "STR_tts_lns_action_lightsOn";
                };
            }, 
            // condition
            {
                count (_target getVariable ['tts_lns_patternTypes', ['Alternating']]) > 0
            } 
        ] call ace_interact_menu_fnc_createAction;

        private _changeLights = ["ChangeLights", localize "STR_tts_lns_actionCategory_changeLights", "scripts\tts_lns\icons\lns_edit_light_icon_64px.paa",
            // statement
            {}, 
            // condition
            {
                count (_target getVariable ['tts_lns_patternTypes', ['Alternating']]) > 1
            },
            // code to insert children
            {
                params ["_target", "_player", "_params"];
                
                private _actions = [];
                {
                    private _childStatement = {
                        params ["_target", "_player", "_params"];
                        _params params ["_vehicle", "_index"];
                        _vehicle setVariable ["tts_lns_lightMode", _index, true];
                        hint ((localize "STR_tts_lns_action_cycleLightMessage") + " " + (_vehicle getVariable ['tts_lns_patternTypes', ["Alternating"]])#_index);
                    };
                    private _action = [format ["%1", _x], _x, "", _childStatement, {true}, {}, [_target, _forEachIndex]] call ace_interact_menu_fnc_createAction;
                    _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
                } forEach (_target getVariable ['tts_lns_patternTypes', ['Alternating']]);

                _actions
            }
        ] call ace_interact_menu_fnc_createAction;

        private _toggleSiren = ["ToggleSiren", localize "STR_tts_lns_action_toggleSiren", "scripts\tts_lns\icons\lns_edit_sound_icon_64px.paa",
            // statement
            {
                params ["_target", "_player", "_params"];
                if (_target getVariable ["tts_lns_sirenOn", false]) then {
                    _target setVariable ["tts_lns_sirenOn", false, true];
                    hint localize "STR_tts_lns_action_sirenOff";
                } else {
                    _target setVariable ["tts_lns_sirenOn", true, true];
                    [_target] remoteExec ["tts_lns_fnc_turnSirenOn", 0, false];
                    hint localize "STR_tts_lns_action_sirenOn";
                };
            },
            // condition
            {
                count (_target getVariable ['tts_lns_sirenTypes', ['Wail']]) > 0
            } 
        ] call ace_interact_menu_fnc_createAction;

        private _changeSiren = ["ChangeSiren", localize "STR_tts_lns_actionCategory_changeSiren", "scripts\tts_lns\icons\lns_edit_sound_icon_64px.paa",
            // statement
            {}, 
            // condition
            {
                count (_target getVariable ['tts_lns_sirenTypes', ['Wail']]) > 1
            },
            // code to insert children
            {
                params ["_target", "_player", "_params"];
                
                private _actions = [];
                {
                    private _childStatement = {
                        params ["_target", "_player", "_params"];
                        _params params ["_vehicle", "_index"];
                        _target setVariable ["tts_lns_sirenMode", _index, true];
                        hint ((localize "STR_tts_lns_action_cycleSirenMessage") + " " + (_target getVariable ['tts_lns_sirenTypes', ['Wail']])#_index);
                    };
                    private _action = [format ["%1", _x], _x, "", _childStatement, {true}, {}, [_target, _forEachIndex]] call ace_interact_menu_fnc_createAction;
                    _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
                } forEach (_target getVariable ['tts_lns_sirenTypes', ['Wail']]);

                _actions
            }
        ] call ace_interact_menu_fnc_createAction;

        [_vehicle, 1, ["ACE_SelfActions"], _category] call ace_interact_menu_fnc_addActionToObject; 
        {
            [_vehicle, 1, ["ACE_SelfActions", "tts_lns_actions"], _x] call ace_interact_menu_fnc_addActionToObject; 
        } forEach [_toggleLights, _changeLights, _toggleSiren, _changeSiren];
    }
    else
    {
        // initialise vanilla actions
        private _sirenActionIDs = [];
        
        // toggle lights on/off
        _sirenActionIDs pushBack (_vehicle addAction [localize "STR_tts_lns_action_toggleLightBar", {
            params ["_target", "_caller", "_actionId", "_arguments"];

            if (_target getVariable ["tts_lns_lightsOn", false]) then {
                _target setVariable ["tts_lns_lightsOn", false, true];
                hint localize "STR_tts_lns_action_lightsOff";
            } else {
                _target setVariable ["tts_lns_lightsOn", true, true];
                [_target] remoteExec ["tts_lns_fnc_turnLightsOn", 0, false];
                hint localize "STR_tts_lns_action_lightsOn";
            };
        },
        [], 6, false, false, "", "driver _target == _this && _target getVariable ['tts_lns_hasSiren', false] && count (_target getVariable ['tts_lns_patternTypes', ['Alternating']]) > 0"]);

        // cycle light pattern
        _sirenActionIDs pushBack (_vehicle addAction [localize "STR_tts_lns_action_cycleLightPattern", {
            params ["_target", "_caller", "_actionId", "_arguments"];
            
            _target setVariable ["tts_lns_lightMode", ((_target getVariable ["tts_lns_lightMode", 0])+1) % count (_target getVariable ['tts_lns_patternTypes', ["Alternating"]]), true];
            hint ((localize "STR_tts_lns_action_cycleLightMessage") + " " + (_target getVariable ['tts_lns_patternTypes', ["Alternating"]])#(_target getVariable ["tts_lns_lightMode", 0]));
        },
        [], 6, false, false, "", "driver _target == _this && _target getVariable ['tts_lns_hasSiren', false] && count (_target getVariable ['tts_lns_patternTypes', ['Alternating']]) > 1"]);

        // toggle siren on/off
        _sirenActionIDs pushBack (_vehicle addAction [localize "STR_tts_lns_action_toggleSiren", {
            params ["_target", "_caller", "_actionId", "_arguments"];

            if (_target getVariable ["tts_lns_sirenOn", false]) then {
                _target setVariable ["tts_lns_sirenOn", false, true];
                hint localize "STR_tts_lns_action_sirenOff";
            } else {
                _target setVariable ["tts_lns_sirenOn", true, true];
                [_target] remoteExec ["tts_lns_fnc_turnSirenOn", 0, false];
                hint localize "STR_tts_lns_action_sirenOn";
            };
        },
        [], 6, false, false, "", "driver _target == _this && _target getVariable ['tts_lns_hasSiren', false] && count (_target getVariable ['tts_lns_sirenTypes', ['Wail']]) > 0"]);

        // cycle siren
        _sirenActionIDs pushBack (_vehicle addAction [localize "STR_tts_lns_action_cycleSirenMode", {
            params ["_target", "_caller", "_actionId", "_arguments"];

            _target setVariable ["tts_lns_sirenMode", ((_target getVariable ["tts_lns_sirenMode", 0])+1) % count (_target getVariable ['tts_lns_sirenTypes', ['Wail']]), true];
            hint ((localize "STR_tts_lns_action_cycleSirenMessage") + " " + (_target getVariable ['tts_lns_sirenTypes', ['Wail']])#(_target getVariable ["tts_lns_sirenMode", 0]));
        },
        [], 6, false, false, "", "driver _target == _this && _target getVariable ['tts_lns_hasSiren', false] && count (_target getVariable ['tts_lns_sirenTypes', ['Wail']]) > 1"]);
        
        _vehicle setVariable ["tts_lns_sirenActionIDs", _sirenActionIDs]; // store action IDs so they can be removed later
    };
    _vehicle setVariable ["tts_lns_hasSirenActions", true];
};