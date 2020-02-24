xquery version "3.0";
declare variable $ThisFileContent :=
<kml>
{
let $schisColl := collection('/db/Schism/')
let $locations := $schisColl//location
let $distinctLocs := distinct-values($locations)
for $i in $distinctLocs
let $titles := $schisColl//article[descendant::location[. = $i]]//title
let $pars := $schisColl//p[descendant::location[self::* = $i]]
let $longestPar := $pars[string-length() = max($pars/string-length())]
return

<Placemark>
<name>{$i}</name>
<description>{$longestPar/string()}</description>
</Placemark>
}
</kml>;
let $filename := "Placeography.kml"
let $doc-db-uri := xmldb:store("/db/queries/", $filename, $ThisFileContent)
return $doc-db-uri 
    
    


