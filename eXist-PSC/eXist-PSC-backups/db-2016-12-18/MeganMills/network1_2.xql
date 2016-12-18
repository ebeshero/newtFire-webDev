xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
 declare variable $ThisFileContent := 

  string-join( 
let $coll := doc('/db/decameron/engDecameronTEI.xml')/*
let $places := $coll//placeName
let $distplaces := distinct-values($places)
for $d in $distplaces

let $locations :=   if ($places[. = $d]/ancestor::floatingText[@type="frame"]) 
then distinct-values($places[. = $d]/ancestor::floatingText//placeName[not(. = $d)]) 
   else if ($places[. = $d]/ancestor::div[@type="novella"]) 
   then distinct-values($places[ . =$d]/ancestor::div[@type="novella"]//placeName[not(. = $d)]) 
   else distinct-values($places[. = $d]/ancestor::div[1]//placeName[not(. = $d)])   
   
   
   let $edge:=
if ($places[. = $d]/ancestor::floatingText[@type="frame"]) 
then "floatingFrame"
else if ($places[. = $d]/ancestor::div[@type="novella"]) 
then "novella"
else "frame"

 let $edgeWeight:=
         if ($places[. = $d]/ancestor::floatingText[@type="frame"] )
            then count($places[. = $d]/ancestor::floatingText//placeName[not(. = $d)])
      else if ($places[. = $d]/ancestor::div[@type="novella"]) 
            then count($places[. = $d]/ancestor::div[@type="novella"]//placeName[not(. = $d)])
      else count($places[. = $d]/ancestor::div[1]//placeName[not(. = $d)])
      
      
      
      
      
for $location in $locations
return
   
 concat($d, "&#x9;", $edge,"&#x9;",$edgeWeight, "&#x9;", $location, " &#10;"), " &#10;")
 
;
 
 let $filename := "Mills.tsv"
let $doc-db-uri := xmldb:store("/db/MeganMills", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://dxcvm05.psc.edu:8080/exist/rest/db/MeganMills/Mills.tsv ) :)