xquery version "3.1";
let $banksy := collection('/db/banksy')/*
let $titles := $banksy//sourceDesc//title
for $t in $titles
let $dates := $t/following-sibling::date/@when
let $years := tokenize($dates, '-')[1] ! number()
order by $years descending
(: 2019-03-01 ebb: We played with group by here, and may want to continue experimenting :)
return concat($t, ': ', string-join($years, ', '), ' ,', count($years))

