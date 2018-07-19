---
filename:    2013-11-13-rbsc-and-architecture-digital-needs.md
layout:      document
category:    planning
author:      Dan Brubaker Horst
description: We have evolving needs for our digital services. Let's find a way to meet them.
title:       RBSC &amp; Architecture Digital Needs
---

### Identified Needs
- Digitized rare books (Architecture & RBSC)
- Digital images (Architecture)
- Digital exhibits with mixed media (RBSC)
	- Digital exhibits released at the same time as the physical exhibits
	- There is a symposium in February 2014 that needs an exhibit
	- Past exhibits have unpublished digitized materials
- Production of digital content is _rapidly_ increasing. We need to accommodate this.

### Immediate Needs
- Presentation of completely digitized monographs
	- Requirements have been gathered; they can be updated rather easily
- Digital exhibits

## Digital Exhibits
We need a path to sustainability creating digital exhibits.
Julie and Sara have been looking at tools for exhibit building and think [Omeka][1] looks attractive.

The primary benefit of Omeka is that it is a mature open-source platform for exhibit building.
It has the same pitfalls as any other content management system: if used as  intended everything should be fine; if your needs exceed the capabilities of the tool it can cause a lot of headache.

In order to evaluate [Omeka][1] we should also consider these prominent plugins:

- [Exhibit Builder][2]
- [FedoraConnector][3]
- [Simple Pages][4]

It appears that using the FedoraConnector is not tenable with CurateND because it requires that the content be accessible without access controls:

> Currently, FedoraConnector can only interact with Fedora servers that do not place authorization checks on remote requests to access object datastreams.

If we implement Omeka as an exhibit system it would have to exist entirely outside our preservation system.
This isn't _necessarily_ a non-starter.
It would reduce the amount of programmer time needed to implement an exhibit system in exchange for duplicating some work for collection managers e.g. depositing digitized content into CurateND as well as separately managing access derivatives in Omeka.

### Alternatives to Omeka
I have three design objectives for a digital exhibit system:

1. Be able to retrieve content and metadata from CurateND or Fedora directly
2. Allow staff who are not programmers to create exhibits and to manage the content of their exhibits.
3. Present content in a [mobile-first responsive design][5] ([further reading][6]).


|              | Fedora  | Easy          | Mobile | Started        |
|--------------|---------|---------------|--------|----------------|
|[Omeka][1]    |  Nope   | Yes           | Maybe  | 2009           |
|[Scalar][7]   |Yes (DIY)| Yes           | Maybe  | 2013           |
|[Exhibitz][8] |  Yes    | Yes (planned) | Maybe  | 2014 (planned) |

Of these options Omeka has been around along the longest and appears to have reasonable adoption.
While this doesn't guarantee that is is the best solution, I've seen quite a few underwhelming Omeka-driven sites, it exists in the wild and people actually use it.

## Monograph viewers
Special collections _already_ has about 50 digitized volumes that are not published.
The Architecture Library has several digitized volumes as well but would like to move beyond just making PDFs available for download.

### What do we actually need in a page turner?

RBSC likes [e-codices][9].
It would be good to know _why_ as it doesn't strike me as being particularly impressive.
Because it limits zoom to only the single-page view it also wouldn't be too difficult to implement using one of the standard image zooming libraries.

Another example is the [Northwestern books][10] site.
It is a robust solution but both the technical infrastructure and metadata that powers it are _very_ complicated.
Their infrastructure is not in a state where it could be easily packaged up and adopted by another institution.

There are also use cases for juxtaposing related content from multiple volumes.
Adam has created a Filemaker Database to do this in Architecture but it is not publicly accessible.
They would love to make that kind of discovery experience available to their patrons at large.

### Infrastructure Needs

- A [IIIF][11] compatible image server
- An [image pipeline][12]
- An image-centric search interface either in CurateND proper or as a separate tool.

## Deliverables
- Before Christmas we need a plan for delivering digital exhibits
- Immediately folioing the launch of CurateND we should schedule stakeholder meetings with Adam and Jennifer in Architecture and Sara in RBSC
	- Content modeling needs
	- Batch ingest process requirements

[1]:  http://omeka.org/
[2]:  http://omeka.org/add-ons/plugins/exhibit-builder/
[3]:  http://omeka.org/add-ons/plugins/fedoraconnector/
[4]:  http://omeka.org/add-ons/plugins/simple-pages/
[5]:  http://www.lukew.com/ff/entry.asp?933
[6]:  http://www.abookapart.com/products/mobile-first
[7]:  http://scalar.usc.edu/
[8]:  https://wiki.duraspace.org/display/hydra/Exhibitz
[9]:  http://www.e-codices.unifr.ch
[10]: http://books.northwestern.edu/
[11]: http://iiif.io
[12]: http://www3.nd.edu/~dbrubak1/planning/building-an-image-pipeline/
