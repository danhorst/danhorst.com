---
title: "Software Development"
date: 2022-05-17T10:55:44-04:00
categories:
 - reference
published: false
---

There are two common use cases for software development in the OIT:

1.  Data services: web APIs (ideally, RESTful), data modeling, some reporting functions
2.  Web applications: data intake, workflow facilitation, data presentation

Most of the time the business needs, you're trying to get data from one place to another while facilitating some user input.

Both of these application contexts require a baseline familiarity with:

-   HTTP(S): verbs, URIs, headers, etc.
-   Request/reponse cycle e.g. web request -> URI -> route -> controller -> action -> view
-   Language (Ruby, JavaScript, etc.) fluency: syntax, control flow, operations on collections, object/data representation
-   Data flow: marshaling (AREL, SQL), manipulation, serialization, deserialization
-   Tooling: static code analysis (e.g. linter, style-guide enforcement), programmatic tests, version control systems, dependency management systems, language runtime management, editor/IDE configuration
-   BONUS: DNS, TCP/IP, web server configuration, Linux server administration

Web applications also require:

-   Web page presentation: HTML, CSS, JavaScript
-   Progressive enhancement: responsive design, HTML-first page construction, presentational JavaScript

-   Usability: information architecture, content strategy, page hierarchy, form/input design, graphic design
-   Accessibility: ARIA roles and landmarks, internationalization, [WebAIM](https://webaim.org/), VoiceOver, etc.
-   BONUS: Performance:  [Lighthouse](https://developers.google.com/web/tools/lighthouse/), [WebPageTest](https://www.webpagetest.org/), [Mozilla Observatory](https://observatory.mozilla.org/)
-   BONUS: Design systems, executable style guides, web components
-   OPTIONAL: Lots of JavaScript: NodeJS, NPM, ES6, language extensions, libraries, frameworks, DOM manipulation, state tracking and propagation, transpilation, hot module reloading, React, Redux, React hooks, Vue.js, webpack, vite.js, deno, gulp, grunt, etc. etc. etc.

I'm sure I missed a bunch of things; there's a lot to cover.

Each list item under each bullet point has depth and breadth that can be explored.



If you're looking for a general overview of web development I came across this recently: [Web Development for Beginners](https://github.com/microsoft/Web-Dev-For-Beginners) developed by Microsoft to train their Azure Cloud Advocates.

It seems like a good way to orient yourself in the basics of web development without launching you into a debate about React hooks.

Web professionals write about web technology on their websites so there's an over-abundance of reading and discovery available on the Internet itself:

1.  [DEV](https://dev.to/) is kind of noisy but has loads of good content in small chunks
2.  Searching  [Stack Overflow](https://stackoverflow.com/)  is often a faster way to find out how to do something than reading the tool/language/framework documentation yourself
3.  [Smashing Magazine](https://www.smashingmagazine.com/)  has a design focus but covers a lot about making websites; they have good looking books but I haven't read any
4.  [Codrops](https://tympanus.net/codrops/)  is a showcase for what is  _possible_ to do on a webpage
5.  [A Book Apart](https://abookapart.com/)  has a bunch of focused, concise books that help explain important concepts
6.  [Sandi Metz](https://sandimetz.com/products)  has a gift for cogent writing about object-oriented programming

I read/follow/digest content from all over the place so if you're interested in something specific I may be able to get you pointed in the right direction.
