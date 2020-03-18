xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(:  :collection('/db/apps/shakespeare/data/')//TEI[distinct-values(descendant::speaker) => count() gt 58]//titleStmt/title:)
let $shakes := collection('/db/apps/shakespeare/data/')
let $wholePlays := $shakes//TEI
let $counts := 
  for $w in $wholePlays 
  let $speakers := $w//sp/@who
   let $distSpeakers := $speakers => distinct-values()
   return count($distSpeakers)
let $maxCount := $counts => max()
return $wholePlays[count(distinct-values(descendant::sp/@who)) = $maxCount]//titleStmt/title


