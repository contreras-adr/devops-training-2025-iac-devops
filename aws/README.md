
# AWS IAC-DEOPS Environment


## 1-  Install AWS CLI and Terraform CLI



## 2- Create Service User for the profile name: "devops-training-2025 "
Create a service user with the needed rights:

```bash
sh aws/iac/create-terraform-service-user.sh
```

### 3- Deploy Infrastructure
```bash
terraform -chdir aws/iac apply 
```

### 3- Upload Java App docker image to ECR


### 4- Deploy Java App in ecs
```bash
terraform -chdir aws/deploy apply 
```



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


