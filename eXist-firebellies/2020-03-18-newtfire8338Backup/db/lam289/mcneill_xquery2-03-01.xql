xquery version "3.1";
declare variable $coll as document-node()+ := collection('/db/pokemonMap/pokemon');
declare variable $ThisFileContent as element() :=

<html>
    <head><title>Pokemon Types and Locations</title></head>
    <body>
        <h1>Where to Find Pokemon by Location</h1>
        <table>
            <tr><th>Type</th><th>Location</th></tr>

{
(:let $coll := collection('/db/pokemonMap/pokemon'):)
let $type := $coll//typing[@type]/string()
let $distType := $type ! lower-case(.) ! tokenize(., ',') ! normalize-space(.) ! tokenize(., ' ') => distinct-values()

for $d in $distType
let $location := $coll//locations/landmark
let $locationMatch := $location[preceding::typing/@type ! lower-case(.) = $d]/string()
let $distLM := $locationMatch => distinct-values()
let $TypeLocation :=  concat('Type: ', $d, ' :Landmark: ', string-join($distLM, ", "))
return (:$TypeLocation:)

<tr>
    <td>{$d}</td>
    <td>{string-join($distLM, ', ')}</td>
    </tr>
}
</table>
</body>
</html>
;

let $filename := "pokemon_mcneillxquery2.html"
let $doc-db-uri := xmldb:store("/db/lam289", $filename, $ThisFileContent)
return $doc-db-uri
