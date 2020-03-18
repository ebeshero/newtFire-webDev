xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $shakes := collection('/db/apps/shakespeare/data/')
let $titles := $shakes//titleStmt/title
for $i in $titles 
where $i[contains(., "Hamlet")]
return $i/base-uri()

