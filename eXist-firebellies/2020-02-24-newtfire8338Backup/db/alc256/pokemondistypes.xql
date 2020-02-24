xquery version "3.1";
let $pokemoncol := collection('/db/pokemonMap/pokemon')
let $placecol := collection('/db/pokemonMap/places')
let $types := $pokemoncol//typing/@type ! tokenize(., "\s+")
let $distypes := distinct-values($types)

for $d in $distypes 
let $pokenames := $pokemoncol//name[following-sibling::typing/contains(@type, $d)]
for $n in $pokenames
let $dexNum := $n/preceding-sibling::dexNum/@num ! normalize-space(.)
let $places := $placecol//location/*[1][following::pokemon/@dexNum = $dexNum]
for $p in $places
let $loctype := $p/parent::location/@type ! string()
let $othernames := $p/following::pokemon[@dexNum != $dexNum]
for $o in $othernames
let $odexNum := $o/@dexNum ! string()
let $otype := $pokemoncol//dexNum[@num=$odexNum]/following-sibling::typing/@type ! tokenize(., "\s+")
for $t in $otype

return concat($d, "&#x9;", $n, "&#x9;", $dexNum, "&#x9;", $p, "&#x9;", $loctype, "&#x9;", $o, "&#x9;", $odexNum, "&#x9;", $t)
