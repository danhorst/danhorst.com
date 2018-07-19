---
type:        post
author:      Dan Brubaker Horst
description: Forging a path to developer happiness through DevOps.
title:       Infrastructure As Code
---

Our goal is to have consistency across development, staging, and production environments.
The first step in achieving that goal is to systematize our environment provisioning and management processes.


## Consolidated vs. Distributed Services

When all the required software is packaged together it reduces resource overhead and lowers startup time by removing the complexity of a distributed cluster of services.
This makes it ideal for development and staging environments.
An environment that contains _all_ the supporting software to run an instance of a [Hydra][1] is considered a "FatVM".

However, it is hard to scale and tune the entire system with all the software intertwined.
The most flexible way to address our rapidly changing needs is to extract and cluster services of similar types.
As we identify bottlenecks in our infrastructure we can spool up nodes of the needed type.
Each node will focus on one type of task: ingest of material, dissemination of a content type, serving a single Rails application, etc.
A tuned, single-purpose environment like this is a "ThinVM".


## The Vision

A centrally-managed [chef][2] instance will coordinate the provisioning and updating of thin and fat VMs across environments.
Pre-provisioned vagrant base boxes will be built automatically as updates to the chef recipes are made.
Staging, pre-production, and production VMs will be able to be spooled up quickly for any given role.


## Proposed Tools

With a centralized provisioning system we can programmatically define software stacks needed to build specialized environments.
We should be able to use the same provisioning manifests ([Chef][2] calls them [cookbooks][3]) to provision VMs in a VM farm as well as build [base boxes][4] for [Vagrant][5] for use in development.
The full toolchain will look something like this:

 - [VeeWee][7] for building [base boxes][4] and VM images
 - [Chef Server][6] for provisioning and distributing updates
 - [Knife][8] as an interface for the provisioning server
 - [Cucumber-chef][9] for testing provisioning manifests
 - [Vagrant][5] for managing development environments
 - [Librarian][10] for storing application-specific provisioning needs
   ([recipies][11])
 - [Foreman][12] for managing application-specific runtime processes

Some of these tools may not be absolutely necessary (such as Librarian).
There may be other approaches worth investigating as well.[^1]


## Application-Centric Configuration

By defining the [Cheffile][13], [Procfile][14], and [Vagrantfile][15] at the root of each application we can treat application dependencies, runtime process needs, and development environment configuration as a part of the application source code.
Together they provide an executable [runbook][16] that can be interpreted by [Librarian][11], [Foreman][12], and [Vagrant][5] respectively.

It is possible to create both "ThinVM" and "FatVM" environments with [Vagrant][5] for local testing.
The [Vagrantfile][15] can provision multiple VMs to approximate the diverse infrastructure we are building for production services.
For example, in order to test the workflow project it can provision a [Redis][17] VM, a [Fedora][18] VM, a [Solr][19] VM, a VM for the application itself, and a VM for workers.
That sounds like a lot of overhead but it should relieve the need for installing and configuring all of those software stacks directly on developer machines.

Documentation for using all of these tools concurrently is sparse.
But there have been some examples of [part of the process][20].


## The Hydra Stack

The full [Hydra][1] application stack is rather complicated.
For an administrative application that can ingest content into [Fedora][18], search holdings via [Solr][19], and present information from [Fedora][18] to a user two complete application stacks as well as several auxiliary pieces of software are needed.

 - Java and a Java web server: [Jetty][21], [Tomcat][22], [JBoss][23], etc.
   - [Apache Solr][19] for full-text search
   - [Fedora Commons][18] for archival storage
 - Ruby and a Ruby web server: [Thin][24], [Puma][25], [Unicorn][26], etc.
   - Rails application for the user interface
   - [Heracles][27] workflow manager (also a Rails application) to govern the
     work queue
   - [Heracles][27] worker processes (Ruby daemons) for ingesting specific
     content types into Fedora
 - [Postgres][28] for non-archival data used by both Rails Applications
 - [Redis][17] for the [Heracles][27] queue and for in-memory caching
 - [nginx][29] as a reverse proxy for all web-facing applications
   - Fedora wrapper to allow for a service external to Fedora to provide
     authentication and authorization for access
   - Reverse proxy for Rails applications
   - Directly serves static assets used by Rails applications


## Starting the Process

The first deliverable is a [VeeWee][7]-built [Vagrant base box][4] that is further provisioned by [chef recipes][11] executed by [chef solo][30].

The second deliverable is a [KVM VM][31] for a staging environment where the previously written chef recipes can be successfully executed.

## Required Reading
- [The Twelve-Factor App][32]
- [ImmutableServer][33]


[1]:  http://projecthydra.org/
[2]:  http://www.opscode.com/chef/
[3]:  http://wiki.opscode.com/display/chef/Introduction+to+Cookbooks+and+More
[4]:  http://vagrantup.com/v1/docs/base_boxes.html
[5]:  http://vagrantup.com/
[6]:  http://wiki.opscode.com/display/chef/Chef+Server
[7]:  https://github.com/jedi4ever/veewee
[8]:  http://wiki.opscode.com/display/chef/Knife
[9]:  http://www.cucumber-chef.org/
[10]: https://github.com/applicationsonline/librarian
[11]: http://wiki.opscode.com/display/chef/Introduction+to+Cookbooks+and+More#IntroductiontoCookbooksandMore-Recipes
[12]: https://github.com/ddollar/foreman
[13]: https://github.com/applicationsonline/librarian#the-cheffile
[14]: https://devcenter.heroku.com/articles/procfile/
[15]: http://vagrantup.com/v1/docs/vagrantfile.html
[16]: http://en.wikipedia.org/wiki/Runbook
[17]: http://redis.io/
[18]: http://fedora-commons.org/
[19]: http://lucene.apache.org/solr/
[20]: http://tumblr.nrako.com/post/22320729770/vagrant-chef-librarian
[21]: http://jetty.codehaus.org/jetty/
[22]: http://tomcat.apache.org/
[23]: http://www.jboss.org/
[24]: http://code.macournoyer.com/thin/
[25]: http://puma.io/
[26]: http://unicorn.bogomips.org/
[27]: https://github.com/ndlib/heracles
[28]: http://www.postgresql.org/
[29]: http://nginx.org/
[30]: http://wiki.opscode.com/display/chef/Chef+Solo
[31]: https://github.com/jedi4ever/veewee/blob/master/doc/kvm.md
[32]: http://www.12factor.net
[33]: http://martinfowler.com/bliki/ImmutableServer.html
[33]: http://www.heroku.com/
[34]: https://devcenter.heroku.com/articles/buildpacks

[^1]: [Heroku][33]'s [buildpacks][34] sound interesting but may be limited to their proprietary service architecture.
