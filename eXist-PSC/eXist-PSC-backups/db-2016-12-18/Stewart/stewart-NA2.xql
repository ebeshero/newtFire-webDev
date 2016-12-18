xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";

declare variable $ThisFileContent:=
string-join(
let $Dickinson := collection('/db/dickinson/f16/')
let $poemFiles := $Dickinson/*
let $apps := $poemFiles//text//body//l//app
let $rdgs := $apps/rdg
let $wits := $rdgs/@wit
for $wit in $wits
let $witNames := tokenize($wit, '\s+')[starts-with(., '#')]
for $witName in $witNames
let $edge := $wit/parent::rdg
let $poemTitle := $wit/ancestor::TEI//titleStmt/title
let $otherWits := $wit/tokenize(., '\s+')[starts-with(., '#')][not(. = $witName)]
let $countOtherWits := count($otherWits)
for $otherWit in $otherWits

return concat($witName, "&#x9;", $edge, "&#x9;", $poemTitle, "&#x9;", $countOtherWits, "&#x9;", $otherWit), "&#10;");


let $filename := "stewart-NA2.tsv"
let $doc-db-uri := xmldb:store("/db/Stewart", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://dxcvm05.psc.edu:8080/exist/rest/db/stewart-NA2.tsv ):)
