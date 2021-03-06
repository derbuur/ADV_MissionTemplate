﻿/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified.
*/

//clothing - (string)
_uniform = ["U_O_CombatUniform_ocamo"];
_vest = ["V_HarnessOSpec_brn"];
_headgear = ["H_HelmetSpecO_ocamo","H_HelmetO_ocamo"];
_backpack = [""];
if ( ADV_par_opfWeap > 0 ) then { _backpack = ["B_AssaultPack_ocamo","B_AssaultPack_cbr"]; };
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "";
_unitTraits = [["medic",false],["engineer",false],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryweapon = "LMG_Zafir_F";

//primary weapon items - (array)
_optic = ["optic_ACO_grn","optic_ARCO","optic_MRCO","optic_Holosight"];
_attachments = ["bipod_01_F_blk"];
if ( ADV_par_opfNVGs == 1 ) then { _attachments pushBack "acc_flashlight"; };
if ( ADV_par_opfNVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [4,0];
if (worldName == "TANOA" || ADV_par_opfWeap == 20 || ADV_par_opfWeap == 21) then {
	_primaryweapon = ["arifle_CTARS_blk_F"];
	_silencer = "muzzle_snds_58_blk_F";
	_primaryweaponAmmo = [5,0];
};

//40mm Grenades - (integer)
_40mmHeGrenadesAmmo = 0;
_40mmSmokeGrenadesWhite = 0;
_40mmSmokeGrenadesYellow = 0;
_40mmSmokeGrenadesOrange = 0;
_40mmSmokeGrenadesRed = 0;
_40mmSmokeGrenadesPurple = 0;
_40mmSmokeGrenadesBlue = 0;
_40mmSmokeGrenadesGreen = 0;
_40mmFlareWhite = 0;
_40mmFlareYellow = 0;
_40mmFlareRed = 0;
_40mmFlareGreen = 0;
_40mmFlareIR = 0;

//weapons - handgun - (string)
_handgun = "hgun_Rook40_F";

//handgun items - (array)
_itemsHandgun = [];
_handgunSilencer = "muzzle_snds_L";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [2,0];

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];

//binocular - (string)
_binocular = "";

//throwables - (integer)
_grenadeSet = 1;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = [""];		//depending on the custom loadout the colours may be merged. add like this: ["HE","HE","WHITE"] (adds two HE and one white smoke grenade).
_chemlights = [""];		//add like this: ["RED","RED","GREEN"] (adds two red and one green chemlight).
_IRgrenade = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 2;
_MediKit = 0;		//if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
_itemsUniform = [];

//items added specifically to vest: - (array)
_itemsVest = [];

//items added specifically to Backpack: - (array)
_itemsBackpack = [];

//linked items (don't put "ItemRadio" in here, as it's set with _equipRadio) - (array)
_itemsLink = [
		"ItemWatch",
		"ItemCompass",
		"ItemGPS",
		"ItemMap",
		"NVGoggles_OPFOR"
	];
		
//items added to any container - (array)
_items = [];

//MarksmenDLC-objects:
if (304400 in (getDLCs 1) || 332350 in (getDLCs 1)) then {
};

	//CustomMod items//
	
//TFAR or ACRE radios
_giveRiflemanRadio = true;
_givePersonalRadio = false;
_giveBackpackRadio = false;
_tfar_microdagr = 0;		//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 1;		//Adds a standard amount of medical items. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 0;
_ACE_packingBandage = 0;
_ACE_elasticBandage = 0;
_ACE_quikclot = 0;
_ACE_atropine = 0;
_ACE_adenosine = 0;
_ACE_epinephrine = 0;
_ACE_morphine = 0;
_ACE_tourniquet = 0;
_ACE_bloodIV = 0;
_ACE_bloodIV_500 = 0;
_ACE_bloodIV_250 = 0;
_ACE_plasmaIV = 0;
_ACE_plasmaIV_500 = 0;
_ACE_plasmaIV_250 = 0;
_ACE_salineIV = 0;
_ACE_salineIV_500 = 0;
_ACE_salineIV_250 = 0;
_ACE_bodyBag = 0;
_ACE_personalAidKit = 0;
_ACE_surgicalKit = 0;

_ACE_SpareBarrel = 0;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 0;
_ACE_DeadManSwitch = 0;
_ACE_DefusalKit = 0;
_ACE_Cellphone = 0;
_ACE_FlareTripMine = 0;
_ACE_MapTools = 0;
_ACE_CableTie = 0;
_ACE_EntrenchingTool = 0;
_ACE_sprayPaintColor = "NONE";
_ACE_gunbag = 0;

_ACE_key = 0;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 0;
_ACE_ATragMX = 0;
_ACE_rangecard = 0;
_ACE_DAGR = 1;
_ACE_microDAGR = 0;
_ACE_RangeTable_82mm = 0;
_ACE_MX2A = 0;
_ACE_HuntIR_monitor = 0;
_ACE_HuntIR = 0;
_ACE_m84 = 0;
_ACE_HandFlare_Green = 0;
_ACE_HandFlare_Red = 0;
_ACE_HandFlare_White = 0;
_ACE_HandFlare_Yellow = 0;

//AGM Variables (if AGM is running) - (bool)
_ACE_isMedic = 0;		//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 0;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = false;
_ACE_isPilot = false;

//Tablet-Items
_tablet = false;
_androidDevice = false;
_microDAGR = true;
_helmetCam = false;

//scorch inv items
_scorchItems = [""];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_candybar","","",""];

//Addon Content:
switch (ADV_par_opfWeap) do {
	case 1: {
		//RHS
		[] call {
			if (isClass(configFile >> "CfgPatches" >> "CUP_weapons_AK")) exitWith {
				_primaryWeapon = "CUP_arifle_RPK74M";
				_primaryweaponAmmo set [0,6];
				_silencer = "CUP_muzzle_Bizon";
			};
			_primaryweapon = "rhs_weap_pkm";
			_primaryweaponAmmo set [0,4];
			_silencer = "";
		};
		_optic = [""];
		_attachments = [""];
		_handgun = "rhs_weap_makarov_pmm";
		_itemsHandgun = [];
		_handgunSilencer = "";
	};
	case 2: {
		//RHS Guerilla
		call {
			if (isClass(configFile >> "CfgPatches" >> "CUP_weapons_AK")) exitWith {
				_primaryWeapon = "CUP_arifle_RPK74";
				_primaryweaponAmmo set [1,5];
				_silencer = "CUP_muzzle_Bizon";
			};
			_primaryweapon = "rhs_weap_pkm";
			_primaryweaponAmmo set [0,4];
			_silencer = "";		//if silencer is added
		};
		_optic = [""];
		_attachments = [""];
		_handgun = "";
		_itemsHandgun = [];
		_handgunSilencer = "";
	};
	case 3: {
		//CUP
		_primaryweapon = "CUP_arifle_RPK74";
		_optic = ["CUP_optic_Kobra"];
		_attachments = [""];
		_silencer = "CUP_muzzle_PBS4";		//if silencer is added
		_primaryweaponAmmo = [10,0];
		_handgun = "CUP_hgun_PB6P9";
		_itemsHandgun = [];
		_handgunSilencer = "CUP_muzzle_PB6P9";
	};
	case 4: {
		//HLC AK
		_primaryweapon = ["hlc_rifle_rpk74n"];
		_optic = [""];
		_attachments = [""];
		_silencer = "hlc_muzzle_762SUP_AK";		//if silencer is added
		_primaryweaponAmmo = [10,0];
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_mak";
			_itemsHandgun = [""];
			_handgunSilencer = "RH_pmsd";
		};
	};
	default {};
};
switch (ADV_par_opfUni) do {
	case 1: {
		//RHS EMR-Summer
		_uniform = ["rhs_uniform_emr_patchless"];
		_vest = ["rhs_6b23_digi_6sh92","rhs_6b13_Flora_6sh92","rhs_6b13_6sh92"];
		_headgear = ["rhs_6b28","rhs_6b28_ess","rhs_6b26_green","rhs_6b26_ess_green","rhs_6b27m_green","rhs_6b27m_green_ess","rhs_6b27m","rhs_6b27m_ess","rhs_6b28_green","rhs_6b28_green_ess"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 2: {
		//RHS Flora
		_uniform = ["rhs_uniform_flora_patchless"];
		_vest = ["rhs_6b13_Flora_6sh92","rhs_6b13_6sh92"];
		_headgear = ["rhs_6b26","rhs_6b26_ess","rhs_6b26_green","rhs_6b26_ess_green","rhs_6b27m_green","rhs_6b27m_green_ess","rhs_6b27m","rhs_6b27m_ess","rhs_6b28_green","rhs_6b28_green_ess"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 3: {
		//RHS Mountain Flora
		_uniform = ["rhs_uniform_mflora_patchless"];
		_vest = ["rhs_6b23_ML_6sh92"];
		_headgear = ["rhs_6b26_green","rhs_6b26_ess_green","rhs_6b27m_green","rhs_6b27m_green_ess","rhs_6b27m","rhs_6b27m_ess","rhs_6b28_green","rhs_6b28_green_ess"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 4: {
		//RHS EMR Desert
		_uniform = ["rhs_uniform_emr_des_patchless"];
		_vest = ["rhs_6b23_ML_6sh92"];
		_headgear = ["rhs_6b7_1m_olive","rhs_6b7_1m_bala2_olive","rhs_6b7_1m","rhs_6b7_1m_bala2","rhs_6b28_green","rhs_6b28_green_bala",
			"rhs_6b27m_green","rhs_6b27m_green_bala","rhs_6b27m_green_ess","rhs_6b26","rhs_6b26_bala","rhs_6b26_ess"];
		_backpack = ["rhs_sidor","rhs_assault_umbts","B_AssaultPack_sgg"];
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhs_1PN138"];
	};
	case 5: {
		//Guerilla
		_uniform = ["U_OG_Guerrilla_6_1","U_OG_Guerilla2_2","U_OG_Guerilla2_1","U_OG_Guerilla2_3","U_OG_Guerilla3_1"];
		_headgear = ["H_Watchcap_cbr","H_Watchcap_camo","H_Booniehat_khk","H_Booniehat_oli","H_Cap_blk","H_Cap_oli","H_Cap_tan","H_Cap_brn_SPECOPS","H_MilCap_ocamo",
			"H_Cap_headphones","H_ShemagOpen_tan"];
	};
	case 6: {
		//Afghan Militia (EricJ's Taliban)
		_uniform = ["U_Afghan01NH","U_Afghan02NH","U_Afghan03NH"];
		_vest = ["V_HarnessOGL_brn","V_HarnessOGL_gry"];
		if (isClass(configFile >> "CfgPatches" >> "maa_Uniform")) then {_uniform append ["TRYK_U_taki_BL","TRYK_U_taki_COY","TRYK_U_taki_wh","TRYK_U_taki_G_BL","TRYK_U_taki_G_COY","TRYK_U_taki_G_WH","TRYK_ZARATAKI","TRYK_ZARATAKI2","TRYK_ZARATAKI3"]};
		_headgear = ["","H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk","Afghan_01Hat","Afghan_02Hat","Afghan_03Hat","Afghan_04Hat","Afghan_05Hat","Afghan_06Hat"];
		_goggles = "";
		_useProfileGoggles = 0;
		if ( ADV_par_opfWeap > 0 ) then { _backpack = ["rhs_sidor"]; };
		_goggles = "";
		_useProfileGoggles = 0;
	};
	case 20: {
		//Apex Green Hex
		_uniform = ["U_O_T_Soldier_F"];
		_vest = ["V_HarnessO_ghex_F","V_HarnessO_ghex_F","V_HarnessOSpec_brn","V_TacVest_oli"];
		_headgear = ["H_HelmetO_ghex_F","H_HelmetSpecO_ghex_F"];
		if ( ADV_par_opfWeap > 0 && ADV_par_opfWeap < 5 ) then { _backpack = ["B_AssaultPack_rgr"]; };
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["NVGoggles_tna_F"];
	};
	default {};
};

///// No editing necessary below this line /////
_player = _this select 0;
[_player] call ADV_fnc_gear;

nil;