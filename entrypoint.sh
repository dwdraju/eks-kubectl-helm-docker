#!/bin/bash
unset AWS_SECRET_ACCESS_KEY
unset AWS_ACCESS_KEY_ID
unset AWS_REGION

aws configure set aws_access_key_id "${K8S_AWS_KEY}"
aws configure set aws_secret_access_key "${K8S_AWS_SECRET}"
aws configure set default.region "${K8S_AWS_REGION}"
aws eks --region "${K8S_AWS_REGION}" update-kubeconfig --name "${K8S_CLUSTER_NAME}"
exec /bin/bash "$@"
