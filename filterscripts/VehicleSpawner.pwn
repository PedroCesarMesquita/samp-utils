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

#define DIALOG_KEY 1000

new offRoad[]       = {0,24,44,70,89,95,100,105,156,157,168,173,179};
new saloons[]       = {1,5,10,19,21,26,36,45,66,67,74,91,92,104,107,116,117,118,126,127,129,140,142,146,147,149,150,151,160,162,180,185,204};
new sportVehicles[] = {2,11,15,29,51,75,77,94,96,102,103,106,141,158,159,165,187,189,202,203};
new industrial[]    = {3,8,13,14,22,40,43,55,56,59,78,82,98,99,114,115,124,131,143,152,154,178,182,200,205,209};
new stationWagons[] = {4,18,58,79,161};
new uniqueVehicles[]= {6,9,23,28,34,42,49,57,83,85,86,108,125,130,132,137,138,139,145,171,172,174,183,188};
new publicService[] = {7,16,20,27,31,32,33,37,38,90,123,128,144,196,197,198,199,201};
new lowriders[]     = {12,134,135,136,166,167,175,176};
new helicopters[]   = {17,25,47,69,87,88,97,148,163};
new boats[]         = {30,46,52,53,54,72,73,84,93,195};
new trailers[]      = {35,50,169,170,184,190,191,206,207,208,210,211};
new convertibles[]  = {39,80,133,155};
new rcVehicles[]    = {41,64,65,101,164,194};
new bikes[]         = {48,61,62,63,68,71,81,109,110,121,122,181,186};
new airplane[]      = {60,76,111,112,113,119,120,153,177,192,193};

new vehicleModels[][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto",
	"Taxi","Washington","Bobcat","Mr. Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Article Trailer","Previon","Coach","Cabbie","Stallion",
	"Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squallo","Seasparrow","Pizzaboy","Tram","Article Trailer 2","Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Topfun Van (Berkley's RC)",
	"Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR-350","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","SAN News Maverick","Rancher","FBI Rancher","Virgo","Greenwood","Jetmax","Hotring Racer","Sandking","Blista Compact","Police Maverick","Boxville","Benson",
	"Mesa","RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher Lure","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropduster","Stuntplane","Tanker","Roadtrain","Nebula","Majestic","Buccaneer","Shamal",
	"Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Towtruck","Fortune","Cadrona","FBI Truck","Willard","Forklift","Tractor","Combine Harvester","Feltzer","Remington","Slamvan","Blade","Freight (Train)","Brownstreak (Train)","Vortex",
	"Vincent","Bullet","Clover","Sadler","Firetruck LA","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility Van","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus","Jester",
	"Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight Flat Trailer (Train)","Streak Trailer (Train)","Kart","Mower","Dune","Sweeper","Broadway","Tornado","AT400","DFT-30","Huntley",
	"Stafford","BF-400","Newsvan","Tug","Petrol Trailer","Emperor","Wayfarer","Euros","Hotdog","Club","Freight Box Trailer (Train)","Article Trailer 3","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
	"Picador","S.W.A.T.","Alpha","Phoenix","Glendale Shit","Sadler Shit","Baggage Trailer A","Baggage Trailer B","Tug Stairs Trailer","Boxville","Farm Trailer","Utility Trailer"
};

stock showMainDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY, DIALOG_STYLE_LIST, "Vehicle Spawner", "Pick random\nSearch by model id\nSearch by model name\nChoose by category", "Confirm", "Cancel");
stock showSearchByIdDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 1, DIALOG_STYLE_INPUT, "Vehicle Spawner - Search by id", "Enter the vehicle model id (400-611):", "Confirm", "Cancel");
stock showSearchByNameDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 2, DIALOG_STYLE_INPUT, "Vehicle Spawner - Search by name", "Enter the vehicle model name:", "Confirm", "Cancel");
stock showCategoriesDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 3, DIALOG_STYLE_LIST, "Vehicle Spawner - Categories", "Off Road\nSaloons\nSport Vehicles\nIndustrial\nStation Wagons\nUnique Vehicles\nPublic Service\nLowriders\nHelicopters\nBoats\nTrailers\nConvertibles\nRC Vehicles\nBikes\nAirplanes", "Confirm", "Cancel");
stock showOffRoadDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 4, DIALOG_STYLE_LIST, "Vehicle Spawner - Off Road", "Landstalker\nBF Injection\nMonster\nPatriot\nRancher\nSandking\nMesa\nRancher Lure\nMonster A\nMonster B\nBandito\nDune\nHuntley", "Confirm", "Cancel");
stock showSaloonsDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 5, DIALOG_STYLE_LIST, "Vehicle Spawner - Saloons", "Bravura\nSentinel\nManana\nEsperanto\nWashington\nPremier\nPrevion\nAdmiral\nGlendale\nOceanic\nHermes\nVirgo\nGreenwood\nBloodring Banger\nElegant\nNebula\nMajestic\nBuccaneer\nFortune\nCadrona\nWillard\nVincent\nClover\nIntruder\nPrimo\nTampa\nSunrise\nMerit\nSultan\nElegy\nStafford\nEmperor\nGlendale Shit", "Confirm", "Cancel");
stock showSportVehiclesDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 6, DIALOG_STYLE_LIST, "Vehicle Spawner - Sport Vehicles", "Buffalo\nInfernus\nCheetah\nBanshee\nTurismo\nSabre\nZR-350\nHotring Racer\nBlista Compact\nHotring Racer A\nHotring Racer B\nSuper GT\nBullet\nUranus\nJester\nFlash\nEuros\nClub\nAlpha\nPhoenix", "Confirm", "Cancel");
stock showIndustrialDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 7, DIALOG_STYLE_LIST, "Vehicle Spawner - Industrial", "Linerunner\nTrashmaster\nPony\nMule\nBobcat\nRumpo\nPacker\nFlatbed\nYankee\nTopfun Van (Berkley's RC)\nWalton\nBurrito\nBoxville\nBenson\nTanker\nRoadtrain\nCement Truck\nTractor\nSadler\nUtility Van\nYosemite\nDFT-30\nNewsvan\nPicador\nSadler Shit\nBoxville", "Confirm", "Cancel");
stock showStationWagonsDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 8, DIALOG_STYLE_LIST, "Vehicle Spawner - Station Wagons", "Perennial\nMoonbeam\nSolair\nRegina\nStratum", "Confirm", "Cancel");
stock showUniqueVehiclesDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 9, DIALOG_STYLE_LIST, "Vehicle Spawner - Unique Vehicles", "Dumper\nStretch\nMr. Whoopee\nSecuricar\nHotknife\nRomero\nTram\nCaddy\nCamper\nBaggage\nDozer\nJourney\nTowtruck\nForklift\nCombine Harvester\nFreight (Train)\nBrownstreak (Train)\nVortex\nHustler\nKart\nMower\nSweeper\nTug\nHotdog", "Confirm", "Cancel");
stock showPublicServiceDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 10, DIALOG_STYLE_LIST, "Vehicle Spawner - Public Service", "Firetruck\nAmbulance\nTaxi\nEnforcer\nBus\nRhino\nBarracks\nCoach\nCabbie\nFBI Rancher\nHPV1000\nFBI Truck\nFiretruck LA\nPolice Car (LSPD)\nPolice Car (SFPD)\nPolice Car (LVPD)\nPolice Ranger\nS.W.A.T.", "Confirm", "Cancel");
stock showLowridersDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 11, DIALOG_STYLE_LIST, "Vehicle Spawner - Lowriders", "Voodoo\nRemington\nSlamvan\nBlade\nTahoma\nSavanna\nBroadway\nTornado", "Confirm", "Cancel");
stock showHelicoptersDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 12, DIALOG_STYLE_LIST, "Vehicle Spawner - Helicopters", "Leviathan\nHunter\nSeasparrow\nSparrow\nMaverick\nSAN News Maverick\nPolice Maverick\nCargobob\nRaindance", "Confirm", "Cancel");
stock showBoatsDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 13, DIALOG_STYLE_LIST, "Vehicle Spawner - Boats", "Predator\nSquallo\nSpeeder\nReefer\nTropic\nCoastguard\nDinghy\nMarquis\nJetmax\nLaunch", "Confirm", "Cancel");
stock showTrailersDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 14, DIALOG_STYLE_LIST, "Vehicle Spawner - Trailers", "Article Trailer\nArticle Trailer 2\nFreight Flat Trailer (Train)\nStreak Trailer (Train)\nPetrol Trailer\nFreight Box Trailer (Train)\nArticle Trailer 3\nBaggage Trailer A\nBaggage Trailer B\nTug Stairs Trailer\nFarm Trailer\nUtility Trailer", "Confirm", "Cancel");
stock showConvertiblesDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 15, DIALOG_STYLE_LIST, "Vehicle Spawner - Convertibles", "Stallion\nComet\nFeltzer\nWindsor", "Confirm", "Cancel");
stock showRcVehiclesDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 16, DIALOG_STYLE_LIST, "Vehicle Spawner - RC Vehicles", "RC Bandit\nRC Baron\nRC Raider\nRC Goblin\nRC Tiger\nRC Cam", "Confirm", "Cancel");
stock showBikesDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 17, DIALOG_STYLE_LIST, "Vehicle Spawner - Bikes", "Pizzaboy\nPCJ-600\nFaggio\nFreeway\nSanchez\nQuad\nBMX\nBike\nMountain Bike\nFCR-900\nNRG-500\nBF-400\nWayfarer", "Confirm", "Cancel");
stock showAirplaneDialog(playerid) ShowPlayerDialog(playerid, DIALOG_KEY + 18, DIALOG_STYLE_LIST, "Vehicle Spawner - Airplane", "Skimmer\nRustler\nBeagle\nCropduster\nStuntplane\nShamal\nHydra\nNevada\nAT400\nAndromada\nDodo", "Confirm", "Cancel");

