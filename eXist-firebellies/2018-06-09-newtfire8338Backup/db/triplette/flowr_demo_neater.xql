xquery version "3.1";
(:  :collection('/db/shakespeare/plays')/PLAY[count(distinct-values(descendant::SPEAKER)) gt 40]:)
 (: FLOWOR :)
 let $coll := collection('/db/shakespeare/plays')/*
for $i in $coll
let $speakers := $i//SPEAKER
let $dvsp := distinct-values($speakers)
where count($dvsp) > 40
return $i

