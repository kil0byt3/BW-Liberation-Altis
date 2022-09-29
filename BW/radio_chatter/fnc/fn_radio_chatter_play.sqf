params [
    ["_radioObj", objNull, [objNull]]
];

if (isNil "BW_radio_chatter_sounds") exitWith {false};

private _randomSound = selectRandom BW_radio_chatter_sounds;
playSound3D [_randomSound, _radioObj];

true