stock isValidModelId(modelid) return modelid >= 400 && modelid <= 611;

stock giveVehicle(playerid, modelid) {
    if(!isValidModelId(modelid)) return SendClientMessage(playerid, 0xFF0000FF, "Model not found");
    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);
    new vehicleid = AddStaticVehicle(modelid, x, y, z, angle, -1, -1);
    PutPlayerInVehicle(playerid, vehicleid, 0);
    new msg[40];
    format(msg, sizeof(msg), "You got a %s", vehicleModels[modelid - 400]);
    return SendClientMessage(playerid, 0x00FF00FF, msg);
}

stock searchByVehicleModelName(name[]) {
    for(new i = strlen(name); i > 1; i--) {
        for(new j = 0; j <= 211; j++) {
            if(!strcmp(name, vehicleModels[j], true, i))
                return j + 400;
        }
    }
    return -1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(!response) return;
    switch(dialogid - DIALOG_KEY) {
        case 0:
            switch(listitem) {
                case 0: giveVehicle(playerid, 400 + random(211));
                case 1: showSearchByIdDialog(playerid);
                case 2: showSearchByNameDialog(playerid);
                case 3: showCategoriesDialog(playerid);
            }
        case 1: giveVehicle(playerid, strval(inputtext));
        case 2: giveVehicle(playerid, searchByVehicleModelName(inputtext));
        case 3:
            switch(listitem) {
                case 0: showOffRoadDialog(playerid);
                case 1: showSaloonsDialog(playerid);
                case 2: showSportVehiclesDialog(playerid);
                case 3: showIndustrialDialog(playerid);
                case 4: showStationWagonsDialog(playerid);
                case 5: showUniqueVehiclesDialog(playerid);
                case 6: showPublicServiceDialog(playerid);
                case 7: showLowridersDialog(playerid);
                case 8: showHelicoptersDialog(playerid);
                case 9: showBoatsDialog(playerid);
                case 10: showTrailersDialog(playerid);
                case 11: showConvertiblesDialog(playerid);
                case 12: showRcVehiclesDialog(playerid);
                case 13: showBikesDialog(playerid);
                case 14: showAirplaneDialog(playerid);
            }
        case 4: giveVehicle(playerid, 400 + offRoad[listitem]);
        case 5: giveVehicle(playerid, 400 + saloons[listitem]);
        case 6: giveVehicle(playerid, 400 + sportVehicles[listitem]);
        case 7: giveVehicle(playerid, 400 + industrial[listitem]);
        case 8: giveVehicle(playerid, 400 + stationWagons[listitem]);
        case 9: giveVehicle(playerid, 400 + uniqueVehicles[listitem]);
        case 10:giveVehicle(playerid, 400 + publicService[listitem]);
        case 11:giveVehicle(playerid, 400 + lowriders[listitem]);
        case 12:giveVehicle(playerid, 400 + helicopters[listitem]);
        case 13:giveVehicle(playerid, 400 + boats[listitem]);
        case 14:giveVehicle(playerid, 400 + trailers[listitem]);
        case 15:giveVehicle(playerid, 400 + convertibles[listitem]);
        case 16:giveVehicle(playerid, 400 + rcVehicles[listitem]);
        case 17:giveVehicle(playerid, 400 + bikes[listitem]);
        case 18:giveVehicle(playerid, 400 + airplane[listitem]);
    }
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if(!strcmp(cmdtext, "/VehicleSpawner", true)) {
        showMainDialog(playerid);
        return 1;
    }
    return 0;
}