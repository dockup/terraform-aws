# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes master servers. Feel free to replace this as necessary.

### Using the backend
1. Set the token in `~/.terraformrc`, [more here](https://www.terraform.io/docs/enterprise/free/#configure-access-for-the-terraform-cli).
2. Edit values inside `bakend.hcl` to suite your need and workspace settings
3. Configure terrform to use this backend
```bash
$ terraform init -backend-config=backend.hcl
```