xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $ThisFileContent :=
string-join(
let $akira := doc('/db/akira/akira-tei.xml')/*
let $controlScenes := $akira//spGrp
for $i in $controlScenes
let $peeps := $i/sp/@who/string()
let $distinctPeeps := distinct-values($peeps)
for $p in $distinctPeeps
let $match := $controlScenes[sp[@who = $p]]
let $otherPeeps := $match//sp[not(@who=$p)]/@who/string()
let $distOPS := distinct-values($otherPeeps)
let $countOP := count($distOPS)
let $edge := "controlScene"
for $d in $distOPS
return 
    concat($p, "&#x9;", $edge, "&#x9;", $countOP, "&#x9;", $d), "&#10;");
    
    let $filename := "AkiraNetData2.tsv"
let $doc-db-uri := xmldb:store("/db/akira/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/akira/AkiraNetData2.tsv ) :)  
