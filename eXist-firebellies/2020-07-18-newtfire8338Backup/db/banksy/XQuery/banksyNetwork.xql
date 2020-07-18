xquery version "3.1";
(: Source - Name :)
(: Target - Year :)
(: Source Edge - Medium :)
(: Target Edge - Editions :)
declare variable $ThisFileContent :=
string-join(
    let $banksy := collection("/db/banksy/XML")
    let $titles := $banksy//sourceDesc//title => distinct-values() => sort()
    for $t in $titles
    let $years := $banksy//sourceDesc[descendant::title = $t]//date/@when ! tokenize(., '-')[1] => distinct-values()
    let $medium := $banksy//sourceDesc[descendant::title = $t]//medium/@type/string() => distinct-values()
    for $m in $medium
    for $y in $years
    return concat($t, "&#x9;", $y, "&#x9;", $m, "&#x9;"), "&#10;");
let $filename := "banksyNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/banksy/XQuery", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri