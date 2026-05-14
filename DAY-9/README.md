# Overview

* Added new IAM policies in Terraform for EBS read/write access and attached them to the IAM Role integrated with EKS Pod Identity Association (PIA).
* Added the EBS CSI Driver as an EKS add-on.
* Created Kubernetes Deployment and StatefulSet resources to verify CSI functionality.
* Created Kubernetes Service Accounts and configured Pod Identity for secure AWS authentication.
* Created StorageClass YAML for dynamic EBS volume provisioning.
* Configured SecretProviderClass YAML to fetch secrets securely from Amazon Web Services AWS Secrets Manager.
* Integrated secrets with Deployment and StatefulSet workloads.
* Successfully verified:

  * Dynamic EBS volume provisioning
  * PVC binding
  * Secret mounting
  * AWS authentication through PIA
  * S3 access from Pods
* Added a Terraform module to provision an Amazon RDS MySQL database for external service testing.

## PVC and CSI Flow

* PVC uses the configured StorageClass.
* StorageClass communicates with the EBS CSI Controller.
* EBS CSI Controller uses:

  * Service Account
  * Pod Identity Association (PIA)
  * IAM Role permissions
* AWS dynamically provisions and attaches the EBS volume to the Pod.

## Secret Management Flow

* SecretProviderClass fetches secrets from AWS Secrets Manager.
* Authentication is handled using:

  * Service Account
  * Pod Identity Association (PIA)
  * IAM Role
* Secrets are securely mounted inside the container.
