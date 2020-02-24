(: 2019-03-09 FRC: For Network Analysis 2, I am attempting to produce a TSV similar to the one I produced for Network Analysis 1.However, with this assignment I am going to try to examine more closely the relationships between speakers and allusions within the contexts of their locations. Therefore, my source node information is still allusions, but my edge is now the location (because in my documents the allusions and the speakers all occur within a tagged setting or location) and my target node is the speaker (specifically the speaker name).  :)
xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $ulysses := collection('/db/ulysses/ulysses/')
(: FRC: Pulling the allusions from the collection.  :)
let $allusions := $ulysses//allusion/@*/string() => distinct-values()
for $i in $allusions
(: FRC: Pulling the locations that are associated with each allusion from the collection. :)
let $location := $ulysses//location[descendant::allusion/@*/string() = $i]/@name/string() => distinct-values()
for $l in $location
(: FRC: Pulling the speakers that are associated with both each location and allusion from the collection. :)
let $speaker := $ulysses//location[@name = $l][descendant:: allusion/@*/string() = $i]//said/@persName/string() => distinct-values()
(: FRC: This third for loop is only so that there are no repeated speaker values on a line. :)
for $j in $speaker
let $count := $speaker => count()
(: Returning a TSV in the order of source node, edge, edge attribute, target node.  :)
return string-join(($i, $l, $count, $j), "&#x9;")
, "&#10;");
$ThisFileContent
(:  
let $filename := "Carter_NetworkAnalysis2.tsv"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri  :)
(: Output at http://newtfire.org:8338/exist/rest/db/frc23/Carter_NetworkAnalysis2.tsv :) 