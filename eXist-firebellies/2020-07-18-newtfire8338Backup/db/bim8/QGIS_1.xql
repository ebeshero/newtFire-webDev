xquery version "3.1";

declare variable $ThisFileContent := string-join(
let $pokemon := collection('/db/2020_ClassExamples/pokemonQGIS')
let $type := $pokemon//typing/@type

let $distType := $type ! upper-case(.) ! tokenize(., ', ')[1] ! normalize-space() ! tokenize(., ' ') => distinct-values()

for $d in $distType
let $locations := $pokemon//landmark
let $locMatch := $locations[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@n/string()
let $distLoc := $locMatch => distinct-values() 

for $l in $distLoc
let $lat := $pokemon//landmark[preceding::typing/@type ! upper-case(.)[contains(.,$d)]][@n = $l]/@lat => distinct-values()
let $lon := $pokemon//landmark[preceding::typing/@type ! upper-case(.)[contains(.,$d)]][@n = $l]/@lon => distinct-values()

return string-join(($d, $l, $lat, $lon), "&#x9;"), "&#10;");

let $filename := "qgis_1.tsv"
let $doc-db-uri := xmldb:store("/db/bim8", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(:  Output at https://newtfire.org:8338/exist/rest/db/bim8/qgis_1.tsv :)

