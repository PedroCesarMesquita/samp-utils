/*
    Invulnerable filterscript for SA-MP
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

public OnFilterScriptInit() printf("Invulnerable filterscript init.");
public OnFilterScriptExit() printf("Invulnerable filterscript exit.");

public OnPlayerConnect(playerid) {
    SetPVarInt(playerid, "invulnerable", 0);
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) {
    if(GetPVarInt(playerid, "invulnerable")) {
        SetPlayerHealth(playerid, 100000.0);
        SetPlayerArmour(playerid, 100000.0);
    }
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid) {
    if(GetPVarInt(playerid, "invulnerable")) {
        RepairVehicle(vehicleid);
        SetVehicleHealth(GetPlayerVehicleID(playerid), 1000000.0);
    }
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if(!strcmp(cmdtext, "/Invulnerable", true)) {
        if(GetPVarInt(playerid, "invulnerable"))
            SendClientMessage(playerid, 0xFF0000FF, "You are already invulnerable. Type /Vulnerable to be vulnerable.");
        else {
            SetPVarInt(playerid, "invulnerable", 1);
            SetPlayerHealth(playerid, 100000.0);
            SetPlayerArmour(playerid, 100000.0);
            SetVehicleHealth(GetPlayerVehicleID(playerid), 1000000.0);
            SendClientMessage(playerid, 0x00FF00FF, "Now you are invulnerable");
        }
        return 1;
    } else if(!strcmp(cmdtext, "/Vulnerable", true)) {
        if(!GetPVarInt(playerid, "invulnerable"))
            SendClientMessage(playerid, 0xFF0000FF, "You are already vulnerable. Type /Invulnerable to be invulnerable.");
        else {
            SetPVarInt(playerid, "invulnerable", 0);
            SetPlayerHealth(playerid, 100.0);
            SetPlayerArmour(playerid, 100.0);
            SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
            SendClientMessage(playerid, 0x00FF00FF, "Now you are vulnerable");
        }
        return 1;
    }
    return 0;
}