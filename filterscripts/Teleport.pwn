/*
    Teleport filterscript for SA-MP
    Copyright (C) 2019  PedroCesarMesquita

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <a_samp>

public OnFilterScriptInit() printf("Teleport filterscript init.");
public OnFilterScriptExit() printf("Teleport filterscript exit.");

#define DIALOG_KEY 1100

enum {
    DIALOG_MAIN,
    DIALOG_PLAYER_ID,
    DIALOG_PLAYER_NAME
}

new dialogs[][][] = {
    { {DIALOG_STYLE_LIST }, "Teleport", "Teleport to player (id)\nTeleport to player (name)" },
    { {DIALOG_STYLE_INPUT}, "Teleport to player (id)", "Enter the target player id" },
    { {DIALOG_STYLE_INPUT}, "Teleport to player (name)", "Enter the target player name" }
};

stock showDialog(playerid, dialogid) return ShowPlayerDialog(playerid, dialogid + DIALOG_KEY, dialogs[dialogid][0][0], dialogs[dialogid][1], dialogs[dialogid][2], "Confirm", "Cancel");

stock teleportToPos(playerid, Float:x, Float:y, Float:z) {
    new vehicleid = GetPlayerVehicleID(playerid), seatid = GetPlayerVehicleSeat(playerid);
    SetPlayerPos(playerid, x, y, z);
    if(vehicleid && !seatid) {
        SetVehiclePos(vehicleid, x, y, z);
        PutPlayerInVehicle(playerid, vehicleid, 0);
    }
    new msg[100];
    format(msg, sizeof(msg), "You have been teleported to (%.2f, %.2f, %.2f)", x, y, z)
    SendClientMessage(playerid, 0x00FF00FF, msg);
}

stock teleportToPlayer(playerid, targetid) {
    if(playerid == targetid || !IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;
    new vehicleid = GetPlayerVehicleID(playerid), seatid = GetPlayerVehicleSeat(playerid), Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    SetPlayerPos(playerid, x, y, z);
    if(vehicleid && !seatid) {
        SetVehiclePos(vehicleid, x, y, z);
        PutPlayerInVehicle(playerid, vehicleid, 0);
    }
    new msg[100], name[MAX_PLAYER_NAME + 1];

    GetPlayerName(targetid, name, sizeof(name));
    format(msg, sizeof(msg), "You have been teleported to %s", name);
    SendClientMessage(playerid, 0x00FF00FF, msg);

    GetPlayerName(playerid, name, sizeof(name));
    format(msg, sizeof(msg), "%s has been teleported to you", name);
    SendClientMessage(targetid, 0xFFFF00FF, msg);

    return 1;
}

stock searchPlayerByName(name[]) {
    for(new i = 0; i < MAX_PLAYERS; i++) {
        new currentname[MAX_PLAYER_NAME + 1];
        GetPlayerName(i, currentname, sizeof(currentname));
        if(strcmp(currentname, name, true) == 0) return i;
    }
    return -1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid - DIALOG_KEY) {
        case DIALOG_MAIN:
            if(response) showDialog(playerid, listitem + 1);

        case DIALOG_PLAYER_ID:
            if(response) {
                teleportToPlayer(playerid, strval(inputtext));
            } else showDialog(playerid, DIALOG_MAIN);

        case DIALOG_PLAYER_NAME:
            if(response) {
                teleportToPlayer(playerid, searchPlayerByName(inputtext));
            } else showDialog(playerid, DIALOG_MAIN);
    }
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if(!strcmp(cmdtext, "/Teleport", true)) {
        showDialog(playerid, DIALOG_MAIN);
        return 1;
    }
    return 0;
}