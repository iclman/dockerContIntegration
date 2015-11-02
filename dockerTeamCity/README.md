# dockerTeamCity
Dockerization of Continuous Integration tool TeamCity connected to another Docker container running MySQL database server.

The connection to the TeamCity server is done via HTTPS on port 8543. The connection between the TeamCity server and the MySQL server is done with the java connector on port 3306.

![Diagram] (/dockerTeamCity/images/docker-teamcity.jpg)


Instructions


1) Clone the MySql docker image from Github. Buil the docker image for MySql5.5 and run the container as "container_mysql".

    $ git clone https://github.com/docker-library/mysql.git dockerMysql
    $ cd dockerMysql/5.5

Build the docker image "image_mysql5.5"

    $ docker build -t image_mysql5.5 .

Create the directory "data_mysql". This directory will be mounted on the container volume /var/lib/mysql.

    $ mkdir ${HOME}/data_mysql


Run the docker container "container_mysql". The port 3306 of the container is exposed and will be used by Teamcity. The Mysql information (user, password) will be used by Teamcity to connecty to mysql.

    $ docker run --name container_mysql  -v ${HOME}/data_mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=<root password for Mysql> -e MYSQL_DATABASE=<name of DB used by TeamCity> -e MYSQL_USER=<MySQL user used by TeamCity> -e MYSQL_PASSWORD=<password for MYSQL_USER> -d -t image_mysql5.5

The mysql server data are made persistent by mounting /home/iclman/data_mysql on the host to /var/lib/mysql in the container.

2) Clone the current container from Github. 
(Make sure you are not in the mysql repository before cloning this repository)

    $ git clone https://github.com/iclman/dockerContIntegration.git

Build the docker image for TeamCity

    $ cd dockerContIntegration/dockerTeamcity
    $ docker build -t image_teamcity . 


Run the docker container "cont_teamcity" and map the port 8543 of the host to the port 8543 of the container. A link to the container "container_mysql" is created 

    $ docker run --name cont_teamcity -p 8543:8543 --link container_mysql:mysqlserver -v <path-to-repo>/data_teamcity:/data/teamcity -d -t image_teamcity

The teamcity data are made persistent by mounting <path-to-repo>/data_teamcity on your host on /data/teamcity in the teamcity container. If you want to mount another directory, you must make sure that mysql-connector-java-5.1.37-bin.jar is made available on /data/teamcity/lib/jdbc.

