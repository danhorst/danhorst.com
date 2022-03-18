---
type:        writing
author:      Dan Brubaker Horst
description: A modest proposal for taming Hydra
categories:
 - Archived
tags:
 - API
 - architecture
 - archives
 - digital humanities
 - ND
 - repository
title:       A Digital Repository We Can Live With
---

## Setting Expectations

The primary deliverable of a digital repository should be a persistent URL that resolves to a rich HTML description of the item.
A digital object should be able to be:

 - Linked to
 - Embedded (e.g. via [oEmbed][1])
 - Indexed by Search Engines (e.g. Google, Google Scholar)
 - Presented in our [Library Catalog][2]
 - Delivered in a wide variety of derivatives

All digital objects need:

 - Access controls
 - Copyright auditing
 - Life cycle management
 - Description and metadata enrichment

We need to provide the services needed to meet these expectations when the digital objects are ingested.

When we store digital objects the original files will be treated specially.
In most cases the original file will be a preservation ready item.
We will want to create a presentation-ready derivative of the original at a reasonable fidelity and in an appropriate format.
When preserving these files the archival and the presentation masters of the file should be versioned and periodically bit-checked for integrity.
On-the-fly derivatives, such as a crop from an image or a plain text export of a TEI document, do not need integrity checking.
Derivatives should be cached and allowed to expire via an appropriate mechanism.


## Don't Dig The Hole Deeper

While the Hydra stack has been helpful it is not without problems.
Thus far our efforts have produced applications that are complicated, difficult to maintain, and fail at delivering an exceptional experience to patrons and curators.
Penn State's [ScholarSphere][3] is a well-implemented "Hydra head" but it is still constrained by the same design decisions present in all "Hydra heads"
Applications that use the "Hydra head" design philosophy have awkwardly coupled concerns.
Persistence, serialization, and presentation are blended together and the resulting application is entwined with Fedora, Solr, and a host of gems.

The promise of the Hydra stack is that if you install a bunch of gems into your application it will be easy to make a Fedora-backed digital repository.
This is fine if there is only one application that serves as a digital repository for an institution.
With each added application it gets more and more complex to maintain the ecosystem because the necessary gems are rapidly changing.
We already have half a dozen applications and will build at least that many this year.
I think this will create a maintenance nightmare.

