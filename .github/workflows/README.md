<h1 align="center">GitHub Actions</h1>
<h6 align="center">This README will describe all GitHub Actions< workflows on My Project</h6>

<p align="center"><img width="250px" src="./diagrams_&_pictures/github_ations_pic.png"></p>

## Application diagram
![app_diagram](diagrams_&_pictures/ops_school-jenkins_app_diagram.png)

Jenkins Link : https://jenkins.kandula.click/

## Table of Contents

- [Jenkins Terraform Deployment](#Jenkins-Terraform-Deployment)
- [Jenkins Ansible Playbooks](#Jenkins-Ansible-Playbooks)
- [Jenkins Kubernetes Deployment](#Jenkins-Kubernetes-Deployment)
- [Jenkins Docker Images](#Jenkins-Docker-Images)
- [Jenkins plugins](#Jenkins-plugins)

## Jenkins Terraform Deployment

![app_diagram](diagrams_&_pictures/jenkins_terraform_jobs.png)

This view aggregate all terraform jenkins jobs

![Pipeline example](diagrams_&_pictures/jenkins_terrafrom_bastion.png)

![Pipeline parameters example](diagrams_&_pictures/terraform_parms.png)

**Job Name: Terraform-Build-Kandula-Env:** <br />
The job will create All Env (will trigger all below jobs with the right logic)
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_build_kandula_env.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/Terraform-Build-Kandula-Env/)


**Job Name: terraform-bastion-server:** <br />
The job will create Bastion instance, this instance is exposed to the internet & will function as VPN server
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_bastion_server.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-bastion-server)


**Job Name: terraform-ebs_jenkins:** <br />
The job will create EBS Storage for Jenkins server to store all Jenkins Data & configs.
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_ebs_jenkins.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-ebs_jenkins/)

**Job Name: terraform-eks:** <br />
The job will create EKS Cluster.
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_eks.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-ebs_jenkins/)


**Job Name: terraform-jenkins:** <br />
The job will create Jenkins Server & Jenkins Slave ready to use.
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_jenkins.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-jenkins/)

**Job Name: terraform-postgres:** <br />
The job will create postgres DB on AWS RDS
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_postgres.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-postgres/)

**Job Name: terraform-s3-buckets:** <br />
The job will create S3 bucket for loging
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_s3_bucket.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-s3-buckets/)

**Job Name: terraform-servers:** <br />
The job will create instances for Elasticsearch, Consul and Prometheus
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_servers.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-servers/)

**Job Name: terraform-vpc:** <br />
The job will create VPC & private zone on Route53
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkis_terraform_deployments/jenkins_terraform_vpc.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Terraform_Deployment/job/terraform-vpc/)

## Jenkins Ansible Playbooks

![app_diagram](diagrams_&_pictures/jenkins_ansible_jobs.png)

**Job Name: ansible-playbook-all-apps:** <br />
The job will provision all the EC2 Instances that we created via terraform
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/jenkins_ansible_build_kandula.groovy)
+ [ansible role location](/ansible/roles)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-all-apps/)

**Job Name: ansible-playbook-consul-agent:** <br />
The job will install consul agent on relevant instances
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/consul_agent_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/consul_agent)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-consul-agent/)

**Job Name: ansible-playbook-consul-registrator:** <br />
The job will install consul registrator on all servers that have docker engine
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/consul_registrator_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/consul_registrator)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-consul-registrator/)

**Job Name: ansible-playbook-consul-server:** <br />
The job will install consul server (cluster of 3 servers)
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/consul_server_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/consul)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-consul-server/)

**Job Name: ansible-playbook-elasticsearch:** <br />
The job will install Elasticsearch & Kibana
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/elasticsearch_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/elasticsearch)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-elasticsearch/)

**Job Name: ansible-playbook-filebeat-server:** <br />
The job will install filebeat
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/filebeat_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/filebeat)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-filebeat-server/)

**Job Name: ansible-playbook-logstahs-agent:** <br />
The job will install logstash
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/logstash_agent_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/logstash)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-logstahs-agent/)

**Job Name: ansible-playbook-node-exporter:** <br />
The job will install Node Exporter
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/node_exporter_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/node_exporter)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-node-exporter/)

