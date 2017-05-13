﻿/*
 * Author: Belbo
 *
 * Contains all the variables important for tfar.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * tfar present and set? - <BOOL>
 *
 * Example:
 * [] call adv_fnc_tfarSettings;
 *
 * Public: No
 */

if (isClass(configFile >> "CfgPatches" >> "tfar_core")) exitWith {
	
	["TFAR_giveLongRangeRadioToGroupLeaders", false, true, "server"] call CBA_settings_fnc_set;
	["TFAR_givePersonalRadioToRegularSoldier", false, true, "server"] call CBA_settings_fnc_set;
	["TFAR_giveMicroDagrToSoldier", false, true, "server"] call CBA_settings_fnc_set;
	["TFAR_SameSRFrequenciesForSide", true, true, "server"] call CBA_settings_fnc_set;
	["TFAR_SameLRFrequenciesForSide", true, true, "server"] call CBA_settings_fnc_set;
	["TFAR_fullDuplex", false, true, "server"] call CBA_settings_fnc_set;
	["TFAR_enableIntercom", true, true, "server"] call CBA_settings_fnc_set;
	["TFAR_objectInterceptionEnabled", false, true, "server"] call CBA_settings_fnc_set;
	["TFAR_PosUpdateMode", 0, true, "server"] call CBA_settings_fnc_set;
	//general
	tfar_terrain_interception_coefficient = 3.0;
	tfar_speakerDistance = 10;

	//radios
	TFAR_DefaultRadio_Personal_West = "tfar_anprc152";
	TFAR_DefaultRadio_Personal_East = "tfar_fadak";
	TFAR_DefaultRadio_Personal_Independent = "tfar_anprc148jem";
	
	TFAR_DefaultRadio_Rifleman_West = "tfar_anprc154";
	TFAR_DefaultRadio_Rifleman_East = "tfar_pnr1000a";
	TFAR_DefaultRadio_Rifleman_Independent = "tfar_anprc154";
	//tfar serious mode
	call {
		if ( ("param_seriousMode" call BIS_fnc_getParamValue) isEqualTo 0 ) exitWith {
			tf_radio_channel_name = "NONE";
			tf_radio_channel_password = "NONE";
		};
		if !( ["SPEZIALEINHEIT LUCHS", serverName] call BIS_fnc_inString ) exitWith {
			tf_radio_channel_name = "TaskForceRadio";
			tf_radio_channel_password = "123";			
		};
		tf_radio_channel_name = "Arma3-TFAR";
		tf_radio_channel_password = "123";
	};

	//frequencies
	//blufor
	_defaultFrequencies_sr_west = ["41.0","42.0","43.0","44.0","45.0","46.0","47.0","48.0"];
	_defaultFrequencies_lr_west = ["51.0","52.0","53.0","54.0","55.0","56.0","57.0","58.0","59.0"];
	
	_defaultFrequencies_sr_east = ["41.0","42.0","43.0","44.0","45.0","46.0","47.0","48.0"];
	_defaultFrequencies_lr_east = ["51.0","52.0","53.0","54.0","55.0","56.0","57.0","58.0","59.0"];
	
	_defaultFrequencies_sr_independent = ["61.0","62.0","63.0","64.0","65.0","66.0","67.0","68.0"];
	_defaultFrequencies_lr_independent = ["71.0","72.0","73.0","74.0","75.0","76.0","77.0","78.0","79.0"];
	
	_settingsSRWest = false call TFAR_fnc_generateSRSettings;
	_settingsLrWest = false call TFAR_fnc_generateLrSettings;
	
	_settingsSREast = false call TFAR_fnc_generateSRSettings;
	_settingsLrEast = false call TFAR_fnc_generateLrSettings;
	
	_settingsSRGuer = false call TFAR_fnc_generateSwSettings;
	_settingsLrGuer = false call TFAR_fnc_generateLrSettings;
	
	private _west_code = "_bluefor";
	private _east_code = "_opfor";
	
	_settingsSRWest set [2, _defaultFrequencies_sr_west];
	_settingsSRWest set [4, _west_code];
	TFAR_freq_sr_west = _settingsSRWest;
	
	_settingsLrWest set [2, _defaultFrequencies_lr_west];
	_settingsLrWest set [4, _west_code];
	TFAR_freq_lr_west = _settingsLrWest;
	
	_settingsSREast set [2, _defaultFrequencies_sr_east];
	_settingsSREast set [4, _east_code];
	TFAR_freq_sr_east = _settingsSREast;
	
	_settingsLrEast set [2, _defaultFrequencies_lr_east];
	_settingsLrEast set [4, _east_code];
	TFAR_freq_lr_east = _settingsLrEast;
	
	_settingsSRGuer set [2, _defaultFrequencies_sr_independent];
	_settingsLrGuer set [2, _defaultFrequencies_lr_independent];
	TFAR_freq_sr_independent = _settingsSRGuer;
	TFAR_freq_lr_independent = _settingsLrGuer;
	
	private _ind_code = call {
		if ([independent,west] call BIS_fnc_sideIsFriendly) exitWith {_west_code};
		if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {_east_code};
		"_independent"
	};
	TFAR_freq_sr_independent set [4, _ind_code];
	TFAR_freq_lr_independent set [4, _ind_code];
	
	missionNamespace setVariable ["tf_west_radio_code",_west_code];
	missionNamespace setVariable ["tf_east_radio_code",_east_code];
	missionNamespace setVariable ["tf_independent_radio_code",_ind_code];

	true;
};
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {
	//für zusätzliche variablen/functions: https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Variables
	call compile preprocessFileLineNumbers "\task_force_radio\functions\common.sqf";
	
	//tfar 0.9.12
	["TF_no_auto_long_range_radio", true, true, "server"] call CBA_settings_fnc_set;
	["TF_give_personal_radio_to_regular_soldier", false, true, "server"] call CBA_settings_fnc_set;
	["TF_give_microdagr_to_soldier", false, true, "server"] call CBA_settings_fnc_set;
	["TF_same_sw_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
	["TF_same_lr_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
	["TF_same_dd_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
	//general
	tf_terrain_interception_coefficient = 3.0;
	tf_speakerDistance = 10;

	//radios
	TF_defaultWestPersonalRadio = "tf_anprc152";
	TF_defaultEastPersonalRadio = "tf_fadak";
	TF_defaultGuerPersonalRadio = "tf_anprc148jem";
	
	TF_defaultWestRiflemanRadio = "tf_anprc154";
	TF_defaultEastRiflemanRadio = "tf_pnr1000a";
	TF_defaultGuerRiflemanRadio = "tf_anprc154";
	//tfar serious mode
	[] spawn {
		waitUntil {!isNil "adv_par_seriousMode" && !isNil "adv_par_customUni" };
		if (adv_par_customUni isEqualTo 9) then { TF_defaultWestPersonalRadio = "tf_anprc148jem"; };
		if ( (adv_par_customWeap isEqualTo 1 || adv_par_customUni isEqualTo 2) && isClass(configFile >> "CfgPatches" >> "tfw_sem52sl") ) then { TF_defaultWestPersonalRadio = "tf_sem52sl"; };
		if ( ADV_par_seriousMode > 0 ) then {
			tf_radio_channel_name = "Arma3-TFAR";
			tf_radio_channel_password = "123";
		};
	};

	//frequencies
	//blufor
	_settingsSwWest = false call TFAR_fnc_generateSwSettings;
	_settingsSwEast = false call TFAR_fnc_generateSwSettings;
	_settingsSwGuer = false call TFAR_fnc_generateSwSettings;
	
	_settingsLrWest = false call TFAR_fnc_generateLrSettings;
	_settingsLrEast = false call TFAR_fnc_generateLrSettings;
	_settingsLrGuer = false call TFAR_fnc_generateLrSettings;
	
	_settingsSwWest set [2, ["41","42","43","44","45","46","47","48"]];
	_settingsLrWest set [2, ["51","52","53","54","55","56","57","58","59"]];
	_settingsSwWest set [4, "_bluefor"];
	_settingsLrWest set [4, "_bluefor"];
	tf_freq_west = _settingsSwWest;
	tf_freq_west_lr = _settingsLrWest;

	_settingsSwEast set [2, ["41","42","43","44","45","46","47","48"]];
	_settingsLrEast set [2, ["51","52","53","54","55","56","57","58","59"]];

	_settingsSwGuer set [2, ["61","62","63","64","65","66","67","68"]];
	_settingsLrGuer set [2, ["71","72","73","74","75","76","77","78","79"]];
	
	_settingsSwEast set [4, "_opfor"];
	_settingsLrEast set [4, "_opfor"];
	tf_freq_east = _settingsSwEast;
	tf_freq_east_lr = _settingsLrEast;

	call {
		if ([independent,west] call BIS_fnc_sideIsFriendly) exitWith {
			_settingsSWGuer set [4, "_bluefor"];
			_settingsLrGuer set [4, "_bluefor"];
		};
		if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {
			_settingsSWGuer set [4, "_opfor"];
			_settingsLrGuer set [4, "_opfor"];
		};
		_settingsSWGuer set [4, "_indfor"];
		_settingsLrGuer set [4, "_indfor"];
	};

	tf_freq_guer = _settingsSwGuer;
	tf_freq_guer_lr = _settingsLrGuer;
	
	true;
};

false;