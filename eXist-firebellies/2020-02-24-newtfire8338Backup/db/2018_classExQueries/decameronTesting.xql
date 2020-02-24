xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $engdecameron := doc('/db/decameron/engDecameronTEI.xml')/*
let $divTypes := $engdecameron//div/@type
let $distinctDivTypes := distinct-values($divTypes)
(: This will return 7 distinct div types: prologue, Day, introduction, novella, conclusion, epilogue, trailer :)
let $floatingText := $engdecameron//floatingText
(: floatingText elements marked when characters in the Decameron were telling stories inside the story :)
(: So, what if we want to network the characters as **collocated** in specific parts of the Decameron? :)
let $persNames := $engdecameron//persName/normalize-space()
let $distinctPeeps := distinct-values($persNames)
for $i in $distinctPeeps
(: ebb: LET'S TALK ABOUT NUMBER/CARDINALITY FOR OUTPUT. What our TSV-based network analysis needs is one node for each individual:)
let $edgeConnector:=
                     if ($engdecameron//persName[. = $i]/ancestor::floatingText) 
                              then "floatingText""
                     else if (XPath condition 2) 
                               then some-alternative-value-to-store--either XPath or "text"
                     else some-other-value-for-all-other-cases--either XPath or "text"