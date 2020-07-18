xquery version "3.1";
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
<svg xmlns="http://www.w3.org/2000/svg" width="2000" height="3000">
   <g transform="translate(70, 30)">
        <line x1="0" y1="0" x2="0" y2="{($maxYear - $minYear) * $timelineSpacer}" style="stroke:blue;stroke-width:2;"/>  
        {
         for $i in (0 to $difference)
         let $year := $minYear + $i

         return
          <g>
            <circle cx="0" cy="{$i * $timelineSpacer}" r="4" stroke="purple" stroke-width="3" fill="violet" />
            <text x="-50" y="{$i * $timelineSpacer + 5}">{$year}</text>
            <text x="15" y="{$i * $timelineSpacer + 5}">{$titles[following-sibling::Q{}date/@when] => string-join("; ")}</text>
          <!-- ebb: Notice the use of Q{} here. We need it to be able read from the non-namespace of our source XML files, now that we're 
          preparing code in the SVG namespace.
          Note also: this code is incorrect at this point. We need to prepare it so it identifies just the titles whose date info matches our current year in our for loop.  How do we need to filter the @when attribute values? 
          --> 
          </g>
        }
   </g>
</svg>;
$ThisFileContent
(:  :let $filename := "banksyTimeline.svg"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent)
return $doc-db-uri :)
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/banksyTimeline.svg :)    
