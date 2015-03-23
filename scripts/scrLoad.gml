if(file_exists("Save.sav")){
    ini_open("Save.sav");
    var LoadedRoom = ini_read_string("General","room",rmNEW);
    var LoadedScore = ini_read_string("General","score",0);
    var LoadedHealthP = ini_read_string("General","player_health",100);
    var LoadedPlayerX = ini_read_real("General","playerX",0);
    var LoadedPlayerY = ini_read_real("General","playerY",0);
    var LoadedMoney = ini_read_real("General","Time",0);
    global.load = true;

    LoadedRoom = real(base64_decode(LoadedRoom));
    global.money = real(base64_decode(LoadedScore));
    global.PlayerHP = real(base64_decode(LoadedHealthP));
    global.playerY = LoadedPlayerY
    global.playerX = LoadedPlayerX
    file_delete("Save.sav")
    ini_close();
    scrRoomChange(LoadedRoom);
}else{}