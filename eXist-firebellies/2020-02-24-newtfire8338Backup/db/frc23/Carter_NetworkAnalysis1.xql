xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $ulysses := collection('/db/ulysses/ulysses/')
let $allusions := $ulysses//allusion/@*/string() => distinct-values()
for $i in $allusions
let $location := $ulysses//location[descendant::allusion/@*/string() = $i]/@name/string() => distinct-values()
for $l in $location
let $speaker := $ulysses//location[@name = $l][descendant:: allusion/@*/string() = $i]//said/@persName/string() => distinct-values()
let $speaker := $ulysses//location[descendant:: allusion/@*/string() = $i]//said/@persName/string() => distinct-values()
let $speakerCount := $speaker => count()
return string-join(($i, $l, $speakerCount), "&#x9;")
, "&#10;");


let $filename := "ulyssesAllusionstoLocations.tsv"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
