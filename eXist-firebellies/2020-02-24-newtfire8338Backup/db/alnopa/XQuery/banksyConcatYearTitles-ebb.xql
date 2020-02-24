xquery version "3.1";
(: Alyssa: Let's go over how to get some good TSV output from Banksy for your network analysis. Take a look at my example in the Class-Examples-2019 folder to see how to set up the XQuery file with the wrapping string-join() function holding the concat() returns.
(:  So, the string-join() works like this:  :)
(: string-join(                            :)
(: YOUR XQUERY FLWOR STATEMENTS HERE       :)
 (: return concat(Source, '&#x9;', Edge, '&#x9;', Target), '&#x10;')         :)
(: See how the string-join() closes after the the concat?  It will bind all the concat() lines into one long string separated by hard-returns after each line.  :)
 :  :)
 (:(: 2019-03-18 ebb: REVISE AND RESUBMIT: There are a couple of problems with this: 
 : 1) It's not going to make a tab-separated values file, because you are using a colon to separate your values. :)
(: 2) The other problem is that you have one year and several titles. The network analysis software can't deal with that.
 : Our network analysis software needs data to come in like this:
 : Source-Node [tab] Edge-Connection [tab] Target-Node [hard-return] :)
(: : Here's the special characters we need for that:    :) 
 (: Source-Node &#x9; Edge-Connection &#x9; Target-Node  &#10;  :)
(:  I think what you're trying to plot here is what artworks are prepared on a given year, right?
 : Think of the year as your Edge-Connection, since you are looking for titles of artworks that share the year:)
(:  What you want to output is Title &#x9; Year &#x9; Other-Title-In-That-Year :)
(: You need one of these on each line.  :) 
(:  I would redo this XQuery so that you first output a for-loop of the titles, and for each title, return its year. :)
 (: Then, for each year, go back on the tree and look for any title that is not the current title. You will need to write a new for-loop to go through each of those. :)
 (: You want to then return your concat() with a title, its year, and then every other title connected to it, with one line for each of the other titles.  :)
 :)
concat("1999", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "1999")]] => string-join("; ")),
concat("2000", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2000")]] => string-join("; ")),
concat("2001", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2001")]] => string-join("; ")),
concat("2002", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2002")]] => string-join("; ")),
concat("2003", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2003")]] => string-join("; ")),
concat("2004", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2004")]] => string-join("; ")),
concat("2005", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2005")]] => string-join("; ")),
concat("2006", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2006")]] => string-join("; ")),
concat("2007", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2007")]] => string-join("; ")),
concat("2008", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2008")]] => string-join("; ")),
concat("2009", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2009")]] => string-join("; ")),
concat("2010", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2010")]] => string-join("; ")),
concat("2011", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2011")]] => string-join("; ")),
concat("2012", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2012")]] => string-join("; ")),
concat("2013", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2013")]] => string-join("; ")),
concat("2014", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2014")]] => string-join("; ")),
concat("2015", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2015")]] => string-join("; ")),
concat("2016", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2016")]] => string-join("; ")),
concat("2017", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2017")]] => string-join("; ")),
concat("2018", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2018")]] => string-join("; ")),
concat("2019", ": ", collection('/db/banksy')//sourceDesc//title[following-sibling::date/@when[contains(., "2019")]] => string-join("; "))