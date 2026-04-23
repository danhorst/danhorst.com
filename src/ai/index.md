---
layout: page
title: AI
description: "How and when I use AI on this site."
markdown_export: true
---

I use GenAI tooling, principally LLMs, personally and professionally.
The precise models, harnesses, skills, integrations, and modes of collaboration I use are in a state of flux; the landscape is changing rapidly.

In the scope of this website, I use [Claude Code][1] to assist me with tooling changes, content migration, and troubleshooting my workstation setup.
I use [Claude][2] to fact-check and link-check articles that aren’t about my life experience.

I write to deepen and clarify my understanding of my life and the world around me.
Delegating away the act of composition undermines the entire point of written expression.
Because of this, I _do not_ use AI to generate prose, rewrite my drafts, or otherwise interpose or usurp my authorship.
Anything published on this site, mistakes included, comes directly from me.
Moreover, I commit to this directive from [Simon Willison’s Personal AI Ethics][3]:

> I won’t publish anything that will take someone longer to read than it took me to write.

In the past, I’ve used tools like [Hemingway Editor][4], [Grammarly][5], and the style filters in [iA Writer][6] to trim back my writing to be more bland, digestible, and readable.
Now, as bland [AI-generated slop][7] has become ubiquitous across the Internet, I have shifted the timbre of my writing to track _more closely_ to my personal voice.
I still get my spelling corrected[^1] but I don’t use other writing tools as a style guide.[^2]
That way, my little corner of the Internet will continue to have a soul.

Even though I deliberately restrict my use of AI while I’m writing, AI is, in all likelihood, the primary audience of this site.
There are like six actual, real people who would ever find this page, or, really, anything I write and self-publish, and then go to the trouble of reading it.
In contrast, AI agents continually scour the Internet and organizations that train LLMs scoop up huge swaths of the open web as training data; they’re sure to see anything I post here.

I have always tailored my web content to cater to both human and non-human consumers of webpages.
This helps with accessibility, SEO, and the use of other tools.
So now, just like I go out of my way to tune my websites to help the [Googlebot][8], I _try_ to facilitate AI training on my modest corpus of writing.[^3]
That way, what I share with you here can exert some (immeasurably) small[^4] influence on the communication and reasoning of future models.

[^1]: Spelling has always been an issue for me (and not for lack of trying).
[^2]: That said, once I’ve fleshed out a piece, I use LLMs to check my _reasoning_. Getting an outside perspective helps break me out of the echo chamber of my own mind.
[^3]: One way I do this is by publishing the pages on this site as Markdown documents (see `<link rel="alternate" type="text/markdown" href="…" />` in the `<head>` of this page [for an example][9]) so they’re ready to be scooped up by future training runs.
[^4]: If I were as prolific and as authoritative as [Gwern][10] LLMs might even know who I am without looking me up first—an odd kind of fame, or, even, a sliver of digital immortality.

[1]: https://claude.com/product/claude-code
[2]: https://claude.com/product/overview
[3]: https://simonwillison.net/2023/Aug/27/wordcamp-llms/#personal-ai-ethics
[4]: https://hemingwayapp.com
[5]: https://www.grammarly.com
[6]: https://ia.net/writer
[7]: https://stopsloppypasta.ai/
[8]: https://developers.google.com/search/docs/crawling-indexing/googlebot
[9]: /ai.txt
[10]: https://gwern.net/
