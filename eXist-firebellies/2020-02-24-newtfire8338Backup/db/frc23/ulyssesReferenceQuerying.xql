xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $ulysses := collection('/db/ulysses/ulysses')
let $location := $ulysses//location/@name/string() => distinct-values()
for $i in $location
let $lat := $ulysses//location[@name = $i]/@lat/string()
let $lon := $ulysses//location[@name = $i]/@lon/string()
let $content := $ulysses//location[@name = $i]//*//*/@*/string()
for $j in $content
return string-join(($lat, $lon, $i, $j), "&#x9;")
, "&#10;");
  
let $filename := "ulyssesReferencesToLocations.tsv"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/frc23/ulyssesReferencesToLocations.tsv :) 