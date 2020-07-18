xquery version "3.1";
declare variable $fileRef := string-join( 
let $u := collection('/db/ulysses/wanderings/')
let $locs := $u//location[descendant::reference]
for $l in $locs
let $locName := $l/@name 
let $chap := $l/ancestor::ulysses//chapter/@chapterName ! string()
let $refs := $l//reference/@to ! string() 
let $distRefs := $refs => distinct-values()
for $d in $distRefs
let $refCount := $l//reference[@to = $d] => count()
return concat($locName,"&#x9;", "loc", "&#x9;", $chap,  "&#x9;", $refCount, "&#x9;", $d , "&#x9;","ref", "&#10;" ) );
let $fileName :="ulyssesLocationTSVfile.tsv"
let $doc-db-uri := xmldb:store("/db//bmt45//Ulysses", $fileName, $fileRef, "text/plain")
return $doc-db-uri
