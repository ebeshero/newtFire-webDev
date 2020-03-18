xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $banksy := collection('/db/banksy')/element()
let $years := $banksy//date/@when
let $yearsDist := $years ! tokenize(., "-")[1] => sort() => distinct-values()
for $y in $yearsDist
let $names := $banksy//bibl/title
let $namesMatch := $names[following-sibling::date/@when[contains(., $y)]]/string() => sort()
return concat("&#9;<group>&#10;&#9;&#9;<year>", $y, "</year>&#10;&#9;&#9;<works>&#10;&#9;&#9;&#9;<title>", $namesMatch => string-join("</title>&#10;&#9;&#9;&#9;<title>"), "</title>&#10;&#9;&#9;</works>&#10;&#9;</group>"), "&#10;");
let $filename := "timeline.xml"
let $doc-db-uri := xmldb:store("/db/banksy/XQuery", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri






