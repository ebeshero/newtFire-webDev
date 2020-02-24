xquery version "3.1";
declare variable $ThisFileContent := 
string-join(
let $coll := collection('/db/Schism')/*
let $locations := $coll//location/normalize-space()
let $distinctLocations := distinct-values($locations)
return 
    $distinctLocations, "&#10;");
    (:With this, we are outputting a plain-text list, This is joining together the list with line-feed characters.:)

 let $filename := "SchismMapData.txt"
let $doc-db-uri := xmldb:store("/db/2018_classExQueries/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/2018_classExQueries/SchismMapData.txt ) :)

