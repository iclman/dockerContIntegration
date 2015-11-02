# dockerJenkins

Setup of a Docker image of a Jenkins server.
Access to the server will be via HTTPS on port 8443

![Diagram] (/dockerJenkins/images/docker-jenkins.jpg)

**Instructions**

1) Clone the current container from Github. 

    $ git clone https://github.com/iclman/dockerContIntegration.git

If you have your own keystore, replace the file "dockerContIntegration/dockerJenkins/keystore.jks" by your key.
You will have to replace the password "changeit"  in the script "start_jenkins.sh" by the password of your keystore.
    
2) Build the docker image for Jenkins

    $ cd dockerContIntegration/dockerJenkins
    $ docker build -t image_jenkins . 

3) Launch a container based on this image

    $ docker run -p 8443:8443 -p 50000:50000 --volume /home/iclman/home_jenkins:/var/jenkins_home -t im_jenkins    
   
In the example above, the directory  /home/iclman/home_jenkins is mounted on the directory /var/jenkins_home of  the container.