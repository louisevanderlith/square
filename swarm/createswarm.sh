docker-machine ssh devmanager "docker swarm leave"
docker-machine ssh devmanager "docker swarm init --listen-addr $(docker-machine ip devmanager) --advertise-addr $(docker-machine ip devmanager)"

export worker_token=$(docker-machine ssh devmanager "docker swarm join-token worker -q")

docker-machine ssh devworker1 "docker swarm leave"
docker-machine ssh devworker1 "docker swarm join --token=${worker_token} --listen-addr $(docker-machine ip devworker1) --advertise-addr $(docker-machine ip devworker1)  $(docker-machine ip devmanager)"

docker-machine ssh devworker2 "docker swarm leave"
docker-machine ssh devworker2 "docker swarm join --token=${worker_token} --listen-addr $(docker-machine ip devworker2) --advertise-addr $(docker-machine ip devworker2)  $(docker-machine ip devmanager)"


#docker-machine ssh avosa-box "docker swarm init --listen-addr $(docker-machine ip avosa-box) --advertise-addr $(docker-machine ip avosa-box)"