xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $coll := collection('/db/2020_ClassExamples/pokemonQGIS/')
let $pokemon := $coll//pokemon
let $types := $pokemon//typing/@type ! tokenize(string(), ',')[1] ! normalize-space() ! tokenize(string(), ' ')
let $distTypes := $types => distinct-values()
for $d in $distTypes
let $landmarks := $pokemon//locations/landmark
let $distLandmark := $landmarks[preceding::typing/@type[contains(., $d)]]/@n ! normalize-space() => distinct-values()
for $l in $distLandmark
let $lat := $landmarks[preceding::typing/@type[contains(., $d)]][@n[contains(., $l)]]/@lat => distinct-values()
let $lon := $landmarks[preceding::typing/@type[contains(., $d)]][@n[contains(., $l)]]/@lon => distinct-values()

return string-join(($d, $l, $lat, $lon), "&#x9;"), "&#10;");
let $filename := "dunn_qgis-01.tsv"
let $doc-db-uri := xmldb:store('/db/shd79', $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 