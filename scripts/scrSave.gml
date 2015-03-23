if(file_exists("Save.sav")) file_delete("Save.sav");
ini_open("Save.sav");

var SavedRoom = base64_encode(string(room));
var SavedPoints = base64_encode(string(global.money));
var SavedHealthP = base64_encode(string(global.PlayerHP));



ini_write_real("General","Time",global.time);
ini_write_string("General","room",SavedRoom);
ini_write_string("General","money",SavedPoints);
ini_write_string("General","player_health",SavedHealthP);
ini_write_real("General","playerX",global.playerX);
ini_write_real("General","playerY",global.playerY);
ini_close();
