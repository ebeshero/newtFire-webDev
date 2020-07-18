xquery version "3.1";
let $teetit := collection("/db/lam289/teetit")
let $titan := $teetit//action/@mrkr/string()
let $teentitan := $titan => distinct-values()

for $t in $teentitan
let $location := $teetit//locationList/locList/@id
let $locationMatch := $location/following::action[@mrkr=$t]/@place/string()
let $distLM := $locationMatch => distinct-values()

for $l in $distLM
let $lat := $teetit//locationList/locList[@id=$l]/@lat/string() => distinct-values()
let $lon := $teetit//locationList/locList[@id=$l]/@lon/string() => distinct-values()
return string-join(($t, $l, $lat, $lon), "&#x9;")
