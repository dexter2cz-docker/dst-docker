# Don't Starve Together dedicated server Docker image

## Generate token and download server config
Login to Klei website:  
https://accounts.klei.com/login  
then go to DST server configuration, create token (ADD NEW SERVER) and download server .zip configuration (Configure):  
https://accounts.klei.com/account/game/servers?game=DontStarveTogether  
and finally unzip to somewhere (/root in this example).  

## Run Docker and server
docker run -it -v /root/MyDediServer:/home/steam/.klei/DoNotStarveTogether/MyDediServer --name DST --net=host dexter2cz/dst  
$ ./run_dedicated_servers.sh
