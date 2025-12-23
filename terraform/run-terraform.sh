#!/usr/bin/env bash
set -euo pipefail

# optional: make plugins/cache persist between runs
cd terraform

mkdir -p .terraform.d/plugin-cache


terraform --version

terraform init
terraform state show aws_iam_role.lambda_role >/dev/null 2>&1 || \
terraform import aws_iam_role.lambda_role example_lambda_role


terraform plan
terraform apply -auto-approve