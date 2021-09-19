# Lights & Sirens Script
## Overview:
Designed for Arma 3, this script allows mission makers and Zeuses to add more sophisticated light/siren systems to vehicles. It can also be used to add a ~~pair of tent lights~~ very expensive custom light bar to vehicles that do not normally have one. The colour of the lights is customisable and multiple light patterns/sirens are available. It is also compatible with Zeus Enhanced so mission makers can use it to enhance their mission on the fly.

## Features:
- Lights/sirens can be added to any vehicle
- Customisable light colour/siren sound
- Light pattern and siren type can be changed through the action menu (if added)
- Light/siren can be turned on via script/Zeus to support non-player vehicles
- Works in MP (Tested on dedicated server)
- Compatible with Zeus Enhanced

The provided light colours are:
- Red
- Blue
- Amber
- Yellow
- Green
- White
- Magenta/Purple
(Based on common colours for emergency/utility vehicles https://en.wikipedia.org/wiki/Emergency_vehicle_lighting)
If you really want to use a different colour to what is provided you can overwrite this colour using:
```sqf
vehicle setVariable ["tts_lns_lightBarColours", [[R,G,B], [R,G,B]], true];
```
Where the first set of RGB values is the left light and the second is the right light. R/G/B value must be from 0-1, so divide by 255 if you are converting from a format like [51, 102, 204]. You might notice excessive brightness if you don't do this.

**NOTE**: This won't work for the fake light bar since it uses premade textures for the provided colours. You might get errors if you try this on a vehicle that uses the fake light bar.

The provided siren types are 'Wail', 'Yelp' and 'Phaser'.

You will not be able to use this script from Zeus unless Zeus Enhanced is loaded.

Demo Video: N/A  
Steam Workshop page: N/A  
Zeus Enhanced: https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631  

## Setup/Use:
1. Download files from repository.
2. Excluding `README.md`, move files into your mission folder and merge `description.ext` and `init.sqf` with your existing files (if you have them).
3. Set up vehicles with sirens/lights in `init.sqf` (see example `init.sqf`) OR apply using Zeus (requires Zeus Enhanced).


## Changelog
Read below for complete changelog history.

### 19/09/2021
- Created repository.