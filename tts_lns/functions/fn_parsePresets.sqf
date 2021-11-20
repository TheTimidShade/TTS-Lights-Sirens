/*
	Author: TheTimidShade

	Description:
		Returns valid parameters from preset string for _lightBarOffset and _lightOffset

	Parameters:
		0: STRING - String offset passed to fn_addSiren
		1: STRING - String centre offset passed to fn_addSiren

	Returns:
		[_lightBarOffset, _lightOffset]

*/

params [
	["_lightBarOffset", "[-0.035,0.02,0.6]", [""]],
	["_lightOffset", "0.4", [""]]
];

private _offsetPresets = [
	["Offroad", [-0.035,0.02,0.6], 0.4],
	["Van", [-0.028,1.6,1.16], 0.4],
	["Hatchback", [-0.010,-0.019,0.28], 0.3],
	["Hunter", [0,-1.1,0.6], 0.45],
	["Ifrit", [0,-1.32,0.40], 0.5]
];

{
	if (_x#0 isEqualTo _lightBarOffset) then {
		_lightBarOffset = _x#1;
	};
	if (_x#0 isEqualTo _lightOffset) then {
		_lightOffset = _x#2;
	};
} forEach _offsetPresets;

// if no preset found check for array and reset to default if invalid
if (typeName _lightBarOffset == "STRING") then {
	if (_lightBarOffset select [0,1] == "[") then {
		_lightBarOffset = parseSimpleArray _lightBarOffset;
	}
	else
	{
		_lightBarOffset = [-0.035,0.02,0.6];
	};
};
if (typeName _lightOffset == "STRING") then {
	if (_lightOffset select [0,1] in "0123456789") then {
		_lightOffset = parseNumber _lightOffset;
	}
	else
	{
		_lightOffset = 0.4;
	};
};
[_lightBarOffset, _lightOffset]