#define download_file
/*
argument0 = url to download from
argument1 = local file to save as
returns the error code from the server. 200 is a succesful download.

NOTE: urls with usernames and passwords do not work.
*/

dll_init()

var server, file, i, port, tcp, endloop, url, error;
server = "";
file = "/"
port = 80;
i = 0;
error = 200;

if(string_pos("http://", argument0) == 1)argument0 = string_delete(argument0, 1,7)
//get file part of url
i = string_pos("/", argument0);
if(i)
{
    file = string_copy(argument0, i, string_length(argument0)-i+1);
    argument0 = string_delete(argument0, i, string_length(file));
}
//get port part
i = string_pos(":", argument0);
if(i)
{
    port = real(string_copy(argument0, 1, i-1));
    argument0 = string_delete(argument0, 1, i);
}
//get server part
server = argument0;


//the code above interpretes the url into a server variable, file variable and port.

tcp = tcp_connect(server, port, 0);
if(!tcp)return false;
set_format(tcp, 1, chr(13) + chr(10)); //set format to text mode to receive one line at a time.
//send get request
clear_buffer(0);
write_chars("GET " + file+ " HTTP/1.1" + chr(13) + chr(10),0);
write_chars("Host: " + server + chr(13) + chr(10),0);
write_chars("Connection: close"+chr(13) + chr(10),0);
write_chars("Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/xaml+xml, application/vnd.ms-xpsdocument, application/x-ms-xbap, application/x-ms-application, application/x-alambik-script, application/x-alambik-alamgram-link, */*"+chr(13)+chr(10),0);
write_chars("Accept-Language: en-us"+chr(13) + chr(10),0);
write_chars("User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; InfoPath.1; .NET CLR 2.0.50727; .NET CLR 1.1.4322)"+chr(13) + chr(10),0);
send_message(tcp,0,0,0);
//receive file header

//interpret header for any errors.
endloop = false;
while(!endloop)
{
    receive_message(tcp,0,0); //receive one line
    i = read_sep(" ",0); //read first word
    switch(i)
    {
//check http error code
        case "HTTP/1.1":
        case "HTTP/1.0":
            error = real(read_sep(" ",0));
            if(error != 200 && error != 301)
            {
                close_socket(tcp);
                return error;
            }
        break;
//if page moved than locate new page and download from it.
        case "Location:":
            if(error == 301)
            {
                close_socket(tcp);
                url = read_sep(chr(13) + chr(10),0);
                return download_file(url,argument1);
            }
        break;
//if blank line (end of header) then exit loop
        case "":
            endloop = true
        break;
    }
}
set_format(tcp, 2,0); //turn off all formatting so we can receive file data.
if(file_exists(argument1))file_delete(argument1);
file = file_open(argument1, 1);
//start receiving file

while(receive_message(tcp, 50000,0) > 0) //receive 50000 bytes
{
    file_write(file,0); //write file chunk to file.
}
close_socket(tcp);
file_close(file);
return 200;


