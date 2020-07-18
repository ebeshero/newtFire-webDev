xquery version "3.1";
declare variable $pokemon as document-node()+ := collection('/db/2020_ClassExamples/pokemonQGIS');
declare variable $ThisFileContent := string-join(
    
let $types := $pokemon//typing/@type/string()
let $neatTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize(., ' ') => distinct-values()

for $t in $neatTypes
let $LM := $pokemon//landmark
let $place := $LM[preceding::typing/@type ! upper-case(.)[contains(., $t)]]/@n
let $distPlace := $place => distinct-values()

for $l in $distPlace
let $lat := $LM[preceding::typing/@type ! upper-case(.)[contains(., $t)]][@n = $l]/@lat
let $lon := $LM[preceding::typing/@type ! upper-case(.)[contains(., $t)]][@n = $l]/@lon
let $Dlat := distinct-values($lat)
let $Dlon := distinct-values($lon)

return string-join(($t, $l, $Dlat, $Dlon),"&#x9;"), "&#10;");

let $filename := "PokemonQGIS_Ex1.tsv"
let $doc-db-uri := xmldb:store("/db/bec80", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri