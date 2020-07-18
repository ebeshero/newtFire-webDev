xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $magellan := collection('/db/frc23/magellanKML')

let $coordinates := $magellan//coordinates
for $c in $coordinates 
let $lat := $c ! normalize-space() ! tokenize(., " ")[1] ! translate(., ",", "")
let $lon := $c ! normalize-space() ! tokenize(., " ")[2] ! translate(., ",", "")
let $id := generate-id($c)
return string-join(($id, $lat, $lon), ",")
, "&#10;");

let $filename := "qgis_2_test.tsv"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri