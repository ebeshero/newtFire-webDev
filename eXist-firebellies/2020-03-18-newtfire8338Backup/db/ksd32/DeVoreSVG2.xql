xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(.,'-')[1];
declare variable $minYear := $years ! xs:integer(.)=>min();
declare variable $maxYear := $years ! xs:integer(.)=>max();
declare variable $lineLength := $maxYear - $minYear;
declare variable $timelineSpacer := 100;
declare variable $title :=$banksyColl//date/preceding-sibling::node();
declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30,30)">
      <line x1="0" y1="0" x2="0" y2="{$lineLength * $timelineSpacer}" style="stroke:blue;stroke-width:2;"/>  
      
         {for $i in (0 to $lineLength) 
        let $art := //date = $i
        let $countArt := count($art)
        return
            <g>
            <circle cx="0" cy="{$i * $timelineSpacer}" r="2" stroke="green" stroke-width="3" fill="red"/>
            
            <text x="0" y="{$i * $timelineSpacer}" fill="red">"{$title = $dates}"</text>
            <rect width="300" height="100" style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)" />
            </g>
         }
      
   </g>
</svg>;
let $filename := "DeVore_timeline.svg"
let $doc-db-uri := xmldb:store("/db/ksd32", $filename, $ThisFileContent)
return $doc-db-uri

