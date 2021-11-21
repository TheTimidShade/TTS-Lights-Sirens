/*
    Author: TheTimidShade

    Description:
        Initialises custom modules for ZEN if enabled

    Parameters:
        NONE
        
    Returns:
        NONE
*/

if (!isClass (configFile >> "CfgPatches" >> "zen_main")) exitWith {};

[] call tts_lns_fnc_zen_moduleAddSiren;
[] call tts_lns_fnc_zen_moduleRemoveSiren;
[] call tts_lns_fnc_zen_moduleChangeLights;
[] call tts_lns_fnc_zen_moduleChangeSiren;