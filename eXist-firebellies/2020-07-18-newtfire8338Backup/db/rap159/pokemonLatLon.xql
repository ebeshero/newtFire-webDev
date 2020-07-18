xquery version "3.1";
declare variable $pokemon as document-node()+ := collection('/db/2020_ClassExamples/pokemonQGIS/') ;
declare variable $ThisFileContent as element() :=

<html>
    <head><title>Pokemon Types and Routes</title></head>
    <body>
        <h1>Where to find Pokemon by Route</h1>
        <table>
            <tr><th>Type</th><th>Routes</th><th>latitude</th><th>longitude</th></tr>
{

let $types := $pokemon//typing/@type/string()
let $distTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize(., ' ')  => distinct-values()

for $d in $distTypes
let $routes := $pokemon//locations//landmark
let $routesMatch:=$routes[preceding::typing/@type ! upper-case(.) [contains(., $d)]]/@n/string()
let $lat:=$routes[preceding::typing/@type ! upper-case(.) [contains(., $d)]]/@lat/string()
let $lon :=$routes[preceding::typing/@type ! upper-case(.) [contains(., $d)]]/@lon/string()
let $distRM := $routesMatch => distinct-values()

return

<tr>
    <td>{$d}</td>
    <td>{string-join($distRM, ', ')}</td>
    <td>{$lat}</td>
    <td>{$lon}</td>
    </tr>
}</table></body>
</html>
;

$ThisFileContent