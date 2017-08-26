xquery version "3.0";

let $collection:=collection('/db/tibetan')

let $phrase:=$collection//phrase[@phr_id='4']

return $phrase/string()
