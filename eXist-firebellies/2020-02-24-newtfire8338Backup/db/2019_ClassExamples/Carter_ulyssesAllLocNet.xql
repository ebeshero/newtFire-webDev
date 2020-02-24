xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $ulysses := collection('/db/ulysses/ulysses/')
let $allusions := $ulysses//allusion/@*/string() => distinct-values()
for $i in $allusions
let $location := $ulysses//location[descendant::allusion/@*/string() = $i]/@name/string() => distinct-values()
(: 2019-03-08 ebb: Just reviewing incoming TSVs this morning, I saw yours had a couple of multiple values for location which was throwing off your TSV columns. I'm adding the for-loop below so each location generates a separate line of output. :)
for $l in $location
let $speaker := $ulysses//location[@name = $l][descendant:: allusion/@*/string() = $i]//said/@persName/string() => distinct-values()
(: ebb: I'm curious about the speaker count! Do you want to link the allusion to the location based on how many times the allusion is made by a particular speaker? I think you might want to be linking this to distinct locations connected with each allusion, so I have just added a predicate to match $l on the inner for-loop for locations that I just added. Take a look at the results and see what you think. Apparently some of these allusion-location connections are not associated with speakers. :)
let $speakerCount := $speaker => count()
return string-join(($i, $l, $speakerCount), "&#x9;")
, "&#10;");

let $filename := "Carter_ulyssesAllLocNet.tsv"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/Carter_ulyssesAllLocNet.tsv :)    