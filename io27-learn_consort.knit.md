---
title: "Tutorial"
output: learnr::tutorial
always_allow_html: true
runtime: shiny_prerendered
---




## Setting up ggplot for CONSORT

### Exercise 1

*Here's a simple exercise with an empty code chunk provided for entering the answer.*
ggplot is based on the grammar of graphics, so that layers are added one at a time.

The layers are

1. Data
2. Aesthetics 
3. Scales 
4. Geometric objects
5. Statistics (calculated)
6. Facets, if any
7. Coordinate System

The first layer is the axis grid, sized based on the available data.
If you call ggplot with data and an aesthetic layer, but no geom,
you will get the basic grid and axes, but not plotted data.

Edit the R code below to make a tall grid that is 100 units wide by 200 units tall:

<div class="tutorial-exercise" data-label="setup_grid" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
# This example sets up a grid that is 45 wide by 90 tall (before editing)
data <- tibble(x=1:45, y = seq(from= 2, to=90,by =2))
ggplot(aes(x, y), data = data) + 
  theme_bw()
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

## Topic 2

### Adding rectangles

Use the example of the tall grid above to make a grid,
and place a geom_rect() near the top.

the arguments for geom-rect include:

Parameters
* xmin - (required) left edge of rectangle
* xmax - (required) right edge of rectangle
* ymin - (required) bottom edge of rectangle
* ymax - (required) top edge of rectangle
* size - (default: 0.5) line width of the rectangle's outline
* linetype - (default: 1=solid) line type of the rectangle's outline
* color - (default: NA=no outline) color of the rectangle's outline
* fill - (default: "grey20") fill color of the rectangle
* alpha - (default: 1=opaque) transparency of the rectangle's fill

Experiment with the arguments.

Then add a rectangle with a different appearance near the bottom.

<div class="tutorial-exercise" data-label="rectangles" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
# This example sets up a grid that is 45 wide by 90 tall (before editing)
data <- tibble(x=1:45, y = seq(from= 2, to=90,by =2))
ggplot(aes(x, y), data = data) + 
  theme_bw() +
  geom_rect(xmin= ,
            xmax= ,
            ymin= ,
            ymax= ,
            size= ,
            fill= )
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

## Topic 3

### Adding text

Use the tall grid with rectangles,
then add text in the boxes with annotate.

Annotate takes the form of a geom:
annotate("text", x = 4, y = 25, label = "Some text")

You can also use color, size, etc. as arguments,
and annotate with "rect", or "segment", or "pointrange"

https://ggplot2.tidyverse.org/reference/annotate.html

Try to add text inside your boxes.
you may want to use a small size=2 to start.

<div class="tutorial-exercise" data-label="text" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
# This example sets up a grid that is 45 wide by 90 tall (before editing)
data <- tibble(x=1:45, y = seq(from= 2, to=90,by =2))
ggplot(aes(x, y), data = data) + 
  theme_bw() +
  geom_rect(xmin= ,
            xmax= ,
            ymin= ,
            ymax= ,
            size= ,
            fill= ) +
  annotate("text", x = 4, y = 25, label = "Some text")
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>


## Topic 4

### Adding line segments / arrows

Use your grid and boxes with text, then 
connect them with arrows to make a flow diagram

You will add arrows with geom_segment()

Use help or ?? to look up the arguments for geom_segment()

An example of one arrow segment is provided below to get you started. Add this arrow, then move it to
where you want it to make flow diagrams by changing 
x, xend, y, and yend.

https://ggplot2.tidyverse.org/reference/geom_segment.html


<div class="tutorial-exercise" data-label="arrows" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
# This example sets up a grid that is 45 wide by 90 tall (before editing)
data <- tibble(x=1:45, y = seq(from= 2, to=90,by =2))
ggplot(aes(x, y), data = data) + 
  theme_bw() +
  geom_rect(xmin= ,
            xmax= ,
            ymin= ,
            ymax= ,
            size= ,
            fill= ) +
  annotate("text", x = 4, y = 25, label = "Some text") +
  geom_segment(
    x=2, xend=2, y=49, yend=15.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed"))
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>


Okay, now you have a simple flow diagram.
You can use these skills to build your own CONSORT diagram!
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server-start">
library(learnr)
knitr::opts_chunk$set(echo = FALSE)
library(tidyverse)
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
learnr:::register_http_handlers(session, metadata = NULL)
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
session$onSessionEnded(function() {
        learnr:::session_stop_event(session)
      })
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-setup_grid-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-setup_grid-code-editor`)), session)
output$`tutorial-exercise-setup_grid-output` <- renderUI({
  `tutorial-exercise-setup_grid-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-rectangles-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-rectangles-code-editor`)), session)
output$`tutorial-exercise-rectangles-output` <- renderUI({
  `tutorial-exercise-rectangles-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-text-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-text-code-editor`)), session)
output$`tutorial-exercise-text-output` <- renderUI({
  `tutorial-exercise-text-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-arrows-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-arrows-code-editor`)), session)
output$`tutorial-exercise-arrows-output` <- renderUI({
  `tutorial-exercise-arrows-result`()
})
</script>
<!--/html_preserve-->
