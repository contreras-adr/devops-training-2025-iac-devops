
# IAC-DEOPS Environment


## CI / CD Strategy with Jenkins and Docker

### Install WSL2 Ubuntu 22.04, Docker and Docker Compose 
https://gist.github.com/Adhjie/8dcab8ef69a82e0b35d017725f20de19
https://documentation.ubuntu.com/wsl/en/latest/howto/install-ubuntu-wsl2/

# Install Portainer to manage Docker in Ubuntu
```bash
docker-compose up -d portainer
http://localhost:9443
```

### Configure Jekins modules to install in *jenkins/plugins.txt*




### Install Jenkins in local environment.
https://github.com/jenkinsci/docker/
```bash
docker-compose up -d jenkins
docker-compose logs jenkins
```





### Create GitHub SSH Key for Jenkins
```bash
ssh-keygen -C "contreras.adr@outlook.com" -f ~/.ssh/jenkins-github
cat ~/.ssh/jenkins-github
```


