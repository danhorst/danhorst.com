---
date: 2013-02-19
type:        writing
author:      Dan Brubaker Horst
description: Every domain has its own vocabulary. For the sake of clarity I've documented what I mean when I use these words.
categories:
 - Archived
tags:
 - DevOps
 - infrastructure
 - reference
title:       Glossary of Terms
---

Continuous Integration
: DEFINE ME

Internal Service
: An internal service is a program that provides data to other programs and is restricted from public access e.g. Fedora, Solr, Redis.

Module
: A module is shared application code packaged as a library.
  We will be creating a number of modules that will be released publicly.
  We may also create private modules.
  Since the bulk of our work is in Ruby and ruby modules are called gems we may use “gem” and “module” interchangeably.

Production
: Production should be as stable, reliable, and robust as possible.

Pre-Production
: The pre-production environment software should be _precisely_ the same as production.
  The only time when software versions should differ from production is while testing a new configuration before immediate deployment to production.
  Data in pre-production may lag behind and/or diverge from production data.
  As such, the pre-production environment is _not_ a fail-over mirror of the production environment.

Sandboxed
: A sandboxed environment doesn’t rely on any external services to run.
  It has it’s own copy of the application data.

Staging
: The staging environment is a sandboxed, publicly accessible application environment used for prototyping new features and experimenting with new software.
  The goal of this environment is to be able to demonstrate software under active development to stakeholders as quickly as possible.

Web Application
: A web application is a program which dynamically generates web pages for public use.
  It may also provide information in other formats than HTML e.g. JSON, XML.

Web Service
: A web service is a program which provides data to external programs, but not web pages.
  It may serve some HTML but it’s primary purpose is to serve as a data API rather than provide curated a user experience.
