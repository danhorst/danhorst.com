---
type:        writing
author:      Dan Brubaker Horst
date:        2022-02-24T14:44:20-04:00
description: Transforming software delivery is hard
tags:
 - DevOps
 - ND
title: Ten Years of DevOps Obstacles
---

I started [writing about DevOps][1] in 2012.
The conversations I'm having in the OIT now sound suspiciously similar to ones I had in the Hesburgh Libraries ten years ago.
I am not pleased with this sense of déjà vu.

Today I attended a higher-ed meetup about "DevOps."
The organizers asked a panel to define what that term means and how it worked--or didn't--at their institution.
In response, I said:

> DevOps--and "splat"-Ops in general like DevSecOps, GitOps, ChatOps, etc.--attempts to change organizational culture, structure, and practices to improve software delivery performance.
> [Software delivery performance][2] has industry-defined measures, indicators, and associated practices.
> It asserts that making fast, frequent changes to your services and infrastructure without compromising their integrity is a foundational capability for successful organizations.

I also said that we're having a hard time doing these things.
There are lots of pitfalls when you're starting:

- DevOps enthusiasts want to talk about tools.
  - Many DevOps tools adopt a "move fast and break things" mentality; caveat emptor.
  - Don't start a conversation about [kuberneties][3][^1].
- It is hard to change the behavior of large, established organizations.
  - Organization change management--even when done successfully--takes _years_.
  - Be mindful of [Conway's Law][4]. Reimagining your work requires changing your organizational structure. There are [existing][5] [resources][6] to help with this.
- Leadership needs to believe in the benefits of these organizational capabilities
  - Lack of buy-in from upper management limits the potential scope & impact of changes.
  - Increasing the pace of change is threatening instead of exciting to organizations that have adopted strict ITIL or another lumbering change-management system.
  - InfoSec and your auditors need to be allies or you won't get far

Many of the tools and practices in this space have been around for years.
Unless you have novel use cases or operate on a grand scale, you'll only run into modest technical hurdles.
The hard part of changing an organization is re-skilling, reorienting, and realigning the people.

Organizations do not change overnight.
It takes a lot of hard work from knowledgeable, well-intentioned people to make a meaningful difference.
I take some solace from the fact that our aspirational peers are quick to acknowledge they're working on issues too.

[^1]: I'm being a bit facetious here. There's a [vast and powerful array of tooling][7] that takes advantage of the APIs provided by K8s. Even so, avoid using it directly unless you are building _platforms_ instead of _solutions_. Avoid building platforms unless they provide key business capabilities you can't get another way--otherwise, have an IaaS partner run them for you.

[1]: /writing/infrastructure-as-code/
[2]: /writing/software-delivery/
[3]: https://kubernetes.io/
[4]: https://en.wikipedia.org/wiki/Conway%27s_law
[5]: https://teamtopologies.com/
[6]: https://web.devopstopologies.com/
[7]: https://www.cncf.io/
