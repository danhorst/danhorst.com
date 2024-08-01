---
title: "Technical Debt"
date: 2024-07-31T13:18:44-04:00
description: Living with long-lived software
---

[Technical debt][1] is both pervasive and disruptive to the discipline of software engineering.
No software<label for="not-all-software" class="margin-toggle sidenote-number"></label>
<input type="checkbox" id="not-all-software" class="margin-toggle"/>
<span class="sidenote">
Aside from ephemeral software that is discarded after use.
</span> is free from technical debt.
Despite this, it's hard for organizations to make productive, impactful changes to the processes and practices that cause technical debt to arise.

It is tempting—and common—to draw parallels between technical debt and _financial_ debt.
You can try to apply lessons from [Financial Peace University][2] to your code base and technical systems but I think it is more useful to think about of technical debt in terms of its impact on marginal cost.

One of core responsibilities of software engineers is to control the marginal cost<label for="marginal-cost" class="margin-toggle sidenote-number"></label>
<input type="checkbox" id="marginal-cost" class="margin-toggle"/>
<span class="sidenote">
Marginal cost, by definition, is the change in the total cost when the quantity produced is increased.
The biggest cost centers are engineering time, cloud computing resources, and licensing fees.
</span> of:

- Extending a system with new functionality
- Scaling a system for broader use

This helps keep the cost of change low over time.<label for="cost-of-change" class="margin-toggle sidenote-number"></label>
<input type="checkbox" id="cost-of-change" class="margin-toggle"/>
<span class="sidenote">
Keeping marginal costs low was one of the claimed benefits of <a href="https://en.wikipedia.org/wiki/Extreme_programming">Extreme Programming (XP)</a>; a set of practices that predated Agile.
There are good ideas in XP but the methodology has fallen out of favor over time.
Agile software development <em>should</em> have similar outcomes but often doesn’t.
</span>
Marginal costs are influenced by:

- Architecture decisions
- Process design
- Implementation choices

Thus "paying down" technical debt involves _remediating_ one of these aspects of the [software development life cycle (SDLC)][3].
This isn’t a simple problem space but it is prevalent enough that patterns have emerged.
That’s why [accumulation of technical debt][4] is one of the [Bottlenecks of Scaleups][5].

[1]: https://en.wikipedia.org/wiki/Technical_debt
[2]: https://www.ramseysolutions.com/ramseyplus/financial-peace
[3]: https://en.wikipedia.org/wiki/Systems_development_life_cycle
[4]: https://martinfowler.com/articles/bottlenecks-of-scaleups/01-tech-debt.html
[5]: https://martinfowler.com/articles/bottlenecks-of-scaleups/
