xquery version "3.1";
<html>
    <head><title>Pokemon Types with Landmarks</title></head>
    <body> 
    <table>
        <tr><th>Type</th><th>Landmarks</th></tr>{
let $pokemon := collection('/db/pokemonMap/pokemon')/*
let $pokemonType := $pokemon//typing/@type
let $pokemonTypeValues := $pokemonType/tokenize(string(), " ") 
let $pokemonTypeValuesUpper := $pokemonType/tokenize(upper-case(string())," ")
let $pokemonTypeValuesDistinct := $pokemonTypeValuesUpper => distinct-values()
for $i in $pokemonTypeValuesDistinct
let $pokemonLandmarks := $pokemon//locations//landmark
let $pokemonLandmarksCurrent := $pokemonLandmarks[contains(preceding::typing/@type/upper-case(string()),$i)]/@n/string()
let $pokemonLandmarksCurrentDistinct := $pokemonLandmarksCurrent => distinct-values()
return 

            <tr><td>{$i}</td> <td>{string-join($pokemonLandmarksCurrentDistinct, ", ")}</td></tr>
}</table></body>
</html>