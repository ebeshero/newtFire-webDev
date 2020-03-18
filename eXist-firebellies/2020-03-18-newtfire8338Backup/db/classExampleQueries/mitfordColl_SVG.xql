xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
(:2017-03-17 ebb: Here is a complete version of the code I began plotting in class on Friday 3/17. In the output SVG I plot two different kinds of graphs of the same data: the number of letters written by Haydon to Mitford in a given year in the Mitford collection. The first graph is plotted like a bar graph (though it's missing a y-axis). The second is plotted more artfully like a timeline. I've labelled the output with quantities and dates, but I've suppressed output of numbers when they were zero to avoid cluttering the graphs.:)
 (:ebb: One thing I tested and learned after class is that, before I start writing SVG (or other XML below), I can return a global variable, or a set of them, just by setting it in parentheses. Try it as you're mapping out your variables to start. I recommend beginning by writing simple queries to retrieve the data you need, then build up your code to start writing SVG elements with their nested FLWORs. Open your SVG output in oXygen to be sure it's coming out valid and well-formed, but view it in the web browser (oXygen's Author window distorts complex SVG). :)
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];
declare variable $HaydonRefs := $lettersColl//tei:titleStmt/tei:title//tei:persName[@ref="#Haydon"];
declare variable $countHaydonRefs := count($HaydonRefs/@ref/string(.));
declare variable $distinctYears := distinct-values($letterDates);
declare variable $DYears_Integers := 
  for $i in $distinctYears
  order by $i ascending
  return xs:integer($i);
(:ebb: Notice that I can make a variable's value be calculated by a FLWOR statement.:)
declare variable $Years_in_Coll :=
   let $maxDY := max($distinctYears)
   let $minDY := min($distinctYears)
   return xs:integer($maxDY) - xs:integer($minDY);
(:ebb: The variable calculation above gives me the total number of years represented in the collection. :)
declare variable $CountHaydonInYear := 
     for $i in $distinctYears
     let $HaydonPerYear := $HaydonRefs[ancestor::tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1] = $i]
     let $countHPY := count($HaydonPerYear)
     order by $countHPY descending
     return $countHPY;
declare variable $maxHaydonInYear := max($CountHaydonInYear);
(:ebb: In the two variables above, I first return an **array**, or a list of the number of Haydon letters written in each year, with the for-loop. In the next variable, I ask for the maximum value in that for-loop, and that's useful for me to see because it tells me the largest value I'll want to plot. :)
(:ebb: The next variables  :)
declare variable $Year_Space := 100;
declare variable $Year_Space_Graph2 := 50;
declare variable $LetterCount_Space := 10;
declare variable $barWidth := 25;
declare variable $graph1_Ytranslate := $maxHaydonInYear * $LetterCount_Space + 5* $LetterCount_Space;
declare variable $graph2_Ytranslate := 2.5 * $graph1_Ytranslate;
declare variable $centeredHeading := ($Years_in_Coll * $Year_Space + 2* $Year_Space) div 2;

declare variable $ThisFileContent :=
<svg width="{$Years_in_Coll * $Year_Space + 2* $Year_Space + 100}" height="{275 + 450}" 
viewBox="0,0,{($Years_in_Coll * $Year_Space + 2* $Year_Space + 100) * 1.5},{(275 + 450) * 1.5}">
<!--VIEWPORT AND VIEWBOX: After finishing the graph, I went back to tinker with the viewport and viewbox to control the aspect ratio, how the numbers we're using in the SVG respond on a screen. We'll discuss how this works in class, but briefly:
width="{my largest X value for the ENTIRE plot + something with some wiggle room}" 
height="{my largest Y for the ENTIRE plot} + wiggle room}"
I can just plug these in, as I'm doing the "Y" value, based on the numbers I'm generating as my graph's output. 275 was the transform/translate value I used for my 2nd (ribbon) graph (that value was $graph2_Ytranslate), and I just looked at my highest value of "Y" in that graph, and guesstimated something a little larger than that to add to it. The values here, without units, are called "user units" and are defined in "user space".
Now, if I want to define how the image behaves on a screen, I define the viewBox attribute. viewBox takes four values:
viewBox="(x1,y1,x2,y2)" which define a new coordinate system to use in rendering our output image. 
x1,y1 defines starting top-left part of the image, and x2,y2 defines the number that represents the bottom right of the user's screen. 
If x1,y1 does not start at 0,0 it'll select the part of your image that starts where you say as the top left of the viewable SVG. (Notice what happens to the output SVG if you set x1,y1 to 200,200)
If x2,y2 is SMALLER than the total width and height you defined for your image, you'll be zooming and cropping, because the viewBox defines what you can see on the visible screen. (Notice what happens if set x2,y2 to the width div 2 and height div 2).
If the x2,y2 is LARGER than the total width and height, the result effectively zooms out, making the output image take up LESS space on the screen. Think of x2,y2 as defining a ratio with your width and height. 
-->

    <g transform="translate(30, {$graph1_Ytranslate})">
    <text x="{$centeredHeading}" y="{-90}" style="text-anchor: middle">Haydon's letters to Mitford per Year, Output like a Bar Graph</text>
    <line x1="{$Year_Space}" x2="{$Years_in_Coll * $Year_Space + 2* $Year_Space}" y1="0" y2="0" style="stroke:black;"/>
      {for $i at $pos in $DYears_Integers
      let $HaydonPerYear := $HaydonRefs[ancestor::tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1] = string($i)]
      let $CountHPY := count($HaydonPerYear)
      order by $i
        return
          <g>  
            <rect x="{$pos * $Year_Space}" y="-{$CountHPY * $LetterCount_Space}" height="{$CountHPY * $LetterCount_Space}" width="{$barWidth}" style="stroke:#006600; fill: #00cc00"/>
          <!--ebb: I decided I wanted to SUPPRESS any counts when they were zero because the 0's along the bar seemed unnecessary and cluttered. I did that with a tiny internal FLWOR so I could use a **where** statement just for the SVG text element in my output:-->
            {let $showIfNotZero := $CountHPY
            where  $showIfNotZero gt 0
            return
            <text x="{$pos * $Year_Space + $barWidth div 2}" y="{-($CountHPY * $LetterCount_Space) div 2}" style="text-anchor: middle; font-size: 12px;">{$CountHPY}</text>
            }
              <text x="{$pos * $Year_Space}" y="20">{$i}</text>  
         </g>}
  </g>
<!-- ebb: Next, I'm just making a second version of the graph here with a new FLWOR. I added a new variable to shorten the distance between years so my graph doesn't take up so much space.--> 
  <!--ebb: In the SVG elements below, I'm reversing x's and y's and heights vs. widths from the FLWOR above. Since we are plotting **downwards** along the vertical ribbon, we don't need to make y's negative here! I'm also making adjustments to plot the rectangles so they center on the ribbon. The $centeredHeading Global Variable gives me a midpoint on which to plot the line and all the X values I'd like to appear centered along it. If I'm centering a rectangle, I subtract half the width of a rectangle from that midpoint to determine the x position of the rectangle.-->
  
  <g transform="translate(30, {$graph2_Ytranslate})">
  <text x="{$centeredHeading}" y="{-45}" style="text-anchor: middle">Haydon's letters to Mitford per Year, Output Vertically and Centered on a Ribbon</text>
  <line y1="0" y2="{$Years_in_Coll * $Year_Space_Graph2 + $Year_Space_Graph2}" x1="{$centeredHeading}" x2="{$centeredHeading}" style="stroke:navy; stroke-width:15"/>
  {for $i at $pos in $DYears_Integers
      let $HaydonPerYear := $HaydonRefs[ancestor::tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1] = string($i)]
      let $CountHPY := count($HaydonPerYear)
      order by $i
        return
          <g> 

            <rect y="{$pos * $Year_Space_Graph2}" x="{$centeredHeading - ($CountHPY * $LetterCount_Space) div 2}" width="{$CountHPY * $LetterCount_Space}" height="{$barWidth}" style="stroke:#006600; fill: #FFD700"/>
            {let $showIfNotZero := $CountHPY
            where  $showIfNotZero gt 0
            return
            <g>
            <text y="{$pos * $Year_Space_Graph2 + ($barWidth div 1.5)}" x="{$centeredHeading}" style="text-anchor: middle; font-size: 12px;">{$CountHPY}</text>
            <text y="{$pos * $Year_Space_Graph2 + ($barWidth div 1.5)}" x="{$centeredHeading - 75}">{$i}</text> 
            </g>
            }
         </g>}
      </g>
  
</svg>;
let $filename := "HaydonLetterPlots.svg"
let $filepath := "/db/classExampleQueries"
let $doc-db-uri := xmldb:store($filepath, $filename, $ThisFileContent)
return $doc-db-uri

(:ebb: Use the Eval button to save this to the database. Run won't work (says you don't have permission). :)
(: Output at http://dxcvm05.psc.edu:8080/exist/rest/db/classExampleQueries/HaydonLetterPlots.svg :)  




              
