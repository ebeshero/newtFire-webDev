xquery version "3.1";
declare variable $ulysses as document-node()+ := collection('/db/ulysses/ulysses');
declare variable $ThisFileContent := 
string-join
(
let $lotusEaters := $ulysses[descendant:: chapter[@chapterName = "The Lotus Eaters"]]
let $location := $lotusEaters//location
let $locationName := $location//@name/string()=>distinct-values()
for $i in $locationName 
let $lat := $location[@name = $i]//@lat/string()
let $lon := $location[@name = $i]//@lon/string()
return string-join(($i, $lat, $lon), ",")
, "
");

let $filename := "ulyssesLotusEatersLoc.csv"

let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri