resource "aws_security_group" "security_group" {
  vpc_id = var.vpc_id
  name   = "${var.prefix}-security-group"
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_iam_role" "cluster_role" {
  name = "${var.prefix}-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSVPCResourceController" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_cloudwatch_log_group" "cluster_log_group" {
  retention_in_days = var.cluster_log_retention_days
  name              = "/aws/eks/${var.cluster_name}/cluster"
}

resource "aws_eks_cluster" "cluster" {
  name                      = "${var.prefix}-${var.cluster_name}"
  role_arn                  = aws_iam_role.cluster_role.arn
  enabled_cluster_log_types = ["api", "audit"]
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.security_group.id]
  }
  depends_on = [
    aws_cloudwatch_log_group.cluster_log_group,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}

resource "aws_iam_role" "nodes" {
  name = "${var.prefix}-${var.cluster_name}-role-node"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nodes_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "node-1" {
  node_role_arn   = aws_iam_role.nodes.arn
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.prefix}-${var.cluster_name}-node-1"
  subnet_ids      = var.subnet_ids

  scaling_config {
    max_size     = var.max_size
    min_size     = var.min_size
    desired_size = var.desired_size
  }

  instance_types = ["t3.micro"]
  capacity_type  = "SPOT"

  depends_on = [
    aws_iam_role_policy_attachment.nodes_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes_AmazonEC2ContainerRegistryReadOnly
  ]
}

resource "aws_eks_node_group" "node-2" {
  node_role_arn   = aws_iam_role.nodes.arn
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.prefix}-${var.cluster_name}-node-2"
  subnet_ids      = var.subnet_ids

  scaling_config {
    max_size     = var.max_size
    min_size     = var.min_size
    desired_size = var.desired_size
  }

  instance_types = ["t3.micro"]
  capacity_type  = "SPOT"

  depends_on = [
    aws_iam_role_policy_attachment.nodes_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes_AmazonEC2ContainerRegistryReadOnly
  ]
}
