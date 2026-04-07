---
title: "Technical Debt"
date: 2024-07-31T13:18:44-04:00
description: Living with long-lived software
---

[Technical debt][1] is both pervasive and disruptive to the discipline of software engineering.
No software[^1] is free from technical debt.
Despite this, it's hard for organizations to make productive, impactful changes to the processes and practices that cause technical debt to arise.

It is tempting—and common—to draw parallels between technical debt and _financial_ debt.
You can try to apply lessons from [Financial Peace University][2] to your code base and technical systems but I think it is more useful to think about of technical debt in terms of its impact on marginal cost.

One of core responsibilities of software engineers is to control the marginal cost[^2] of:

- Extending a system with new functionality
- Scaling a system for broader use

This helps keep the cost of change low over time.[^3]
Marginal costs are influenced by:

- Architecture decisions
- Process design
- Implementation choices

Thus "paying down" technical debt involves _remediating_ one of these aspects of the [software development life cycle (SDLC)][3].
This isn’t a simple problem space but it is prevalent enough that patterns have emerged.
That’s why [accumulation of technical debt][4] is one of the [Bottlenecks of Scaleups][5].

The only effective way to manage these marginal costs is to periodically and rigorously _simplify_ standing systems through methods like introducing new layers of abstraction, breaking services into smaller component pieces, and depreciating anything you can get away with.

[1]: https://en.wikipedia.org/wiki/Technical_debt
[2]: https://www.ramseysolutions.com/ramseyplus/financial-peace
[3]: https://en.wikipedia.org/wiki/Systems_development_life_cycle
[4]: https://martinfowler.com/articles/bottlenecks-of-scaleups/01-tech-debt.html
[5]: https://martinfowler.com/articles/bottlenecks-of-scaleups/

[^1]: Aside from ephemeral software that is discarded after use.

[^2]: Marginal cost, by definition, is the change in the total cost when the quantity produced is increased.
The marginal costs of software increase in a nonlinear fashion as the complexity of the system increases i.e. it is *much* easier to change a simpler thing than a complicated thing.
The biggest cost centers are engineering time, cloud computing resources, and licensing fees.

[^3]: Keeping marginal costs low was one of the claimed benefits of [Extreme Programming (XP)](https://en.wikipedia.org/wiki/Extreme_programming); a set of practices that predated Agile.
There are good ideas in XP but the methodology has fallen out of favor over time.
Agile software development *should* have similar outcomes but often doesn’t.
