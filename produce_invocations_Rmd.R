
### --- project
### --- Q1 universe is mine
### --- QR codes to Wikidata entity URLs

### --- script
### --- produce_invocations_Rmd.R

### --- lib
library(magrittr)

### --- header

header <- "---
title: Invocations\\:\\ Q1 universe is mine.
author:
- name: \\@GSMilovanovic
date: \"`r format(Sys.time(), '%d %B %Y')`\"
abstract: 
output:
  html_document:
    theme: cosmo
    toc: no
    includes:
      in_header: header.html
---

"

### --- Invocations

intro <- 
  paste0("[![](_img/github.png)]",
         "(https://github.com/GoranMilovanovic/q1universeismine)  ",
         "[![](_img/twitter.png)]",
         "(https://twitter.com/q1universe)  ",
         "[![](_img/instagram.png)]",
         "(https://www.instagram.com/q1universeismine)  ",
         "<hr>",
         "<br>")

### --- text
text <- "All presented works are **invocations**.<br><br>
Each work encompasses two components:<br><br>
- a **Symbol** (a tokenized digital image which adheres to ownership), and<br>
- an **Invoked** (which is instantiated only upon interaction with the Symbol).
<br><br>
An Invocation is complete *only upon interaction* with the Symbol which 
produces the Invoked.<br><br>
**Example.** From the [Q1 Universe is mine.](https://www.q1universeismine.net)
project:<br><br>
![](_img/invocation.png)<br><br>
- The **Symbol** is to the left in the schema;<br>
- **I** represents the **Invoked** in the schema 
(which is a page view of [https://www.wikidata.org/wiki/Q42?@gsmilovanovic](https://www.wikidata.org/wiki/Q42?@gsmilovanovic) in this example - 
a digitally signed URL of Q42 in Wikidata;<br>
- An **Invocation** is a complete piece only upon interaction: **Symbol &#8594; I**."

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
  "**Invocations:Q1 universe is mine.  rendered on: 2021/09/25**",
  "<br><br><br>"
  )

### --- compose

cmp_rmd <- paste0(
  header,
  intro,
  text, 
  footer
)
writeLines(cmp_rmd, 
           "invocations.Rmd")

### --- render
rmarkdown::render("invocations.Rmd")
