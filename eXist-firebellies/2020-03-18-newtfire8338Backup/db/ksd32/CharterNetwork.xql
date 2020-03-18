xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";

let $Breacon := doc('/ksd32/CharterCollation.xml')
let $doc := $Breacon//sourceDesc//bibl/@xml:id/string()
for $d in $doc
let $DistinctDoc := $doc =>distinct-values()
(: Documents :)
let $wit := $Breacon//text/body/ab/app/rdg/@wit/string()
for $i in $Breacon 
let $CountWit := $Breacon//body//ab//rdg/@wit =>count()
(: count of witnesses :)
(: count of documents :)
let $appear := $Breacon//body//pb/@ed/string()
for $a in $appear
let $pear :=$Breacon//*[parent::ab//app/rdg/@wit/string()=$a]
return $pear
