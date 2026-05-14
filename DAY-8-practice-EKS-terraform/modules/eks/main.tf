########################################
# IAM Role for EKS Cluster
########################################
data "aws_ami" "al2023" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}


resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "eks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

########################################
# CloudWatch Log Group
########################################

resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 30
}

########################################
# KMS Key
########################################

########################################
# EKS Cluster
########################################

resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  version = var.cluster_version

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {
    subnet_ids              = var.private_subnet_id
    security_group_ids      = var.security_group_id

    endpoint_private_access = false
    endpoint_public_access  = true

    public_access_cidrs = [ var.public_cidr ]

  }


  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }


  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]

  tags = {
    Environment = var.environment
    owner        = var.owner
    dm           = var.dm
    department   = var.department
    project_name = var.project_name
    end_date     = var.end_date
    bu           = var.bu
  }
}

########################################
# Node IAM Role
########################################

resource "aws_iam_role" "eks_pod_identity_role" {
  name = "eks-pod-identity-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

########################################
# S3 Read Only Policy
########################################

resource "aws_iam_policy" "s3_read_only_policy" {
  name = "eks-pod-s3-read-only-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = [
          "arn:aws:s3:::your-bucket-name"
        ]
      },
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "*"
        ]
      }
    ]
  })
}

########################################
# Secrets Manager Read Policy
########################################

resource "aws_iam_policy" "secrets_manager_read_policy" {
  name = "eks-pod-secretsmanager-read-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.eks_pod_identity_role.name
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}

resource "aws_iam_role_policy_attachment" "secret_attach_policy" {
  role       =  aws_iam_role.eks_pod_identity_role.name
  policy_arn =  aws_iam_policy.secrets_manager_read_policy.arn
}

resource "aws_iam_role" "ekansh_node_role" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "worker_node" {
  role       = aws_iam_role.ekansh_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni" {
  role       = aws_iam_role.ekansh_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.ekansh_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

########################################
# Managed Node Group
########################################

resource "aws_eks_node_group" "EKansh-node-group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-nodegroup"

  node_role_arn = aws_iam_role.ekansh_node_role.arn

  subnet_ids = var.private_subnet_id

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  instance_types = var.instance_type

  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  disk_size = 30

  update_config {
    max_unavailable = 1
  }

  tags = {
    Environment = var.environment
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr
 
  ]
}
########################################
# EKS Pod Identity Association
########################################

resource "aws_eks_pod_identity_association" "pod_identity" {
  cluster_name    = aws_eks_cluster.eks.name
  namespace       = "default"
  service_account = "catalog-mysql-sa"

  role_arn = aws_iam_role.eks_pod_identity_role.arn

  depends_on = [
    aws_eks_cluster.eks
  ]
}


