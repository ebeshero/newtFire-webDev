xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $ThisFileContent:=
(: 2018-03-12 ebb: To fix this, we just needed to take distinct-values of every piece of output shy of the emos themselves. We needed distinct-values of the gender attributes, for example, because those weren't matching up with the distinct values of names. I had to do the same thing with the titles of plays--get the distinct values--so we didn't return the cardinality error.  :)
string-join(
let $lope := collection('/db/lope/plays')/*
let $lopeSpeakers := $lope//sp/@who
let $lopeDistinctSpeakers := distinct-values($lopeSpeakers)
for $eDS in $lopeDistinctSpeakers
let $name := substring-after($eDS, '#')
let $match := $lope//sp[@who=$eDS]
let $spGender := distinct-values($match/@ana/string())
let $emos := $match/descendant::w[@type='emotion']/string()
let $distEmos := distinct-values($emos)

let $edge:= 'sp'
let $edgeTitle := distinct-values($match/tokenize(base-uri(), '/')[last()])
(: ebb: LET'S EXPERIMENT WITH EDGE ATTRIBUTES: Let's make the $edge be the title of the play in which this connection appears. That's what we're getting with $edgeTitle: I used the base-uri() function to get the filepath. We needed to take distinct values here so this matches up with the distinct list of character names.:)
for $e in $distEmos
return

concat($name, "&#x9;", $spGender, "&#x9;", $edge,  "&#x9;", $edgeTitle,  "&#x9;", $e), "&#10;");

let $filename := "lopeEmoNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/lope", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/lope/lopeEmoNetwork.tsv ) :)   