**Job Name: ansible-playbook-prometheus:** <br />
The job will install prometheus
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_ansible_playbooks/prometheus_ansible_playbook.groovy)
+ [ansible role location](/ansible/roles/prometheus)
+ [jenkins job link](https://jenkins.kandula.click/view/Ansible-Playbooks/job/ansible-playbook-prometheus/)

## Jenkins Kubernetes Deployment

![app_diagram](diagrams_&_pictures/jenkins_k8s_jobs.png)

![Pipeline parameters example](diagrams_&_pictures/jenkins_k8s_params.png)

**Job Name: Kandula-Deployment-All-EKS:** <br />
The job will deploy all components on EKS cluter (will trigger all below jobs)
+ [jenkins file location](/Jenkins/jenkins_jobs/kubernetes_deployment/jenkins_kube_all_deployment.groovy)
+ [kube Deployment file or helm](/Jenkins/jenkins_jobs/kubernetes_deployment)
+ [jenkins job link](https://jenkins.kandula.click/view/Kubernetes_Deployment/job/Kandula-Deployment-All-EKS/)

**Job Name: Kandula-Application-Deployment:** <br />
The job will deploy kandula application on EKS cluster
+ [jenkins file location](/Jenkins/jenkins_jobs/kubernetes_deployment/jenkinsfile_kandula_deployment.groovy)
+ [ansible role location](/Jenkins/jenkins_jobs/kubernetes_deployment/kalandula_app.yaml)
+ [jenkins job link](https://jenkins.kandula.click/view/Kubernetes_Deployment/job/Kandula-Application-Deployment/)

**Job Name: Kandula-Consul-Helm-Deployment:** <br />
The job will deploy consul via helm chart on EKS Cluster
+ [jenkins file location](/Jenkins/jenkins_jobs/kubernetes_deployment/jenkinsfile_kube_consul_helm.groovy)
+ [ansible role location](/helm-releases/consul)
+ [jenkins job link](https://jenkins.kandula.click/view/Kubernetes_Deployment/job/Kandula-Consul-Helm-Deployment/)

**Job Name: Kandula-Filebeat-Deployment:** <br />
The job will deploy filebeat on EKS Cluster
+ [jenkins file location](/Jenkins/jenkins_jobs/kubernetes_deployment/jenkinsfile_kube_filebeat_deployment.groovy)
+ [ansible role location](/Jenkins/jenkins_jobs/kubernetes_deployment/filebeat-k8s-config.yaml)
+ [jenkins job link](https://jenkins.kandula.click/view/Kubernetes_Deployment/job/Kandula-Filebeat-Deployment/)

**Job Name: Kandula-Prometheus-Stack-Deployment:** <br />
The job will deploy Prometheus, Alertmanager, Node exporter, Grafana via helm chart on EKS Cluster
+ [jenkins file location](/Jenkins/jenkins_jobs/kubernetes_deployment/jenkinsfile_kube_prometheus_stack.groovy)
+ [ansible role location](/helm-releases/kube-prometheus-stack)
+ [jenkins job link](https://jenkins.kandula.click/view/Kubernetes_Deployment/job/Kandula-Prometheus-Stack-Deployment/)

## Jenkins Docker Images

![app_diagram](diagrams_&_pictures/jenkins_docker_jobs.png)

**Job Name: Jenkins-Slave-Docker-clean :** <br />
The job will clean jenkins server host from old docker images & continers that are not working(prune)
Job have Scheduler that will run this job at midnight
+ [jenkins file location](/Jenkins/jenkins_jobs/docker-cleanup/docker_cleanup.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Docker-Images/job/Jenkins-Slave-Docker-clean/)

**Job Name: Jenkins-Slave-Docker-Image-Creation :** <br />
The job will create jenkins slave docker image
+ [jenkins file location](/Jenkins/jenkins_jobs/jenkins_slave_images/create-update-image.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Docker-Images/job/Jenkins-Slave-Docker-Image-Creation/)

![app_diagram](diagrams_&_pictures/jenkins_docker_imge.png)


![app_params](diagrams_&_pictures/jenkins_docker_oarams.png)

**Job Name: Kandula-Docker-Image-Creation :** <br />
The job will create Kandula App docker image
+ [jenkins file location](https://github.com/eranmos/ops-school-kandula-project-app/blob/master/jenkins_kandula_create_image.groovy)
+ [jenkins job link](https://jenkins.kandula.click/view/Docker-Images/job/Kandula-Docker-Image-Creation/)



## Jenkins Plugins