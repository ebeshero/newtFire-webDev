xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";

let $Dickinson := collection('/db/dickinson/f16/')
let $poemFiles := $Dickinson/*
let $apps := $poemFiles//text//body//l//app
let $rdgs := $apps/rdg
let $wits := $rdgs/@wit
for $wit in $wits
let $witNames := tokenize($wit, '\s+')[starts-with(., '#')]
for $witName in $witNames
let $edge := $wit/parent::rdg
let $poemTitle := $wit/ancestor::TEI//titleStmt/title
let $otherWits := $wit/tokenize(., '\s+')[starts-with(., '#')][not(. = $witName)]
let $countOtherWits := count($otherWits)
for $otherWit in $otherWits

return string-join(string-join(($witName, $edge, $poemTitle, $countOtherWits, $otherWit), "&#x9;"), "&#10;")




