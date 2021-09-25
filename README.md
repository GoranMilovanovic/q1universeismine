# Q1 universe is mine.
[q1universeismine.net](https://www.q1universeismine.net/)

**QR code references to first 1000 [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page) entities,
digitally signed by the artist.**<br> 
**All these worlds are yours. Attempt no landing at other entities.**

![](_img/twitter_header.png)

1,000 NFT collectables will be dropped in 20 batches (50 items each) beginning in September 2021.<br>
They will be dropped into [OpenSea](https://opensea.io/) via [Polygon](https://polygon.technology/).<br>
Follow [@q1universe](https://twitter.com/q1universe) on Twitter for drop announcements.<br>
The items are fractionally priced, decreasing in price from Q1 Universe is mine.

**They are concepts, and have references: own them. All of them.**

--- 

**Code**

`_q1universeismine.R`
- fetch Wikidata items
- obtain `en` label where available
- digitally sign in the URL query string
- pricing
- pick random background color
- timestamp
- add random batch
- produce QR codes.

`produce_q1universeismine_Rmd.R`
- abstraction to produce `index.Rmd` and
- render `index.html`;
- the rendered batch(es) are controlled via `sb`.
