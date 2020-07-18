xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
 (: declare more global variables to pull data from the Banks collection. :)
  declare variable $timelineSpacer := 100;
 declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
 declare variable $years := $dates ! tokenize(., '-')[1];
 declare variable $minYear := $years ! xs:integer(.) => min();
 declare variable $maxYear := $years ! xs:integer(.) => max();
 declare variable $lineLength := $maxYear - $minYear;
 declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30, 30)">
      <line x1="0" y1="0" x2="0" y2="{$lineLength * $timelineSpacer}" style="stroke:blue;stroke-width:2;"/>  
      {
          
        for $i in (0 to $lineLength)
        let $matchYear := $minYear + $i
        return
            <g>
             <circle cx="0" cy="{$i * $timelineSpacer}" r="2" stroke="purple" stroke-width="3" fill="violet"/>
             <circle cx="0" cy="300" r="4" stroke="purple" stroke-width="3" fill="violet"/>
            <text x="10" y="300" style="fill:navy; stroke-width: 2; text-anchor:start">2002</text>
            <text x="50" y="300" style="fill:navy; stroke-width: 2; text-anchor:start">Choose Your Weapon, Girl with Balloon</text>
            <rect x="75" y="320" height="20" width="20" style="fill: aqua"/>
            <text x="78" y="335" style="fill:navy; stroke-width: 2; text-anchor:start">2</text>
            <rect x="95" y="320" height="20" width="0" style="fill: lavender"/>
            <text x="98" y="335" style="fill:navy; stroke-width: 2; text-anchor:start"/>
             </g>
      
      }
      
   </g> <!--ebb: I just corrected this to be a close-tag, so the code is well-formed. -->
</svg>;
$ThisFileContent
(: 2019-04-08 ebb: check minus. You experimented a bit with trying to build on my output, but you'd have to do each data point by hand this way. Please review our posted solution here in db/2019_ClassExamples/banksyTimelineSVGComplete.svg (also in DHClass-Hub), and let me know if you'd like to go over how to make the for loop work and how to make a "treewalker" variable. :)

