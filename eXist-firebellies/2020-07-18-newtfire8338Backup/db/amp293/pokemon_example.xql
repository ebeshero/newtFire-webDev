xquery version "3.1";
(:  : let $pokemon := collection('/db/pokemonMap/pokemon'):)

declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon');
declare variable $ThisFileContent as element() := 

<html>
    <head><title>Pokemon Types and Routes</title></head>
    <body>
        <h1>Where to find Pokemon by Route</h1>
        <table>
            <tr><th>Type</th><th>Routes</th></tr>
{

let $types := $pokemon//typing/@type/string()
let $distTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize(., ' ') => distinct-values()

for $d in $distTypes
let $routes := $pokemon//route
let $routesMatch := $routes[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@num/string()
let $distRM := distinct-values($routesMatch)
return (:concat($d, ': Routes Found On: ', string-join($distRM, ',')):)
<tr>
    <td>{$d}</td>
    <td>{string-join($distRM, ', ')}</td>
    </tr>
}
</table>
</body>
</html>
;

let $filename := "pokemon_example.html"
let $doc-db-uri := xmldb:store('/db/amp293', $filename, $ThisFileContent)
return $doc-db-uri
