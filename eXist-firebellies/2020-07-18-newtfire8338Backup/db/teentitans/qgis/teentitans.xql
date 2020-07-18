xquery version "3.1";

(: declare variable $ThisFileContent := string-join( :)
let $teentitans := collection("/db/teentitans/season2")
let $titan := $teentitans//action/@mrkr/string()
let $leads := $titan => distinct-values()

for $t in $leads
let $location := $teentitans//locationList/locList/@id
let $locationMatch := $location/following::action[@mrkr=$t]/@place/string()
let $distLM := $locationMatch => distinct-values()

for $l in $distLM
let $lat := $teentitans//locationList/locList[@id=$l]/@lat/string() => distinct-values()
let $lon := $teentitans//locationList/locList[@id=$l]/@lon/string() => distinct-values()

let $time := $teentitans//action[@mrkr=$t]/@timestamp/string() => distinct-values()

return string-join(($t, $l, $lat, $lon, $time), "&#x9;")

(: return string-join(($t, $l, $lat, $lon), "&#x9;"), "&#10;");

let $filename := "teentitans.tsv"
let $doc-db-uri := xmldb:store("/db/teentitans/qgis", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri :)

