switch(mpos){
    case 0:{
        scrRoomChange(rmNEW)
        break;
    }
    case 1:{
        scrLoad();
        break;
    }
    case 2:{
        scrRoomChange(rmCodes);
        break;
    }
    case 3:{
        game_end();
        break;
    }
    default: break;
}
