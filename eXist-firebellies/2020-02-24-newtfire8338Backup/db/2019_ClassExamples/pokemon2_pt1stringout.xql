xquery version "3.1";
(:  :declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon'); :)
let $pokemon := collection('/db/pokemonMap/pokemon')
let $types := $pokemon//typing/@type
(: Some Pokemon have multiple types, coded in the typing/@type as a white-space separated list. A few of these have commas in them, so along the way, we'll trim those out and get rid of any extra white spaces before taking distinct-values(). :)
let $distTypes := $types ! upper-case(.) ! substring-before(., ',') ! normalize-space() ! tokenize(., ' ') => distinct-values()
(: Now it's time for the for-loop. Let's walk through each type one by one and see if we can match them up to names of Pokemon and locations for Pokemon. We can create a directory of Pokemon types this way. :)
for $d in $distTypes
let $locations := $pokemon//locations/landmark
let $locsMatch := $locations[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@n/string()
let $distLM := $locsMatch => distinct-values()
return concat($d, ' : where: ', string-join($distLM, ', ')) 


