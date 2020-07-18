declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $Chas as document-node() := doc('/db/mitford/literary/Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $si as document-node() := doc('https://digitalmitford.org/si.xml');
let $Chasplaces := $Chas//tei:placeName
let $siPlaces := $si//tei:place
let $ChasPlaceRefs := $Chasplaces/@ref/string()
let $distChPRs := sort(distinct-values($ChasPlaceRefs))
for $i at $pos in $distChPRs
let $siCPrs := $si//tei:place[@xml:id = substring-after($i, '#')]
let $name := $siCPrs/tei:placeName[1]
let $countInPlay := count($Chasplaces[@ref = $i])
where $countInPlay > 1 and $countInPlay < 20
order by $countInPlay descending
return concat($name, ': ', $countInPlay)





