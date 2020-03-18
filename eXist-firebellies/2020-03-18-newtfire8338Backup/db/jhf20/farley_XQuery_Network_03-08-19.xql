xquery version "3.1";
declare variable $ThisFileContent:= string-join( 
let $banksy := collection("/db/banksy/XML")
let $titles := $banksy//sourceDesc//title[string-length(.) gt 0]
for $t in $titles
let $edge:=
            if ($t/following-sibling::medium/@type[contains(., 'spray_paint')]) 
                    then "Spray Paint"
            else if ($t/following-sibling::medium/@type[contains(., 'canvas')]) 
                    then "Canvas"
            else "other medium"
let $location := $t/following-sibling::location[contains(.,'London')]
return
concat($t(:source node:), "&#x9;"(:tab character:), $edge(:shared interaction or edge:), "&#x9;", $location(:target node:)), "&#10;");

let $filename := "banksyMediumsRetry.tsv"
let $doc-db-uri := xmldb:store("/db/jhf20", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
