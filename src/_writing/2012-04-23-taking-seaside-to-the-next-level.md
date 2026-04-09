---
date: 2012-04-23
type:        writing
author:      Dan Brubaker Horst
description: An outline for future development on the Seaside Research Portal.
categories:
 - Archived
tags:
 - digital humanities
 - ND
 - Seaside
title:       Next Steps for the Seaside Research Portal
---

## Enhance Experience

### &#9733;&#9733; Interactive Map

#### Desired
 - Migrate from Google Maps to [Leaflet][7]
 - Provide a [GeoJSON][29] representation of search results
 - Support devices with touch-driven interfaces e.g. phones, tablets

#### Nice-to-have
 - Add other layers of information to the map
   - Relevant photos
   - [Nolli map][10] style infrastructure overlays
   - Overlays from town plans and aerial photos made using [ArcGIS][8]
 - Generate custom map tiles using [TileMill][9]
 - Build walking tours and other modes of interaction with the map

### &#9733;&#9733; Responsive Design

#### Desired
 - Flex layout to accommodate multiple viewports
   - Mobile portrait and landscape
   - Tablet portrait and landscape
   - Desktop widescreen
   - Full HD TV
 - Switch to &#8220;responsive images&#8221; for slideshow and other hero images
   - The size of the images should relate to the viewport size
   - Use background images set by media queries (or possibly JavaScript)
     - Have links to high-resolution images (possibly gated)

#### Nice-to-have
 - Build rack [RESS][13] module to provide [modernizer][14]-like switching in the page template
 - Support for high-resolution (&#8220;retina&#8221;) screens
   - Have double resolution images available using the ['@2x' syntax][11]
   - Investigate using a JavaScript switching library like [Retina.js][12]
 - Implement IIIF-compliant image server for &#8220;responsive images&#8221;

### &#9733; Interaction and Display
 - Improve presentation of single images
   - Lightbox image displays don't work well when zoomed in on a mobile device
   - Show metadata from the parent structure alongside the image
   - Be able to advance from one image to the next by clicking on the side of the present image
 - Allow for date range search with a slider similar to [ARTstor][28] (histogram is optional)

### &#9733; Support Touch Devices
 - Navigation elements should be sufficiently large
 - Allow swiping gestures in relevant contexts
 - Allow pinch zooming on maps and images viewers

### &#9733; Image Gallery
 - Generated thumbnails don't look good. Switch to [ImageMagick][27] (or something else) for thumbnail generation.
 - Allow for browsing large collections of images with possible inspiration from:
   - [500px][15]
   - [Google Image Search][16]
 - Have a more intimate viewing experience when viewing an image with possible inspiration from:
   - [Art.sy][17]
   - [500px][18]

### &#9734; Search Engine Optimization
 - Have a [generated sitemap][19]
 - Follow recommendations of [Google Webmaster Tools][20]
 - Use [microformats and microdata][21]
   - For navigation elements e.g. [SiteNavigationElement][22] and [SearchResultsPage][23]
   - For content with the goal of supporting [rich snippets][24]

### &#9734; Measuring User Engagement
 - Track user interaction with site elements
 - Follow user paths through the site, possibly with the aid of additional tools:
   - [Mixpanel][25]
   - [crazyegg][26]


## Facilitate Research
 - Implement Authentication/Authorization system that can mediate on-campus and off-campus accounts
   - Account management
   - Permissions management
 - Organizational Tools
   - Bookmark Items
   - Save searches
 - Data portability
   - Provide citation information for each item
   - Export records to [Refworks][2] or Endnote
   - Integrate with other library services e.g. eShelf (not yet developed)
   - Integrate with [Zotero][3] (and possibly other 3rd party tools)
 - Allow Requests for additional services


## Facilitate Curation
 - Improve cataloging experience by doing one of the both of the following:
   - Enhance the current web interface
   - Build an intermediary datastore that could be accessed using FileMaker Pro
 - Batch operations
   - Uploading multiple images at once
   - Easy association building between groups of items
   - Tagging sets of pictures at once
 - Editing tools
   - Enhanced editor for HTML content
   - Allow for editing of content pages that live outside of Fedora
 - Data modeling
   - Capture relationships between architects and firms over time
   - Revisions for structures
   - Greater diversity of roles for contributors e.g. contractor, landscaper


## Community Engagement
 - Bring in photos from other sites
   - [Flickr][4]
   - [Picasa Web][5]
   - [Panoramio][6]
   - Others?
 - Allow for user submissions to be added to our holdings
   - Photos
   - Stories
   - Videos
   - Comments (in appropriate contexts)
 - Encourage end-user metadata enrichment
   - Allow for tagging and moderated comments
   - Track edits and monitor for abuse
   - Recognize top contributors
   - Certify that authenticity of certain accounts
   - Allow for commentary from notable people e.g. Robert Davis
   - "moderators" from ND and other institutions


[1]:  http://seaside.library.nd.edu
[2]:  http://www.refworks.com/
[3]:  http://www.zotero.org/
[4]:  http://www.flickr.com
[5]:  https://web.archive.org/web/20060701142231/http://picasaweb.google.com/
[6]:  http://www.panoramio.com/
[7]:  https://leafletjs.com
[10]: https://web.archive.org/web/20050723021505/http://nolli.uoregon.edu/
[29]: http://geojson.org/geojson-spec.html
[8]:  http://www.esri.com/software/arcgis/index.html
[9]:  http://mapbox.com/tilemill/
[11]: http://developer.apple.com/library/ios/#documentation/2DDrawing/Conceptual/DrawingPrintingiOS/SupportingHiResScreens/SupportingHiResScreens.html
[12]: http://retinajs.com/
[13]: http://www.lukew.com/ff/entry.asp?1392
[14]: http://modernizr.com/
[15]: http://500px.com/
[16]: http://www.google.com/search?q=seaside+florida&tbm=isch
[17]: http://art.sy/
[18]: http://500px.com/photo/4155299
[19]: https://github.com/jronallo/blacklight-sitemap
[20]: http://www.google.com/webmasters/tools/
[21]: http://schema.org/
[22]: http://schema.org/SiteNavigationElement
[23]: http://schema.org/SearchResultsPage
[24]: http://www.google.com/webmasters/tools/richsnippets
[25]: https://mixpanel.com/
[26]: http://www.crazyegg.com/
[27]: http://www.imagemagick.org/script/command-line-options.php#thumbnail
[28]: http://library.artstor.org/library/welcome.html#3|search|6|All20Collections3A20column20of20trajan|Filtered20Search|||type3D3626kw3Dcolumn20of20trajan26geoIds3D26clsIds3D26id3Dall26bDate3D26eDate3D26dExact3D3126prGeoId3D
