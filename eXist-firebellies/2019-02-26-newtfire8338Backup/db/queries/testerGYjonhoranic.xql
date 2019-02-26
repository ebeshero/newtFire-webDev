xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $doc := doc("/db/graveyard/graveyardInfo-TEI.xml");
declare variable $info := $doc/*;
declare variable $person := $info//tei:person[tei:death];
declare variable $dead := $person//tei:surname;
declare variable $regions := $person//tei:person//tei:region;

declare variable $deadString := $dead/string();
declare variable $regionString := $regions/string();

declare variable $disDead := distinct-values($deadString);
declare variable $disRegions := distinct-values($regionString);


declare variable $listDead :=
    for $i in $disDead
    let $deadCount := count($person[descendant::tei:surname = $i])
    where $deadCount gt 3
    order by $deadCount descending
    return $i;
    
declare variable $listDeadCount :=
    for $i in $disDead
    let $deadCount := count($person[descendant::tei:surname = $i])
    where $deadCount gt 3
    order by $deadCount descending
    return $deadCount;
    
declare variable $regionMatch := 
    for $i in $disDead  
    let $deadCount := count($person[descendant::tei:surname = $i])
    let $deadRegions := $person[descendant::tei:surname = $i]//tei:death//tei:region
    where $deadCount gt 3
    return $deadRegions;

declare variable $disRegionMatch := distinct-values($regionMatch);

declare variable $deadToRegion :=
    for $i in $disDead
    let $deadCount := count($person[descendant::tei:surname = $i])
    let $deadRegions := $person[descendant::tei:surname = $i]//tei:death//tei:region[text()]
    for $r in $deadRegions
    let $regionsCount := count($person[descendant::tei:surname = $i][descendant::tei:death//tei:region = $r])
    where $deadCount gt 3
    order by $regionsCount descending
    return concat($i, "_", $r, "-", $regionsCount);
    
declare variable $disDeadToRegion := distinct-values($deadToRegion);
declare variable $deadCountMax := max($listDeadCount);
declare variable $y := xs:integer($deadCountMax) * 25;
declare variable $x := xs:integer(count($listDead)) * 55;
declare variable $SpacerY := 25;
declare variable $SpacerX := 50;

declare variable $color_1 := "#77DD77";
declare variable $color_2 := "#FDFD96";
declare variable $color_3 := "#779ECB";
declare variable $color_4 := "#FFB347";
declare variable $color_5 := "#CB99C9";
declare variable $color_6 := "#FF6961";
declare variable $color_7 := "#CFCFC4";
declare variable $colorArray := ("#77DD77","#FDFD96","#779ECB","#FFB347","#CB99C9","#FF6961","#CFCFC4");

declare variable $colorSelect :=
    for $i at $pos in $disRegionMatch
    let $colorValue :=
        for $c at $pos2 in $colorArray
        where $pos = $pos2
        return $c
    return concat($i, "_", $colorValue);
    
declare variable $thisFile :=

<svg width="800" height="800" viewBox="0 0 1000 900">
    <g transform="translate(200, 800)">
    
    <text x="10" y="-400" style="font-size:25px">Family Graveplots Seperated by Place of Death Before</text>
    <text x="30" y="-370" style="font-size:25px">Inturment/Reinturment in Brush Creek Cemetary</text>
    
    <line x1="0" y1="0" x2="0" y2="-{$y}" stroke="black" stroke-width="4"/>
    <text x="-30" y="-{$y}">{$deadCountMax}</text>
    <text x="-30" y="-150">{($deadCountMax)* 0.5}</text>
    <text x="-30" y="0">0</text>
    
    <line x1="0" y1="0" x2="{$x}" y2="0" stroke="black" stroke-width="4"/>
        {
        for $i at $pos in $listDead 
        let $deadCount := count($person[descendant::tei:surname = $i])
        let $totalY := $deadCount * $SpacerY
        return 
        
        <g id="{$i}"> 
            <text x="{($pos * $SpacerX) + 10}" y="15" style="writing-mode: tb">{$i}</text>
            <text x="{$pos * $SpacerX}" y="{-$totalY - 15}">{$deadCount}</text>
            <rect x="{$pos * $SpacerX}" y="{-$totalY}" width="20" height="{$totalY}" style="stroke: black; stroke-width:1; fill:none;" />
            
        <g>
            {
            let $deadRegions := $person[descendant::tei:surname = $i]//tei:death//tei:region[text()]
            let $disDeadRegions := distinct-values($deadRegions)
            (: Below: from assignment sheet. :)
            let $matchesRegionList := 
                for $d in $disDeadToRegion
                where substring-before($d, '_') = $i
                return $d
            for $m at $posM in $matchesRegionList
            let $reg := tokenize(substring-after($m, '_'), '-')[1]
            let $count := tokenize(substring-after($m, '_'), '-')[last()]
            let $intCount := xs:integer($count)
            let $regYVal := $intCount * $SpacerY
            let $accumYVal := 
                for $a in (0 to $posM - 1)
          
                let $accum := $matchesRegionList[$posM - $a]
                let $countAccum := (tokenize(substring-after($accum, '_'), '-')[last()], '0')[1]
                let $intCountAccum := xs:integer($countAccum)
                let $accumY := $intCountAccum * $SpacerY
                return $accumY
            let $accumPos := sum($accumYVal)
     
            let $cVal :=
                for $v in $colorSelect
                where $reg = substring-before($v, '_')
                return substring-after ($v, '_')
         
            return
            <g>
                <rect class="{$reg}_{$count}" x="{$pos * $SpacerX}" y="-{$accumPos}" width="20" height="{$regYVal}" style="stroke: black; stroke-width:1; fill: {$cVal}"/>   
            </g>
            }
        </g>  
    </g>}
    </g>
</svg>;

let $filename := "test2.svg"
let $db := xmldb:store("/db/jonhoranic", $filename, $thisFile)
return $db
(: Output: http://dxcvm05.psc.edu:8080/exist/rest/db/jonhoranic/test.svg :)

