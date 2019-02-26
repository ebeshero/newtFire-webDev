xquery version "3.1";
(:  :declare variable $ThisFileContent := :)
<kml>
{    
let $coll := collection('/db/Schism')/*
let $locations := $coll//location/normalize-space()
let $distinctLocations := distinct-values($locations)
for $i in $distinctLocations
let $match := $coll//location[./normalize-space() = $i]
let $surroundPar := $match/ancestor::p
let $maxLengthPar := $surroundPar[string-length() = max($surroundPar/string-length())]
return 
 <Placemark>
     <name>{$i}</name>
     <description>{$maxLengthPar/string()}</description>
</Placemark>    
}
</kml>
(:  : let $filename := "SchismMapData.kml"
let $doc-db-uri := xmldb:store("/db/2018_classExQueries/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri:)
(: output at :http://newtfire.org:8338/exist/rest/db/2018_classExQueries/SchismMapData.kml ) :)

