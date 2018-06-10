xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $coll := collection('/db/mitford');
declare variable $letColl := collection('/db/mitford/letters');
declare variable $letFiles := $letColl/*;
declare variable $letDates := $letColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];

(:
let $distYears := distinct-values($letDates)
for $distYear in $distYears
order by $distYear
return concat($distYear, ', ')
:)

declare variable $distDates := distinct-values($letDates);
declare variable $maxYear := xs:integer(max($distDates));
declare variable $minYear := xs:integer(min($distDates));
declare variable $yearNum := xs:integer($maxYear) - xs:integer($minYear);
declare variable $lineLength := $yearNum * 365;
declare variable $HaydonLetters := $letColl[descendant::tei:titleStmt/tei:title/tei:persName/@ref="#Haydon"];
declare variable $HaydonDates :=$HaydonLetters//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string(); 
declare variable $minHaydon := min($HaydonDates);
declare variable $maxHaydon := max($HaydonDates);
declare variable $minHaydonYear := xs:integer(tokenize($minHaydon, '-')[1]);
declare variable $maxHaydonYear := xs:integer(tokenize($maxHaydon, '-')[1]);
declare variable $svgHaydonSpan := ($maxHaydonYear - $minHaydonYear) * 365;
declare variable $svgHaydonMinYearPlot := ($minHaydonYear - $minYear) * 365;
declare variable $svgHaydonMaxYearPlot := ($maxHaydonYear - $minYear) * 365;
declare variable $minHaydonDayAdd := xs:integer(format-date($minHaydon, '[d]'));
declare variable $maxHaydonDayAdd := xs:integer(format-date($maxHaydon, '[d]'));
declare variable $svgMinHaydonDate := $svgHaydonMinYearPlot + $minHaydonDayAdd;
declare variable $svgMaxHaydonDate := $svgHaydonMaxYearPlot + $maxHaydonDayAdd;

declare variable $ThisFileContent := 
<svg width="500" height="2700">
   <g transform="translate(30, 100)">
      <line x1="100" y1="0" x2="100" y2="{$lineLength}" stroke="maroon" stroke-width="5"/>  
      
         {
         for $i in (0 to $yearNum)
                return
                 <g>
                <line x1="50" y1="{$i*365}" x2="115" y2="{$i*365}" stroke="black" stroke-width="3"/>
                <text x="35" y="{($i*365) - 25}" fill="maroon" style="font-size:20;">{count($letDates[contains(., $minYear + $i)])}</text>
                <text x="120" y="{($i*365) + 5}">{$minYear + $i}</text>

                <circle cx="50" cy="{$i*365}" r="{count($letDates[contains(., $minYear + $i)])}" fill="black" />

                <line x1="200" y1="{$svgMinHaydonDate}" x2="200" y2="{$svgMaxHaydonDate}" stroke="maroon" stroke-width="3" stroke-dasharray="5,5"/>
                <text x="190" y="{$svgMinHaydonDate - 10}" style="font-size:30;">Haydon Letters</text>
                <text x="210" y="{$svgMinHaydonDate + 15}" style="font-size:20;">1819 - 1823</text>
                
                <rect x="100" y="{$svgMinHaydonDate}" width="100" height="{$svgMaxHaydonDate - 410}" style="fill:maroon;fill-opacity:0.05;"/>
<!-- ebb: Nice work setting a fill-opacity! Another way to control this is by the sequence of the elements you set. By default, SVG plots elements over top of the previous elements if they're in the same coordinate space. So you *could* control this without opacity by putting the text elements after the rect element in your for-loop. -->

            </g>
         }
         
   </g>
</svg>;

let $filename := "ClassExTimeLineP1.svg"
let $doc-db-uri := xmldb:store("/db/quantumSatire", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/quantumSatire/ClassExTimeLineP1.svg :)
(: 2018-04-04 ebb: Excellent work with customizing this timeline assignment: Your output is wonderfully legible and makes a lot of sense to plot as a rectangle rather than a line. We'll be continuing this exercise as our last JavaScript assignment (and last homework of the term), and you have a great code-base here to start with. (In case you're looking ahead, what we'll do is output more people's timespans of correspondence, and toggle them on or off on click of a selection box.) 
 Score: 10/10
 :  :)