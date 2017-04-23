xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $graveyard := doc("/db/graveyard/graveyardInfo-TEI.xml")/*;
declare variable $deadPeople := $graveyard//tei:person[tei:death];
declare variable $countDead := count($deadPeople);
declare variable $countDeadwithSurnames := count($deadPeople[descendant::tei:surname]);
declare variable $surnames := distinct-values($deadPeople//tei:surname);
declare variable $regionsOfDeath := $deadPeople//tei:death//tei:region[text()];
(:Some of the region elements are empty, so check if a text node is present. :)
declare variable $distinctRegions := distinct-values($regionsOfDeath/normalize-space());
declare variable $usualRegions := 
            for $i in $surnames 
            let $deathCount := count($deadPeople[descendant::tei:surname = $i])
        let $regionsForThese := $deadPeople[descendant::tei:surname = $i]//tei:death//tei:region
        where $deathCount gt 3
        return $regionsForThese;
declare variable $distinctUsualRegions := distinct-values($usualRegions);
(:ebb: variables for calculating the Y axis (via max Y value) on bar graph, and stretching Y values for visibility::)
declare variable $countsBySurname :=
   for $i in $surnames
    let $deathCount := count($deadPeople[descendant::tei:surname = $i])
    return $deathCount;
declare variable $maxY := max($countsBySurname);
declare variable $Y_StretchFactor := 20;
declare variable $Y_Axis_Length := $maxY * $Y_StretchFactor;
(:ebb: variables for calculating the X axis and spacing X values.:)
declare variable $selectSurnames := 
    for $i in $surnames
    let $deathCount := count($deadPeople[descendant::tei:surname = $i])
    where $deathCount gt 3
    order by $deathCount descending
    return $i;
(:ebb: Below, I'm making an array to store information about each surname, regions represented, and the number of deaths for that surname per region :)
declare variable $deathsSurnameRegion := 
    for $i in $selectSurnames
    let $deathCount := count($deadPeople[descendant::tei:surname = $i])
    let $deathRegions := $deadPeople[descendant::tei:surname = $i]//tei:death//tei:region[text()]
    for $r in $deathRegions 
    let $deathRegCount := count($deadPeople[descendant::tei:surname = $i][descendant::tei:death//tei:region = $r])
    where $deathCount gt 3
    order by $deathRegCount descending
    return concat($i, "_", $r, "-", $deathRegCount) ;
(:This makes an array of strings formatted like this: King_Pennsylvania-3. The same variable repeats for each region, so we'll take distinct values in a new variable, below. We can reach up to information stored in this array when we're plotting our stacked bar plots, and use substring-before() and substring-after() to grab the pieces we need to match up. :)
declare variable $distDeathsSurRegion := distinct-values($deathsSurnameRegion);

declare variable $quantSurnames := count($selectSurnames);
declare variable $X_Spacer := 50;
declare variable $X_Axis_Length := $quantSurnames * $X_Spacer + $X_Spacer;
(: Named color codes for SVG are listed and shown here: http://www.december.com/html/spec/colorsvg.html. I decided I wanted to color based on 
 : shared hues, keeping the number of different colors limited. (Read more about choosing colors for the web here: https://webdesign.tutsplus.com/articles/a-comprehensive-introduction-to-color-in-design--cms-26480 )
 : I found a helpful list of 12 "soft hues" here: http://www.december.com/html/spec/softhues.html
 : I only need 7 for the 7 distinct regions on the legend.
 :   :)
 (:MESSING WITH COLORS:)
declare variable $color_1 := "#99FFCC"; (:pale green:)
declare variable $color_2 := "#CCCC99"; (:deep gold:)
declare variable $color_3 := "#CCCCFF"; (:lavender:)
declare variable $color_4 := "#CCFFFF"; (:aqua:)
declare variable $color_5 := "#FFCC99"; (:light orange:)
declare variable $color_6 := "#FFFF99"; (:light yellow:)
declare variable $color_7 := "#CCCCCC"; (:grey:)
declare variable $colorArray :=  ("#99FFCC", "#CCCC99", "#CCCCFF", "#CCFFFF","#FFCC99", "#FFFF99", "#CCCCCC");
(:ebb: You know what I want? I want an array that holds the name of a state and its associated color variable, just like my legend below does. I'm going to output these as a variable that I can match and break apart by tokenizing and looking at substrings.  :)
declare variable $colorStates :=
 for $i at $pos in $distinctUsualRegions
 let $colorVal := 
    for $c at $pos2 in $colorArray
    where $pos = $pos2
    return $c
 return concat($i, "_", $colorVal);
 
declare variable $ThisFileContent :=
<svg width='1000' height="1000" viewBox='0,0,1200,1200'>
    <g transform="translate(100, 500)">
        <text x="0" y="-480">Brush Creek Cemetery Section I: Count of the dead: {$countDead}</text>
        <text x="0" y="-450">Count of the dead with surnames: {$countDeadwithSurnames}</text>
        <text x="0" y="-430">Count of distinct surnames: {count($surnames)} </text>
        <text x="0" y="-410">Which distinct regions are represented where the family deathcount is greater than 3?</text>
        <!--ebb: I asked this question to help me work out how many different regions would be represented on my stacked bar graph.
        I  wrote a FLWOR to make a list of the region names to output in a list here. I can also loop through this list to output an array I can use for color coding. I want each region to have its own color in my stacked graph.
        -->
        <text x="0" y="-390">
        {let $countDR := count($distinctUsualRegions)
return concat("There are ", $countDR, ": ", string-join($distinctUsualRegions, ', '))}
        </text>
<!--The concat function joins single strings together. String-join bundles multiple strings together and ties them with whatever punctuation I want to use. I can combine them together here.-->   


<g id="legend"><!--Make a legend: Draw an SVG rectangle with no fill. Put inside its area some text elements followed by boxes to indicate color coding of each distinct region. -->
<rect x="600" y="{-490}" height="{30 * 10}" width="200"
        style="stroke:black; stroke-width: 1; fill: none"/>
<text x="630" y="{-490 + 30}">Legend:</text>
<!--I'm going to make a FLWOR that outputs each region in a text element next to a rectangle that contains an associated color, determined by position in a for-loop. -->

{for $i at $pos in $distinctUsualRegions
 let $colorVal := 
    for $c at $pos2 in $colorArray
    where $pos = $pos2
    return $c
return
    <g>
    <text x="635" y="{-490 + 30 + $pos * 30}">{$i}</text>
    <rect x="730" y="{-490 + 15 + ($pos * 30)}" height="20" width="20" style="stroke: black; stroke-width: 1; fill: {$colorVal}"/>
    </g>
}
<g>
    <!--ebb: This is to set the last box for unmarked records, which will look clear on the graph. -->
    <text x="635" y="{-490 + 30 + (count($distinctUsualRegions) + 1) * 30}">Unmarked</text>
    <rect x="730" y="{-490 + 15 + (count($distinctUsualRegions) + 1) * 30}" height="20" width="20" style="stroke: black; stroke-width: 1; fill: none"/>
</g>
    </g>
        
<g id="graph"><!--bar graph here. -->
<!--X axis: -->
<line x1="0" y1="0" x2="{$X_Axis_Length}" y2="0" style="stroke: black; stroke-width: 2"/>
<text x="10" y="-{$Y_Axis_Length + 50}" style="text-anchor: start">Geographic Distribution of Families with more than 3 deaths in Brush Creek Section I</text>
<!--Y axis: -->
<line x1="0" y1="0" x2="0" y2="-{$Y_Axis_Length}" style="stroke: black; stroke-width: 2"/>
<text x="-30" y="-{$Y_Axis_Length div 2}" style="text-anchor: middle; writing-mode: tb; glyph-orientation-vertical: 0;">Number of Deaths</text>
<!--horizontal hashmarks at top and midpoint on Y axis: -->
<line x1="-5" x2="5" y1="-{$Y_Axis_Length}" y2="-{$Y_Axis_Length}" style="stroke: black; stroke-width: 1"/>
<text x="-10" y="-{$Y_Axis_Length}" style="text-anchor: end">{$maxY}</text>
<line x1="-5" x2="5" y1="-{$Y_Axis_Length div 2}" y2="-{$Y_Axis_Length div 2}" style="stroke: black; stroke-width: 1"/>
<text x="-10" y="-{$Y_Axis_Length div 2}" style="text-anchor: end">{$maxY div 2}</text>

{
for $i at $pos in $selectSurnames 
let $deathCount := count($deadPeople[descendant::tei:surname = $i])
let $totalYVal := $deathCount * $Y_StretchFactor
(: Working with our global variable $selectSurnames, this returns 11 surnames where the deathcount is higher than 3 :)
return 
   <g id="{$i}"> 
   <!--surname labels-->
   <text x="{$pos * $X_Spacer + ($X_Spacer div 2)}" y="5" style="text-anchor: end" transform="rotate(-45,{$pos * $X_Spacer + ($X_Spacer div 2)},30)">{$i}</text>
   <!--total deathcount: put above top of bar -->
   <text x="{$pos * $X_Spacer}" y="{-$totalYVal - 15}">{$deathCount}</text>
   <rect x="{$pos * $X_Spacer}" y="{-$totalYVal}" width="20" height="{$totalYVal}" style="stroke: black; stroke-width:1; fill:none;" />
<!--ebb: Make stacked bars based on counts in each region. To do this we need to be able to access each region, get its count, and **add** it to the bar below it. Let's try a for-loop that is based on numbers, for each member of a list of distinct values for a surname's regions that's output according to descending order.
NOTE: We may loop through distinct values of regions taken inside the FLWOR, get the count at each region, and output them by descending count, or build something like I did here by storing all the information in a global variable. No matter how you do it, you're going to need an **accumulator** array to add the count for each region to the counts of its predecessors in order to make a stacked bar graph. A stacked bar has to work so that the stack you're processing stands on top of the preceding ones.  
-->
<g class="regions">{
     let $deathRegions := $deadPeople[descendant::tei:surname = $i]//tei:death//tei:region[text()]
     let $distinctDRs := distinct-values($deathRegions)
     let $matchesRegionList := 
          for $d in $distDeathsSurRegion
          where substring-before($d, '_') = $i
          return $d
     for $m at $posM in $matchesRegionList
     let $reg := tokenize(substring-after($m, '_'), '-')[1]
     let $count := tokenize(substring-after($m, '_'), '-')[last()]
     let $intCount := xs:integer($count)
     let $regYVal := $intCount * $Y_StretchFactor
     let $accumYVal := 
          for $a in (0 to $posM - 1)
          (:ebb: This very useful loop lets us look up the counts at each of the *previous* $posM steps! :)
          let $accum := $matchesRegionList[$posM - $a]
          let $countAccum := (tokenize(substring-after($accum, '_'), '-')[last()], '0')[1]
          let $intCountAccum := xs:integer($countAccum)
          let $accumY := $intCountAccum * $Y_StretchFactor
          return $accumY
     let $accumPos := sum($accumYVal)
     (:ebb: Now we add the all the preceding YVals together. Notice where we use this value in the graph below. :)
     let $cVal :=
         for $v in $colorStates
         where $reg = substring-before($v, '_')
         return substring-after ($v, '_')
         (:ebb: Here we're looping over the $colorStates global variable, and wherever its region substring matches our current region, we output its color value substring for use in coloring our region stacks. :)
     return
        <g> <!--<text>checking $accumYVal: {$accumYVal}</text>-->
      <rect class="{$reg}_{$count}" x="{$pos * $X_Spacer}" y="-{$accumPos}" width="20" height="{$regYVal}" style="stroke: black; stroke-width:1; fill: {$cVal}"/>   
</g>
          }
 </g>          

</g>
}
</g>

</g>
</svg>;
let $filename := "graveyardTester.svg"
let $filepath := "/db/classExampleQueries"
let $doc-db-uri := xmldb:store($filepath, $filename, $ThisFileContent)
return $doc-db-uri 

(:ebb: Use the Eval button to save this to the database. Run won't work (says you don't have permission). :)
(: Output at http://dxcvm05.psc.edu:8080/exist/rest/db/classExampleQueries/graveyardTester.svg :)  

