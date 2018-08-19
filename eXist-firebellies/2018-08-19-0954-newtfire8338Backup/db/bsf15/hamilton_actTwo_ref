xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $hamilton := collection('/db/hamilton/');
declare variable $actOne := collection('/db/hamilton/Act_One');
declare variable $actTwo := collection('/db/hamilton/Act_Two');
declare variable $speakers := $hamilton//sp/@who/tokenize(string(), ' ');
declare variable $actTwo_speakers := $actTwo//sp/@who/tokenize(string(), ' ');
declare variable $distinctSpks := distinct-values($speakers);
declare variable $actTwo_distinctSpks := distinct-values($actTwo_speakers);

declare variable $ThisFileContent:=
string-join(
for $i in $actTwo_distinctSpks
let $actTwo_songs := $actTwo//text[descendant::sp/@who[tokenize(string(), ' ') = $i]]
let $song := $actTwo_songs//head/title

for $s in $song
let $selectSong := $actTwo_songs[descendant::head/title = $s]
let $speakerApp := count($selectSong//sp/@who[tokenize(string(), ' ') = $i])
let $persRef := $selectSong//sp[@who[tokenize(string(), ' ') = $i]]//persName/@ref
let $distinct_persRef := distinct-values($persRef)

for $r in $distinct_persRef
let $refApp := count($selectSong//sp[@who[tokenize(string(), ' ') = $i]]//persName[@ref = $r])


return
    concat(substring-after($i, '#'), "&#x9;", $speakerApp, "&#x9;",  $s, 
"&#x9;", substring-after($r, '#'), "&#x9;", $refApp),  "&#10;");

let $filename := "hamilton_act_two_ref_data.tsv"
let $doc-db-uri := xmldb:store("/db/bsf15/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
