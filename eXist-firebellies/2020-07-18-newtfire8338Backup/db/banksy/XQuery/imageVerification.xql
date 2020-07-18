xquery version "3.1";
let $banksy := collection("/db/banksy/XML")
let $pages := $banksy/descendant::body/descendant::img/@src/string() ! tokenize(., "/")[last()] => sort()
return $pages






