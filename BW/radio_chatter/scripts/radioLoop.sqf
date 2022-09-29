if (!isNil "BW_radio_chatter_sounds" && {count BW_radio_chatter_sounds > 0}) then {
    [{
        private _radio = missionNamespace getVariable ["BW_radio_chatter_object", objNull];
        if (_radio isNotEqualTo objNull) then {
            [{(player distance2D _this) < 10}, {
                [_this] call BW_fnc_radio_chatter_play;
            }, _radio] call CBA_fnc_waitUntilAndExecute;
        };
    }, 40, []] call CBA_fnc_addPerFrameHandler;
};
