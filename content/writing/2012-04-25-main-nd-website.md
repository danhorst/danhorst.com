---
type:        writing
author:      Dan Brubaker Horst
description: Observations and notes about the 2012 responsive redesign of nd.edu.
categories:
 - Archived
tags:
 - design
 - mobile
 - ND
 - responsive
title:       What I Know About The nd.edu Website
---

## The present (2011) website
 - is the second responsive design for nd.edu
   - there are layout adjustments at: 481px, 530px, 700px, 701px, 768px, 960px, 1050px, 1200px, and 1400px
   - media queries are sized in ems instead of px to avoid text resizing issues in some browsers
 - is "mobile first"
   - the site was designed with a phone-sized viewport as the primary target
   - small images are sent first, then large ones if needed
 - is _NOT_ using a content management system of any kind
   - the website is a relatively simple PHP template
   - the pages are all the root file, index.php, within a directory hierarchy
   - there is only one person who updates the content that is not syndicated into the site and they do it using Dreamweaver
 - uses progressive enhancement to deliver
   - in-line SVG (vector images) for some logos including the one in the top left that anchors the navigation with a raster images fall back
   - embedded versions of the official university typefaces
 - employs [RESS][1] to alter how the template is rendered based on the UserAgent of the requesting device
   - at present this is limited to answering the question "Is this a mobile device"
   - the general idea is to store "modernizer-like" values in a cookie that is set on the initial request
     - this was initially implemented using [Detector][2] but it didn't behave as originally hoped
     - the current implementation is an in-house developed script that consists mostly of regular expression matching against the incoming UserAgent
   - if the website is loaded on a mobile device:
     - the large, image slider in the background is not loaded at all
     - only one of the web fonts is loaded
     - the drop down menus in the main navigation are not loaded
 - loads large images, such as the ones in the image sliders, using media queries
   - pictures in sliders are all background images so their source file and dimensions can be adjusted with CSS
   - images in the large slider are scaled to the size of their containing element using "background-size: cover"
   - high resolution ("retina") screens are supported with double resolution images using the "device-pixel-ratio" media query
 - uses several open-source, or liberally licensed components
   - [jQuery][3] as the foundation for all the site JavaScript
   - [modernizer][4] to enable client-side progressive enhancement
   - [Flexslider][5] for both of the image sliders on the main page

## Responsive Design Resources

 - Eric recommended _[Responsive Web Design][6]_ by [Ethan Marcotte][7] which informed the implementation of the first responsive redesign of nd.edu.
 - I maintain [a page documenting my understanding of responsive design][8].

## Professional Development

Conferences Agency has developers to:

 - [Breaking Development][9]
 - [HighEdWeb][10]
 - [RailsConf][11]

[1]:  http://www.lukew.com/ff/entry.asp?1392
[2]:  https://github.com/dmolsen/Detector
[3]:  http://jquery.com/
[4]:  http://modernizr.com/
[5]:  http://www.woothemes.com/flexslider/
[6]:  http://www.abookapart.com/products/responsive-web-design
[7]:  https://x.com/beep
[8]:  /writing/responsive-design
[9]:  http://bdconf.com/
[10]: http://www.highedweb.org/
[11]: http://railsconf.com/
