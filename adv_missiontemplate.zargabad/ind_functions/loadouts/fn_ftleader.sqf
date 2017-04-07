﻿/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_I_CombatUniform","U_I_CombatUniform_shortsleeve"];
_vest = ["V_PlateCarrierIA2_dgtl","V_PlateCarrierIA1_dgtl"];
_headgear = ["H_HelmetIA"];
_backpack = [""];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "";
_unitTraits = [["medic",false],["engineer",false],["explosiveSpecialist",false],["UAVHacker",false],["camouflageCoef",1.0],["audibleCoef",1.0]];

//weapons - primary weapon - (string)
_primaryWeapon = ["arifle_Mk20_F","arifle_Mk20_plain_F"];

//primary weapon items - (array)
_optic = ["optic_Hamr"];
_attachments = [""];
if ( ADV_par_NVGs == 1 ) then { _attachments pushBack "acc_flashlight"; };
if ( ADV_par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = ["muzzle_snds_M"];

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [8,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

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
_handgun = "hgun_ACPC2_F";

//handgun items - (array)
_itemsHandgun = [];
_handgunSilencer = "muzzle_snds_acp";		//if silencer is added

//handgun ammo (if a handgun is given) - (integer)
_handgunAmmo = [2,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//weapons - launcher - (string)
_launcher = "";

//launcher ammo (if a launcher is given) - (integer) 
_launcherAmmo = [0,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

//binocular - (string)
_binocular = "Rangefinder";

//throwables - (integer)
_grenadeSet = 1;		//contains 2 HE grenades, 1 white and one coloured smoke grenade and 1 red chemlight. Select 0 if you want to define your own grenades.
_grenades = [""];		//depending on the custom loadout the colours may be merged. add like this: ["HE","HE","WHITE"] (adds two HE and one white smoke grenade).
_chemlights = [""];		//add like this: ["RED","RED","GREEN"] (adds two red and one green chemlight).
_IRgrenade = 1;

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
_givePersonalRadio = true;
_giveBackpackRadio = false;
_tfar_microdagr = 0;				//adds the tfar microdagr to set the channels for a rifleman radio

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
_ACE_MapTools = 1;
_ACE_CableTie = 2;
_ACE_EntrenchingTool = 0;
_ACE_sprayPaintColor = "RANDOM";
_ACE_gunbag = 0;

_ACE_key = 0;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
_ACE_flashlight = 1;
_ACE_kestrel = 0;
_ACE_altimeter = 0;
_ACE_ATragMX = 0;
_ACE_rangecard = 0;
_ACE_DAGR = 0;
_ACE_microDAGR = 1;
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
_androidDevice = true;
_microDAGR = false;
_helmetCam = false;

//scorch inv items
_scorchItems = ["sc_dogtag","sc_mre"];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_charms","sc_candybar","","",""];

//Addon Content:
switch (ADV_par_indWeap) do {
	case 1: {
		//Vanilla trg21
		_primaryWeapon = ["arifle_TRG21_F"];
		_silencer = ["muzzle_snds_M"];
	};
	case 2: {
		//SELmods
		_primaryweapon = ["rhs_weap_m4_carryhandle","rhs_weap_m4_carryhandle_mstock","rhs_weap_m4a1_carryhandle"];
		_optic = ["rhsusf_acc_ACOG","rhsusf_acc_ACOG3","rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD"];
		_attachments = [""];
		if ( ADV_par_NVGs == 1 ) then { _attachments pushback "rhsusf_acc_M952V"; };
		if ( ADV_par_NVGs == 2 ) then { _attachments pushback "rhsusf_acc_anpeq15side_bk"; };
		_attachments pushBack (["","","","","rhsusf_acc_grip1","rhsusf_acc_grip2","rhsusf_acc_grip2_tan","rhsusf_acc_grip3"] call BIS_fnc_selectRandom);
		_silencer = "rhsusf_acc_rotex5_grey";
		_primaryweaponAmmo set [1,9];
		_handgun = "rhsusf_weap_m1911a1";
		_itemsHandgun = [""];
		_handgunSilencer = "";
	};
	case 3: {
		_primaryWeapon = ["hlc_rifle_FAL5061","hlc_rifle_g3a3ris","hlc_rifle_STG58F","hlc_rifle_L1A1SLR"];
		_optic = [""];
		_attachments = [""];
		_silencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = ["RH_m1911"];
			_itemsHandgun = [""];
			_handgunSilencer = "";
		};
	};
	case 20: {
		//APEX HK416
		_primaryWeapon = ["arifle_SPAR_01_blk_F"];
		_silencer = "muzzle_snds_M";
		_primaryweaponAmmo set [1,1];
		_optic = ["optic_Arco_blk_F"];
	};
	case 21: {
		//APEX AKM
		_primaryWeapon = ["arifle_AKM_F","arifle_AKM_F","arifle_AKM_F","arifle_AK12_F"];
		_optic = [""];
		if ( ADV_par_NVGs == 2 ) then { _attachments = _attachments-["acc_pointer_IR"]; };
		_silencer = "";
	};
	default {};
};

switch (ADV_par_indUni) do {
	case 1: {
	//PMC uniforms
		_uniform = ["U_IG_Guerrilla_6_1","U_IG_Guerilla2_2","U_IG_Guerilla2_1","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_C_HunterBody_grn","U_Rangemaster","U_Competitor"];
		_vest = ["V_PlateCarrier1_blk","V_PlateCarrier2_blk"];
		_headgear = ["H_Cap_blk","H_Cap_blu","H_Cap_blk_CMMG","H_Cap_grn","H_Cap_oli","H_Cap_oli_hs","H_Cap_red","H_Cap_tan","H_MilCap_blue","H_MilCap_gry","H_Cap_headphones"];
		_backpack = [""];
	};
	case 2: {
	//TFA uniforms
		_uniform = ["TFA_Instructor_BW","TFA_Instructor_BT","TFA_Instructor2_BW","TFA_Instructor_BlT","TFA_green_blk_rs","TFA_green_blk","TFA_green_KHK","TFA_green_KHK_rs","TFA_black_KHK_rs","TFA_black_KHK","TFA_black_grn_rs","TFA_black_grn"];
		_vest = ["TFA_PlateCarrierH_Black","TFA_PlateCarrierH_fol","TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_Mix","TFA_PlateCarrierH_Tan"];
		_headgear = ["TFA_Cap_Inst","TFA_Cap_bears","TFA_Cap_lad","TFA_Cap_oak","TFA_Cap_HS_blk","TFA_Cap_HS_grn","TFA_Cap_HS_tan"];
	};
	case 20: {
	//Apex Syndikat
		_uniform = ["U_I_C_Soldier_Camo_F","U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F"];
		_vest = ["V_TacChestrig_grn_F","V_TacChestrig_cbr_F","V_TacChestrig_oli_F","V_HarnessO_brn","V_HarnessO_ghex_F","V_TacVest_oli","V_I_G_resistanceLeader_F"];
		_headgear = ["H_Cap_headphones","H_Shemag_olive","H_MilCap_gry","H_MilCap_blue","H_Cap_oli","H_Cap_grn","H_Booniehat_oli","H_Bandanna_khk","","","",""];
		_giveRiflemanRadio = true;
		_givePersonalRadio = false;
	};
};

///// No editing necessary below this line /////

_player = _this select 0;
if !(toUpper ((str _player) select [4,2]) == "FT") then {
	_ACE_sprayPaintColor = "NONE";
};
[_player] call ADV_fnc_gear;
if (toUpper ((str _player) select [4,2]) == "FT") exitWith {nil;};

switch ( toUpper ((str _player) select [4,4]) ) do {
	case "CSW_": { [_player,1] call ADV_fnc_CSW; };
	case "ACSW": { [_player,2] call ADV_fnc_CSW; };
	case "MORT": { [_player,3] call ADV_fnc_CSW; };
	case "AMOR": { [_player,4] call ADV_fnc_CSW; };
	case "TOW_": { [_player,5] call ADV_fnc_CSW; };
	case "ATOW": { [_player,6] call ADV_fnc_CSW; };
	default {
		switch true do {
			case (toUpper ((str _player) select [4,6]) == "ASSCSW"): { [_player,2] call ADV_fnc_CSW; };
			case (toUpper ((str _player) select [4,9]) == "ASSMORTAR"): { [_player,4] call ADV_fnc_CSW; };
			case (toUpper ((str _player) select [4,6]) == "ASSTOW"): { [_player,6] call ADV_fnc_CSW; };
			default {};
		};
	};
};

true;