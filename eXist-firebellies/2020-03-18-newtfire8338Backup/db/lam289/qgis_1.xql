xquery version "3.1";

declare variable $ThisFileContent := string-join(
let $qgisPoke := collection('/db/2020_ClassExamples/pokemonQGIS')
let $pokeType := $qgisPoke//typing/@type
let $distType := $pokeType ! tokenize(., ',')[1] ! normalize-space(.) ! tokenize(., ' ') => distinct-values()

for $d in $distType
let $location := $qgisPoke//locations/landmark/@n
let $locationMatch := $location[preceding::typing/@type = $d]/string()
let $distLM := $locationMatch => distinct-values()

for $l in $distLM
let $lat := $qgisPoke//locations/landmark[preceding::typing/@type = $d][@n = $l]/@lat => distinct-values()
let $lon := $qgisPoke//locations/landmark[preceding::typing/@type = $d][@n = $l]/@lon => distinct-values()
return string-join(($d, $l, $lat, $lon), "&#x9;"), "&#10;");

let $filename := "qgis_1.tsv"
let $doc-db-uri := xmldb:store("/db/lam289", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri

 
