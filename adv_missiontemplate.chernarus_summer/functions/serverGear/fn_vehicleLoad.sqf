﻿/*
 * Author: Belbo
 *
 * Adds items to vehicle for BLUFOR.
 *
 * Arguments:
 * 0: vehicle - <OBJECT>
 * 1: should the vehicle be a medical vehicle? (optional) - <BOOL>
 * 2: should the vehicle carry weapons and ammunition (optional) - <BOOL>
 * 3: amount of ace-spare parts for the vehicle (optional) - <NUMBER>
 * 5: should the vehicle be a repair vehicle? (optional) - <BOOL>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [MRAP_1, false, true, 2, false] call adv_fnc_vehicleLoad;
 *
 * Public: Yes
 */

params [
	["_target", objNull, [objNull]], 
	["_isMedic", false, [true]], 
	["_withWeapons", false, [true]], 
	["_amountOfSpareParts", 1, [0]],
	["_isRepairVehicle", false, [0,true]]
];

if (_target isEqualTo objNull) exitWith {};

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

_backpacks = [];

//weapons and ammo
if (_withWeapons) then {
	switch (true) do {
		case (_par_customWeap == 1): {
			call {
				if !(isClass(configFile >> "CfgPatches" >> "hlcweapons_g36")) exitWith {
					_target addWeaponCargoGlobal ["BWA3_G36",1];
				};
				_target addWeaponCargoGlobal ["hlc_rifle_G36A1",1];
			};
			_target addWeaponCargoGlobal ["BWA3_Pzf3_Loaded",2];
			
			if (isClass(configFile >> "CfgPatches" >> "hlcweapons_g36") && !(isClass(configFile >> "CfgPatches" >> "adv_hlcG36_bwmod"))) then {
				_target addMagazineCargoGlobal ["hlc_30rnd_556x45_EPR_G36",30];
			} else {
				_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36",20];
				_target addMagazineCargoGlobal ["BWA3_30Rnd_556x45_G36_Tracer",10];
			};
			_target addMagazineCargoGlobal ["BWA3_200Rnd_556x45_Tracer",2];
			_target addMagazineCargoGlobal ["BWA3_10Rnd_762x51_G28_LR",4];
			if (isClass(configFile >> "CfgPatches" >> "hlcweapons_MG3s")) then {
				_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_MG3",2];
			} else {
				_target addMagazineCargoGlobal ["BWA3_120Rnd_762x51_Tracer",2];
			};
			
			_target addMagazineCargoGlobal ["BWA3_DM51A1",5];
			_target addMagazineCargoGlobal ["BWA3_DM25",10];
			_target addMagazineCargoGlobal ["BWA3_DM32_Orange",5];
			_target addMagazineCargoGlobal ["BWA3_DM32_Yellow",5];
		};
		case (_par_customWeap == 2 || _par_customWeap == 3 || _par_customWeap == 4): {
			_target addWeaponCargoGlobal ["rhs_weap_m4_carryhandle",1];
			_target addWeaponCargoGlobal ["rhs_weap_M136",2];
			
			if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",2]; };
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag",20];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_red",10];
			_target addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_soft_pouch",2];
			_target addMagazineCargoGlobal ["rhsusf_100Rnd_762x51",2];
			_target addMagazineCargoGlobal ["rhsusf_20Rnd_762x51_m118_special_Mag",4];
			
			_target addMagazineCargoGlobal ["rhs_mag_m67",5];
			_target addMagazineCargoGlobal ["rhs_mag_an_m8hc",10];
			_target addMagazineCargoGlobal ["rhs_mag_m18_red",5];
			_target addMagazineCargoGlobal ["rhs_mag_m18_green",5];
		};
		case (_par_customWeap >= 5 && _par_customWeap <= 7): {
			if (_par_customWeap == 7) then {
				_target addWeaponCargoGlobal ["CUP_arifle_L85A2",1];
			} else {
				_target addWeaponCargoGlobal ["CUP_arifle_M4A1",1];
			};
			_target addWeaponCargoGlobal ["CUP_launch_M136",2];
			
			if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  _target addMagazineCargoGlobal ["CUP_M136_M",2]; };
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag",20];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_red",10];
			_target addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",2];
			_target addMagazineCargoGlobal ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",2];
			if (_par_customWeap == 5) then {
				_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_M110",4];
				_target addMagazineCargoGlobal ["CUP_20Rnd_762x51_B_SCAR",4];
			} else {
				_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",4];
			};
			
			_target addMagazineCargoGlobal ["HandGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
		case (_par_customWeap == 8): {
			_target addWeaponCargoGlobal ["UK3CB_BAF_L85A2",1];
			_target addWeaponCargoGlobal ["UK3CB_BAF_AT4_AP_Launcher",2];

			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag",20];
			_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_red",10];
			_target addMagazineCargoGlobal ["UK3CB_BAF_200Rnd_T",2];
			_target addMagazineCargoGlobal ["UK3CB_BAF_75Rnd_T",2];
			_target addMagazineCargoGlobal ["UK3CB_BAF_20Rnd",4];
			
			_target addMagazineCargoGlobal ["HandGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
		case (_par_customWeap == 9): {
			_target addWeaponCargoGlobal ["hlc_smg_mp5a2",1];
			if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
				_target addWeaponCargoGlobal ["rhs_weap_M136",2];
				if !(isClass(configFile >> "CfgPatches" >> "ace_disposable")) then { _target addMagazineCargoGlobal ["rhs_m136_mag",2]; };
			} else {
				if (isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {  
					_target addWeaponCargoGlobal ["launch_NLAW_F",2];
				} else {
					_target addWeaponCargoGlobal ["launch_NLAW_F",1];
					_target addMagazineCargoGlobal ["NLAW_F",2];
				};
			};

			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_b_G3",15];
			_target addMagazineCargoGlobal ["hlc_20Rnd_762x51_B_fal",15];
			_target addMagazineCargoGlobal ["hlc_20rnd_762x51_T_G3",5];
			_target addMagazineCargoGlobal ["hlc_20Rnd_762x51_T_fal",5];
			_target addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4",2];
			_target addMagazineCargoGlobal ["hlc_50rnd_762x51_M_FAL",2];
			
			_target addMagazineCargoGlobal ["HandGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
		default {
			call {
				if (isClass(configFile >> "CfgPatches" >> "ace_disposable")) exitWith {
					_target addWeaponCargoGlobal ["launch_NLAW_F",2];
				};
				_target addWeaponCargoGlobal ["launch_NLAW_F",1];
				_target addMagazineCargoGlobal ["NLAW_F",2];
			};
			call {
				if (_par_customWeap == 20) exitWith {
					_target addWeaponCargoGlobal ["arifle_SPAR_01_blk_F",1];
					_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_red",20];
					_target addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red",10];
					_target addMagazineCargoGlobal ["200Rnd_556x45_Box_Red_F",2];
				};
				_target addWeaponCargoGlobal ["arifle_MXC_Black_F",1];
				_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",20];
				_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer",10];
				call {
					if (isClass(configFile >> "CfgPatches" >> "adv_configsVanilla")) exitWith {
						_target addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer_red",2];
					};
					_target addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer",4];
				};
			};
			_target addMagazineCargoGlobal ["130Rnd_338_Mag",2];
			_target addMagazineCargoGlobal ["20Rnd_762x51_Mag",4];
			//_target addMagazineCargoGlobal ["150Rnd_762x54_Box",1];
			//_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",1];
			
			_target addMagazineCargoGlobal ["MiniGrenade",5];
			_target addMagazineCargoGlobal ["SmokeShell",10];
			_target addMagazineCargoGlobal ["SmokeShellRed",5];
			_target addMagazineCargoGlobal ["SmokeShellBlue",5];
		};
	};
	_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
	_target addMagazineCargoGlobal ["1Rnd_SmokeRed_Grenade_shell",10];
	
	/*
	if ( isClass (configFile >> "CfgPatches" >> "ACE_cargo") && _par_logisticAmount > 2 ) then {
		if ( ([_target] call ace_cargo_fnc_getCargoSpaceLeft) > 2) then {
			_crate = ["ADV_LOGISTIC_CRATENORMAL",true,west,getPosASL _target] call adv_fnc_dialogLogistic;
			[_crate,_target] call ace_cargo_fnc_loadItem;
		};
	};
	*/
};

//helmets and vests
switch (true) do {
	case (_par_customUni == 1 || _par_customUni == 2): {
		_target addItemCargoGlobal ["BWA3_M92_Fleck",1];
		_target addItemCargoGlobal ["BWA3_Vest_Fleck",1];
		_target addBackpackCargoGlobal ["BWA3_AssaultPack_Fleck",1];
	};
	case (_par_customUni == 6): {
		_target addItemCargoGlobal ["CUP_H_BAF_Helmet_3_DPM",1];
		_target addItemCargoGlobal ["CUP_V_BAF_Osprey_Mk2_DPM_Empty",1];
		_target addBackpackCargoGlobal ["CUP_B_Bergen_BAF",1];
	};
	case (_par_customUni == 7 || _par_customUni == 8 || _par_customUni == 10): {
		_target addItemCargoGlobal ["rhsusf_ach_bare",1];
		_target addItemCargoGlobal ["rhsusf_spc",1];
		_target addBackpackCargoGlobal ["rhsusf_falconii",1];
	};
	case (_par_customUni == 12): {
		_target addItemCargoGlobal ["UK3CB_BAF_H_Mk7_Camo_A",1];
		_target addItemCargoGlobal ["UK3CB_BAF_V_Osprey",1];
		_target addBackpackCargoGlobal ["UK3CB_BAF_B_Bergen_MTP_Rifleman_L_A",1];	
	};
	default {
		_target addItemCargoGlobal ["H_HelmetB",1];
		_target addItemCargoGlobal ["V_TacVest_blk",1];
		_target addBackpackCargoGlobal ["B_AssaultPack_rgr",1];
	};
};
		
_target addMagazineCargoGlobal ["Chemlight_red",5];
_target addItemCargoGlobal ["ToolKit",1];
if (_isRepairVehicle) then { (firstBackpack _target) addItemCargoGlobal ["Toolkit",1] ; };

//radios
if (_par_Radios == 1 || _par_Radios == 3) then {
	_target addItemCargoGlobal ["ItemRadio",2];
	if ( isClass (configFile >> "CfgPatches" >> "acre_main") ) then {
		_target addItemCargoGlobal [acre_westBackpackRadio,1];
	};
};

_ACE_fieldDressing = 30;
_ACE_packingBandage = 0;
_ACE_elasticBandage = 0;
_ACE_quikclot = 0;
if (missionnamespace getVariable ["ace_medical_enableAdvancedWounds",false]) then {
	_ACE_fieldDressing = 10;
	_ACE_packingBandage = 10;
	_ACE_elasticBandage = 10;
	_ACE_quikclot = 10;
};
_ACE_atropine = 0;
_ACE_epinephrine = 4;
_ACE_morphine = 4;
_ACE_tourniquet = 3;
_ACE_bloodIV = 0;
_ACE_bloodIV_500 = 0;
_ACE_bloodIV_250 = 0;
_ACE_plasmaIV = 0;
_ACE_plasmaIV_500 = 0;
_ACE_plasmaIV_250 = 0;
_ACE_salineIV = 0;
_ACE_salineIV_500 = 5;
_ACE_salineIV_250 = 0;
_ACE_bodyBag = 2;
_ACE_personalAidKit = 0;
if ( (missionnamespace getVariable ["ace_medical_consumeItem_PAK",0]) > 0 ) then {
	_ACE_personalAidKit = 1;
};
_ACE_surgicalKit = 1;
if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) > 0 ) then {
	_ACE_surgicalKit = 10;
};

_FAKs = 5;
_mediKit = 0;
	
//medical items:
if (_isMedic) then {
	_ACE_fieldDressing = 30;
	_ACE_packingBandage = 30;
	_ACE_elasticBandage = 30;
	_ACE_quikclot = 30;
	_ACE_morphine = 20;
	_ACE_epinephrine = 20;
	_ACE_atropine = 10;
	_ACE_tourniquet = 20;
	_ACE_bloodIV = 5;
	_ACE_bloodIV_500 = 10;
	_ACE_bloodIV_250 = 15;
	_ACE_plasmaIV = 5;
	_ACE_plasmaIV_500 = 10;
	_ACE_plasmaIV_250 = 15;
	_ACE_salineIV = 10;
	_ACE_salineIV_500 = 15;
	_ACE_salineIV_250 = 20;
	_ACE_bodyBag = 10;
	_ACE_personalAidKit = 1;
	if (isClass(configFile >> "CfgPatches" >> "adv_aceCPR")) then {
		_ACE_personalAidKit = 0;
	};
	if (missionNamespace getVariable ["ACE_medical_consumeItem_PAK",0] > 0) then {
		_ACE_personalAidKit = 5;
	};
	_ACE_surgicalKit = 1;
	if ( (missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0]) > 0 ) then {
		_ACE_surgicalKit = 10;
	};
	_FAKs = 30;
	_mediKit = 2;
	
	_target setVariable ["ACE_medical_medicClass", 2, true];
	
	if ( isClass (configFile >> "CfgPatches" >> "ACE_cargo") && _par_logisticAmount > 2 ) then {
		if ( ([_target] call ace_cargo_fnc_getCargoSpaceLeft) > 2) then {
			_crate = ["ADV_LOGISTIC_CRATEMEDIC",true,west,getPosASL _target] call adv_fnc_dialogLogistic;
			[_crate,_target] call ace_cargo_fnc_loadItem;
		};
	};
	
};

