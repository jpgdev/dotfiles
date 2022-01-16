# Setup docker

# TOOD: Add this to ansible? Use this as notes for now.


#### Run docker without root
# Source: https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
#
# WARNING: This makes the user have the equivalent of root privileges at all time
#
# To be able to run docker without using sudo/being root, there are some steps required:
# Need to make sure there is a `docker` group
sudo groupadd docker

# Add the user to the `docker` group
sudo gpasswd -a $USER docker

# Either log off and on or run this:
newgrp docker

# To simply test this:
docker run hello-world