<figure class="illustration">
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 495" aria-label="[title + description]">
  <title>Current Hydra Architecture</title>
  <desc>
    Block diagram with different applciation stacks that have duplicate elements: Blacklight, Om, ActiveFedora, and RubyDora.
    These applciation stacks all communicated with shared Fedora and Solr backing services.
  </desc>
   <defs><style>.t,.c{font-size: 14px}.c{text-anchor:middle}.b{fill:none;stroke-linejoin:round}</style></defs>
  <path class="b" stroke-dasharray="1,1" d="M10 15h155v200H10z"/>
  <path class="b" d="M40 25h90v20H40z"/>
  <text class="t" y="40" x="45">Blacklight</text>
  <path class="b" d="M40 50h90v20H40z"/>
  <text class="t" y="65" x="45">Om</text>
  <path class="b" d="M40 100h90v20H40z"/>
  <text class="t" y="115" x="45">Rubydora</text>
  <text class="t" y="90" x="45">ActiveFedora</text>
  <path class="b" d="M40 75h90v20H40z"/>
  <text class="t" y="144.893" x="25.946">Serializer</text>
  <path class="b" d="M20 130h65v20H20z"/>
  <path class="b" d="M95 130h60v35H95z"/>
  <text class="c" y="145.498" x="124.924">
    <tspan y="145.498" x="124.924">Content</tspan><tspan y="158.938" x="124.924">Model</tspan>
  </text>
  <path class="b" d="M95 170h60v35H95z"/>
  <text class="c" y="185.49" x="124.924">
    <tspan y="185.49" x="124.924">Content</tspan><tspan y="198.938" x="124.924">Model</tspan>
  </text>
  <path class="b" stroke-dasharray="1,1" d="M195 15h155v280H195z"/>
  <path class="b" d="M225 25h90v20h-90z"/>
  <text class="t" y="40" x="230">Blacklight</text>
  <path class="b" d="M225 50h90v20h-90z"/>
  <text class="t" y="65" x="230">Om</text>
  <path class="b" d="M225 75h90v20h-90z"/>
  <text class="t" y="90" x="230">ActiveFedora</text>
  <path class="b" d="M225 100h90v20h-90z"/>
  <text class="t" y="115" x="230">Rubydora</text>
  <path class="b" d="M205 130h65v20h-65z"/>
  <text class="t" y="144.893" x="210.946">Serializer</text>
  <path class="b" d="M205 155h65v20h-65z"/>
  <text class="t" y="169.893" x="210.946">Serializer</text>
  <path class="b" d="M205 180h65v20h-65z"/>
  <text class="t" y="194.893" x="210.946">Serializer</text>
  <path class="b" d="M280 130h60v35h-60z"/>
  <text class="c" y="145.498" x="309.924">
    <tspan y="145.498" x="309.924">Content</tspan><tspan y="158.938" x="309.924">Model</tspan>
  </text>
  <path class="b" d="M280 170h60v35h-60z"/>
  <text class="c" y="185.498" x="309.924">
    <tspan y="185.498" x="309.924">Content</tspan><tspan y="198.938" x="309.924">Model</tspan>
  </text>
  <path class="b" d="M280 210h60v35h-60z"/>
  <text class="c" y="225.498" x="309.924">
    <tspan y="225.498" x="309.924">Content</tspan><tspan y="238.938" x="309.924">Model</tspan>
  </text>
  <path class="b" d="M280 250h60v35h-60z"/>
  <text class="c" y="265.498" x="309.924">
    <tspan y="265.498" x="309.924">Content</tspan><tspan y="278.938" x="309.924">Model</tspan>
  </text>
  <path class="b" stroke-dasharray="1,1" d="M375 15h155v240H375z"/>
  <path class="b" d="M405 25h90v20h-90z"/>
  <text class="t" y="40" x="410">Blacklight</text>
  <path class="b" d="M405 50h90v20h-90z"/>
  <text class="t" y="65" x="410">Om</text>
  <path class="b" d="M405 75h90v20h-90z"/>
  <text class="t" y="90" x="410">ActiveFedora</text>
  <path class="b" d="M405 100h90v20h-90z"/>
  <text class="t" y="115" x="410">Rubydora</text>
  <path class="b" d="M385 130h65v20h-65z"/>
  <text class="t" y="144.393" x="390.946">Serializer</text>
  <path class="b" d="M385 155h65v20h-65z"/>
  <text class="t" y="169.893" x="390.946">Serializer</text>
  <text class="c" y="145.498" x="489.924">
    <tspan y="145.498" x="489.924">Content</tspan><tspan y="158.938" x="489.924">Model</tspan>
  </text>
  <path class="b" d="M460 130h60v35h-60z"/>
  <text class="c" y="185.498" x="489.924">
    <tspan y="185.498" x="489.924">Content</tspan><tspan y="198.938" x="489.924">Model</tspan>
  </text>
  <path class="b" d="M460 170h60v35h-60z"/>
  <text class="c" y="225.498" x="489.924">
    <tspan y="225.498" x="489.924">Content</tspan><tspan y="238.938" x="489.924">Model</tspan>
  </text>
  <path class="b" d="M460 210h60v35h-60z"/>
  <text y="408.338" x="125.354" font-size="24">Solr</text>
  <path class="b" d="M100 355h90v90h-90z"/>
  <text y="432.582" x="258.023" font-size="36">Fedora</text>
  <path class="b" d="M200 355h220v130H200z"/>
  <path d="M115 220s0 105 60 105c30 0 40.004 1.075 49.621 5.884C233.485 336.389 240 350 240 350" fill="none" stroke="#000" stroke-width="2"/>
  <path d="M140 350s-5-40 25-40 30 5 55-10M270 300c-5 10-10 20-5 30s20 20 20 20" fill="none" stroke="#000" stroke-width="2"/>
  <path d="M410 260s0 60-50 65-125 0-170-5c-30-5-34.568 7.162-30 30M425 370c35.271-23.515 39.542-40.935 25-60-14.542-19.065-10-30 0-50M45 225s18.365 33.365 40 55c25 25 25 70 25 70" fill="none" stroke="#000" stroke-width="2"/>
  <path d="M41.99 220.962l4.487 14.94s.648-2.96 2.452-4.116c1.804-1.157 4.764-.51 4.764-.51zM110.996 353.304l1.802-15.496s-1.768 2.461-3.883 2.808c-2.114.347-4.576-1.42-4.576-1.42zM114.495 216.803l-3.266 15.254s1.993-2.282 4.131-2.426c2.138-.144 4.42 1.85 4.42 1.85zM410.67 256.459l-5.609 14.556s2.326-1.942 4.46-1.75c2.134.19 4.077 2.517 4.077 2.517zM271.198 296.334l-9.9 12.056s2.819-1.113 4.785-.26c1.966.852 3.079 3.67 3.079 3.67zM288.483 352.711l-8.81-12.874s.282 3.017-1.086 4.667-4.385 1.93-4.385 1.93zM241.736 353.324l-4.08-15.057s-.727 2.942-2.562 4.049c-1.835 1.107-4.777.38-4.777.38zM160.74 353.49l2.045-15.465s-1.806 2.433-3.926 2.747c-2.12.314-4.553-1.493-4.553-1.493zM223.925 297.986l-15.132 3.793s2.928.783 4 2.639c1.071 1.855.288 4.782.288 4.782zM140.966 352.795l2.318-15.427s-1.85 2.4-3.974 2.677c-2.125.276-4.526-1.573-4.526-1.573zM451.055 257.501l-10.272 11.742s2.852-1.025 4.79-.111c1.939.913 2.963 3.765 2.963 3.765zM423.156 371.465l14.729-5.142s-2.986-.516-4.221-2.267c-1.235-1.752-.719-4.738-.719-4.738z" stroke="#000" stroke-width=".429"/>
