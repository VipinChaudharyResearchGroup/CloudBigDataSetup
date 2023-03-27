DOCKER := /usr/bin/docker



start:
		sudo systemctl start docker

# add a condition for checking if a network with this name doesn't exist 
net-create:
		$(DOCKER) network create \
		--driver=bridge \
		--subnet=172.28.0.0/16 \
		--ip-range=172.28.5.0/24 \
		--gateway=172.28.5.254 \
		br0W

net-list:
		$(DOCKER) network ls

