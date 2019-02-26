xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $graveyard := doc("/db/graveyard/graveyardInfo-TEI.xml")/*;
declare variable $dead := $graveyard//tei:person[tei:death];
declare variable $surnames := distinct-values($dead//tei:surname);
declare variable $regions := $dead//tei:death//tei:region[text()];

(: Dead people :)
declare variable $surname-death := 
    for $i in $surnames
    let $deathCount := count($dead[descendant::tei:surname = $i])
    where $deathCount gt 3
    order by $deathCount descending
    return $i;

(: Regions where the dead people died :)
declare variable $regions-surnames := 
            for $i in $surnames 
            let $deathCount := count($dead[descendant::tei:surname = $i])
        let $regions-dead := $dead[descendant::tei:surname = $i]//tei:death//tei:region
        where $deathCount gt 3
        return $regions-dead;
        
declare variable $actual-regions := distinct-values($regions-surnames);

declare variable $death-surname-region := 
    for $i in $surname-death
    let $death-count := count($dead[descendant::tei:surname = $i])
    let $death-regions := $dead[descendant::tei:surname = $i]//tei:death//tei:region[text()]
    for $r in $death-regions 
    let $count-death-regions := count($dead[descendant::tei:surname = $i][descendant::tei:death//tei:region = $r])
    where $death-count gt 3
    order by $count-death-regions descending
    return concat($i, "-", $r, "-", $count-death-regions) ;

declare variable $distDeathsSurRegion := distinct-values($death-surname-region);

declare variable $colors :=  ("#E6B0AA", "#D7BDE2", "#A9CCE3", "#A3E4D7","#F9E79F", "#DC7633", "#808B96");

declare variable $colorStates :=
    for $i at $posI in $actual-regions
    let $colorVal := 
        for $c at $posC in $colors
        where $posI = $posC
        return $c
    return concat($i, "-", $colorVal);
    
 declare variable $ThisFileContent :=
 
<svg width='1000' height="1000" viewBox='0,0,1200,1200'>
    <g transform="translate(100, 500)">
        <text x="0" y="-450">Count Of Dead- {count($dead[descendant::tei:surname])}</text>
        <text x="0" y="-420">Count Of Distinct Families- {count($surname-death)}</text>
        <text x="0" y="-350">For more information on the Graveyard Project, click <a href="http://graveyard.newtfire.org">here</a></text>

    <g>
        <rect x="600" y="-490" height="300" width="200"
            style="stroke:black; stroke-width: 1; fill: none"/>
        <text x="630" y="-460">Legend:</text>
    {for $i at $pos in $actual-regions
        let $colorVal := 
            for $c at $pos2 in $colors
            where $pos = $pos2
            return $c
        return
    <g>
        <text x="635" y="{-460 + $pos * 30}">{$i}</text>
        <rect x="730" y="{-475 + ($pos * 30)}" height="20" width="20" style="stroke: black; stroke-width: 1; fill:{$colorVal}"/>
    </g>
    }
    <g>
        <text x="635" y="{-460 + (count($actual-regions) + 1) * 30}">Unmarked</text>
        <rect x="730" y="{-475 + (count($actual-regions) + 1) * 30}" height="20" width="20" style="stroke: black;stroke-width: 1;fill: none"/>
    </g>
    </g>
      
    <g>
        <line x1="0" y1="0" x2="600" y2="0" style="stroke: black; stroke-width: 2"/>
        <text x="0" y="-480">Geographic Distribution of Families with more than 3 deaths in Brush Creek Section I</text>
        <line x1="0" y1="0" x2="0" y2="-240" style="stroke: black; stroke-width: 2"/>
        <text x="-50" y="-170" style="writing-mode: tb; transform: rotate(360deg);">Number of Deaths</text>

    {
    for $i at $pos in $surname-death 
    let $deathCount := count($dead[descendant::tei:surname = $i])
    let $y := $deathCount * 20
    return 
    <g> 
        <text x="{$pos * 50 + 50}" y="15" style="text-anchor: end" transform="rotate(-90,{$pos * 50 + 25},30)">{$i}</text>
        <text x="{$pos * 50}" y="{-$y - 15}">{$deathCount}</text>
        <rect x="{$pos * 50}" y="{-$y}" width="20" height="{$y}" style="stroke: black; stroke-width:1;fill:none;"/>

    <g>{
        let $matchesRegionList := 
            for $d in $distDeathsSurRegion
            where substring-before($d, '-') = $i
            return $d
                for $m at $posM in $matchesRegionList
                    let $reg := tokenize(substring-after($m, '-'), '-')[1]
                    let $count := tokenize(substring-after($m, '-'), '-')[last()]
                    let $intCount := xs:integer($count)
                    let $regYVal := $intCount * 20
                    let $accumYVal := 
                        for $a in (0 to $posM - 1)
                        let $accum := $matchesRegionList[$posM - $a]
                        let $countAccum := (tokenize(substring-after($accum, '-'), '-')[last()], '0')[1]
                        let $intCountAccum := xs:integer($countAccum)
                        let $accumY := $intCountAccum * 20
                        return $accumY
                    let $accumPos := sum($accumYVal)
                    let $cVal :=
                        for $v in $colorStates
                        where $reg = substring-before($v, '-')
                        return substring-after ($v, '-')
                    return
    <g>
        <rect class="{$reg}_{$count}" x="{$pos * 50}" y="-{$accumPos}" width="20" height="{$regYVal}" style="stroke:black; stroke-width:1; fill: {$cVal}"/>   
    </g>
    }
    </g>
    </g>
    }
    </g>
    </g>
</svg>;

let $filename := "Newton_XQueryEx4.svg"
let $filepath := "/db/ajnewton1"
let $doc-db-uri := xmldb:store($filepath, $filename, $ThisFileContent)
return $doc-db-uri 

(: Output http://dxcvm05.psc.edu:8080/exist/rest/db/ajnewton1/Newton_XQueryEx4.svg :) 

