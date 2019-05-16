---
title: "Secure a Static Site With Okta"
date: 2019-05-13T15:43:45-04:00
draft: true
---

At my day job, I need to publish documentation to a wide, but not public, audience.
Since it is technical documentation, I can make a use case for using a git-backed static site.

My initial design looked like this:

- Use [Jekyll][1] as the CMS ([Hugo][2] is also a good option)
  - Store the project in [Bitbucket][3]
  - Use [branch permissions][4] to dictate the contribution workflow
- Store the compiled site in S3
  - NOTE: DO NOT configure the S3 bucket to serve the website since CloudFront will be handling the requests. Use the "block all public requests" option to force the issue.
- Use [Bitbucket pipelines][5] to trigger a Lambda function or [SAM process][6] and/or use [CodeBuild][7] to compile the site
- Serve the website from CloudFront
  - Use AWS Certificate Manager to provide SSL certificates
- Secure the website using cloudfront-auth & Okta

- Build environment
  - You want to have dependencies cached so the build doesn't take forever
  - ECR

## Project Scaffolding

VPC
Security Groups
Role

## Deployments

https://alexbilbie.com/2016/12/codebuild-codepipeline-update-jekyll-website/

1. Build outside AWS
2. Build inside AWS

1. Execute build
2. Create build environment

1. Build container outside AWS
	1. Publish container in ECR
	2. Publish container in Docker Hub
2. Build container inside AWS


AWS CodeDeploy

```
/refs/heads/master
```

https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-https-requests-s3/

https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html

[1]: https://jekyllrb.com/
[2]: https://gohugo.io/
[3]: https://bitbucket.org/
[4]: https://confluence.atlassian.com/bitbucketserver/using-branch-permissions-776639807.html
[5]: https://bitbucket.org/product/features/pipelines
[6]: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html
[7]: https://docs.aws.amazon.com/codebuild/latest/userguide/sample-bitbucket-pull-request.html
