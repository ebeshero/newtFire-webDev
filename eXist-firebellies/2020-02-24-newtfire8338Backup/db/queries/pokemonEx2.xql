xquery version "3.1";
(:  :declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon'); :)
let $pokemon := collection('/db/pokemonMap/pokemon')
let $types := $pokemon//typing/@type ! tokenize(., ' ')
(: Some Pokemon have multiple types, coded in the typing/@type as a white-space separated list :)
let $distTypes := $types ! lower-case(.) ! normalize-space() => distinct-values()
(: Let's walk through each type one by one and see if we can match them up to names of Pokemon and locations for Pokemon. We can create a directory of Pokemon this way. :)
for $d in $distTypes
let $names := $pokemon//name
let $namesMatch := $names[following-sibling::typing/@type ! lower-case(.)[contains(., $d)]]
let $locations := $pokemon//locations/landmark
let $locsMatch := $locations[preceding::typing/@type ! lower-case(.)[contains(., $d)]]/@n/string()
let $distLM := $locsMatch => distinct-values()
return concat($d, ' : where: ', string-join($distLM, ', '))


