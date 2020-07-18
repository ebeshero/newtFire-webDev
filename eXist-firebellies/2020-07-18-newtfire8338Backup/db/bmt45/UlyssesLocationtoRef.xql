xquery version "3.1";
declare variable $fileRef := string-join(
let $u := collection('/db//bmt45//Ulysses')//ulysses
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
return concat($d, "&#x9;", $r, "&#x9;", $re, "&#x9;", $count),"&#10;") ;
let $filename := "ulyssesLocationtoRef.tsv"
let $doc-db-uri := xmldb:store("/db//bmt45//Ulysses", $filename, $fileRef, "text/plain")
return $doc-db-uri
(:  :Bmt45:  I had a hard time settting this up but the potential tsv file provides the necessary information to create a tsv file to be used in cytospace to create a network graph. :)
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/pokemonTypeLoc.html :)  