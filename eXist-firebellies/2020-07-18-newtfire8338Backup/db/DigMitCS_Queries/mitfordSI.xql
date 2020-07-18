xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $lineFeed := '&#10;';
declare variable $ThisFileContent := string-join(
let $si := doc('/db/mitford/si.xml')/*
let $histPersons := $si//listPerson[@sortKey="histPersons"]
(:  :let $occupations := $histPersons//occupation:)
(:  :let $distinctOccs := distinct-values($occupations/normalize-space()) :)
(:  :let $sortedTwinkies := sort($distinctOccs) :)
let $persons := $histPersons/person
for $i in $persons
let $id := $i/@xml:id/string()
let $names := $i/child::persName/normalize-space(string())
let $tab := '&#x9;'
let $comma := '?! '
let $joinedNames := string-join($names, $comma)
let $occupations := $i//occupation
let $joinedOccs := string-join($occupations, $comma)
let $viaf := $i//ref[contains(@target, 'viaf')]/@target/string()
(: &#x9; is a tab separator. &#10; is a line-feed character:)
return concat($id, $tab, $joinedNames, $tab, $joinedOccs, $tab, $viaf), $lineFeed);

let $filename := "MitfordSI.tsv"
let $doc-db-uri := xmldb:store("/db/mitford/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/mitford/MitfordSI.tsv ) :)   


