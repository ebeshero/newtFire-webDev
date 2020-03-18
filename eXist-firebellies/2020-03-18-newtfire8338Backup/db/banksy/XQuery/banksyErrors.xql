xquery version "3.1";
(: collection('/db/banksy')//medium[not(@type="spray_paint")]/base-uri() :)
(: collection('/db/banksy')//date/@when[matches(., "[A-Z]")]/base-uri() :)
let $banksy := collection('/db/banksy')
let $medium := $banksy//medium[not(@type="spray_paint")][not(@type="canvas")]/base-uri()
let $titlesBibl := $banksy//sourceDesc//title[string-length(.) eq 0]
let $titlesHeader := $banksy//sourceDesc//title[string-length(.) eq 0]
return $medium