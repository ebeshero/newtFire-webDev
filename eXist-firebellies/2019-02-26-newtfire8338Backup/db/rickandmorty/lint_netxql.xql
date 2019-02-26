xquery version "3.1";

declare variable $ThisFileContent := 

string-join(
let $rickNmorty := doc('/db/drl43/lint_rNm_networking_xml.xml')/*
let $rnmpeople := $rickNmorty//persName[@level="main"]
let $nonMainpeople:= $rickNmorty//persName[not(@level="main")]
let $rnmdistinctPs := distinct-values($rnmpeople)
for $edp in $rnmdistinctPs


let $peers:= 
if ($rnmpeople[. = $edp]/ancestor::convo) 
        then distinct-values($rnmpeople[. = $edp]/ancestor::convo//persName[@level="dimension"])
   else if ($rnmpeople[. = $edp]/ancestor::scene) 
        then distinct-values($rnmpeople[. = $edp]/ancestor::scene//persName[@level="dimension"])
   else "none"

let $edgeType:=
    if ($rnmpeople[. = $edp]/ancestor::convo[1]) 
        then "personal"
    else if ($rnmpeople[. = $edp][ancestor::scene[1] and not(ancestor::convo)]) 
        then "casual"
    else "script"

let $edgeWeight:=
    if ($rnmpeople[. = $edp]/ancestor::convo) 
        then count($rnmpeople[. = $edp]/ancestor::convo//persName[not(. = $edp)])
   else if ($rnmpeople[. = $edp]/ancestor::scene) 
        then count($rnmpeople[. = $edp]/ancestor::scene//persName[not(. = $edp)])
   else "script"

for $peer in $peers
let $match:= $rickNmorty//persName[. = $peer]
let $kind:=
if ($match[contains(., "Morty")]) 
    then "morty"
else if ($match[contains(., "Rick")])
    then "rick"
else "neither"

return

concat($edp, "&#x9;",  $edgeType, "&#x9;", $edgeWeight, "&#x9;", $peer, "&#x9;", $kind), "&#10;");

 
let $filename := "rNmOutput1.tsv"
let $doc-db-uri := xmldb:store("/db/rickandmorty/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/drl43/rNmOutput2.tsv ) :)  
