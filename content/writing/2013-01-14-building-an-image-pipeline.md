---
type:        writing
author:      Dan Brubaker Horst
description: Our needs for image dissemination are a bit different than normal.
categories:
 - Archived
tags:
 - digital humanities
 - image processing
 - ND
title:       Building an Image Pipeline
---

## Setting Expectations

We have a variety of needs when it comes to preserving and presenting image files to our patrons.
Raster images will be stored in three forms: the archival master, the presentation master, and a thumbnail.

The archival master will be stored at full resolution in the original file format.
The original file will only be available to patrons on request.
It will not be exposed to the Internet.

The presentation master will stored in a multi-resolution image format and be used to generate the images delivered to our patrons.
The presentation master will not be made available to the patron &mdash; they will not be aware that it exists.
Access to the derivatives of the presentation master will be restricted based on the access rights of the image.

The thumbnail will be a JPEG scale of the original images with a 200px longest side.
Thumbnails will be made available to the public for all of our image content _unless_ the image is explicitly marked private.

### Accepted Formats for Archival Masters
 - DNG
 - JPEG (not recommended for archival masters)
 - PNG[^1]
 - TIFF

### Disallowed Formats for Archival Masters
 - GIF
 - JPEG2000
 - Camera RAW e.g. CR2, NEF, ARW
 - Graphics program formats e.g. PSD, XCF
 - Archaic formats e.g. PICT

### Derivatives Made from Presentation Masters
 - JPEG encoded scale of the image up to 3000px a side
 - JPEG encoded crop of the image up to 3000px a side
 - JPEG encoded tile of a crop or a scale 256px per side
 - JPEG encoded thumbnail 200px per side


## Image Processing

<figure class="illustration">
<figcaption class="marginnote">
  Image Pipeline Block Diagram
</figcaption>
<div id="image-pipeline-design" class="canvas">
  <img src="/img/image-pipeline-design.svg" alt="A line drawing of the components of the proposed image pipeline.">
</div>
</figure>

The image pipeline only accommodates raster image files of particular file types.
Other image formats, like EPS, will be treated as regular files.

[^1]: PNG is the only accepted format that has an alpha channel. There is no plan to preserve transparency in the image pipeline.
