xquery version "3.1";
declare variable $ThisFileContent := 
string-join(
let $coll := collection('/db/Schism')/*
let $locations := $coll//location/normalize-space()
let $distinctLocations := distinct-values($locations)
return 
    $distinctLocations, "&#10;");

 let $filename := "SchismMapData.txt"
let $doc-db-uri := xmldb:store("/db/2018_classExQueries/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
   