</svg>
<figcaption class="marginnote">
  <em>Our Current Repository Architecture</em>
  The APIs for Fedora and Solr are the integration layer between applications.
</figcaption>
</figure>

## An API-Driven Architecture

I believe that we can forestall our growing pains if we reexamine our architecture.
The collection of gems that makes up a "Hydra head"  which as also been colloquially referred to as the "Hydra neck"  isn't a good integration point across multiple applications because it ties every application too closely to Fedora and Solr.

Right now when we say "repository" we mean Fedora Commons.
When we say "repository" we _should_ mean a common API for storing and retrieving digital objects.
If we wrap Fedora and the canonical Solr index with an application that provides a [Hypermedia API][4] to the underlying content we can keep a lot of the complexity centralized.
This will effectively move the point of integration between our applications from the Fedora API to the new API that we have written to meet our needs.
This should lower the barrier of implementation for client applications after an upfront investment in time.

<figure class="illustration">
<svg xmlns="http://www.w3.org/2000/svg" version="1.2" viewBox="0 0 540 460">
  <title>Proposed Hydra Architecture</title>
  <desc>
    Block diagram with simple applciation stacks that communicate over a Hypermida API to a data abstraction layer.
    The API layer wrapps shared Fedora and Solr backing services and consolidates common content models and serializers.
  </desc>
  <defs>
    <style>.t,.c{font-size: 14px}.c{text-anchor:middle}.b{fill:none;stroke-linejoin:round}</style>
    <marker orient="auto" id="a" overflow="visible">
      <path d="M8.719 4.034L-2.207.016 8.719-4.002c-1.746 2.372-1.736 5.618 0 8.036z" transform="scale(.6)" fill-rule="evenodd" stroke-width=".625" stroke-linejoin="round"/>
    </marker>
    <marker orient="auto" id="b" overflow="visible">
      <path d="M8.719 4.034L-2.207.016 8.719-4.002c-1.746 2.372-1.736 5.618 0 8.036z" transform="scale(-.6)" fill-rule="evenodd" stroke-width=".625" stroke-linejoin="round"/>
    </marker>
  </defs>
  <path class="b" stroke="#000" d="M40 242.36h90v90H40z"/>
  <text x="65.354" y="295.748" font-size="24">Solr</text>
  <path class="b" stroke="#000" d="M140 242.36h220v130H140z"/>
  <text x="198.023" y="319.942" font-size="36">Fedora</text>
  <path class="b" stroke="#000" d="M370 187.36h60v35h-60z"/>
  <text class="c" x="399.924" y="202.858">
    <tspan x="399.924" y="202.858">Content</tspan><tspan x="399.924" y="216.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M370 227.36h60v35h-60z"/>
  <text class="c" x="399.924" y="242.858">
    <tspan x="399.924" y="242.858">Content</tspan><tspan x="399.924" y="256.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M370 267.36h60v35h-60z"/>
  <text class="c" x="399.924" y="282.858">
    <tspan x="399.924" y="282.858">Content</tspan><tspan x="399.924" y="296.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M370 307.36h60v35h-60z"/>
  <text class="c" x="399.924" y="322.858">
    <tspan x="399.924" y="322.858">Content</tspan><tspan x="399.924" y="336.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M435 187.36h60v35h-60z"/>
  <text class="c" x="464.924" y="202.858">
    <tspan x="464.924" y="202.858">Content</tspan><tspan x="464.924" y="216.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M435 227.36h60v35h-60z"/>
  <text class="c" x="464.924" y="242.858">
    <tspan x="464.924" y="242.858">Content</tspan><tspan x="464.924" y="256.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M435 267.36h60v35h-60z"/>
  <text class="c" x="464.924" y="282.858">
    <tspan x="464.924" y="282.858">Content</tspan><tspan x="464.924" y="296.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M435 307.36h60v35h-60z"/>
  <text class="c" x="269.924" y="322.858">
    <tspan x="464.924" y="322.858">Content</tspan><tspan x="464.924" y="336.298">Model</tspan>
  </text>
  <path class="b" stroke="#000" d="M435 347.36h65v20h-65z"/>
  <text class="t" x="440.946" y="362.253">Serializer</text>
  <path class="b" stroke="#000" d="M435 372.36h65v20h-65z"/>
  <text class="t" x="440.946" y="387.253">Serializer</text>
  <path class="b" stroke="#000" d="M435 397.36h65v20h-65z"/>
  <text class="t" x="440.946" y="412.253">Serializer</text>
  <path class="b" stroke="#000" d="M365 347.36h65v20h-65z"/>
  <text class="t" x="370.946" y="362.253">Serializer</text>
  <path class="b" stroke="#000" d="M365 372.36h65v20h-65z"/>
  <text class="t" x="370.946" y="387.253">Serializer</text>
  <path class="b" stroke="#000" d="M365 397.36h65v20h-65z"/>
  <text class="t" x="370.946" y="412.253">Serializer</text>
  <path class="b" stroke="#000" d="M40 212.36h90v20H40z"/>
  <text class="t" x="45" y="227.36">Blacklight</text>
  <path class="b" stroke="#000" d="M252.5 212.36h90v20h-90z"/>
  <text class="t" x="257.5" y="227.36">Om</text>
  <path class="b" stroke="#000" d="M157.5 212.36h90v20h-90z"/>
  <text class="t" x="162.5" y="227.36">Rubydora</text>
  <path class="b" stroke="#000" d="M205 187.36h90v20h-90z"/>
  <text class="t" x="210" y="202.36">ActiveFedora</text>
  <path fill="none" stroke="#000" stroke-width=".985" stroke-linejoin="round" stroke-dasharray=".98521988,.98521988" d="M30 177.36h480v255H30z"/>
  <text x="30" y="172.36" font-size="12">Hypermedia API Wrapper</text>
  <path class="b" stroke="#000" stroke-dasharray="1,1" d="M55 19.86h110v40H55z"/>
  <path class="b" stroke="#000" d="M65 29.86h90v20H65z"/>
  <text class="t" x="70" y="44.86">API Client</text>
  <path class="b" stroke="#000" stroke-dasharray="1,1" d="M190 7.36h160v65H190z"/>
  <path class="b" stroke="#000" d="M200 17.36h45v45h-45z"/>
  <text x="211.04" y="44.753">Solr</text>
  <path class="b" stroke="#000" d="M250 17.36h90v20h-90z"/>
  <text x="255" y="32.36">Blacklight</text>
  <path class="b" stroke="#000" d="M250 42.36h90v20h-90z"/>
  <text class="t" x="255" y="57.36">API Client</text>
  <path class="b" stroke="#000" stroke-dasharray="1,1" d="M370 7.36h110v65H370z"/>
  <path class="b" stroke="#000" d="M380 17.36h65v20h-65z"/>
  <text class="t" x="385" y="32.253">Serializer</text>
  <path class="b" stroke="#000" d="M380 42.36h90v20h-90z"/>
  <text class="t" x="385" y="57.36">API Client</text>
  <path d="M105 120l90 100M270 130v90M320 220l100-85" transform="translate(0 -52.64)" fill="none" stroke="#000" stroke-width="2" marker-start="url(#a)" marker-end="url(#b)"/>
