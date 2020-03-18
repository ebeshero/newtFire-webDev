xquery version "3.1";
(:ebb: Start your string-join() at the top of the file like I showed in my examples in the Class-Examples-2019 directory. You close your string-join after the concat function closes. The concat in your return is the first repeating part of your string-join().:)
(:  So the string-join() works like this:  :)
(: string-join(                            :)
(: YOUR XQUERY FLWOR STATEMENTS HERE       :)
 (: return concat(Source, '&#x9;', Edge, '&#x9;', Target), '&#x10;')         :)
(: See how the string-join() closes after the the concat?  It will bind all the concat() lines into one long string separated by hard-returns after each line.  :)
let $banksy := collection('/db/banksy')/element()
let $years := $banksy//date/@when
let $yearsDist := $years ! tokenize(., "-")[1] => sort() => distinct-values()
for $y in $yearsDist
let $names := $banksy//bibl/title
let $namesMatch := $names[following-sibling::date/@when[contains(., $y)]]/string() => sort()
return concat($y, ": ", $namesMatch => string-join("; "))
(: 2019-03-18 ebb: REVISE AND RESUBMIT: There are a couple of problems with this: 
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
 (: Then, for each year, go back on the tree and look for any title that is not the current title.  :)
 (: You want to return a title, its year, and then every other title connected to it, with one line for each of the other titles. :)

