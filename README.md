# README.md

## Interior Design Studio Infrastructure

This repository contains the infrastructure-as-code setup for deploying the Interior Design Studio web application using **Terraform**, **Azure Kubernetes Service (AKS)**, and **Helm**. It manages both backend (Django), frontend (SPA), and TLS certificate provisioning with Let's Encrypt.

---

## ⚙️ Technologies Used

* **Azure AKS** — managed Kubernetes cluster
* **Terraform** — infrastructure provisioning
* **Helm** — templated application deployment
* **NGINX Ingress Controller** — traffic routing
* **cert-manager** — TLS certificate automation
* **Let's Encrypt** — ACME certificate authority
* **GitHub Actions** — CI/CD pipelines

---

## 📂 Repository Structure

```
terraform/
  cluster/                 # AKS + networking modules
  helm/
    django/               # backend Helm chart
    frontend/             # frontend Helm chart
    tls/                  # Ingress + cert-manager + Certificate
    dummy/                # dummy service for ACME HTTP challenge
```

---

## 🔒 TLS / HTTPS Configuration

TLS is handled via **cert-manager** and Let's Encrypt with an automated `ClusterIssuer` and `Certificate`:

* `tls-ingress` chart provisions an Ingress for the ACME HTTP-01 challenge.
* A `dummy` service is deployed to respond to challenge requests.
* All main Ingress objects (frontend, backend) use a single `tls-frontend` secret.

---

## 🚀 CI/CD: Frontend Pipeline

The frontend application is automatically built and deployed using GitHub Actions:

* On push to `develop` in `app/frontend/`:

  * Docker image is built using `Dockerfile`
  * Image is pushed to DockerHub with `GITHUB_SHA` as tag
  * PR is created in a **forked infra repo** (`interior-design-infra-*`)

    * The PR updates `values.yaml` in the frontend Helm chart with the new image tag

---

## 🔧 Deployment Instructions

1. Provision infrastructure:

   ```bash
   terraform -chdir=terraform/cluster init
   terraform -chdir=terraform/cluster apply
   ```

2. Deploy Helm charts:

   ```bash
   terraform -chdir=terraform/helm apply
   ```

---

## 🌐 Ingress Domain

The application is served over HTTPS using the domain:

```
tavrds-7177.uksouth.cloudapp.azure.com
```

---

## 🎓 Authors

* Infrastructure: [Viktoria Otrok](https://github.com/88victory88)
* Based on Azure AKS + Terraform architecture best practices
