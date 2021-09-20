class tts_lns
{
	class Main
	{
		file = "scripts\tts_lns\functions";
		class addSiren {};
		class removeSiren {};
		class turnLightsOn {};
		class turnSirenOn {};
		class createSirenSound {};
		class addSirenActions {};
		class removeSirenActions {};
		class handleSirenJIP;
		class handleLightBarCleanup {};
	};
	class ZEN
	{
		file = "scripts\tts_lns\functions\zen";
		class zen_initCustomModules {preInit = 1;};
		class zen_addSiren {};
		class zen_removeSiren {};
		class zen_changeLights {};
		class zen_changeSiren {};
	};
};
