---
type:        writing
author:      Dan Brubaker Horst
date:        2022-02-24T14:44:20-04:00
draft:       true
description: A cinical take on transforming software delivery
tags:
 - DevOps
 - ND
title: Ten Years of Failing at DevOps
---

I started [writing about DevOps][1] in 2012.
For better or worse, the conversations I'm having in the OIT ten years later sound suspicially similar to the ones I was having in the Hesburgh Libraries ten years ago.
This is a sobering realization.

Today I attended a higher-ed meetup for about "DevOps" and they asked everyone to define both what that term means and how it worked--or didn't--at their institution.
This is what I said:

> DevOps--and "splat"-Ops in general like DevSecOps, GitOps, ChatOps, etc.--attempts to change organization culture, structure, and practices to improve software delivery performance.
> [Software delivery performance][2] has industry-defined measures, indicators, and associated practices.
> It asserts that making fast, frequent changes to your services and infrastructure without compromising their integrity is a foundational capability for successful organizations.

I also said, in a few different ways, that we're having a hard time doing these things.
There are lots of pitfalls when you're starting out:

- DevOps enthusiasts want to talk about tools
  - Many DevOps tools are developed in the vein of "move fast and break things"
  - Don't start a conversation about [kuberneties][3][^1]
- Changing behavior in large, established organizations is hard
  - Organization change managment--even when done successfully--takes _years_
  - Be mindful of [Conway's Law][4]; to reimagine your work you will need to change your organizational structure. There are [existing][5] [resources][6] to help with this.
- Leadership needs to believe in the benefits of these organizational capabilites
  - Without buy-in from above changes will be limited in scope & impact
  - If you're heavily invested in ITIL, or other burdensome change-management systems,

Many of the tools and practices in this space have been around for years.
Unless you have novel use cases or operate on a grand scale you'll only run into modest technical hurdles.
The real challenge is re-skilling, reorienting, and realigning the teams that do the work.

[^1]: I'm being a bit facetious here. There's a [vast and powerful array of tooling][7] that takes advantage of the APIs provided by K8s. Even so, avoid using it directly unless you are building _platforms_ not _solutions_. Avoid building platforms unless it provides a key business capability you can't get another way--otherwise have an IaaS partner run them for you.

[1]: /writing/infrastructure-as-code/
[2]: /writing/software-delivery/
[3]: https://kubernetes.io/
[4]: https://en.wikipedia.org/wiki/Conway%27s_law
[5]: https://teamtopologies.com/
[6]: https://web.devopstopologies.com/
[6]: https://www.cncf.io/
