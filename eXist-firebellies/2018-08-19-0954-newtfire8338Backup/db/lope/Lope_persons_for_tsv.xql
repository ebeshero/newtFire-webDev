xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
string-join(
let $lope := collection('/db/lope')/*
let $lopeSpeakers := $lope//sp/@who
let $lopeDistinctSpeakers := distinct-values($lopeSpeakers)
for $eDS in $lopeDistinctSpeakers
let $name := substring-after($eDS, '#')
let $match := $lope//sp[@who=$eDS]
let $spGender := $match/@ana/string()
let $emos := $match/descendant::w[@type='emotion']/string()
let $distEmos := distinct-values($emos)

let $edge:= 'sp'
for $e in $emo
return
concat($name, "&#x9;", $spGender, "&#x9;", $edge, "&#x9;", $e), "&#x10;")
 
