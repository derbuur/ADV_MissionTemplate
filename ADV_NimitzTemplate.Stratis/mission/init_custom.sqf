﻿/*
this init is supposed to be mission specific.
It's being executed right after the mission is being loaded.
Every call, spawn or execVM that's mission specific should be placed in here.
*/
//////////////////////////////////////////////////////////////////////////////////
//calls before mission start (during the loading- and briefing-screen):
//////////////////////////////////////////////////////////////////////////////////
// place your custom content here:
//Laxeman variables
L_suppress_active = false;



	//everything that's only supposed to run on the server:
	if (isServer) then {
	// place your custom content here:
		/*
		_markerPos1 = getPosASL respawn_helper;
		"respawn_west" setMarkerPos [_markerPos1 select 0, _markerPos1 select 1, _markerPos1 select 2];
		"respawn_west" setMarkerDir (getDir respawn_helper);
		*/

	
	};





//////////////////////////////////////////////////////////////////////////////////
//calls after mission start (after the briefing-screen):
		waitUntil {time > 1};
//////////////////////////////////////////////////////////////////////////////////
// place your custom content here:




	//everything that's only supposed to run on the server:
	if (isServer) then {
	// place your custom content here:
	
	
	
	
	};




//////////////////////////////////////////////////////////////////////////////////
//end of the init-script:
if (true) exitWith {};
//////////////////////////////////////////////////////////////////////////////////