xquery version "3.1";
declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon');
declare variable $ThisFileContent as element() :=

<html> 
    <head><title>Pokemon Types and Landmarks</title></head>
    <body>
        <h1>Where to find Pokemon by Landmark</h1>
        <table>
            <tr><th>Type</th><th>Landmark</th></tr>
{
    
    let $types := $pokemon//typing/@type/string()
let $neatTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize(., ' ') => distinct-values()

for $t in $neatTypes
let $LM := $pokemon//landmark
let $place := $LM[preceding::typing/@type ! upper-case(.)[contains(., $t)]]/@n/string()
let $distPlace := $place => distinct-values()

return (:concat ($t, ': Location Landmarks - ' , string-join($distPlace, ', ')):)

<tr>
    <td>{$t}</td>
    <td>{string-join($distPlace, ', ')}</td>
        </tr>
    
}

</table></body>
</html>
;

let $filename := "pokemon_landmark.html"
let $doc-db-uri := xmldb:store('/db/bec80', $filename, $ThisFileContent)
return $doc-db-uri