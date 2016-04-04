﻿/*
unit loadout script by Belbo
creates a specific loadout for playable units. Add the items to their respective variables. (expected data type is given).
The kind of ammo a player gets with this loadout does not necessarily have to be specified. If tracer ammo is supposed to be used, you should set _primaryweaponAmmo to 0 and add those
magazines one for one in _items.
*/

//clothing - (string)
_uniform = ["U_B_CombatUniform_mcam_worn"];
_vest = ["V_PlateCarrierGL_rgr"];
_headgear = ["H_HelmetB_grass"];
_backpack = ["B_Carryall_khk"];
_insignium = "";
_useProfileGoggles = 1;		//If set to 1, goggles from your profile will be used. If set to 0, _goggles will be added (or profile goggles will be removed when _goggles is left empty).
_goggles = "G_Lowprofile";

//weapons - primary weapon - (string)
_primaryweapon = ["arifle_MX_Black_F","arifle_MX_F","arifle_MXC_Black_F","arifle_MXC_F"];

//primary weapon items - (array)
_optic = ["optic_ACO","optic_Hamr","optic_MRCO","optic_Holosight"];
_attachments = [""];
if ( ADV_par_NVGs == 1 ) then { _attachments pushback "acc_flashlight"; };
if ( ADV_par_NVGs == 2 ) then { _attachments pushback "acc_pointer_IR"; };
_silencer = "muzzle_snds_H";		//if silencer is added

//primary weapon ammo (if a primary weapon is given) and how many tracer mags - (integer)
_primaryweaponAmmo = [7,0];		//first number: Amount of magazines, second number: config index of magazine or classname of magazine type.

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
_handgun = "hgun_Pistol_heavy_01_F";

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
_binocular = "Binocular";

//throwables - (integer)
_grenadeHE = 2;
_grenadeSmokeWhite = 1;
_grenadeSmokeYellow = 0;
_grenadeSmokeOrange = 0;
_grenadeSmokeRed = 0;
_grenadeSmokePurple = 0;
_grenadeSmokeBlue = 0;
_grenadeSmokeGreen = 1;
_chemlightYellow = 0;
_chemlightRed = 1;
_chemlightGreen = 0;
_chemlightBlue = 0;
_IRgrenade = 0;

//first aid kits and medi kits- (integer)
_FirstAidKits = 2;
_MediKit = 0;		//if set to 1, a MediKit and all FirstAidKits will be added to the backpack; if set to 0, FirstAidKits will be added to inventory in no specific order.

//items added specifically to uniform: - (array)
_itemsUniform = [];

//items added specifically to vest: - (array)
_itemsVest = [];

//items added specifically to Backpack: - (array)
_itemsBackpack = ["ToolKit","MineDetector","SatchelCharge_Remote_Mag"];

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

//ACRE radios
_ACREradios = ["ACRE_PRC343"];	//_this select 0=shortrange radio;_this select 1=leader radio;_this select 2=backpackRadio;
//TFAR items
_givePersonalRadio = false;
_giveRiflemanRadio = true;
_tfar_microdagr = 0;		//adds the tfar microdagr to set the channels for a rifleman radio

//ACE items (if ACE is running on the server) - (integers)
_ACE_EarPlugs = 1;

_ace_FAK = 1;		//overwrites the values for bandages, morphine and tourniquet and adds a specified number of bandages and morphine. Defined in fn_aceFAK.sqf
_ACE_fieldDressing = 3;
_ACE_packingBandage = 6;
_ACE_elasticBandage = 6;
_ACE_quikclot = 6;
_ACE_atropine = 0;
_ACE_adenosine = 0;
_ACE_epinephrine = 0;
_ACE_morphine = 2;
_ACE_tourniquet = 2;
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
_ACE_EntrenchingTool = 1;
_ACE_UAVBattery = 0;
_ACE_wirecutter = 0;
_ACE_Clacker = 0;
_ACE_M26_Clacker = 1;
_ACE_DeadManSwitch = 1;
_ACE_DefusalKit = 1;
_ACE_Cellphone = 0;
_ACE_MapTools = 0;
_ACE_CableTie = 2;
_ACE_sprayPaintColor = "NONE";

_ACE_key = 3;	//0 = no key, 1 = side dependant key, 2 = master key, 3 = lockpick
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
_ACE_isMedic = 0;	//0 = no medic; 1 = medic; 2 = doctor;
_ACE_isEngineer = 2;	//0 = no specialist; 1 = engineer; 2 = repair specialist;
_ACE_isEOD = true;
_ACE_isPilot = false;

