xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $ThisFileContent := string-join(
let $pacific := collection('/db/pacific/mapping')
let $lat := $pacific//geo[@select="lat"] 
for $lt in $lat 
let $lon := $pacific//geo[@select="lon"][preceding-sibling::geo[@select="lat"] = $lt][1]/string() ! normalize-space()
let $niceLat := $lt/string() ! normalize-space()
let $id := generate-id($lt)
return string-join(($id, $niceLat, $lon), ",")
, "&#10;");

let $filename := "qgis_2__2take2.tsv"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
