xquery version "3.1";
declare variable $ulysses := collection('/db/ulysses/ulysses/')/*;
declare variable $telemachiad := $ulysses[descendant::section/@sectionName = 'The Telemachiad'];
declare variable $wanderings := $ulysses[descendant::section/@sectionName = 'The Wanderings of Ulysses'];
declare variable $homecoming := $ulysses[descendant::section/@sectionName = 'The Homecoming'];

declare variable $telemachiadRefs := $telemachiad//location//reference/@to/string() => count();
declare variable $telemachiadAllus := $telemachiad//location//allusion/@*/string() => count();
declare variable $telemachiadPers := $telemachiad//location//person/@who/string() => count();
declare variable $wanderingsRefs := $wanderings//location//reference/@to/string() => count();
declare variable $wanderingsAllus := $wanderings//location//allusion/@*/string() => count();
declare variable $wanderingsPers := $wanderings//location//person/@who/string() => count();
declare variable $homecomingRefs := $homecoming//location//reference/@to/string() => count();
declare variable $homecomingAllus := $homecoming//location//allusion/@*/string() => count();
declare variable $homecomingPers := $homecoming//location//person/@who/string() => count();

declare variable $telemachiadTotal := $telemachiadRefs + $telemachiadAllus + $telemachiadPers;
declare variable $wanderingsTotal := $wanderingsRefs + $wanderingsAllus + $wanderingsPers;
declare variable $homecomingTotal := $homecomingRefs + $homecomingAllus + $homecomingPers;
declare variable $ulyssesTotal := $telemachiadTotal + $wanderingsTotal + $homecomingTotal;

declare variable $ulyssesTitles := $ulysses//chapter/@chapterName/string();
declare variable $ThisFileContent := 
<svg width="2000" height="3000">
<g transform="translate(30, 30)">
<line x1 = "50" y1 = "10" x2 = "50" y2 = "{$ulyssesTotal}" style="stroke:blue;stroke-width:2"/>
<line x1 = "25" y1 = "{$ulyssesTotal}" x2 = "75" y2 = "{$ulyssesTotal}" style="stroke:blue;stroke-width:2"/> 

<text x = "25" y = "{$ulyssesTotal + 20}">Total references, allusions, and persons in Ulysses: {$ulyssesTotal}</text>

<rect x = "100" y = "10" width = "200" height = "{$telemachiadRefs}" style = "fill:red"/>
<text x = "100" y = "40">Telemachiad References: {$telemachiadRefs}</text>
<rect x = "100" y = "{$telemachiadRefs + 10}" width = "200" height = "{$telemachiadAllus}" style = "fill:blue"/>
<text x = "100" y = "{$telemachiadRefs + 30}">Telemachiad Allusions: {$telemachiadAllus}</text>
<rect x = "100" y = "{$telemachiadAllus + $telemachiadRefs + 10}" width = "200" height = "{$telemachiadPers}" style = "fill:yellow"/>
<text x = "100" y = "{$telemachiadAllus + $telemachiadRefs + 30}">Telemachiad Persons: {$telemachiadPers}</text>

<rect x = "350" y = "10" width = "200" height = "{$wanderingsRefs}" style = "fill:red"/>
<text x = "350" y = "40">Wanderings References: {$wanderingsRefs}</text>
<rect x = "350" y = "{$wanderingsRefs + 10}" width = "200" height = "{$wanderingsAllus}" style = "fill:blue"/>
<text x = "350" y = "{$wanderingsRefs + 30}">Wanderings Allusions: {$wanderingsAllus}</text>
<rect x = "350" y = "{$wanderingsAllus + $wanderingsRefs + 10}" width = "200" height = "{$wanderingsPers}" style = "fill:yellow"/>
<text x = "350" y = "{$wanderingsAllus + $wanderingsRefs + 30}">Wanderings Persons: {$wanderingsPers}</text>

<rect x = "600" y = "10" width = "200" height = "{$homecomingRefs}" style = "fill:red"/>
<text x = "600" y = "40">Homecoming References: {$homecomingRefs}</text>
<rect x = "600" y = "{$homecomingRefs + 10}" width = "200" height = "{$homecomingAllus}" style = "fill:blue"/>
<text x = "600" y = "{$homecomingRefs + 30}">Homecoming Allusions: {$homecomingAllus}</text>
<rect x = "600" y = "{$homecomingAllus + $homecomingRefs + 10}" width = "200" height = "{$homecomingPers}" style = "fill:yellow"/>
<text x = "600" y = "{$homecomingAllus + $homecomingRefs + 30}">Homecoming Persons: {$homecomingPers}</text>
{
for $i in $ulyssesTitles
let $tAllusCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Telemachiad']//location//allusion/@* =>count()
let $tRefsCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Telemachiad']//location//reference/@to =>count()
let $tPersCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Telemachiad']//location//person/@who =>count()
let $wAllusCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Wanderings of Ulysses']//location//allusion/@* =>count()
let $wRefsCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Wanderings of Ulysses']//location//reference/@to =>count()
let $wPersCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Wanderings of Ulysses']//location//person/@who =>count()
let $hAllusCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Homecoming']//location//allusion/@* =>count()
let $hRefsCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Homecoming']//location//reference/@to =>count()
let $hPersCount := $ulysses[descendant::chapter/@chapterName = $i][descendant::section/@sectionName = 'The Homecoming']//location//person/@who =>count()
return 
    <g>
       <line x1 = "25" y1 = "{$tAllusCount}" x2 = "75" y2 = "{$tAllusCount}" style="stroke:pink;stroke-width:2"/> 
       <line x1 = "25" y1 = "{$tRefsCount}" x2 = "75" y2 = "{$tRefsCount}" style="stroke:pink;stroke-width:2"/>
       <line x1 = "25" y1 = "{$tPersCount}" x2 = "75" y2 = "{$tPersCount}" style="stroke:pink;stroke-width:2"/> 
        <line x1 = "25" y1 = "{$wAllusCount}" x2 = "75" y2 = "{$wAllusCount}" style="stroke:orange;stroke-width:2"/> 
       <line x1 = "25" y1 = "{$wRefsCount}" x2 = "75" y2 = "{$wRefsCount}" style="stroke:orange;stroke-width:2"/>
       <line x1 = "25" y1 = "{$wPersCount}" x2 = "75" y2 = "{$wPersCount}" style="stroke:orange;stroke-width:2"/> 
              <line x1 = "25" y1 = "{$hAllusCount}" x2 = "75" y2 = "{$hAllusCount}" style="stroke:purple;stroke-width:2"/> 
       <line x1 = "25" y1 = "{$hRefsCount}" x2 = "75" y2 = "{$hRefsCount}" style="stroke:purple;stroke-width:2"/>
       <line x1 = "25" y1 = "{$hPersCount}" x2 = "75" y2 = "{$hPersCount}" style="stroke:purple;stroke-width:2"/> 



        </g>
}
<text x = "-10" y = "-10">The line is a chapter by chapter comparison of the number of allusions, references, and persons in each section, with Telemachiad pink, Wanderings orange, and Homecoming purple.</text>
</g>
</svg>;

let $filename := "ulyssesGraph.svg"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/frc23/ulyssesGraph.svg :) 
