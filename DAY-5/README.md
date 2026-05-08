

## Overview

This project creates a production-grade Amazon EKS cluster using Terraform modular architecture.

The setup includes:

- Existing VPC integration using Terraform data sources
- Dedicated reusable EKS module
- Dedicated reusable Security Group module
- Managed Node Groups
- IAM Roles and Policies
- CloudWatch logging
- KMS encryption for Kubernetes secrets
- Restricted public API access using allowed CIDRs
- Production-ready modular Terraform structure

---

# Architecture

```text
Existing VPC
    ↓
Terraform Data Source
    ↓
Security Group Module
    ↓
EKS Module
    ↓
Managed Node Group
    ↓
Worker Nodes Join Cluster
```
# Modules Used
## 3. EKS Module

Responsible for:

- EKS Cluster
- IAM Roles
- IAM Policies
- Node Groups
- CloudWatch Logs
- KMS Encryption
- EKS Networking

---

# Root Module Integration done in root module 

# Why Security Group Uses List(String)

AWS EKS expects:

```hcl
security_group_ids = ["sg-123456"]
```

Even if only one Security Group is used.

Terraform variable type:

```hcl
variable "security_group_id" {
  type = list(string)
}
```

---

# Why Subnet IDs Use List(String)

EKS requires multiple subnet IDs.

Example:

```hcl
subnet_ids = [
  "subnet-public",
  "subnet-private"
]
```

Terraform variable:

```hcl
variable "private_subnet_id" {
  type = list(string)
}
```

---

# Restrict Public API Access

The Kubernetes API endpoint is restricted to a specific public IP.

Example:

```hcl
public_access_cidrs = [
  "49.xx.xx.xx/32"
]
```

This ensures:

- Only your laptop/office IP can access kubectl
- Public internet access is blocked

---

# Current Learning Setup

Current setup:

```text
1 Public Subnet
1 Private Subnet
```

This works only if:

- Both are in different Availability Zones

Otherwise EKS cluster creation fails.

---


