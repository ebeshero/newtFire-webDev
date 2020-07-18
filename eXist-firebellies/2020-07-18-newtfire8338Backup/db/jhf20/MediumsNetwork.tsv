xquery version "3.1";
let $banksy := collection("/db/banksy/XML")
    let $titles := $banksy//sourceDesc//title => distinct-values() => sort()
    for $t in $titles
    let $lat := $banksy//sourceDesc[descendant::title = $t]//location/@lat => distinct-values()
    let $long := $banksy//sourceDesc[descendant::title = $t]//location/@long => distinct-values()
    let $medium := $banksy//sourceDesc[descendant::title = $t]//medium/@type/string() => distinct-values()
    for $m in $medium
    
    return concat($t, "&#x9;", $m, "&#x9;", $lat, "&#x9;", $long)