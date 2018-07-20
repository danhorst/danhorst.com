---
type:        post
author:      Dan Brubaker Horst
description: This is how we propose to manage different types of applications across environments.
markup:      mmark
categories:
 - Archived
title:       Service &amp; Application Management
---

## Our Goal

The software developers in the library will be building and deploying many applications of varying size and complexity on an ongoing basis.
In order to ensure operational efficiency throughout the service life cycle of these applications we need to have consistency across development, staging, and production environments.

We need an infrastructure that will grow and change to meet our needs.

## Application Deployment

We want to be able to deploy applications in two different ways:

 - As a VM
 - As a cluster service

### Virtual Machines
Applications deployed as virtual machines will contain all the OS and supporting software alongside the application code.
Multiple virtual machines will be run on a VM host.
A VM must be able to be migrated from one host to another in order to ensure continuous service.

The following types of applications will be deployed in this manner:

 - [Web Applications][1]
 - [Web Services][2]

### Cluster Services
Cluster services run on a RHEL [high-availability cluster][3].
The OS and supporting software is managed separately across cluster nodes.
In order to run an application as a cluster service it must be specially configured.
An cluster service can migrate from one node to another to ensure continuous service.

The following types of applications will be deployed in this manner:

 - [Internal Services][4]
 - [Web Services][2]

## Application Environments

As [web applications][1] are being developed they will pass through 5 different environments:

 - [Development][]
 - [Continuous Integration][5] (CI)
 - [Staging][]
 - [Pre-Production][]
 - [Production][]

## Implementation Hurdles
 - Hardware for VM hosts has been ordered but we do not have a high-availability VM infrastructure in place.
 - Provisioning and maintaining virtual machines requires [automated processes][6] that are not yet in place.
 - A new high-availability cluster needs to be built with RHEL 6.
 - The CI environment must be configured to test software packaged as a VM.

[1]: /posts/glossary#web-application               (definition)
[2]: /posts/glossary#web-service                   (definition)
[3]: http://www.redhat.com/products/enterprise-linux-add-ons/high-availability/
[4]: /posts/glossary#internal-service              (definition)
[5]: /posts/glossary#continuous-integration        (definition)
[6]: https://puppetlabs.com/

[development]:    /posts/glossary#development      (definition)
[pre-production]: /posts/glossary#pre-production   (definition)
[production]:     /posts/glossary#production       (definition)
[staging]:        /posts/glossary#staging          (definition)
