xquery version "3.1";

let $pokemon := collection('/db/pokemonMap/pokemon')
let $types := $pokemon//typing/@type
return $types