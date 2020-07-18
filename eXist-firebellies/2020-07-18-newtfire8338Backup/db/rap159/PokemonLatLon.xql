
xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $albumInfo := collection('/db/brandnew/XML/albumInfo')


let $studio := $albumInfo//typing/@type/string()
let $distTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize(., ' ')  => distinct-values()

for $d in $distTypes
let $routes := $pokemon//landmark
let $routesMatch:=$routes[preceding::typing/@type ! upper-case(.) [contains(., $d)]]/@n
let $town := $routesMatch => distinct-values()

for $z in $town
let $lat:=$routes[preceding::typing/@type ! upper-case(.) [contains(., $d)]][@n=$z]/@lat => distinct-values()
let $lon :=$routes[preceding::typing/@type ! upper-case(.) [contains(., $d)]][@n=$z]/@lon => distinct-values()


return string-join(($d, $z, $lat, $lon),"&#x9;"));
$ThisFileContent

(:   let $filename := "pokemonLatLon.tsv"
let $doc-db-uri := xmldb:store("/db/rap159/", $filename, $ThisFileContent)
return $doc-db-uri :)




