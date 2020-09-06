# build a simple table
iris %>%
  count(Species) %>%
  select(n, Species)->
table

# glue together text into a single variable
# ideally would auto-extract colnames to do this, rather than manual gluing
table %>%
  mutate(text_f = glue("{n} {Species}<br>")) ->
table_f

# count the maximum width in characters
# subtract 4 for "<br>"
char_wide <- max(nchar(table_f$text_f)) - 4

# collapse text to a single text string with linebreaks (except for the last line)
label <- glue_collapse(table_f$text_f) %>%
  str_extract(pattern = "^.+(?=<br>$)")

# set up locations of text boxes
df <- tibble( label = label,
              x = c(0.2, .6),
              y = c(0.8, .5))

# plot text boxes, with width in cm related to character count (plus one for spaces)
ggplot(df) +
  aes(
    x, y, label = label,
    hjust = c(0.5,0.5), vjust = c(0.5,0.5)
    ) +
    geom_textbox(width = unit((char_wide)*0.2, "cm")) +
    xlim(0, 1) + ylim(0, 1)

