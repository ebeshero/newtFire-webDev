xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $coll := collection ('/db/rickandmorty/drlScripts/');
declare variable $possessee := $coll//tei:TEI//tei:body//tei:speaker[@who]/text();
declare variable $possessor := $coll//tei:TEI//tei:body//tei:speaker/@who/string();
declare variable $distVal := distinct-values($possessor);

for $edp in $distVal
let $count := count($distVal)
order by $count ascending
return

<svg class="chart" width="600" height="800">
     <g class="bar">
    <rect x="{count($edp)+1}" y="0" width="19" height="{$count * 10}"></rect>
    <text x="{$count*10+3}" y="9.5" dy=".35em">{$distVal}</text>
    </g>
    
     </svg>
     
