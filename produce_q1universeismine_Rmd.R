
### --- project
### --- Q1 universe is mine
### --- QR codes to Wikidata entity URLs

### --- script
### --- produce_q1universeismine_Rmd.R

### --- lib
library(magrittr)

### --- header

header <- "---
title: Q1 universe is mine.
author:
- name: \\@GSMilovanovic
date: \"`r format(Sys.time(), '%d %B %Y')`\"
abstract: 
output:
  html_document:
    theme: cosmo
    toc: no
---

"

### --- intro

intro <- 
  paste0("[![](_img/github.png)]",
         "(https://github.com/GoranMilovanovic/q1universeismine)  ",
         "[![](_img/twitter.png)]",
         "(https://twitter.com/q1universe)  ",
         "[![](_img/instagram.png)]",
         "(https://www.instagram.com/q1universeismine)  ",
         "<hr>",
         "**QR code references to first 1000 Wikidata entities,",
         "<br>",
         "digitally signed by the artist. All these worlds are yours.",
         "<br>",
         "Attempt no landing at other entities.**",
         "<br><br>",
         "1,000 NFT collectables will be dropped<br>",
         " in 20 batches (50 items each) beginning in September 2021.<br>",
         "They will be dropped into [OpenSea](https://opensea.io/)",
         " via [Polygon](https://polygon.technology/).<br>",
         "Follow [\\@q1universe](https://twitter.com/q1universe) ",
         " on Twitter for drop announcements.<br>",
         "The items are fractionally priced, decreasing in price from<br>",
         "Q1 Universe is mine.<br>",
         "**They are concepts, and have references: own them. All of them.**")

### --- art

# - art: load wd_entities_frame
wd_entities_frame <- read.csv(
  paste0(getwd(), "/_art_frame/universeQ1ismine_frame.csv"),
  header = TRUE,
  check.names = FALSE,
  row.names = 1,
  stringsAsFactors = FALSE
  )

# - select batches to run
sb <- 1
wd_entities_frame <- wd_entities_frame %>% 
  dplyr::filter(batch %in% sb)

# - art:components
lF <- list.files("_qr/")
components <- lapply(wd_entities_frame$qid, function(x) {
  # - locate text
  w <- which(wd_entities_frame$qid  == x)
  # - locate QR code
  wQR <- which(grepl(paste0("^", x, "_"), lF))
  # - identifier
  id_q <- paste0("{#", x, "}")
  # - produce
  text <- paste0("<hr>",
                 "<h3>", 
                 "<a name=\"", 
                 x, 
                 "\"></a>",
                 x, 
                 " ", 
                 wd_entities_frame$label[w], 
                 " is mine.",
                 "</h3>",
                 ifelse(
                   wd_entities_frame$description[w] != "",
                   wd_entities_frame$description[w],
                   "No description"
                 ),
                 "<br>",
                 "[",
                 wd_entities_frame$title[w],
                 "]",
                 "(",
                 wd_entities_frame$title[w],
                 ")", 
                 "<br>",
                 "", 
                 wd_entities_frame$timestamp[w],
                 " UTC",
                 "<br>",
                 "B", wd_entities_frame$batch[w],
                 "  **&Xi; ", wd_entities_frame$e_init[w],
                 "**<br>",
                 "[![](",
                 paste0("_qr/", lF[wQR]),
                 ")](", 
                 wd_entities_frame$URL[w], 
                 ")",
                 "{ width=45% }")
  text <- gsub("  ", " ", text, fixed = TRUE)
  # - output
  return(text)
})
components <- paste(components, 
                    sep = "<br>", 
                    collapse = "")

### --- footer 

footer <- paste0(
  "<br>",
  "<hr>",
  "[![](_img/github.png)]", 
  "(https://github.com/GoranMilovanovic/q1universeismine)  ",
  "[![](_img/twitter.png)]",
  "(https://twitter.com/q1universe)  ",
  "[![](_img/instagram.png)]",
  "(https://www.instagram.com/q1universeismine)  ",
  "<br><br>",
  "**QR references rendered on: 2021/09/25**",
  "<br><br><br>"
  )

### --- compose

cmp_rmd <- paste0(
  header,
  intro,
  components, 
  footer
)
writeLines(cmp_rmd, 
           "index.Rmd")

### --- render
rmarkdown::render("index.Rmd")
