class tts_lns
{
	class lns
	{
		file = "scripts\tts_lns\functions";
		class init { postInit = 1; };
		class addSiren {};
		class removeSiren {};
		class turnLightsOn {};
		class turnSirenOn {};
		class createSirenSound {};
		class addSirenActions {};
		class removeSirenActions {};
		class handleSirenJIP {};
		class setupLightBar {};
		class handleLightBarCleanup {};
		class flashLight {};
		class createLightObjects {};
		class parsePresets {};
	};
	class zen
	{
		file = "scripts\tts_lns\functions\zen";
		class initCustomModules {};
		class zen_moduleAddSiren {};
		class zen_moduleRemoveSiren {};
		class zen_moduleChangeLights {};
		class zen_moduleChangeSiren {};
	};
};
