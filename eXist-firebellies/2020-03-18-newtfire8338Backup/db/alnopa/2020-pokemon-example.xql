xquery version "3.1";
declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon');
declare variable $ThisFileContent as element() := 

<html>
    <head>
        <title>Pokemon</title>
    </head>
    <body>
        <h1>Where to find Pokemon by Route</h1>h1>
        <table>
            <tr>
                <th>Type</th>
                <th>Route</th>
            </tr>
                {

(: let $pokemon := collection('/db/pokemonMap/pokemon') :)

let $types := $pokemon//typing/@type
let $distTypes := $types ! upper-case(.) ! normalize-space() ! tokenize(., ', | ') => distinct-values()
for $d in $distTypes
let $routes := $pokemon//route
let $routesMatch := $routes[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@num/string()
let $distRM := $routesMatch => distinct-values()
(: Original: return concat($d, ': Routes Found On: ', string-join($distRM, ', ')) :)
return
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
let $doc-db-uri := xmldb:store('/db/alnopa', $filename, $ThisFileContent)
return $doc-db-uri