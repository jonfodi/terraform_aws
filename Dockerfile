FROM hashicorp/terraform:1.6.6

# Tools Terraform AWS provider often needs for HTTPS + debugging
RUN apk add --no-cache bash ca-certificates curl jq openssl

WORKDIR /work

# Nice defaults
ENV TF_IN_AUTOMATION=1

COPY . .

RUN chmod +x /work/terraform/run-terraform.sh

ENTRYPOINT ["/work/terraform/run-terraform.sh"]