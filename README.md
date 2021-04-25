# DevOps Project

## Deploying Flask Application

### Contents

* Overview
* Technologies
* Jira
* GitHub
* Terraform
* AWS
* Ansible
* Docker and Docker Compose
* Jenkins
* Acheivements
* Improvements
* Acknowledgements

### Overview

In this project, we have built a CI/CD pipeline to deploye a simple python flask app using AWS.
Using different technologies, we have been able to create a staging environment for developers to see if everything is working in the app before deploying to the production.

### Brief

The application must:

* Be deployed to a Virtual Machine for testing
* Be deployed in a Docker Stack using Docker Compose
* Make use of a managed Database solution

### Technology Stack

Technologies used in the development of our DevOps Pipeline:

* Jira
* Github
* Terraform
* AWS
* Ansible
* Jenkins
* Docker

### Jira

We have used jira as our project management software. We chose jira as its an easy to use software that allows us to use scrum methodologies such as creating sprints and user stories.

![jira sprint](/images/jira-sprint.PNG)

JIRA Board can be found [here](https://qarestaurant.atlassian.net/jira/software/projects/DEV/boards/7).


### Github

We used github as our version control system as we are comfortable with this software and it is easy to incorporate with our jenkins box.


We used a feature branch model to ensure that when any new features were pushed up the code could be checked before it was allowed to be used in a production environment. The use of branches was also vital for the building of our Jenkins pipelines as it allowed us to differentiate between the developement and production environments.

### Terraform

We have used Terraform locally to configure the resources we were looking to use from AWS. In this project we used Terraform to create: 4 EC2 instances, 1 RDS instance, 1 Internet Gateway, 1 NAT gateway, 3 Subnets (1 public and 2 private). We also used Terraform to pass User Data to our bastion host. This allowed us to automate the installation of ansible and pass SQL commands to the RDS database.


### Amazon Web Services (AWS)

We used AWS as we needed a reliable low-cost infrastructure that we could confidently deploy our application too. Within AWS we made use of a Virtual Private Cloud. By utilising this technology, we can control the access users have to our application. By only publishing our nginx container and keeping the other docker containers (database, backend) in a private subnet, we have been able to keep data more secure and limit access to it.

We used two main features of AWS to complete this project:

* Relational Database Service (RDS): This was used to house our database and has the advantage of allowing our database to be scalable.
* EC2 (Elastic Cloud Computing): We used EC2 instances to house the different components of our app, as well as using them as an ansible controller and as our Jenkins machine.
                                 Each instance was spun up with ubuntu on as it is a light-weight operating system, making the infrastructure easily torn down and spun back up.


### Ansible

We used ansible to configure our EC2 instances, ensuring that all the software we need is installed such as Docker, Docker Compose and Jenkins. This allowed us to automate the installation of software and ensure that all our instances have the correct software required to deploy our app.


### Docker and Docker Compose

We used Docker and Docker compose to create containers to house the different parts of our application and allow them to talk to each other. By using Docker we could house the front and back end of the application in different containers but put them on the same network to allow them to communicate with each other without the end user being able to access any containers that they are not given explicit access to.


### Jenkins

Jenkins was deployed on an EC2 instance using Ansible. Within Jenkins, we configured 2 pipelines for Development and Production.

The development pipeline is set up to build every time there is a push to the Dev Branch of this repository using a webhook. It is designed to test the application and allow us to view how any changes we have made to our code will affect the application before pushing the code to the main branch.

![jenkins development image](/images/jenkins-development.PNG)

Once we are satisfied that the new code is running on the development pipeline, we can push the code to main which will trigger a build in the Production Pipeline. This pipeline builds and deploys our application to the live environment.

![jenkins production images](/images/jenkins-production.PNG)


### Acheivements

* Working Jenkins Pipelines- Both our development and production pipelines deploy a working application to the relevant EC2 Instance.
* Automation- We began work on automating as much of the process as possible and feel as though we made good progress considering the time we had available. 
* Terraform- We used terraform to fully build the environment we worked in. We also would feel confident using the terraform to continuall spin up the same enviroment.

### Improvements

* Testing- Fix the errors for the front-end test so that both the back and front end tests could be run in the development pipeline.
* GitHub- Allow for the deployment of the pipeline from a private GitHub repository.
* Ansible- Utilise the roles feature in Ansible to make the code more streamline and easy to follow. This would also help us ensure only the correct pieces of software were being downloaded onto each virtual machine.

### Future prospects

* Use the images that we pushed to Docker Hub to build the application on the production/ deployment Virtual Machines.
* Continue to automate more of the pipeline. Look into using Terraform to configure the database. Use terraform to create Jenkinsfiles/Docker-Compose files filled with the correct information.

### Acknowledgements

We would like to acknowledge the help of our trainers and our fellow trainees for their help during this project. 




