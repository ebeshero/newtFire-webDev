xquery version "3.1";  

declare variable $ThisFileContent := string-join(
let $uColl := collection('/db/ulysses/ulysses')
let $location := $uColl//location[@name='Loopline Bridge']
let $locName:= $location/@name
let $distLocNames := $locName => distinct-values()
for $i in $distLocNames
let $content := $location[@name = $i]//reference/@*
for $c in $content
let $cName := $c/parent::*/name()
return concat($i,"&#x9;","loc","&#x9;",$cName,"&#x9;","ref","&#x9;",$c/string() ),"&#10;" );
let $filename := "Loopline.tsv"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/frc23/Loopline.tsv:)
 
