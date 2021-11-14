/*
	Author: TheTimidShade

	Description:
		Handles a flash from the light bar

	Parameters:
		0: OBJECT - Light point to flash
		1: OBJECT - Sphere to flash (used for daytime)
		2: BOOL - True for light on, false for light off
	
	Returns:
		NOTHING

*/

params [
	["_light", objNull, [objNull]],
	["_sphere", objNull, [objNull]],
	["_on", true, [false]]
];

if (!hasInterface) exitWith {};
if (isNull _light || isNull _sphere) exitWith {};

if (_on) then
{
	_light setLightIntensity 150;
	if (sunOrMoon > 0) then {_sphere hideObject false;};
}
else 
{
	_light setLightIntensity 0;
	_sphere hideObject true;
};