//Tablet-Items
_tablet = false;
_androidDevice = false;
_microDAGR = true;
_helmetCam = false;

//scorch inv items
_scorchItems = ["sc_dogtag","sc_mre"];
_scorchItemsRandom = ["sc_cigarettepack","sc_chips","sc_charms","sc_candybar","sc_wrench","sc_wrench","sc_tape","sc_tape"];

//Addon Content:
switch (ADV_par_customWeap) do {
	case 1: {
		//BWmod
		if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36")) then {
			_primaryWeapon = ["hlc_rifle_G36A1"];
			_optic = ["HLC_Optic_G36dualoptic35x2d"];
			_attachments = [""];
			if (isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod")) then { _primaryweaponAmmo set [1,4] };
		} else {
			_primaryweapon = ["BWA3_G36"];
			_optic = ["BWA3_optic_ZO4x30"];
			if ( ADV_par_NVGs > 0 ) then { _attachments = ["BWA3_acc_LLM01_irlaser"]; };
		};
		_silencer = "BWA3_muzzle_snds_G36";		//if silencer is added
		_handgun = "BWA3_P8";
		_itemsHandgun = [];
		_handgunSilencer = "";		//if silencer is added
	};
	case 2: {
		//SELmods
		_primaryweapon = ["rhs_weap_m4_grip2","rhs_weap_m4_carryhandle","rhs_weap_m4_carryhandle"];
		if (ADV_par_customUni == 10 || ADV_par_customUni == 11) then {
			_primaryweapon = ["rhs_weap_m4_carryhandle","rhs_weap_m16a4_carryhandle","rhs_weap_m16a4_carryhandle","rhs_weap_m16a4_carryhandle","rhs_weap_m16a4_grip"];
		};
		_optic = ["rhsusf_acc_compm4","rhsusf_acc_eotech_552","rhsusf_acc_ACOG"];
		//if (isClass(configFile >> "CfgPatches" >> "iansky_opt")) then {_optic append [""];};
		if ( ADV_par_NVGs > 0 ) then { _attachments = ["rhsusf_acc_anpeq15"]; };
		_silencer = "rhsusf_acc_rotex5_grey";		//if silencer is added
		_primaryweaponAmmo set [1,9];
		_handgun = "rhsusf_weap_m9";
		_itemsHandgun = [""];
		_handgunSilencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = "RH_m9";
			_itemsHandgun = ["RH_x300"];
			_handgunSilencer = "RH_m9qd";
		};
	};
	case 3: {
		//SELmods CUP Mk16
		_primaryweapon = ["CUP_arifle_Mk16_CQC_FG","CUP_arifle_Mk16_CQC_SFG","CUP_arifle_Mk16_CQC","CUP_arifle_Mk16_CQC"];
		_optic = ["CUP_optic_CompM4"];
		if ( ADV_par_NVGs > 0 ) then { _attachments = ["CUP_acc_ANPEQ_15"]; };
		_silencer = "CUP_muzzle_snds_SCAR_L";		//if silencer is added
		_primaryweaponAmmo set [1,9];
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 4: {
		//SELmods CUP M4
		_primaryweapon = ["CUP_arifle_M4A1","CUP_arifle_M4A1_black","CUP_arifle_M4A1_camo","CUP_arifle_M4A1_desert","CUP_arifle_M4A3_desert"];
		_optic = ["CUP_optic_CompM4"];
		if ( ADV_par_NVGs > 0 ) then { _attachments = ["CUP_acc_ANPEQ_2_camo"]; };
		_silencer = "CUP_muzzle_snds_M16_camo";		//if silencer is added
		_primaryweaponAmmo set [1,9];
		_handgun="CUP_hgun_M9";
		_itemsHandgun=[];
		_handgunSilencer = "CUP_muzzle_snds_M9";		//if silencer is added
	};
	case 5: {
		//BAF
		_primaryweapon="CUP_arifle_L85A2";
		_optic = ["CUP_optic_SUSAT","CUP_optic_ACOG"];
		_attachments = [];
		_silencer = "CUP_muzzle_snds_L85";		//if silencer is added
		_primaryweaponAmmo set [1,9];
		_handgun="CUP_hgun_Glock17";
		_itemsHandgun=["CUP_acc_Glock17_Flashlight"];
		_handgunSilencer = "muzzle_snds_L";		//if silencer is added
	};
	case 6: {
		//UK3CB
		_primaryweapon = ["UK3CB_BAF_L85A2","UK3CB_BAF_L85A2_RIS_AFG","UK3CB_BAF_L85A2_EMAG","UK3CB_BAF_L85A2_RIS"];
		_optic = ["UK3CB_BAF_SUSAT_3D","UK3CB_BAF_TA31F_3D"];
		if ( ADV_par_NVGs > 0 ) then { _attachments = ["UK3CB_BAF_LLM_IR_Black"]; };
		_silencer = "UK3CB_BAF_Silencer_L85";
		_primaryweaponAmmo set [1,2];
		_handgun = "UK3CB_BAF_L131A1";
		_itemsHandgun=["UK3CB_BAF_Flashlight_L131A1"];
		_handgunSilencer = "muzzle_snds_L";
	};
	case 7: {
		_primaryWeapon = ["hlc_rifle_g3a3ris","hlc_rifle_g3a3ris","hlc_rifle_g3a3ris","hlc_rifle_FAL5061","hlc_rifle_STG58F","hlc_rifle_L1A1SLR"];
		_optic = [""];
		_attachments = [""];
		_silencer = "";
		if (isClass(configFile >> "CfgPatches" >> "RH_de_cfg")) then {
			_handgun = ["RH_m1911"];
			_itemsHandgun = [""];
			_handgunSilencer = "";
		};
	};
	default {};
};
switch (ADV_par_customUni) do {
	case 1: {
		//BWmod Tropen
		_uniform = ["BWA3_Uniform_idz_Tropen"];
		if (isClass(configFile >> "CfgPatches" >> "German_feldbluse_patches")) then { 
			_uniform = ["PBW_Uniform1_tropen","PBW_Uniform1H_tropen","PBW_Uniform2_tropen","PBW_Uniform3_tropen","PBW_Uniform3K_tropen","PBW_Uniform4_tropen","PBW_Uniform4K_tropen"]; 
		};
		_vest = ["BWA3_Vest_Grenadier_Tropen"];
		_headgear = ["BWA3_CrewmanKSK_Tropen","BWA3_OpsCore_Tropen_Camera"];
		if (isClass(configFile >> "CfgPatches" >> "example_german_headgear_config")) then {
			_items pushback "PBW_muetze1_tropen";
		};
		_backpack = ["BWA3_PatrolPack_Tropen"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 2: {
		//BWmod Fleck
		_uniform = ["BWA3_Uniform_idz_Fleck"];
		if (isClass(configFile >> "CfgPatches" >> "German_feldbluse_patches")) then { 
			_uniform = ["PBW_Uniform1_fleck","PBW_Uniform1H_fleck","PBW_Uniform2_fleck","PBW_Uniform3_fleck","PBW_Uniform3K_fleck","PBW_Uniform4_fleck","PBW_Uniform4K_fleck"]; 
		};
		_vest = ["BWA3_Vest_Grenadier_Fleck"];
		_headgear = ["BWA3_CrewmanKSK_Fleck","BWA3_OpsCore_Fleck_Camera"];
		if (isClass(configFile >> "CfgPatches" >> "example_german_headgear_config")) then {
			_items pushback "PBW_muetze1_fleck";
		};
		_backpack = ["BWA3_PatrolPack_Fleck"];
		if ( isClass(configFile >> "CfgPatches" >> "Dsk_lucie_config") ) then { _itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["dsk_nsv"]; };
	};
	case 3: {
		//TFA Mixed
		_uniform = ["TFA_BDU_MCAM_RS","TFA_BDU_MCAM","TFA_BDU_NWU2","TFA_BDU_NWU2_RS","TFA_MCAM_BDU","TFA_MCAM_BDU_RS","TFA_MCAM_NWU2","TFA_MCAM_NWU2_RS","TFA_MCAM_NWU3","TFA_MCAM_NWU3_RS",
			"TFA_NWU2_MCAM","TFA_NWU2_MCAM_RS","TFA_NWU2_BDU","TFA_NWU2_BDU_RS","TFA_NWU2_NWU3","TFA_NWU2_NWU3_RS","TFA_NWU3_MCAM","TFA_NWU3_MCAM_RS","TFA_NWU3_NWU2","TFA_NWU3_NWU2_RS"];
		_vest = ["TFA_PlateCarrierH_MCam","TFA_PlateCarrierH_Tan","TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_NWU2"];
		_headgear = ["TFA_ECH_Multi","TFA_ECH_Tan","TFA_ECH_NWU3","TFA_ECH_DESERT","TFA_ECH_SAND","TFA_ECH_GRASS""TFA_FAST_Multi","TFA_FAST_Tan","TFA_FAST_NWU2","TFA_FAST_NWU3",
					"TFA_FAST_DES","TFA_FAST_SND","TFA_FAST_SNK","TFA_Mich_Tan","TFA_Mich_Green"];
	};
	case 4: {
		//TFA Woodland
		_uniform = ["TFA_nwu3","TFA_nwu3_rs"];
		_vest = ["TFA_PlateCarrierH_fol","TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_Mix","TFA_PlateCarrierH_MCam"];
		_headgear = ["TFA_ECH_NWU3","TFA_FAST_NWU3","TFA_Mich_Green"];
		_backpack = ["TFA_assault_grn"];
	};
	case 5: {
		//TFA Desert
		_uniform = ["TFA_nwu2","TFA_nwu2_rs"];
		_vest = ["TFA_PlateCarrierH_Grn","TFA_PlateCarrierH_Mix","TFA_PlateCarrierH_NWU2","TFA_PlateCarrierH_MCam","TFA_PlateCarrierH_Tan"];
		_headgear = ["TFA_FAST_NWU2","TFA_Mich_Tan","TFA_ECH_AOR"];
		_backpack = ["TFA_assault_NWU2","TFA_assault_tan","TFA_assault_Mcam"];
	};
	case 6: {
		//TFA ACU
		_uniform = ["TFA_acu","TFA_acu_rs"];
		_vest = ["TFA_PlateCarrierH_ACU"];
		_headgear = ["TFA_H_HelmetIA_A"];
		_backpack = ["TFA_assault_ACU"];
	};
	case 7: {
		//RHS OCP
		_uniform = ["rhs_uniform_cu_ocp"];
		_vest = ["rhsusf_iotv_ocp_Repair"];
		_headgear = ["rhsusf_ach_helmet_ocp","rhsusf_ach_helmet_headset_ocp","rhsusf_ach_helmet_ESS_ocp","rhsusf_ach_helmet_headset_ess_ocp",
			"rhsusf_mich_bare_tan","rhsusf_mich_bare_tan_headset","rhsusf_ach_bare_tan_ess","rhsusf_ach_bare_tan_headset_ess"];
		_items pushBack "rhsusf_patrolcap_ocp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 8: {
		//RHS UCP:
		_uniform = ["rhs_uniform_cu_ucp"];
		_vest = ["rhsusf_iotv_ucp_Repair"];
		_headgear = ["rhsusf_ach_helmet_ucp","rhsusf_ach_helmet_headset_ucp","rhsusf_ach_helmet_ESS_ucp","rhsusf_ach_helmet_headset_ess_ucp",
			"rhsusf_mich_bare_norotos_alt","rhsusf_mich_bare_headset","rhsusf_ach_bare_ess","rhsusf_ach_bare_headset_ess"];
		_items pushBack "rhsusf_patrolcap_ucp";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 10: {
		//RHS MARPAT Desert
		_uniform = ["rhs_uniform_FROG01_d"];
		_vest = ["rhsusf_spc_mg"];
		_headgear = ["rhsusf_lwh_helmet_marpatd","rhsusf_mich_helmet_marpatd","rhsusf_mich_helmet_marpatd_alt","rhsusf_mich_helmet_marpatd_norotos"];
		_backpack = ["B_Carryall_cbr"];
		_items pushBack "rhs_Booniehat_marpatd";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};	
	case 11: {
		//RHS MARPAT Woodland
		_uniform = ["rhs_uniform_FROG01_wd"];
		_vest = ["rhsusf_spc_mg"];
		_headgear = ["rhsusf_lwh_helmet_marpatwd","rhsusf_mich_helmet_marpatwd","rhsusf_mich_helmet_marpatwd_alt","rhsusf_mich_helmet_marpatwd_norotos"];
		_backpack = ["B_Carryall_khk"];
		_items pushBack "rhs_Booniehat_marpatwd";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["rhsusf_ANPVS_15"];
	};
	case 9: {
		//Guerilla
		_uniform = ["U_BG_Guerrilla_6_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1"];
		_headgear = ["H_Shemag_olive","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Cap_headphones","H_MilCap_mcamo","H_MilCap_gry","H_MilCap_blue","H_Cap_tan_specops_US",
			"H_Cap_usblack","H_Cap_oli_hs","H_Cap_blk","H_Booniehat_tan","H_Booniehat_oli","H_Booniehat_khk","H_Watchcap_khk","H_Watchcap_cbr","H_Watchcap_camo"];
		_itemsBackpack = ["ToolKit","IEDUrbanSmall_Remote_Mag","IEDUrbanSmall_Remote_Mag","APERSTripMine_Wire_Mag"];
		_ACE_Clacker = 0;
		_ACE_DeadManSwitch = 0;
		_ACE_DefusalKit = 1;
		_ACE_Cellphone = 0;
	};
	case 12: {
		//UK3CB
		_uniform = ["UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM","UK3CB_BAF_U_CombatUniform_MTP_TShirt","UK3CB_BAF_U_CombatUniform_MTP_TShirt_RM","UK3CB_BAF_U_CombatUniform_MTP_RM","UK3CB_BAF_U_CombatUniform_MTP_ShortSleeve_RM"];
		_vest = ["UK3CB_BAF_V_Osprey_Rifleman_A","UK3CB_BAF_V_Osprey_Rifleman_B","UK3CB_BAF_V_Osprey_Rifleman_C","UK3CB_BAF_V_Osprey_Rifleman_D","UK3CB_BAF_V_Osprey_Rifleman_E","UK3CB_BAF_V_Osprey_Rifleman_F"];
		_headgear = ["UK3CB_BAF_H_Mk7_Camo_A","UK3CB_BAF_H_Mk7_Camo_B","UK3CB_BAF_H_Mk7_Camo_C","UK3CB_BAF_H_Mk7_Camo_D","UK3CB_BAF_H_Mk7_Camo_E","UK3CB_BAF_H_Mk7_Camo_F","UK3CB_BAF_H_Mk7_Net_A","UK3CB_BAF_H_Mk7_Net_B","UK3CB_BAF_H_Mk7_Net_C","UK3CB_BAF_H_Mk7_Net_D"];
		_backpack = ["UK3CB_BAF_B_Bergen_MTP_Sapper_H_A","UK3CB_BAF_B_Bergen_MTP_Sapper_H_B"];
		_items pushBack "UK3CB_BAF_H_Beret_RM_Bootneck";
		_itemsLink = _itemsLink-["NVGoggles_OPFOR"]+["UK3CB_BAF_HMNVS"];
	};
	case 13: {
		//TRYK SpecOps
		_uniform = ["TRYK_U_denim_hood_mc","TRYK_shirts_DENIM_od","TRYK_U_denim_hood_blk","TRYK_U_denim_hood_nc","TRYK_hoodie_FR","TRYK_U_pad_hood_odBK","TRYK_U_pad_hood_Cl",
			"TRYK_shirts_TAN_PAD_YEL","TRYK_U_B_PCUs"];
		_vest append ["TRYK_V_Sheriff_BA_TBL","TRYK_V_Sheriff_BA_TB3","TRYK_V_tacv1_BK","TRYK_V_tacv10LC_OD","TRYK_V_ArmorVest_Brown2",
			"TRYK_V_ArmorVest_Ranger2","TRYK_V_ArmorVest_rgr","TRYK_V_ArmorVest_khk","TRYK_V_ArmorVest_coyo","TRYK_V_IOTV_BLK"];
		_headgear append ["TRYK_R_CAP_OD_US","TRYK_R_CAP_BLK","H_Cap_headphones","H_Cap_oli_hs","H_Cap_blk","TRYK_ESS_CAP_tan",
			"TRYK_H_PASGT_COYO","TRYK_H_PASGT_OD"];
	};
	case 14: {
		//TRYK Snow
		_uniform = ["TRYK_U_B_PCUHsW6","TRYK_U_B_PCUHsW4","TRYK_U_B_PCUHsW","TRYK_U_B_PCUHsW5"];
		_vest = ["TRYK_V_ArmorVest_Winter"];
		_headgear = ["TRYK_H_woolhat_WH","TRYK_H_woolhat_WH",""];
		_backpack = ["TRYK_B_Carryall_wh"];
		_useProfileGoggles = 0;
		_goggles = ["TRYK_kio_balaclava_WH","",""];
	};
	default {};
};

///// No editing necessary below this line /////

_player = _this select 0;
[_player] call ADV_fnc_gear;

true;