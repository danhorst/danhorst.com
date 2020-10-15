---
type:        writing
author:      Dan Brubaker Horst
date:        2020-10-15T14:45:28-04:00
description: What is software delivery performance and how do you measure it?
tags:
 - DevOps
 - ND
title: Software Delivery
---

> This was extracted from an internal document I wrote for work but I reference it so often I wanted to give it a more germinate home.

Efficient, reliable, and reproducible software delivery keeps the cost of introducing change low over the lifetime of a service offering.
With this as a foundation, organizations can iterate toward adopting and leveraging enterprise integrations that reduce maintenance burden and decrease time to delivery for new work.

## Key Measures

From [Accelerate](https://itrevolution.com/book/accelerate/), Appendix B and [The Key to High Performance (free PDF e-book; email sign-up required) p3](https://itrevolution.com/book/accelerate/) ([YouTube](https://www.youtube.com/watch?v=RBuPlMTXuFc)).
The more painful code deployments are, the poorer the software delivery performance and culture.

- _Deploy frequency:_ How often are changes made to production? Favor small, frequent changes.
  - [Continuous Delivery](#continuous-delivery)
  - Version control
- _Lead time:_ How long does it take to go from commit to running in production?
  - Version control
  - Test automation
- _Mean time to restore (MTTR):_ How long does it take to restore a failed service?
  - Version control
  - Monitoring
- _Change fail percentage:_ How often do changes cause an outage or another negative outcome?
  - Strongly correlated with overall software delivery performance

## Key Indicators

From [Accelerate](https://itrevolution.com/book/accelerate/), Technical Practices and [The Key to High Performance (free PDF e-book; email sign-up required) p14](https://itrevolution.com/book/accelerate/) ([YouTube](https://www.youtube.com/watch?v=RBuPlMTXuFc)).

### Continuous Delivery

- _Test automation:_ automated tests give quick feedback and create a virtuous cycle of quality
- _Deployment automation:_  [see Characteristics of Cloud Computing below](#characteristics-of-cloud-computing)
- _Trunk-based development:_ keep master deployable, favor short-lived feature branches
- _Shift left on security:_ include InfoSec early and often in the SDLC
- _Loosely coupled architecture:_  [see Key Outcomes for System Architecture below](#key-outcomes-for-system-architecture)
- _Empowered teams:_ teams choose the tools they use, favor performance over standards
- _Continuous integration:_ run tests on every commit, merge, and deploy

### Other Indicators

- Version control: track everything—not just code, configuration is just as important
- Test data management: automated test suites need access to appropriate data
- Monitoring: measure the [four golden signals](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/#xref_monitoring_golden-signals): latency, traffic, errors, saturation

## Characteristics of Cloud Computing

From [NIST 800-145](https://doi.org/10.6028/NIST.SP.800-145).
Implementing systems that display these characteristics is strongly correlated with high-performance organizations.

1. _On-demand self-service._ Allow automatic provisioning of computing resources, storage, etc. without requiring human interaction with the service provider.
2. _Broad network access._ Services are available over the network and accessed through standard mechanisms that are device agnostic.
3. _Resource pooling._ Storage, processing, memory, network bandwidth, and other resources are pooled, shared, and dynamically assigned using a multi-tenant model.
4. _Rapid elasticity._ Capabilities can be elastically provisioned and released, in some cases automatically, to scale rapidly outward and inward commensurate with demand.
5. _Measured service._ Resource usage can be monitored, controlled, and reported, providing transparency for both the provider and consumer of the utilized service.

## Key Outcomes for System Architecture

Decoupled systems are crucial for lowering the cost of change. This evaluation is from [The Key to High Performance (free PDF e-book; email sign-up required) p3](https://itrevolution.com/book/accelerate/) ([YouTube](https://www.youtube.com/watch?v=RBuPlMTXuFc)).

- Can your team make large-scale changes to the design of your systems without the permission of someone outside of your team or without depending on other teams?
- Can your team complete its work with neither fine-grained communication nor fine-grained coordination?
- Can your team deploy and release your product on-demand independently of other services?
- Can your team do most of your testing on-demand without requiring an integrated test environment?
- Can your team perform deployments during normal business hours and with negligible downtime?
