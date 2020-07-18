xquery version "3.1";
<html>
    <head><title>Pokemon Types and Locations</title></head>
    <body>
        <table>
            <tr><th>Type</th><th>Landmarks</th></tr>
{
let $coll := collection('/db/pokemonMap/pokemon')
let $pokemon := $coll//pokemon
let $types := $pokemon//typing/@type ! tokenize(string(), ' ') ! tokenize(string(), ',')[1]
let $distTypes := $types=>distinct-values()
for $d in $distTypes
let $landmarks := $pokemon//locations/landmark
let $distLandmark := $landmarks[preceding::typing/@type/string() = $d] ! text() ! normalize-space()=> distinct-values()
return      (: concat('Type: ', $d, ': Landmark: ', string-join($distLandmark, ', ')) :)
<tr>
    <td>{$d}</td>
    <td>{string-join($distLandmark, ', ')}</td>
    </tr>
}
</table>
</body>
</html>