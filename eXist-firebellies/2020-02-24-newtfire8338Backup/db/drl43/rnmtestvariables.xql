xquery version "3.1";
 
(:  declare variable $ThisFileContent := 
:)
  string-join( 
let $rickNmorty := doc('/db/drl43/lint_rNm_networking_xml.xml')/*
let $rnmpeople := $rickNmorty//persName[@level=main]
let $rnmdistinctPs := distinct-values($rnmpeople)
for $edp in $rnmdistinctPs
let $peers:= 
    if ($rnmpeople[. = $edp]/ancestor::convo) 
        then distinct-values($rnmpeople[. = $edp]/ancestor::convo//persName[@level=dimension])
   else if ($rnmpeople[. = $edp]/ancestor::scene) 
        then distinct-values($rnmpeople[. = $edp]/ancestor::scene//persName[@level=dimension])
   else "none"

let $edgeType:=
    if ($rnmpeople[. = $edp]/ancestor::convo) 
        then "personal"
    else if ($rnmpeople[. = $edp]/ancestor::scene) 
        then "casual"
    else "script"

let $edgeWeight:=
    if ($rnmpeople[. = $edp]/ancestor::convo) 
        then count($rnmpeople[. = $edp]/ancestor::convo//persName[not(. = $edp)])
   else if ($rnmpeople[. = $edp]/ancestor::scene) 
        then count($rnmpeople[. = $edp]/ancestor::scene//persName[not(. = $edp)])
   else "script"

for $peer in $peers
return
   
 concat($edp, "&#x9;",  $edgeType, "&#x9;", $edgeWeight, "&#x9;", $peer), " &#10;" )
 
 
 (:
let $filename := "rNmOutput.tsv"
let $doc-db-uri := xmldb:store("/db/drl43/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
:)