if !(isClass (configFile >> "CfgPatches" >> "ACE_medical")) then {
	_target addItemCargoGlobal ["FirstAidKit",_FAKs];
	_target addItemCargoGlobal ["MediKit",_mediKit];
};

//ACE items (if ACE is running on the server) - (integers)
if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
	_ACE_EarPlugs = 5;

	_ACE_SpareBarrel = 0;
	_ACE_tacticalLadder = 0;
	_ACE_UAVBattery = 0;
	_ACE_wirecutter = 1;
	_ACE_sandbag = 20;
	_ACE_Clacker = 0;
	_ACE_M26_Clacker = 0;
	_ACE_DeadManSwitch = 0;
	_ACE_DefusalKit = 0;
	_ACE_Cellphone = 0;
	_ACE_MapTools = 1;
	_ACE_CableTie = 5;
	_ACE_NonSteerableParachute = 0;

	_ACE_key_west = 0;
	_ACE_key_east = 0;
	_ACE_key_indp = 0;
	_ACE_key_civ = 0;
	_ACE_key_master = 0;
	_ACE_key_lockpick = 0;
	_ACE_kestrel = 0;
	_ACE_ATragMX = 0;
	_ACE_rangecard = 0;
	_ACE_altimeter = 0;
	_ACE_microDAGR = 0;
	_ACE_DAGR = 0;
	_ACE_RangeTable_82mm = 0;
	_ACE_rangefinder = 0;
	_ACE_NonSteerableParachute = 0;
	_ACE_IR_Strobe = 2;
	_ACE_M84 = 0;
	_ACE_HandFlare_Green = 0;
	_ACE_HandFlare_Red = 4;
	_ACE_HandFlare_White = 0;
	_ACE_HandFlare_Yellow = 0;
	[_target] call ADV_fnc_addACEItems;
	if ( isClass (configFile >> "CfgPatches" >> "ACE_repair") && isClass (configFile >> "CfgPatches" >> "ACE_cargo") ) then {
		if (_isRepairVehicle) then {
			_target setVariable ["ACE_isRepairVehicle", 1, true];
			call {
				if (_target isKindOf "TANK") then {
					["ACE_Track", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
					["ACE_Wheel", _target, _amountOfSpareParts] call ace_cargo_fnc_addCargoItem;
				};
				["ACE_Track", _target, _amountOfSpareParts] call ace_cargo_fnc_addCargoItem;
				["ACE_Wheel", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
			};
			//[_target,_amountOfSpareParts-1,"ACE_Track",true] call ACE_repair_fnc_addSpareParts;
			//[_target,_amountOfSpareParts-1,"ACE_Wheel",true] call ACE_repair_fnc_addSpareParts;
		} else {
			call {
				if (_target isKindOf "CAR") exitWith {
					["ACE_Wheel", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
				};
				if (_target isKindOf "TANK") exitWith {
					["ACE_Track", _target, _amountOfSpareParts-1] call ace_cargo_fnc_addCargoItem;
				};
			};
		};
	};
	if ( (_target isKindOf "Helicopter") && isClass (configFile >> "CfgPatches" >> "ACE_fastroping") ) then {
		[_target] call ace_fastroping_fnc_equipFRIES;
	};
};

//backpacks & parachutes
if (_target isKindOf "Air") then {
	_parachutes = ["B_Parachute"];
	_freeSpaces = _target emptyPositions "cargo";
	/*
	_freeSpaces = _freeSpaces + (_target emptyPositions "Gunner");
	_freeSpaces = _freeSpaces + (_target emptyPositions "Driver");
	_freeSpaces = _freeSpaces + (_target emptyPositions "Commander");
	*/
	if (_freeSpaces > 8) then {_freespaces = 8};
	if (_target isKindOf "Helicopter") then { _freespaces = 2 };
	{_target addBackpackCargoGlobal [_x, _freeSpaces];} count _parachutes;
};
{_target addBackpackCargoGlobal [_x, 1];} count _backpacks;

true;