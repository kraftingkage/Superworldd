ini_open("codeused.cdu");
ini_write_string("Used",global.codeused,global.codew);
ini_close();

r =irandom(999999);
    if(r == 1){
    show_message("1,000,000")
}else{
r =irandom(99999);
        if(r == 1){
        show_message("100,000")
}else{
r =irandom(9999);
            if(r == 1){
            show_message("10,000")
}else{
r =irandom(999);
                if(r == 1){
                show_message("1,000")
}else{
r =irandom(99);
                    if(r == 1){
                    show_message("100")
}else{
r =irandom(9);
                        if(r== 1){
                      show_message("10")
}else{
show_message("AWWWWWWW")
room_restart();
}
}}}}}
