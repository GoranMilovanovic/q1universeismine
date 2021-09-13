
### --- project
### --- Q1 universe is mine
### --- QR codes to Wikidata entity URLs

### --- script
### --- _q1universeismine.R

### --- license

usethis::use_cc0_license()

### --- produce entity URLs

wd_prefix <- 
  "https://www.wikidata.org/wiki/"
entities <- paste0("Q", 1:1000)
wd_entities <- paste0(wd_prefix, entities)

### --- list works

wb_api_prefix <- 
  "https://www.wikidata.org/w/api.php?action=wbgetentities&format=json&ids="
wd_entities_frame <- lapply(entities, function(x) {
  ent <- httr::GET(
    paste0(wb_api_prefix, x)
  )
  ent <- rawToChar(ent$content)
  ent <- jsonlite::fromJSON(ent)
  lab <- ent$entities[[1]]$labels$en$value
  desc <- ent$entities[[1]]$descriptions$en$value
  return(
    list(
      qid = x,
      label = lab,
      description = desc, 
      timestamp = as.character(
        as.POSIXlt(Sys.time(), 
                   tz = "UTC")
        )
      )
  )
}) 
# - collect
wd_entities_frame <- data.table::rbindlist(wd_entities_frame)

### --- add URLs

wd_entities_frame$URL <- wd_entities

### --- add titles

prefix <- "https://www.q1universeismine.net#"
wd_entities_frame$title <- paste0(prefix, 
                                  wd_entities_frame$qid)

### --- fix labels and descriptions: what is missing? (at least in en)

wd_entities_frame$label[is.na(wd_entities_frame$label)] <- ""
wd_entities_frame$description[is.na(wd_entities_frame$description)] <- ""

### --- add pricing in ETH

wd_entities_frame$e_init <- (1000:1)/100

### --- store wd_entities_frame

write.csv(wd_entities_frame, 
          paste0(getwd(), "/_art_frame/universeQ1ismine_frame.csv"))

### --- produce QR codes

# - admissible colors
sCols <- c("blue", "red", "yellow", 
           "orange", "violet", "green", 
           "white")
# - QR code
art <- lapply(wd_entities_frame$URL, function(x) {
  w <- which(wd_entities_frame$URL == x)
  # - filename
  qrname <- paste(
    wd_entities_frame$qid[w],
    wd_entities_frame$label[w], 
    "is mine."
  )
  qrname <- gsub("  ", " ", qrname, fixed = TRUE)
  qrname <- ifelse(nchar(qrname) > 80,
                   paste0(substr(qrname, 1, 40),
                          "... is mine"),
                   qrname)
  qrname <- paste0(qrname, ".png")
  qrname <- gsub("..", ".", qrname, fixed = TRUE)
  
  qrname <- iconv(qrname, 
                  "latin1",
                  "ASCII",
                  sub= " ")
  qrname <- gsub("\\s+", "_", qrname)
  qrname <- paste0("_qr/", qrname)
  # - plot QR code
  par(mar = c(1, 1, 1, 1))
  png(qrname)
  # - random background color
  sCol <- sample(sCols, 1)
  qrcode::qrcode_gen(dataString = x, 
                     wColor = sCol)
  dev.off()
  # - crop QR code image
  img <- imager::load.image(qrname)
  img <- imager::imsub(img,
                       x < 428,
                       y < 428)
  imager::save.image(img, qrname)
})
