image_version=`date +%Y%m%d%H%M`;
echo $image_version;
# cd WebAppCore
git pull --rebase origin master;
docker stop webappcore;
docker rm webappcore;
docker build -t webappcore:$image_version .;
docker images;
docker run -p 8088:80 -d --name webappcore webappcore:$image_version;
# -v ~/docker-data/house-web/appsettings.json:/app/appsettings.json -v ~/docker-data/house-web/NLogFile/:/app/NLogFile   --restart=always
docker logs webappcore;
#删除build过程中产生的镜像    #docker image prune -a -f
docker rmi $(docker images -f "dangling=true" -q)
