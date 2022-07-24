<h1 align="center">Clearpoint SRE Assessment</h1>
<h6 align="center">This Repo will aggregate my assessment</h6>

<p align="center"><img width="250px" src="./diagrams_&_pictures/clearpoint_logo_1.jpeg"></p>

## Table of Contents

- [Infrastructure Architecture Diagram](#Infrastructure-Architecture-Diagram)
- [Application Diagram](#Application-Diagram)
- [EKS Diagram](#EKS-Diagram)
- [IP Address Allocation](/network_address_design/network_adresses_design.md)
- [Deployment Process](#Deployment-Process)
- [Prerequisites](#prerequisites)
- [Deployment Instructions](#Deployment-Instructions)
- [Application Connections](#Application-Connections)
- [Application URLS](#Application-URLS)
- [Vulnerability Check](#Vulnerability-Check)
- [Monitoring](#Monitoring)
- [Kandula](#Kandula)
- [Links to dockerhub related images](#Links-to-dockerhub-related-images)
- [Links to GitHub related repository](#Links-to-GitHub-related-repository)
- [Improvement Points For The Future](#Improvement-points-for-the-future)


## Infrastructure Architecture Diagram
![architecture_diagram](diagrams_&_pictures/ops_school_project_architecture_diagram.png)

## Application Diagram
![app_diagram](diagrams_&_pictures/ops_school-project_app_diagram.png)

## EKS Diagram
![app_diagram](diagrams_&_pictures/kandula_eks_diagram.png)

## Deployment Process
+ Infrastructure deployment via Terraform & Jenkins
+ EC2 instances provisioning via Jenkins jobs that will run Ansible Playbooks)
+ EKS deployments via Jenkins Jobs

## Prerequisites
To deploy all infrastructure you will need below application to be installed on your workstation/server
+ Install [GIT](https://github.com/git-guides/install-git) on your workstation/server
+ Install [Terraform v1.1.2](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server
+ Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) on your workstation/server
+ Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your workstation/server

## Deployment Instructions
Infrastructure deployment will be performed via Terraform locally & Jenkins.
1. Terraform deployment is divided into eight parts.
   Run the following on each terraform_XXX folder (Jenkins job can run only after Jenkins deployment)
   ```bash
   terraform init
   terraform apply --auto-approve
   ```

+ [Terraform-s3](/terraform/terraform_s3_bucket) - Creating S3 Buckets
+ [Terraform-EBS](/terraform/terraform_ebs_jenkins) - Creating EBS Storage
+ [Terraform-VPC](/terraform/terraform_vpc) - Creating VPC
+ [Terraform-Jenkins](/terraform/terraform_jenkins) - Creating Jenkins Master & Jenkins Slave
+ [Terraform-Servers](/terraform/terraform_servers) - Creating Consul cluster, Elasticsearch, Prometheus without application (application will be installed via ansible playbook)
+ [Terraform-EKS](/terraform/terraform_eks) - Creating Kubernetes cluster
+ [Terraform-RDS](/terraform/terraform_postgres) - Creating Postgres DB on AWS RDS
+ [Terraform Bastion Server](/terraform/terraform_bastion_server) - Creating Bastion server for debugging & maintenance
> note: Bastion server - In order to avoid security issues we're recommending to destroy the machine or turn it off when not needed

After deploying Jenkins Servers (Master & Slave) you can run rest of the deployments via Jenkins Job:
Jenkins UI : https://jenkins.kandula.click/
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_build_kandula_env.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform%20Deployment/job/Terraform-Build-Kandula-Env/)


2. After deploying the infrastructure via Terraform & Jenkins we will need to provision our EC2 instances with below app:
+ Consul Cluster (3 servers)
+ Consul Agent
+ Consul Registrator
+ Elasticsearch
+ Kibana
+ Logstash
+ Filebeat
+ Prometheus
+ Node Exporter

All Ansible playbooks will be run via jenkins job (Ansible installed on the Jenkins-slave docker image).

+ please run Jenkins job:
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/jenkins_ansible_build_kandula.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-all-apps/)


4. Deploying below applications on EKS cluster:
+ Kandula-Prometheus-Stack
+ Kandula App
+ Filebeat
  All EKS deployments will be run via Jenkins Job
    + please run Jenkins Job:
    + [jenkins file location](Jenkins/jenkins_jobs/kubernetes_deployment/jenkins_kube_all_deployment.groovy)
    + [jenkins job link](https://jenkins.kandula.click/view/Kubernetes%20Deployment/job/Kandula-Deployment-All-EKS/)

#### [Click here get all info about my jenkins jobs and configurations](Jenkins/README.md)

## Application Connections

### Jenkins Master:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Jenkins to outside | Jenkins_Master | * | * | * | * |
| Jenkins_UI | * | *  | Jenkins_Master | 443 | TCP |
| Jenkins_UI | * | * | Jenkins_Master |  80 | TCP |
| Jenkins_UI | * | * | Jenkins_Master | 8080  | TCP |
| Docker_API | * | * | Jenkins_Master | 4243 | TCP |
| Docker_Hostport | * | * | Jenkins_Master | 32768-60999 | TCP |
| Node_Exporter | * | * | Jenkins_Master  | 9100 | TCP |
| Consul | * | * | Jenkins_Master |  8301 | TCP,UDP |
| Consul | * | * | Jenkins_Master |  8302 | TCP,UDP |
| Consul | * | * | Jenkins_Master |  8300 | TCP |
| SSH | * | * | Jenkins_Master | 22 | TCP |

### Jenkins Slave:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Jenkins to outside | Jenkins_Slave | * | * | * | * |
| Docker_API | * | * | Jenkins_Slave | 4243 | TCP |
| Docker_Hostport | * | * | Jenkins_Slave | 32768-60999 | TCP |
| Node_Exporter | * | * | Jenkins_Slave  | 9100 | TCP |
| Consul | * | * | Jenkins_Slave |  8301 | TCP,UDP |
| Consul | * | * | Jenkins_Slave |  8302 | TCP,UDP |
| Consul | * | * | Jenkins_Slave |  8300 | TCP |
| SSH | * | * | Jenkins_Slave | 22 | TCP |

### Consul Server:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Consul to outside | Consul | * | * | * | * |
| Consul UI | * | * | Consul | 443 | TCP |
| Consul UI | * | * | Consul | 80 | TCP |
| Consul DNS Interface  | * | * | Consul | 8600 | TCP |
| Consul API | * | * | Consul  | 8500 | TCP |
| Consul LAN Serf | * | * | Consul |  8301 | TCP,UDP |
| Consul Wan Serf | * | * | Consul |  8302 | TCP,UDP |
| Consul RPC | * | * | Consul |  8300 | TCP |
| Node_Exporter | * | * | Consul | 9100 | TCP |
| SSH | * | * | Consul | 22 | TCP |

### Elasticsearch & Kibana:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| ElasticSearch to outside | ElasticSearch | * | * | * | * |
| ElasticSearch_API | * | * | ElasticSearch | 9200 | TCP |
| ElasticSearch_API | * | * | ElasticSearch | 9300 | TCP |
| Kibana UI | * | * | ElasticSearch | 5601 | TCP |
| Node_Exporter | * | * | ElasticSearch  | 9100 | TCP |
| Consul | * | * | ElasticSearch |  8301 | TCP,UDP |
| Consul | * | * | ElasticSearch |  8302 | TCP,UDP |
| Consul | * | * | ElasticSearch |  8300 | TCP |
| SSH | * | * | ElasticSearch | 22 | TCP |

### Prometheus:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| Prometheus to outside | Prometheus | * | * | * | * |
| Prometheus | * | * | Prometheus | 9090 | TCP |
| Alert_Manager | * | * | Prometheus | 9093 | TCP |
| Node_Exporter | * | * | Prometheus  | 9100 | TCP |
| Consul | * | * | Prometheus |  8301 | TCP,UDP |
| Consul | * | * | Prometheus |  8302 | TCP,UDP |
| Consul | * | * | Prometheus |  8300 | TCP |
| SSH | * | * | Prometheus | 22 | TCP |

### PostgreSQL:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| PostgreSQL to outside | PostgreSQL | * | * | * | * |
| PostgreSQL DB | * | * | PostgreSQL | 5432 | TCP |

### EKS Nodes:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| EKS_Nodes to outside | EKS_Nodes | * | * | * | * |
| Consul UI | * | * | EKS_Nodes | 443 | TCP |
| Consul API | * | * | EKS_Nodes  | 8500 | TCP |
| Consul LAN Serf | * | * | EKS_Nodes |  8301 | TCP,UDP |
| Consul Wan Serf | * | * | EKS_Nodes |  8302 | TCP,UDP |
| Consul RPC | * | * | EKS_Nodes |  8300 | TCP |
| SSH | * | * | EKS_Nodes | 22 | TCP |

### Bastion:
| Description | Source | Source Port | Destination  | Destination Port | Protocol |
| ----------- | ------ | ----------- | ------------ | -----------------| -------- |
| bastion to outside | bastion | * | * | * | * |
| OPEN_VPN | * | *  | bastion | 1194 | TCP,UDP |
| SSH | * | * | bastion | 22 | TCP |

## Application URLS
To access applications I created two AWS hostedzones:
1. Internal communication
   ![route53 private](diagrams_&_pictures/route53_private.png)

2. External communication
   ![route53 public](diagrams_&_pictures/router53_public.png)
>note: records on route53 created via terraform deployment

Public URLs to access my apps: <br />
- [Kandula](https://app.kandula.click/) - Kandula web application
- [Consul](https://consul.kandula.click/) - Consul UI
- [Elasticsearch](https://es.kandula.click/) - DB to store logs
- [Kibana](https://kibana.kandula.click/) - Kibana data visualization
- [Prometheus EKS](https://prometheus.kandula.click/) -  Prometheus that monitoring EKS Cluster
- [Prometheus EC2](https://prometheus-ec2.kandula.click/) - Prometheus that monitoring EC2 instances that not related to EKS
- [Grafana](https://grafana.kandula.click/) - Grafana visualization (working with both Prometheus servers)
- [Kibana](https://jenkins.kandula.click/) - Jenkins UI

## Vulnerability Check
In my Project I am using two vulnerability tools:
+ Trivy
+ Snyk

### Docker image Vulnerability Check via Trivy
I integrated Trivy in my Jenkins pipeline.
When jenkins will create a docker trivy will scan it & will provide output report
with vulnerability issues that he discovered

#### Jenkins - Docker image creation pipeline with Trivy:
![architecture_diagram](diagrams_&_pictures/jenkins_trivy_build.png)


#### Trivy report on jenkins pipeline:
![architecture_diagram](diagrams_&_pictures/jenkins_trivy_report.png)

### Code scan vulnerability Check via Trivy & Snyk
For the code scan I used two tools Trivy & Snyk.
I integrated Trivy with my github & created workflow to scan my code when pull request created
and will failed the build when discovered critical issues.

![architecture_diagram](diagrams_&_pictures/trivy_github_1.png)

As I wanted to discover more tools I started to use Snyk & Integrated it with my GitHub as well:

![architecture_diagram](diagrams_&_pictures/snyk.png)

## Monitoring
![monitroing_diagram](diagrams_&_pictures/ops_school-project_monitoring_diagram.png)

My monitoring sulition is devided for two parts :
1. Metric monitoring
   I am using below components for metric monitoring
+ Prometheus
+ Grafana
+ Node Exporter

#### Grafana NodeExporter dashboards for EC2 Instance
![grafana_ec2_diagram](diagrams_&_pictures/grafana_ec2.png)

#### Grafana
![grafana_eks_diagram2](diagrams_&_pictures/grafana_node_eks.png)

#### Grafana
![grafana_eks_diagram3](diagrams_&_pictures/grafana_k8s_ns.png)

2. Loging Monitoring
   I am using below components for metric monitoring
+ Elasticsearch
+ Kibana
+ Logstash
+ Filebeat

#### Kibana ALB dashboards
![kibana_LB_diagram](diagrams_&_pictures/kibana_alb.png)

#### EKS dashboards
![kibana_APP_diagram](diagrams_&_pictures/kibana_eks.png)

#### Kandula
##### Kandula web site
![kibana_APP_diagram](diagrams_&_pictures/kandula_app.png)

![kibana_APP_diagram](diagrams_&_pictures/kandula_app1.png)

### Links to dockerhub related images
- [Kandula](https://hub.docker.com/repository/docker/erandocker/ops-school-kandula) - docker pull erandocker/ops-school-kandula:tagname
- [Jenkins Slave Ubuntu-18.04](https://hub.docker.com/repository/docker/erandocker/jenkins-slave-ubuntu-18.4) - docker pull erandocker/jenkins-slave-ubuntu-18.4:tagname
- [Jenkins Slave Centos-7](https://hub.docker.com/repository/docker/erandocker/jenkins-slave-docker-centos-7) - docker pull erandocker/jenkins-slave-docker-centos-7:tagname

### Links to GitHub related repository
- [Terrafom VPC module](https://github.com/eranmos/ops-school-terraform-aws-vpc.git) - Terraform VPC module for AWS VPC, Subnets, Routing, NAT Gateway creation
- [Kandula Application](https://github.com/eranmos/ops-school-kandula-project-app.git) - Code for Kandule Application

### Improvement Points For The Future
+ Creating helm chart for kandula app & filebeat.
+ Improving my Grafana & Kibana dashboards.
+ Supporting the DB connection to application.
+ Adding more logs to Kandula application.
+ Creating Alertmanager & integrate it with slack to send msg for Critical issues.
+ using [Jenkins Fleet Plugin](https://plugins.jenkins.io/ec2-fleet/) to deploy Jenkins Slaves

