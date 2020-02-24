xquery version "3.1";
declare variable $fileRef := string-join(
let $u := collection('/db//ulysses//wanderings')//ulysses
let $ref := $u//reference//@to ! lower-case(.) ! string()
let $distref := $ref => distinct-values()
for $r in $distref
let  $relation := $u//*[child::reference/@to/string() = $r]/name() => distinct-values()
for $re in $relation
let $count := $relation => count() 
let $location := $u//location//@name ! lower-case(.) ! string()
let $distLocation := $location => distinct-values()
for $d in $distLocation
order by $count ascending
return concat($d, "&#x9;", $count, "&#x9;", $re, "&#x9;", $r),"&#10;") ;
let $filename := "ulyssesLocationtoRefrevised.tsv"
let $doc-db-uri := xmldb:store("/db//bmt45//Ulysses", $filename, $fileRef, "text/plain")
return $doc-db-uri
