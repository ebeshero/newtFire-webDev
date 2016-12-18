xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
 declare variable $ThisFileContent := 

  string-join( 
let $coll := doc('/db/decameron/engDecameronTEI.xml')/*
let $places := $coll//placeName
let $distplaces := distinct-values($places)
for $d in $distplaces

let $locations :=   if ($places/ancestor::floatingText[@type="frame"]) 
then (distinct-values($places/ancestor::floatingText))
   else if ($places/ancestor::div[@type="novella"]) 
   then (distinct-values($places/ancestor::div[@type="novella"]))
   else distinct-values($places/ancestor::div[1])
   
   let $edge:=
if ($places/ancestor::floatingText[@type="frame"]) 
then ("floatingFrame")
else if ($places/ancestor::div[@type="novella"]) 
then ("novella")
else "frame"

 let $edgeWeight:=
         if ($places/ancestor::floatingText[@type="frame"] )
            then count (distinct-values($places/ancestor::floatingText))
      else if ($places/ancestor::div[@type="novella"]) 
            then count(distinct-values($places/ancestor::div[@type="novella"]))
      else count($places/ancestor::div[1])
      
for $location in $locations
return
   
 concat($d, "&#x9;", $edge, "&#x9;", $location), " &#10;")
;
 
 let $filename := "Mills.tsv"
let $doc-db-uri := xmldb:store("/db/MeganMills", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://dxcvm05.psc.edu:8080/exist/rest/db/MeganMills/Mills.tsv ) :)