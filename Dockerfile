# Dockerfile to run terraform. This file creates a docker image and then
# runs terraform apply inside it. This is done as a workaround so that
# we don't run into weird issues from helm like
# https://github.com/helm/helm/issues/2409
#
# docker run -v '/Users/yuva/.aws:/root/.aws' \
#            -v '/Users/yuva/.terraformrc:/root/.terraformrc' \
#            terraform-aws:latest ./docker/run

FROM alpine:3.10

RUN apk add --no-cache libssl1.1 ca-certificates unzip bash

# https://www.terraform.io/downloads.html
RUN wget https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip && \
    unzip terraform_0.12.6_linux_amd64.zip && \
    mv ./terraform /usr/local/bin/terraform


RUN mkdir -p /app
WORKDIR /app
COPY . .
