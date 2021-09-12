
### --- project
### --- Q1 universe is mine
### --- QR codes to Wikidata entity URLs

### --- script
### --- produce_q1universeismine_Rmd.R

### --- header

header <- "---
title: Q1 universe is mine.
author:
- name: \\@GSMilovanovic
  affiliation: DataKolektiv
date: \"`r format(Sys.time(), '%d %B %Y')`\"
abstract: 
output:
  html_document:
    theme: cosmo
    toc: no
---

"

### --- intro

intro <- paste0("<hr>", 
                "**QR code references to first 1,000 Wikidata entities.**",
                "<br>",
                "**All these worlds are yours. ", 
                "Attempt no landing at other entities.**",
                "<br>")

### --- art

# - art: load wd_entities_frame
wd_entities_frame <- read.csv(
  paste0(getwd(), "/_art_frame/universeQ1ismine_frame.csv"),
  header = TRUE,
  check.names = FALSE,
  row.names = 1,
  stringsAsFactors = FALSE
  )

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
  "<hr>",
  paste0("Production ended: ", 
         as.character(
           as.POSIXlt(Sys.time(), 
                      tz = "UTC")
         ), 
         " UTC."),
  "<br>",
  "<br>",
  "[![](_img/CC0_button.png)]", 
  "(https://creativecommons.org/share-your-work/public-domain/cc0/)   ",
  "[![](_img/GitHub-Mark-32px.png)](https://github.com/GoranMilovanovic)",
  "<br><br><br>"
  )

### --- compose

cmp_rmd <- paste0(
  header,
  intro,
  components, 
  footer
)
writeLines(cmp_rmd, "_q1universeismine.Rmd")

### --- render
rmarkdown::render("_q1universeismine.Rmd")
