# vkdt

## a graph-based photography workflow tool

![node-editor](img/screen-nodes.jpg)

## how is it different to darktable?

after developing [darktable](https://darktable.org) for about ten years,
why did i restart from a new codebase?

the vkdt project addresses several shortcomings of the core architecture of dt.
these points are the main motivation to start fresh:


**developer sanity**

* single code-path GPU processing only (not i386, SSE/AVX, OpenCL mixed)
* single pipeline with full res full region only (no need to sync gui, preview, cropped)
* bloat free
* no gtk (also no qt)
* introspection code not needed: configs are human readable
* most data stays on the GPU from initial processing to display
* strict separation of gui (`c++`) and core code (`c`, `glsl`)
* module reordering/multi instancing transparently solved with a node graph


**core processing features**

* vkdt does roughly 20x more work and is roughly 20x faster at the same time
  (don't ask me how this happens, classic dt just loses speed between the
  cracks)
* more speed means we can enable more advanced modules by default, pain free (see below)
* processing is a node graph: vkdt supports multiple inputs (merge/align
  frames) and multiple outputs (variants, histograms, ..) at the same time


**user facing features**

* full res raw processing usually faster than vsync
* supports 10-bit displays out of the box (try this with gtk/cairo..)
* better highlight inpainting
* interactive brush strokes (pentablet) with guided smoothing
* local laplacian pyramids for local contrast
* deconvolution sharpening
* thumbnail processing is disk i/o limited (be sure to use fast SSD where you
  can) and rawspeed limited: some raws can be decoded quicker (RAF) than
  others (CR2)
* animated graphs with optional feedback loops
* full screen colour management that supports dual monitors even when the
  window is split between the two
* support for raw video (mlv) and ldr video (mp4, mov)


## screenshots

images shown here are taken from the playraw category on [pixls.us](https://pixls.us).

lighttable mode:

[![](img/screen-lt.jpg)](img/screen-lt.jpg)

darkroom mode, showing the configurable favourites tab:

[![](img/screen-dr-fav.jpg)](img/screen-dr-fav.jpg)

darkroom mode, showing the node graph connections:

[![](img/screen-dr-con.jpg)](img/screen-dr-con.jpg)
