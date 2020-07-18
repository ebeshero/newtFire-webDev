xquery version "3.1";
(: FRC: I procrastinated and didn't leave enough time for this assignment, and I'm not sure that I got everything to work as it should. Perhaps this is due to the fact that I haven't worked with XQuery in a bit, but I had trouble referencing the paintings that were related to each year of the for loop, and this meant that the timeline doesn't really represent, for example, the changes in medium like I wanted it to. :)
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $sourceDesc := $banksyColl//sourceDesc;
declare variable $titles := $sourceDesc//title;
declare variable $medium := $sourceDesc//medium/@type/string();
declare variable $date := $sourceDesc//date/@when/string();
declare variable $minDate := $date => min();
declare variable $maxDate := $date => max();
declare variable $years := $date ! tokenize(., '-')[1];
declare variable $minYear := $years ! number() => min();
declare variable $maxYear := $years ! number() => max();
declare variable $difference := xs:integer($maxYear) - xs:integer($minYear);
declare variable $timelineSpacer := 100;
 declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30, 30)">
          <line x1="0" y1="0" x2="0" y2="{($maxYear - $minYear) * $timelineSpacer}" style="stroke:blue;stroke-width:2;"/>  
        {
         for $i in (0 to $difference)
         let $year := $minYear + $i
        let $paintingsByYear := $sourceDesc[($date ! tokenize(.,'-')[1]) ! xs:integer(.)  = $year]
         let $count := $paintingsByYear => count()
         let $color := if ($sourceDesc[descendant::medium = "spray_paint"]) then "blue"
         else if ($sourceDesc[descendant::medium = "canvas"]) then "red"
         else "violet"
         return
          <g>     
            <circle cx="0" cy="{$i * $timelineSpacer}" r="{1 + $count * .1}" stroke="purple" stroke-width="3" fill="{$color}" />
          <text x = "30" y = "{$i * $timelineSpacer}">{$year}</text>
          <text x = "80" y = "{$i * $timelineSpacer}">Number of works: {$count}</text>
       </g>
            }
         </g>

</svg>;
let $filename := "Carter_SVG2_Output.svg"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/frc23/Carter_SVG2_Output.svg :) 
