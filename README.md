# TTS Lights + Sirens
This script allows mission makers and Zeuses to add more sophisticated light/siren systems to vehicles. When the lights are turned on, dynamic lights are created to simulate the flash from the lights which looks significantly better at night. During the day, 'sphere' objects are created along with the lights so that the lights are easily visible since light sources do not show up well in bright lighting. When the siren is turned on, the siren sound effect will play on loop until it is turned off. The light pattern and siren tone can be changed through the action menu (ACE interaction if using ACE). Light colours and siren tones can be customised for individual vehicles.

You can see the script in action in this [demo video](https://youtu.be/EXLUBDblfe8) or if you'd like to test the script for yourself, you can try out the [demo mission](https://steamcommunity.com/sharedfiles/filedetails/?id=2661391416).

This is the script version, a [mod version](https://steamcommunity.com/sharedfiles/filedetails/?id=2661398142) is also available on the Steam Workshop.

### Features:
- Lights/sirens can be added to any vehicle
- Customisable light colour/siren sound
- Light pattern and siren type can be changed through the action menu
- Lights/siren can be turned on via script/Zeus to support non-player vehicles
- Designed for multiplayer and tested on dedicated server
- Compatible with ACE
- Useable from Zeus via [Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631)
- Editor modules to simplify usage (*Mod version only*!)

**ZEN Modules**:
- Add Lights/Siren
- Change Lights/Siren
- Remove Lights/Siren

**Editor Modules (MOD VERSION ONLY):**
- Add Lights/Siren
- Set Light/Siren State

**For help with troubleshooting, questions or feedback, join my [Discord](https://discord.gg/8Y2ENWQMpK)**

___

The available light colours are:
- Red
- Blue
- Amber/Orange
- Yellow
- Green
- White
- Magenta/Purple  

Based on common light colours for emergency/utility vehicles according to [Wikipedia](https://en.wikipedia.org/wiki/Emergency_vehicle_lighting).  

The available light patterns are 'Alternating', 'DoubleFlash' and 'RapidAlt'.  
The available siren types are 'Wail', 'Yelp', 'Phaser' and 'TwoTone'.

___

### **More information:**
- [Script version install instructions](https://github.com/TheTimidShade/TTS-Lights-Sirens/wiki/Script-version-install-instructions)
- [Function documentation](https://github.com/TheTimidShade/TTS-Lights-Sirens/wiki/Function-documentation)

### **License:**
This script is licensed under [Arma Public License Share Alike (APL-SA)](https://www.bohemia.net/community/licenses/arma-public-license-share-alike).

### **Supported Languages:**
- English 

If you'd like to translate the script into a different language, contact me via my Discord or create a pull request.

### **Credits:**
- Members of the [Task Force Dingo](taskforcedingo.com) community who helped test the script in multiplayer and provided the dedicated server used for testing.

___


### **Examples:**  
Add lights/siren to vehicle:
```sqf
[_vehicle, ["Wail", "Phaser"], ["Alternating", "RapidAlt"], ["red", "blue"], [-0.035,0.02,0.6], 0.4, false] call tts_lns_fnc_addSiren;
```
Manage lights via script:
```sqf
// lights on
if (isServer) then {
    _vehicle setVariable ["tts_lns_lightsOn", true, true]; // turn lights on
    [_vehicle] remoteExec ["tts_lns_fnc_turnLightsOn", 0, false]; // start effect
};

// lights off
_vehicle setVariable ["tts_lns_lightsOn", false, true];

// change lights
// changes lights to mode 1 (second mode in light pattern array for this vehicle)
_vehicle setVariable ["tts_lns_lightMode", 1, true];
```
Manage siren via script:
```sqf
// siren on
if (isServer) then {
    _vehicle setVariable ["tts_lns_sirenOn", true, true]; // turn siren on
    [_vehicle] remoteExec ["tts_lns_fnc_turnSirenOn", 0, false]; // play siren effect
};

// siren off
_vehicle setVariable ["tts_lns_sirenOn", false, true];

// change siren
// changes siren to tone 1 (second tone in siren types array for this vehicle)
_vehicle setVariable ["tts_lns_sirenMode", 2, true];
```
Remove lights/siren:
```sqf
[_vehicle] call tts_lns_fnc_removeSiren;
```

___

## Changelog
Read below for complete changelog history.

### 02/01/2022
- Fixed an issue with the actions not being added correctly in multiplayer for vehicles that did not have a variable name.

### 27/11/2021
- Merged 'Change Lights' and 'Change Siren' ZEN module.

### 22/11/2021
- Adjusted light point settings.
- Adjusted light intensity.

### 21/11/2021
- Updated stringtable with editor module entries.
- Increased light flare distance to 3km.
- Added checks to make sure lightMode and sirenMode are valid before using them since invalid values were causing performance issues.
- Converted tabs to spaces.

### 20/11/2021
- Added missing stringtable entries.
- Added ships to valid vehicles list.
- Added ability to write string in offset parameters to use presets. Current presets are "Offroad", "Van", "Hatchback", "Hunter" and "Ifrit".
- Added preset parameter to 'Add Lights/Siren' ZEN module.
- Removed `init.sqf` since it isn't needed.

### 19/11/2021
- Reworked README file.

### 18/11/2021
- Fixed some incorrect stringtable entries.
- Added ACE action support.

### 14/11/2021
- Added ZEN module icons.
- Cleaned up ZEN functions.
- Added init function.
- Added 'Two Tone' siren type.
- Added stringtable.
- Split light bar setup into it's own function.
- Cleaned up `fn_turnLightsOn`.

### 21/09/2021
- Added variable light pattern system same as siren system so amount and type of light patterns can be customised.
- Added the ability to leave the light/siren type lists empty to disable them.

### 20/09/2021
- Fixed JIP adding/removing of actions not working.
- Fixed lights/sirens that are on not being turned on for JIP players.
- Added V1 of ZEN modules.
- Fixed fake light bar not getting deleted properly when the vehicle they were attached to was deleted.

### 19/09/2021
- Created repository.
