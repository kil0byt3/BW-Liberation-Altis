//exeple
// [pos_mission,tank_classname,side_tank,distanse_patryle] execVM "${somepath\file.sqf}";

	// 	pos_mission - aryy ccordinate
	// 	tank_classname - class name of tant need to destroid
	// 	side_tank - side tank(east west or independent)
	// 	distanse_patryle - radiys patyl tank(m)

// done example
// [[200,200,0],"rhsgref_ins_g_t72ba",EAST,1500] execVM "BW\other_missions\mission_1\mission_1.sqf";

//param
params ["_pos_mission", "_tank_classname", "_side_tank","_distanse_patryle"];
//tank
private _Tank_1 = [_pos_mission, 180, _tank_classname, _side_tank] call BIS_fnc_spawnVehicle;
//mission
["Task_01", true, ["Destroy enemy tank","Destroy enemy tank","respawn_west"], getPos(_Tank_1 select 0), "ASSIGNED", 5, true, true, "target", true] call BIS_fnc_setTask;
//patrol
[(_Tank_1 select 2), getPos (_Tank_1 select 0), _distanse_patryle] call bis_fnc_taskPatrol;
//marker
private _marker1 = createMarker ["Marker1", getPos (_Tank_1 select 0)];
"Marker1" setMarkerShape "ELLIPSE";
"Marker1" setMarkerSize [_distanse_patryle, _distanse_patryle];
"Marker1" setMarkerColor "ColorBlack";
"Marker1" setMarkerBrush "Cross";
//wait until tank destroyed
waitUntil{
	sleep 10;
	!alive (_Tank_1 select 0)
};

["Task_01","SUCCEEDED"] call BIS_fnc_taskSetState;

private _rewards = createHashMap;
_rewards set ["intel", 10];
["BW_liberation_missionEnd", ["BW_other_missions_destroyTank", "SUCCEEDED", _rewards]] call CBA_fnc_serverEvent;

deleteMarker _marker1;
sleep 10;
["Task_01"] call BIS_fnc_deleteTask;
