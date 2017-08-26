xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $ThisFileContent:=
string-join(
let $decameron := doc('/db/decameron/engDecameronTEI.xml')
let $people := $decameron//text//persName
let $distinctPeople  := distinct-values($people)
for $p in $distinctPeople
let $peers:=
             
         if (//text//persName[. = $p]/ancestor::floatingText)
                then distinct-values(//persName[. = $p]/ancestor::floatingText//persName[. != $p])
       (: else if (//persName [.= $p][not(ancestor::floatingText)][ancestor::div[1]/@type='novella'] 
                then distinct-values(//persName[. = $p]/ancestor::div[1]//persName[. != $p]) :)
         else (distinct-values(//persName[. = $p][not(ancestor::floatingText)]/ancestor::div[1]//persName[. != $p]))
         
      let $edgeType:=
        if (//persName[. = $p]/ancestor::floatingText)
               then "floatingText"
        else if (//persName[. = $p][not(ancestor::floatingText)]/ancestor::div[1][@type="novella"])
               then "novella"
        else "frame"  
         
    for $peer in $peers
    return
         concat($p, "&#x9;", $edgeType, "&#x9;",$peer), "&#10;");

let $filename := "MyNetworkData.tsv"
let $doc-db-uri := xmldb:store("/db/Samantha-McGugian/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
         
