xquery version "3.1";
let $collection  := collection('/db/shakespeare/plays')/*
let $filePath :=$collection/base-uri()
for $f in $filePath
let $filename := tokenize($f, '/')[last()]
return $filename
