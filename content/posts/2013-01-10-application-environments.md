---
type:        post
author:      Dan Brubaker Horst
description: Defining our expectations for deploying and managing applications.
categories:
 - Archived
title:       Application Environments
---

## Setting Expectations
We can only guarantee three things about our software development practices:

1. We are building a constellation of services that work together.
2. They will change over time.
3. The operational complexity of the entire system will continue to increase.

Our team has been tasked with creating a wide variety of services in a short period of time.
In fulfilling our goals we will build and deploy many applications of varying size and complexity which work towards a [common end][1].
We need an infrastructure that will grow and change to meet our needs.

## Definition of Terms

### Production
Production should be as stable, reliable, and robust as possible.

### Pre-Production
The pre-production environment software should be _precisely_ the same as production.
The only time when software versions should differ from production is while testing a new configuration before immediate deployment to production.
Data in pre-production may lag behind and/or diverge from production data.
As such, the pre-production environment is _not_ a fail-over mirror of the production environment.

### Staging
The staging environment is a sandboxed, publicly accessible application environment used for prototyping new features and experimenting with new software.
The goal of this environment is to be able to demonstrate software under active development to stakeholders as quickly as possible.

### Development
Development is a sandboxed environment for active software development.
This environment will typically be on the developer's machine and managed by [vagrant][2].

### Sandboxed
A sandboxed environment doesn't rely on any external services to run.
It has it's own copy of the application data.

### Web Application
A web application is a program which dynamically generates web pages for public use.
It may also provide information in other formats than HTML e.g. JSON, XML.

### Web Service
A web service is a program which provides data to external programs, but not web pages.
It may serve some HTML but it's primary purpose is to serve as a data API rather than provide curated a user experience.

### Internal Service
An internal service is a program that provides data to other programs and is restricted from public access e.g. Fedora, Solr, Redis.

### Module
A module is shared application code packaged as a library.
We will be creating a number of modules that will be released publicly.
We may also create private modules.
Since the bulk of our work is in Ruby, and ruby modules are called gems, we may use "gem" and "module" interchangeably.


## Software Management
The production environment software has been vetted.
The pre-production environment software should be _precisely_ the same as production.
The only time when software versions are permitted to differ from production is while testing a new configuration.

### Consolidated vs Distributed
In sandboxed environments the full software stack --- e.g. Rails, Solr, and Fedora --- is bundled together into one VM container.
In [Infrastructure As Code][3] this is called a FatVM.
FatVMs are used in the development and beta environments.

In pre-production and production software is broken out into tiers.
This permits mirroring, clustering, and load balancing to be used as scaling strategies of individual components of our infrastructure.


## Data Management
The production environment is the canonical source of data.
The data in all the other environments should be based on the production environment.
Data from production should be able to be migrated to pre-production on demand.
Data synchronization may occur wholesale --- as in the case of pre-production --- or in subsets for sandboxed environments.


## Operational Management
The number of applications that we have deployed and need to maintain will increase over time.
The variety of software needed to support those applications will also increase.
Staffing will _not_ increase at the same rate as operational complexity.
To keep everyone's workload manageable we will need to leverage the tools at our disposal for [version control][4], [automated testing][5], [continuous integration][6], [automated deployment][7], [monitoring][8], and [configuration management][9].
Mastery of these tools will be an ongoing process.
We, as the development team, want to be a part of that process.


[1]: /posts/a-serviceable-digital-repository/
[2]: http://www.vagrantup.com/
[3]: /posts/infrastructure-as-code/
[4]: http://git-scm.com/
[5]: http://rspec.info/
[6]: http://jenkins-ci.org/
[7]: https://github.com/capistrano/capistrano
[8]: http://www.nagios.org/
[9]: http://www.opscode.com/chef/
