#!/usr/bin/env bash

aws iam create-role \
    --role-name AWS-CodePipeline-Service \
    --assume-role-policy-document file://trust-policy.json

aws iam put-role-policy \
    --role-name AWS-CodePipeline-Service \
    --policy-name codepipeline-service-access-to-resources \
    --policy-document file://permissions-policy.json
