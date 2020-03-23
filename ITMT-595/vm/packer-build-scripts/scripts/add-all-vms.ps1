
# Add servers
cd ../build/

vagrant box add ./nginx-web-server-virtualbox.box --name nginx-web-server
echo "[NGINX] vagrant box added..."

vagrant box add ./node-application-server-virtualbox.box --name node-application-server 
echo "[NODE] vagrant box added..."

vagrant box add ./mongodb-server-virtualbox.box --name mongodb-server
echo "[MONGODB] vagrant box added..."

vagrant box add ./mongodb-server-virtualbox.box --name mongodb-rep1-server
echo "[MONGODB REP1] vagrant box added..."

vagrant box add ./redis-caching-server-virtualbox.box --name redis-caching-server
echo "[REDIS] vagrant box added..."
