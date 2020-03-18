xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $brandNewColl := collection('/db/brandnew/Albums')
let $album := $brandNewColl//album/string() =>distinct-values()
for $x in $album
let $song := $brandNewColl//title[following-sibling::album = $x]
let $distSong := $song/string() => distinct-values()
for $y in $distSong
let $length := $brandNewColl//info[child::album = $x][child::title = $y]/songLength/string()
for $z in $length
order by $x
return string-join(($x, $y, $z),"&#x9;"), "&#10;");
  
let $filename := "brandNewNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/bec80", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
