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
declare variable $deathsSurnameRegion := 
    for $i in $selectSurnames
    let $deathCount := count($deadPeople[descendant::tei:surname = $i])
    let $deathRegions := $deadPeople[descendant::tei:surname = $i]//tei:death//tei:region[text()]
    for $r in $deathRegions 
    let $deathRegCount := count($deadPeople[descendant::tei:surname = $i][descendant::tei:death//tei:region = $r])
    where $deathCount gt 3
    order by $deathRegCount descending
    return concat($i, "_", $r, "-", $deathRegCount) ;
(:This makes an array of strings formatted like this: King_Pennsylvania-3. The same variable repeats for each region, so we'll take distinct values in a new variable:  :)
declare variable $distDeathsSurRegion := distinct-values($deathsSurnameRegion);

declare variable $quantSurnames := count($selectSurnames);
declare variable $X_Spacer := 50;
declare variable $X_Axis_Length := $quantSurnames * $X_Spacer;
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

$distDeathsSurRegion

