/*
    Vehicle Spawner filterscript for SA-MP
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

public OnFilterScriptInit() printf("VehicleSpawner filterscript init.");
public OnFilterScriptExit() printf("VehicleSpawner filterscript exit.");

new vehicleModels[][][] = {
	{"Landstalker","Off Road"},{"Bravura","Saloons"},{"Buffalo","Sport Vehicles"},{"Linerunner","Industrial"},{"Perennial","Station Wagons"},{"Sentinel","Saloons"},{"Dumper","Unique Vehicles"},{"Firetruck","Public Service"},{"Trashmaster","Industrial"},{"Stretch","Unique Vehicles"},
	{"Manana","Saloons"},{"Infernus","Sport Vehicles"},{"Voodoo","Lowriders"},{"Pony","Industrial"},{"Mule","Industrial"},{"Cheetah","Sport Vehicles"},{"Ambulance","Public Service"},{"Leviathan","Helicopters"},{"Moonbeam","Station Wagons"},{"Esperanto","Saloons"},
	{"Taxi","Public Service"},{"Washington","Saloons"},{"Bobcat","Industrial"},{"Mr. Whoopee","Unique Vehicles"},{"BF Injection","Off Road"},{"Hunter","Helicopters"},{"Premier","Saloons"},{"Enforcer","Public Service"},{"Securicar","Unique Vehicles"},{"Banshee","Sport Vehicles"},
	{"Predator","Boats"},{"Bus","Public Service"},{"Rhino","Public Service"},{"Barracks","Public Service"},{"Hotknife","Unique Vehicles"},{"Article Trailer","Trailers"},{"Previon","Saloons"},{"Coach","Public Service"},{"Cabbie","Public Service"},{"Stallion","Convertibles"},
	{"Rumpo","Industrial"},{"RC Bandit","RC Vehicles"},{"Romero","Unique Vehicles"},{"Packer","Industrial"},{"Monster","Off Road"},{"Admiral","Saloons"},{"Squallo","Boats"},{"Seasparrow","Helicopters"},{"Pizzaboy","Bikes"},{"Tram","Unique Vehicles"},
	{"Article Trailer 2","Trailers"},{"Turismo","Sport Vehicles"},{"Speeder","Boats"},{"Reefer","Boats"},{"Tropic","Boats"},{"Flatbed","Industrial"},{"Yankee","Industrial"},{"Caddy","Unique Vehicles"},{"Solair","Station Wagons"},{"Topfun Van (Berkley's RC)","Industrial"},
	{"Skimmer","Airplane"},{"PCJ-600","Bikes"},{"Faggio","Bikes"},{"Freeway","Bikes"},{"RC Baron","RC Vehicles"},{"RC Raider","RC Vehicles"},{"Glendale","Saloons"},{"Oceanic","Saloons"},{"Sanchez","Bikes"},{"Sparrow","Helicopters"},
	{"Patriot","Off Road"},{"Quad","Bikes"},{"Coastguard","Boats"},{"Dinghy","Boats"},{"Hermes","Saloons"},{"Sabre","Sport Vehicles"},{"Rustler","Airplane"},{"ZR-350","Sport Vehicles"},{"Walton","Industrial"},{"Regina","Station Wagons"},
	{"Comet","Convertibles"},{"BMX","Bikes"},{"Burrito","Industrial"},{"Camper","Unique Vehicles"},{"Marquis","Boats"},{"Baggage","Unique Vehicles"},{"Dozer","Unique Vehicles"},{"Maverick","Helicopters"},{"SAN News Maverick","Helicopters"},{"Rancher","Off Road"},
	{"FBI Rancher","Public Service"},{"Virgo","Saloons"},{"Greenwood","Saloons"},{"Jetmax","Boats"},{"Hotring Racer","Sport Vehicles"},{"Sandking","Off Road"},{"Blista Compact","Sport Vehicles"},{"Police Maverick","Helicopters"},{"Boxville","Industrial"},{"Benson","Industrial"},
	{"Mesa","Off Road"},{"RC Goblin","RC Vehicles"},{"Hotring Racer A","Sport Vehicles"},{"Hotring Racer B","Sport Vehicles"},{"Bloodring Banger","Saloons"},{"Rancher Lure","Off Road"},{"Super GT","Sport Vehicles"},{"Elegant","Saloons"},{"Journey","Unique Vehicles"},{"Bike","Bikes"},
	{"Mountain Bike","Bikes"},{"Beagle","Airplane"},{"Cropduster","Airplane"},{"Stuntplane","Airplane"},{"Tanker","Industrial"},{"Roadtrain","Industrial"},{"Nebula","Saloons"},{"Majestic","Saloons"},{"Buccaneer","Saloons"},{"Shamal","Airplane"},
	{"Hydra","Airplane"},{"FCR-900","Bikes"},{"NRG-500","Bikes"},{"HPV1000","Public Service"},{"Cement Truck","Industrial"},{"Towtruck","Unique Vehicles"},{"Fortune","Saloons"},{"Cadrona","Saloons"},{"FBI Truck","Public Service"},{"Willard","Saloons"},
	{"Forklift","Unique Vehicles"},{"Tractor","Industrial"},{"Combine Harvester","Unique Vehicles"},{"Feltzer","Convertibles"},{"Remington","Lowriders"},{"Slamvan","Lowriders"},{"Blade","Lowriders"},{"Freight (Train)","Unique Vehicles"},{"Brownstreak (Train)","Unique Vehicles"},{"Vortex","Unique Vehicles"},
	{"Vincent","Saloons"},{"Bullet","Sport Vehicles"},{"Clover","Saloons"},{"Sadler","Industrial"},{"Firetruck LA","Public Service"},{"Hustler","Unique Vehicles"},{"Intruder","Saloons"},{"Primo","Saloons"},{"Cargobob","Helicopters"},{"Tampa","Saloons"},
	{"Sunrise","Saloons"},{"Merit","Saloons"},{"Utility Van","Industrial"},{"Nevada","Airplane"},{"Yosemite","Industrial"},{"Windsor","Convertibles"},{"Monster A","Off Road"},{"Monster B","Off Road"},{"Uranus","Sport Vehicles"},{"Jester","Sport Vehicles"},
	{"Sultan","Saloons"},{"Stratum","Station Wagons"},{"Elegy","Saloons"},{"Raindance","Helicopters"},{"RC Tiger","RC Vehicles"},{"Flash","Sport Vehicles"},{"Tahoma","Lowriders"},{"Savanna","Lowriders"},{"Bandito","Off Road"},{"Freight Flat Trailer (Train)","Trailers"},
	{"Streak Trailer (Train)","Trailers"},{"Kart","Unique Vehicles"},{"Mower","Unique Vehicles"},{"Dune","Off Road"},{"Sweeper","Unique Vehicles"},{"Broadway","Lowriders"},{"Tornado","Lowriders"},{"AT400","Airplane"},{"DFT-30","Industrial"},{"Huntley","Off Road"},
	{"Stafford","Saloons"},{"BF-400","Bikes"},{"Newsvan","Industrial"},{"Tug","Unique Vehicles"},{"Petrol Trailer","Trailers"},{"Emperor","Saloons"},{"Wayfarer","Bikes"},{"Euros","Sport Vehicles"},{"Hotdog","Unique Vehicles"},{"Club","Sport Vehicles"},
	{"Freight Box Trailer (Train)","Trailers"},{"Article Trailer 3","Trailers"},{"Andromada","Airplane"},{"Dodo","Airplane"},{"RC Cam","RC Vehicles"},{"Launch","Boats"},{"Police Car (LSPD)","Public Service"},{"Police Car (SFPD)","Public Service"},{"Police Car (LVPD)","Public Service"},{"Police Ranger","Public Service"},
	{"Picador","Industrial"},{"S.W.A.T.","Public Service"},{"Alpha","Sport Vehicles"},{"Phoenix","Sport Vehicles"},{"Glendale Shit","Saloons"},{"Sadler Shit","Industrial"},{"Baggage Trailer A","Trailers"},{"Baggage Trailer B","Trailers"},{"Tug Stairs Trailer","Trailers"},{"Boxville","Industrial"},
	{"Farm Trailer","Trailers"},{"Utility Trailer","Trailers"}
};

enum {
    DIALOG_MAIN,
    DIALOG_SEARCH_BY_ID,
    DIALOG_SEARCH_BY_NAME
}

new dialogs[][][] = {
    { {DIALOG_STYLE_LIST }, "Vehicle Spawner", "Pick random\nSearch by model id\nSearch by model name" },
    { {DIALOG_STYLE_INPUT}, "Vehicle Spawner - Search by id", "Enter the vehicle model id (400-611):" },
    { {DIALOG_STYLE_INPUT}, "Vehicle Spawner - Search by name", "Enter the vehicle model name:" }
};

stock isValidModelId(modelid) return modelid >= 400 && modelid <= 611;

stock showDialog(playerid, dialogid) {
    return ShowPlayerDialog(playerid, dialogid, dialogs[dialogid][0][0], dialogs[dialogid][1], dialogs[dialogid][2], "Confirm", "Cancel");
}

stock giveVehicle(playerid, modelid) {
    if(!isValidModelId(modelid)) return SendClientMessage(playerid, 0xFF0000FF, "Model not found");
    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);
    new vehicleid = AddStaticVehicle(modelid, x, y, z, angle, -1, -1);
    PutPlayerInVehicle(playerid, vehicleid, 0);
    new msg[40];
    format(msg, sizeof(msg), "You got a %s", vehicleModels[modelid - 400][0]);
    return SendClientMessage(playerid, 0x00FF00FF, msg);
}

stock searchByVehicleModelName(inputtext[]) {
    for(new i = strlen(inputtext); i > 1; i--) {
        for(new j = 0; j <= 211; j++) {
            if(!strcmp(inputtext, vehicleModels[j][0], true, i))
                return j + 400;
        }
    }
    return -1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid) {
        case DIALOG_MAIN:
            if(response) {
                if(listitem == 0) giveVehicle(playerid, 400 + random(211));
                else showDialog(playerid, listitem);
            }

        case DIALOG_SEARCH_BY_ID:
            if(response) giveVehicle(playerid, strval(inputtext));
            else showDialog(playerid, DIALOG_MAIN);

        case DIALOG_SEARCH_BY_NAME:
            if(response) giveVehicle(playerid, searchByVehicleModelName(inputtext));
            else showDialog(playerid, DIALOG_MAIN);
    }
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if(!strcmp(cmdtext, "/VehicleSpawner", true)) {
        showDialog(playerid, DIALOG_MAIN);
        return 1;
    }
    return 0;
}