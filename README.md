# Project 2 devops

## Deploying flask app

### Contents

* Overview
* Technologies
* Jira
* Github
* Aws
* subnet
* Terraform
* Ansible
* Docker
* Jenkins
* what went well
* future additions

### Overview
In this project we have deployed a simple python flask app using a ci pipeline using amazon web services (AWS) 
Using many different technologies we have been able to create a staging environment for developers to see if everything is working in the app before deploying to the production.

### Brief
The application must:

* Be deployed to a Virtual Machine for testing
* Be deployed in a Docker Stack Using compose
* Make use of a managed Database solution

### Technologies

Below is a list of technologies we used to deploy this application
* Jira
* Github
* AWS
* RDS
* EC2
* Terraform
* Ansible
* Jenkins
* Docker

### Jira

We have used jira as our project management software. We chose jira as its an easy to use software that allows us to use scrum methodologies such as creating sprints and user stories.

![jira image](/images/Jira.PNG)
![jira sprint](/images/jira-sprint.PNG)

### Github

We used github as our version control system as we are comfortable with this software and it is easy to incorporate with our jenkins box.


We used a feature branch modal for this project as to ensure that the new features that we were pushing up did not break the project. This is also the modal that needed to be used for our pipeline as the dev branch is what we deployed to our development machine and the main branch is where we deployed the production. With out this modal we would not have been able to create a development and production site for our app.


### Amazon Web Services (AWS)

We used AWS as we needed a reliable low-cost infrastructure that we could confidently deploy our application too. 


### Virtual Private Cloud (VPC)

We have created a vpc that houses our instances in. We have done this so that our front end can be accessed by a user on the internet and our backend in a private subnet so that users can’t access our database directly.



### Relational Database Service (RDS)

We used and RDS for our database this meant that our database is scalable.


### Elastic Compute Cloud (EC2)

We used four ec2 instances all deployed with ubuntu on. We chose ubuntu as this is a light weight operating system that can easily be spun up. This makes our infrastructure easy to be torn down and spun up again with minimal human intervention.


### Terraform

We have used Terraform to configure and deploy all of our ec2 instances and installs ansible on our bastion host. This allows us to run a file to create our instances meaning that we do not fall prey to environment drift within our infrastructure 


### Ansible

We have used ansible to configure our instances ensuring that all the software we need is installed such as Docker, Docker compose and jenkins. This allows us to automate the installation of software and ensure that all our instances have the correct software required to deploy our app.

Image

### Docker
We used docker to create contains to ensure our instances had the correct system environments for our application to run for example we needed to have nginx installed so that nginx can handle all requests before sending them to another server.


### Jenkins

We have created one jenkins instance that has two jenkins pipelines in, these are our development pipeline and our production pipeline. Our development pipeline is where we deploy from our dev branch which allows us to run our test and ensure that the application is running correctly in a live environment. Our production builds and deploys our application to the live environment.

![jenkins development image](/images/jenkins-development.PNG)
![jenkins production images](/images/jenkins-production.PNG)

### What went well what went bad
I feel like our jenkins pipelines were deployed with minimal difficulties.

We tried to deploy the tests but found that we ran out of time and when trying to deploy the app from a private github this was too difficult for the short space of time we had.



### Future prospects

* Push more to docker hub so that we could pull the images down 
* Connect through a private repo in github
* Run pytests on the development instance 



### Conclusion


We have created a small successful infrastructure Ci pipeline that can be used to aid the development of the application.





