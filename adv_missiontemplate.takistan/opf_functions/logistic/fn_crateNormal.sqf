﻿/*
 * Author: Belbo
 *
 * Fills a crate with regular ammunition for OPFOR
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [this] call adv_opf_fnc_crateNormal;
 *
 * Public: Yes
 */

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

{
	private _target = _x;
	//makes the crates indestructible:
	_target allowDamage false;
	
	//weapons & ammo
	switch (true) do {
		//BWmod
		case (_par_opfWeap == 1 || _par_opfWeap == 2): {
			//ammo
			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_AK",30];
			_target addMagazineCargoGlobal ["rhs_30Rnd_545x39_7N10_AK",10];
			call {
				if (isClass(configFile >> "CfgPatches" >> "CUP_weapons_AK")) exitWith {
					call {
						if (_par_opfWeap == 1) then {
							_target addMagazineCargoGlobal ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",5];
						};
						_target addMagazineCargoGlobal ["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",8];
					};
				};
				_target addMagazineCargoGlobal ["rhs_100Rnd_762x54mmR_green",5];
			};
			//if (ADV_par_opfSilencers > 0) then { _target addMagazineCargoGlobal ["rhs_20rnd_9x39mm_SP5",10]; } else { _target addMagazineCargoGlobal ["rhs_10Rnd_762x54mmR_7N1",10]; };
			_target addMagazineCargoGlobal ["rhs_mag_9x19_17",5];
		};
		//SeL RHS
		case (_par_opfWeap == 3): {
			//ammo
			_target addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M",30];
			_target addMagazineCargoGlobal ["CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",10];
			_target addMagazineCargoGlobal ["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",5];
			//_target addMagazineCargoGlobal ["CUP_10Rnd_762x54_SVD_M",10];
			_target addMagazineCargoGlobal ["CUP_8Rnd_9x18_Makarov_M",5];
		};
		case (_par_opfWeap == 4): {};
		default {
			switch (true) do {
				case (_par_opfWeap == 21): {
					_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_F",30];
					_target addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_F",10];
					_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",8];
				};
				case (worldName == "TANOA" || _par_opfWeap == 20): {
					_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_F",30];
					_target addMagazineCargoGlobal ["30Rnd_580x42_Mag_Tracer_F",10];
					_target addMagazineCargoGlobal ["100Rnd_580x42_Mag_F",8];
				};
				default {
					_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",30];
					_target addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer",10];
					_target addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer",5];
				};
			};
			/*
			_target addMagazineCargoGlobal ["10Rnd_762x51_Mag",10];
			_target addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag",10];
			*/
			_target addMagazineCargoGlobal ["16Rnd_9x21_Mag",5];
		};
	};
	//grenades
	switch (true) do {
		case ( _par_opfWeap == 1 && _par_opfWeap == 2): {
			_target addMagazineCargoGlobal ["rhs_mag_rgd5",4];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_white",4];
			_target addMagazineCargoGlobal ["rhs_mag_rdg2_black",4];
			_target addMagazineCargoGlobal ["rhs_VOG25",10];
			_target addMagazineCargoGlobal ["rhs_VG40OP_white",4];
		};
		case ( _par_opfWeap == 3): {
			_target addMagazineCargoGlobal ["CUP_HandGrenade_RGD5",4];
			_target addMagazineCargoGlobal ["SmokeShell",4];
			_target addMagazineCargoGlobal ["SmokeShellGreen",4];
			_target addMagazineCargoGlobal ["CUP_1Rnd_HE_GP25_M",10];
			_target addMagazineCargoGlobal ["CUP_FlareYellow_GP25_M",4];
		};
		default {
			_target addMagazineCargoGlobal ["HandGrenade",4];
			_target addMagazineCargoGlobal ["SmokeShell",4];
			_target addMagazineCargoGlobal ["SmokeShellGreen",4];
			_target addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_target addMagazineCargoGlobal ["UGL_FlareYellow_F",4];
		};
	};
	if ( _par_opfNVGs == 2 && !(isClass (configFile >> "CfgPatches" >> "ACE_attach")) ) then {
		_target addMagazineCargoGlobal ["O_IR_Grenade",1];
	};

	_ACE_fieldDressing = 0;
	_ACE_packingBandage = 0;
	_ACE_elasticBandage = 0;
	_ACE_quikclot = 0;
	_ACE_atropine = 0;
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
	_ACE_personalAidKit = 0;
	_ACE_surgicalKit = 0;
	_ACE_bodyBag = 0;
	
	_FAKs = 0;
	_mediKit = 0;
	
	if !(isClass (configFile >> "CfgPatches" >> "ACE_Medical")) then {
		_target addItemCargoGlobal ["FirstAidKit",_FAKs];
		_target addItemCargoGlobal ["MediKit",_mediKit];
	};
	//medical stuff
	if (isClass (configFile >> "CfgPatches" >> "ACE_common")) then {
		_ACE_EarPlugs = 2;

		_ACE_SpareBarrel = 0;
		_ACE_tacticalLadder = 0;
		_ACE_UAVBattery = 0;
		_ACE_wirecutter = 0;
		_ACE_sandbag = 0;
		_ACE_Clacker = 0;
		_ACE_M26_Clacker = 0;
		_ACE_DeadManSwitch = 0;
		_ACE_DefusalKit = 0;
		_ACE_Cellphone = 0;
		_ACE_MapTools = 0;
		_ACE_CableTie = 0;
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
		_ACE_IR_Strobe = 1;
		_ACE_M84 = 0;
		_ACE_HandFlare_Green = 0;
		_ACE_HandFlare_Red = 2;
		_ACE_HandFlare_White = 0;
		_ACE_HandFlare_Yellow = 0;
		[_target] call ADV_fnc_addACEItems;
	};
	nil;
} count _this;

true;