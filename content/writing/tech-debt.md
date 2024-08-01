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
I use a specific conceptual framework to guide my approach to technical debt to guide my actions and avoid succumbing to the temptation to dismiss crushing technical debt as inevitable and insurmountable.

One of core responsibilities of software engineers is to control the marginal cost<label for="marginal-cost" class="margin-toggle sidenote-number"></label>
<input type="checkbox" id="marginal-cost" class="margin-toggle"/>
<span class="sidenote">
Marginal cost, by definition, is the change in the total cost when the quantity produced is increased.
Common cost centers are engineering time, cloud computing resources, and licensing fees.
</span> of:

- Extending a system with new functionality
- Scaling a system for broader use

This helps keep the cost of change low over time.<label for="cost-of-change" class="margin-toggle sidenote-number"></label>
<input type="checkbox" id="cost-of-change" class="margin-toggle"/>
<span class="sidenote">
This was one of the claimed benefits of <a href="https://en.wikipedia.org/wiki/Extreme_programming">Extreme Programming (XP)</a>; a set of practices that predated Agile.
There are good ideas in XP but the methodology has fallen out of favor over time.
Agile software development <em>should</em> have similar outcomes but often doesn’t.
</span>
Marginal costs are influenced by:

- Architecture decisions
- Process design
- Implementation choices

Thus "paying down" technical debt involves _remediating_ one of these aspects of the [software development life cycle (SDLC)][2].

[1]: https://en.wikipedia.org/wiki/Technical_debt
[2]: https://en.wikipedia.org/wiki/Systems_development_life_cycle
