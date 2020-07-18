xquery version "3.1";
(:  :declare variable $banksy as document-node()+ := collection('/db/banksy'); :)
let $banksy := collection('/db/banksy')/*
let $titles := $banksy//sourceDesc//title
let $dates := $banksy//sourceDesc//date/@when/string()
let $distDates := $dates => distinct-values()
for $d in $distDates
let $dTitles := $titles[following::date/@when = $d]/string()
return concat($d, ': ', string-join($dTitles, ', '))


