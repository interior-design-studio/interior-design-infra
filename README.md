# Interior Design Studio - Infrastructure

## Project Overview

This repository contains Infrastructure as Code (IaC) for deploying the Interior Design Studio application to Azure Kubernetes Service (AKS) using Terraform and Helm.

The setup includes:
- Azure Kubernetes Service (AKS) cluster
- Static Public IP with DNS Label (FQDN)
- Ingress NGINX Controller (via Helm)
- PostgreSQL Database (via Helm)
- Storage Account for Terraform state and application storage


## Project Structure

```
terraform/
├── cluster/          # Terraform code for AKS cluster and network
├── helm/             # Terraform code for Helm releases (Ingress, PostgreSQL)
```

- `terraform/cluster/`: deploys resource group, public IP, storage account, and AKS cluster.
- `terraform/helm/`: installs Helm charts for Ingress NGINX and PostgreSQL.


## Quick Deployment Steps

### 1. Deploy Cluster Infrastructure

```bash
cd terraform/cluster
terraform init
terraform apply
```

### 2. Assign AKS access to Public IP

Use Azure Portal or run the provided Bash script to assign the "Network Contributor" role to the AKS managed identity.

### 3. Verify Cluster and Update Kubeconfig

```bash
az aks get-credentials --resource-group interior-design-studio-dev --name aksname --overwrite-existing
kubectl get nodes
```

### 4. Deploy Helm Releases

```bash
cd ../helm
terraform init
terraform apply
```

### 5. Access the Application

Visit your FQDN address:

```
http://tavrds.uksouth.cloudapp.azure.com
```


## Important Notes

- Static Public IP is pre-created and assigned during AKS cluster provisioning.
- Ingress Controller deployment may initially show `FAILED` status if Azure Load Balancer delays IP assignment; this will self-correct.
- PostgreSQL database is installed internally within the Kubernetes cluster.


## Authors

- Victoria Otrok

---

> For detailed step-by-step deployment instructions, see `INSTRUCTION.md`.

