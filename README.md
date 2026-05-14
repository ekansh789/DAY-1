# README - EKS Pod Identity Association (PIA) Setup

## Tasks Completed

* Updated Terraform configuration to support EKS Pod Identity Association (PIA).
* Created new IAM policies to provide AWS access permissions for Kubernetes Service Accounts.
* Created IAM Role for Pod Identity access.
* Attached required IAM policies for:

  * S3 bucket access
  * AWS Secrets Manager access

---

# Kubernetes Service Account (SA)

* Created Kubernetes Service Account using a YAML manifest.
* Associated the Service Account with the IAM Role using EKS Pod Identity Association.

This allows Pods to securely access AWS services without using static AWS credentials.

---

# Installed Required Components

Installed the following components using Helm charts:

* AWS Secrets Store CSI Driver
* ASCP (AWS Secrets and Configuration Provider)

These components enable Kubernetes Pods to securely fetch secrets directly from AWS Secrets Manager.

---

# Verification Performed

## S3 Access Verification

* Deployed a test Pod using the configured Service Account.
* Verified successful connectivity and read access to the S3 bucket from inside the Pod.
* Confirmed IAM Role and Pod Identity Association were working correctly.

---

# Deployment with ClusterIP Service

* Created and deployed a Kubernetes Deployment using YAML manifests.
* Exposed the application using a ClusterIP Service.
* Verified the Service and connectivity using:

  * `kubectl get svc`
  * `kubectl get endpointslices`

## ClusterIP Service

ClusterIP works like a customer-care number:

* Any available Pod can respond to the request.
* Traffic is load-balanced between available Pods.
* Mainly used for stateless applications.

---

# StatefulSet Deployment

Successfully deployed a StatefulSet using YAML manifests with:

* Headless Service
* ConfigMaps
* Persistent Volume mounting
* Secret volume mounting
* Kubernetes Service Account integration

---

# AWS Secret Integration

* Configured SecretProviderClass for AWS Secrets Manager integration.
* Mounted secrets inside the Pod using CSI volume mounts.
* Used Pod Identity and Service Account for secure AWS authentication.

---

# Pod Identity Association (PIA)

Used EKS Pod Identity to:

* Avoid static AWS credentials
* Securely grant AWS access to Kubernetes workloads
* Simplify IAM integration with EKS

---

# Technologies Used

* Terraform
* AWS EKS
* IAM Roles and Policies
* Kubernetes Deployment
* Kubernetes StatefulSet
* ClusterIP Services
* Headless Services
* ConfigMaps
* AWS Secrets Manager
* CSI Driver
* ASCP
* Helm Charts
