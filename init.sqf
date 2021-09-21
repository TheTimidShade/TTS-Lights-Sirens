if (isServer) then {
	[vehicle1, ["Wail", "Yelp", "Phaser"], ["Alternating", "DoubleFlash", "RapidAlt"], ["red", "blue"], [-0.035,0.02,0.6], 0.4, false] call tts_lns_fnc_addSiren;
	[vehicle2, ["Wail", "Yelp", "Phaser"], ["DoubleFlash", "RapidAlt"], ["red", "blue"], [-0.028,1.6,1.16], 0.4, false] call tts_lns_fnc_addSiren;
	[vehicle3, ["Wail", "Yelp", "Phaser"], ["Alternating", "DoubleFlash", "RapidAlt"], ["red", "blue"], [-0.010,-0.019,0.28], 0.3, true] call tts_lns_fnc_addSiren;
};