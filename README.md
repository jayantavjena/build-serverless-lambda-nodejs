Use AWS CodeBuild to build a Lambda function written in node.js (deployed using a SAM transform)

- The ```hello-world``` folder contains an [Lambda function](hello-world/index.js) written in node.js and is packaged using a SAM transform, using AWS CodeBuild
- A [CloudFormation template](template.yaml) provisions the following:
  - A git repository in AWS CodeCommit, 
  - the build project in AWS CodeBuild, 
  - and a build pipeline in AWS CodePipeline that triggers builds on changes to the ```develop``` branch in the repository   
- Provision the CloudFormation stack as follows:

```
# Provision the CloudFormation stack
$ aws cloudformation create-stack \
    --stack-name develop-build-serverless-lambda-nodejs \
    --template-body file://template.yaml \
    --capabilities CAPABILITY_IAM

# Get the HTTP clone URL for the repository in CodeCommit
$ aws cloudformation describe-stacks \
    --stack-name develop-build-serverless-lambda-nodejs \
    --query "Stacks[0].Outputs[*].OutputValue" \
    --output text
https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-serverless-lambda-nodejs
    
```
- Once provisioned, the existing code artifacts in this repository are to be pushed to the repository in CodeCommit

```
# Configure credentials for an IAM user that has the privileges to push code to the repository in CodeCommit

$ export AWS_PROFILE=my-iam-user
$ git config credential.helper '!aws codecommit credential-helper $@'
$ git config credential.UseHttpPath true

# Use the HTTP clone URL obtained from the CloudFormation stack output
$ git remote add cc https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-serverless-lambda-nodejs
$ git remote -v
cc	https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-serverless-lambda-nodejs (fetch)
cc	https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-serverless-lambda-nodejs (push)
gh	git@github.com:km-aws-devops/build-serverless-lambda-nodejs.git (fetch)
gh	git@github.com:km-aws-devops/build-serverless-lambda-nodejs.git (push)

$ git branch
* develop
$ git push cc develop 

```

- Refer [documentation](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-https-unixes.html) for connecting to CodeCommit repositories using the AWS CLI credential helper