</svg>
<figcaption class="marginnote">
  <em>The Proposed Repository Architecture</em>
  The persistence mechanism of digital objects is obfuscated by a common API.
  Complexity is centralized allowing for simpler client applications.
</figcaption>
</figure>

One of the topics that perennially pops up at Hydra meetings is: "What would Hydra look like without Fedora?"
The proposed API-driven architecture offers an answer.
Because it removes the Fedora API as the common interface between applications the entire persistence layer can be changed to anything that implements the API.
This also provides a benefit for developers because it would allow alternate implementations of the API, e.g. one backed by SQLite, to be used while developing repository-backed applications.


## Patron-Facing API Clients

While the centralized repository will have a canonical representation of each object most of the time an object belongs to a more specific context.
Groups of digital objects should be able to be embedded or re-cast in other interfaces as members of a collection, exhibit, or other specialized interfaces.

### Exhibit
An exhibit is a selection of items with particular scholarly significance.
They should stand alone or serve as digital companions to exhibits presented in the Rare Books exhibit area.
Exhibits may be as simple as static pages with embedded repository content.
There is room for a tool like Atrium to facilitate this process but it's present incarnation is more focused on "collections" than "exhibits"

### Collection
A collection interface is an alternative to a conventional finding aid.
Collections will typically be based on Blacklight and have their own collection-specific Solr indexes.

### Portal
A portal is a collection with additional features and visualizations.
We can provide value to our patrons with tools that enable them to sift, sort, and juxtapose our holdings.
The collection interface would typically be Blacklight-driven while the other components may be either shared visualization tools or one-off pieces as needed.


## Selector-Facing API Clients

One of the selling points of Hydra is that it can unite the patron-facing discovery interface with the curator-facing administrative interface within the same application.
While this is nice in some cases, such as in a self-submit style application, the needs of a patron and a curator can diverge dramatically in some cases.
In the Seaside project we split the administrative interface and the discovery interface into two applications.
This allows us to tailor the experience for each audience.
We can extend this idea further and create a variety of tools for adding and editing content into the repository to meet the needs of curators in different contexts.

### Single-item Editor
This can be accomplished in a traditional Hydra-style form view in an application.
To enable editing items from the front-end view we could create a simple browser extension, or perhaps even a bookmarklet, that embeds an editing interface onto the presentation page.
This would work best when there are only a few curators.

### Batch Ingest
There are a number of areas that use Filemaker Pro or other databases to manage their collections.
Thick clients are sometimes very helpful and we shouldn't force them to abandon their established workflow to accommodate our repository.
Hopefully writing an adapter from FMP using a client to our repository API will be simpler than our current solution of writing rake tasks that call ActiveFedora directly.

### Depository
In a depository privileged patrons can curate their own submissions.
In this case a conventional "Hydra head" like [Libra][5] and [ScholarSphere][3] would be a fine solution.


## Next Steps

There is a lot of work involved in this proposal.
Here are some of the deliverables:

- Determine if adding another layer of abstraction in our infrastructure will result in a net loss of work.
I believe it has the potential to do so but I have no empirical data.

- Design the one repository API to rule them all.
This will not be easy.
There are a lot of things to get wrong and arm waving about [HATEOS][6] doesn't make the technical challenges disappear.

- Implement the API.
If we do the design work up front this will easier but it is still a major project.

- Implement the repository API with a different persistence mechanism.
It would greatly simplify the development stack if the API could be implemented on top of something like Redis or SQLite.

- Write clients for the API.
A Ruby client and a JavaScript client would be a good start.

- Determine how to make repository content portable.
[oEmbed][1] is one option; are there others?


[1]: http://oembed.com/
[2]: http://onesearch.library.nd.edu/primo_library/libweb/action/search.do?vid=NDU
[3]: https://scholarsphere.psu.edu/
[4]: http://blog.steveklabnik.com/posts/2012-02-27-hypermedia-api-reading-list
[5]: http://libra.virginia.edu/
[6]: http://en.wikipedia.org/wiki/HATEOAS
