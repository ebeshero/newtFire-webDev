xquery version "3.1";
    (: Just change the variable based on which collection you're running over to make csv's for each major section of Ulysses.:)
    declare variable $fileRef := string-join(
let $uColl := collection('/db/ulysses/ulysses')
let $location := $uColl//location[@name='Ormond Quay Lower']
let $locName:= $location/@name
let $distLocNames := $locName => distinct-values()
for $i in $distLocNames
let $content := $location[@name = $i]//*/@*
for $c in $content
let $cName := $c/parent::*/name()
return concat($i,"&#x9;","loc","&#x9;",$cName,"&#x9;","ref","&#x9;",$c/string() ),"&#10;" );
let $filename := "OrmondQuayLowerTSV.tsv"
let $doc-db-uri := xmldb:store("/db//bmt45//Ulysses", $filename, $fileRef, "text/plain")
return $doc-db-uri