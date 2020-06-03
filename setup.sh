#!/bin/bash
reinstall_docker_nginx=true
configure_nginx=true

LISTEN=0.0.0.0:80
SERVER_NAME=localhost

# Arrays
declare -a LOCATIONS=("/")
declare -a PROXIES=("http://localhost:5000")
declare -a images=("iris:1.0")
declare -a ports=("5000:5000")

#-------------------------------------------------

####
#### Install all necessary packages
####

if [ "$reinstall_docker_nginx" = true ]
then
	# Remove previous docker
	apt update
	apt-get -y purge docker docker-engine docker.io

	# Install and enable docker
	apt-get -y install docker.io
	systemctl start docker
	systemctl enable docker

	# Remove previous nginx
	apt-get -y purge nginx nginx-common nginx-full

	# Install and enable nginx
	apt-get -y install nginx
	systemctl enable nginx
	systemctl start nginx
	ufw enable
fi

#### 
####Setup nginx config
####

# get length of an array
n_locations=${#LOCATIONS[@]}

# insert at
LINE_NUMBER=63

if [ "$configure_nginx" = true ]
then
	sed -i ''"${LINE_NUMBER}"'i\
	server {\
		listen '"${LISTEN}"'; \
		server_name '"${SERVER_NAME}"'; \
		\
		location '"${LOCATIONS[0]}"' { \
			proxy_pass '"${PROXIES[0]}"'; \
		} \
	}' /etc/nginx/nginx.conf

	# insert at
	LINE_NUMBER=70

	# use for loop to read all values and indexes
	for (( i=1; i<${n_locations}; i++ ));
	do
		
		sed -i ''"${LINE_NUMBER}"'i\
		location '"${LOCATIONS[i]}"' { \
			proxy_pass '"${PROXIES[i]}"'; \
		}' /etc/nginx/nginx.conf
		LINE_NUMBER=$(($LINE_NUMBER + 4))
	done
fi

####
#### Run all images
####

docker kill $(docker ps -q)

# get length of an array
n_images=${#images[@]}

# use for loop to read all values and indexes
for (( i=0; i<${n_images}; i++ ));
do
    docker build -t "${images[$i]}" .
    ID="$(docker images | grep ${images[$i]} | head -n 1 | awk '{print $3}')"
	docker run -d -p "${ports[$i]}" "${ID}"
done

service nginx restart