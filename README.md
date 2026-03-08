# Architecture Overview

This project implements a **complete end-to-end DevOps pipeline for a microservices platform deployed on AWS using Kubernetes (EKS)**.

The system automates the entire lifecycle:

```
Code Commit → CI/CD Pipeline → Docker Build → Push to ECR → Kubernetes Deployment → ALB Ingress → Public Access
```

Multiple microservices run independently inside an **Amazon EKS cluster** and are exposed through a **single Application Load Balancer (ALB)** using Kubernetes Ingress routing.

---

# System Architecture

```
Internet
   │
   ▼
AWS Application Load Balancer (ALB)
   │
   ▼
Kubernetes Ingress (AWS Load Balancer Controller)
   │
   ├── /                → client-service (Frontend)
   ├── /meeting        → meeting-service
   ├── /analytics      → analytics-service
   ├── /blog           → blog-service
   ├── /polls          → polls-service
   ├── /sessions       → sessions-service
   ├── /notification   → notification-service
   ├── /aahar          → aahar-service
   └── /ums            → ums-service
                        │
                        ▼
                Kubernetes Pods
                        │
                        ▼
                 Amazon EKS Cluster
```

All services are containerized using **Docker** and deployed inside **Kubernetes pods**.

---

# CI/CD Architecture

The platform uses **Jenkins pipelines** for continuous integration and deployment.

Two pipeline layers are implemented:

1. **Orchestration Pipeline**
2. **Individual Microservice Pipelines**

---

## Jenkins Orchestration Pipeline

The orchestration pipeline detects which services changed and triggers only those pipelines.

```
Developer
   │
   ▼
GitHub Repository
   │
   ▼
Jenkins Orchestration Pipeline
   │
   ▼
Detect Changed Files
   │
   ├── services/aahar        → trigger pipeline-aahar
   ├── services/blog         → trigger pipeline-blog
   ├── services/analytics    → trigger pipeline-analytics
   ├── services/polls        → trigger pipeline-polls
   ├── services/sessions     → trigger pipeline-sessions
   ├── services/notification → trigger pipeline-notification
   ├── services/meeting      → trigger pipeline-meeting
   └── services/ums          → trigger pipeline-ums
```

This avoids rebuilding every service unnecessarily.

Change detection is implemented using:

```
git diff --name-only HEAD~1 HEAD
```

---

## Microservice Pipeline Flow

Each service has its own Jenkins pipeline.

```
GitHub Commit
     │
     ▼
Jenkins Pipeline
     │
     ▼
Docker Build
     │
     ▼
Tag Image
     │
     ▼
Push Image → AWS ECR
     │
     ▼
Update Kubernetes Deployment
     │
     ▼
Rolling Update in EKS
```

This ensures **zero-downtime deployments**.

---

# AWS VPC Architecture

The infrastructure is provisioned using **Terraform modules**.

The VPC architecture follows AWS best practices with **public and private subnets**.

```
                         Internet
                            │
                            ▼
                      Internet Gateway
                            │
                            ▼
                    Public Subnets (AZ-1 / AZ-2)
                            │
                            │
                    AWS Load Balancer (ALB)
                            │
                            ▼
                     Private Subnets
                   (EKS Worker Nodes)
                            │
                            ▼
                     Kubernetes Pods
                            │
                            ▼
                     Microservices
```

---

# Detailed Network Architecture

```
                    +-----------------------+
                    |        Internet       |
                    +----------+------------+
                               |
                               v
                      +--------+--------+
                      |   Internet GW   |
                      +--------+--------+
                               |
               +---------------+---------------+
               |                               |
               v                               v
       +--------------+                +--------------+
       | Public Subnet|                | Public Subnet|
       |   AZ-1       |                |   AZ-2       |
       +------+-------+                +------+-------+
              |                               |
              v                               v
         +-------------------------------------------+
         |       AWS Application Load Balancer       |
         +------------------+------------------------+
                            |
                            v
               +------------------------------+
               |      Private Subnets         |
               |        (EKS Nodes)           |
               +---------------+--------------+
                               |
                               v
                       +---------------+
                       |   EKS Cluster |
                       +---------------+
                               |
                               v
                        Kubernetes Pods
                               |
                               v
                        Microservices
```

Worker nodes run inside **private subnets** for improved security.

---

# Container Architecture

Each service is packaged as a Docker container.

Example services:

| Service      | Description                |
| ------------ | -------------------------- |
| client       | Frontend React application |
| meeting      | Meeting management         |
| analytics    | Analytics processing       |
| blog         | Blog platform              |
| polls        | Poll management            |
| sessions     | Session service            |
| notification | Notification engine        |
| aahar        | Food ordering service      |
| ums          | User Management Service    |

Each service runs inside its own **Kubernetes Deployment**.

---

# Container Registry

Docker images are stored in **AWS Elastic Container Registry (ECR)**.

Example repositories:

```
aahar
blog
analytics
meeting
polls
sessions
notification
ums
client
```

Images are tagged using Jenkins build numbers.

Example:

```
blog:5
meeting:8
analytics:12
```

---

# Kubernetes Deployment Architecture

```
Docker Images (ECR)
        │
        ▼
Kubernetes Deployment
        │
        ▼
ReplicaSets
        │
        ▼
Pods
        │
        ▼
ClusterIP Services
        │
        ▼
Ingress
        │
        ▼
AWS Application Load Balancer
```

Kubernetes automatically performs **rolling updates** during deployments.

---

# Application Routing

All services are accessible through the **ALB DNS endpoint**.

Example:

```
http://<ALB-DNS>/
http://<ALB-DNS>/meeting
http://<ALB-DNS>/analytics
http://<ALB-DNS>/blog
http://<ALB-DNS>/polls
http://<ALB-DNS>/sessions
http://<ALB-DNS>/notification
http://<ALB-DNS>/aahar
http://<ALB-DNS>/ums
```

The root path `/` serves the **client frontend application**.

---

# Health Check Mechanism

Each service exposes a health endpoint:

```
GET /health
```

Example response:

```
OK
```

The AWS ALB uses this endpoint to verify that pods are healthy before routing traffic.

Ingress configuration:

```
alb.ingress.kubernetes.io/healthcheck-path: /health
```

---

# Key DevOps Practices Implemented

This project demonstrates several production-grade DevOps practices:

* Infrastructure as Code using Terraform
* Microservices architecture
* Docker containerization
* Kubernetes orchestration
* CI/CD automation with Jenkins
* Container registry using AWS ECR
* Ingress-based routing
* Rolling deployments
* Health monitoring
* Cloud-native deployment architecture

---

# End-to-End Deployment Flow

```
Developer commits code
        │
        ▼
GitHub repository updated
        │
        ▼
Jenkins orchestration pipeline detects changes
        │
        ▼
Relevant microservice pipelines triggered
        │
        ▼
Docker images built and pushed to ECR
        │
        ▼
Kubernetes deployments updated
        │
        ▼
Pods updated with rolling deployment
        │
        ▼
AWS ALB exposes services to the internet
```

---
