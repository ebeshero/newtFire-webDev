xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(:  :declare variable $ThisFileContent := 
string-join(  :)
let $nellColl := collection('/db/Nelson/CSG_XML')
let $nellFile := $nellColl/*
let $SiteIndex := doc('/db/Nelson/siteIndex.xml')/*
let $distSIarchs := distinct-values($SiteIndex//nym//re)
let $fileDates := $nellFile//teiHeader//fileDesc//title//date/@when/string()
let $fileNums := $nellFile//teiHeader//fileDesc//title/@corresp/substring-after(.,'CT0')
let $phrases := $nellFile//phr
let $words := $phrases//w
let $posses := $words[@type='poss']

for $poss in $posses


(:  :let $parentPhr := $poss/ancestor::phr
let $possValue := 
if ($poss[@ana[substring-after(.,'#') = $SiteIndex//nym/@xml:id/string()]]) then ($SiteIndex//nym[@xml:id/string() = ($poss/@ana/substring-after(.,'#'))]//re/string())
else if ($poss[@ana[substring-after(.,'#') = $SiteIndex//org/@xml:id/string()]]) then ($SiteIndex//org[@xml:id/string() = ($poss/@ana/substring-after(.,'#'))]//orgName/string())
else $poss/string()

let $possAtt := 'poss'

let $correspObject := 
if ($poss/parent::phr/w[@type="noun"][@ana[substring-after(.,'#') = $SiteIndex//nym/@xml:id/string()]]) then ($SiteIndex//nym[@xml:id/string() = ($poss/@ana/substring-after(.,'#'))]//re/string())
else if ($poss/parent::phr/w[@type="noun"][@ana[substring-after(.,'#') = $SiteIndex//org/@xml:id/string()]]) then ($SiteIndex//org[@xml:id/string() = ($poss/@ana/substring-after(.,'#'))]//orgName/string())
else $poss/parent::phr/w[@type="noun"]/string()

let $nounAtt := 'noun'

return concat($possValue, "&#x9;", $possAtt, "&#x9;", $parentPhr, "&#x9;", $correspObject, "&#x9;", $nounAtt), "&#10;");

let $filename := "nelsonGrammarOutput.tsv"
let $doc-db-uri := xmldb:store("/db/Nelson", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri :)
(:output = http://dxcvm05.psc.edu:8080/exist/rest/db/rParker/nelsonGrammarOutput.tsv:)

