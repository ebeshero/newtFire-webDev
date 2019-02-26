xquery version "3.1";
declare namespace svg= "http://www.w3.org/2000/svg";

declare variable $coll := collection('/db/rickandmorty/shortsFiles/')/*;
declare variable $titles := $coll/shortTitle;
declare variable $refTitle := $coll/cultureRef/text();
declare variable $dates := $coll//cultureRef/@year/string();
declare variable $episodeName := $coll//cultureRef;

declare variable $minYear := xs:integer(min($dates));
declare variable $maxYear := xs:integer(max($dates));
declare variable $yearNum := xs:integer($maxYear) - xs:integer($minYear);
declare variable $lineLength := $yearNum * 200;
declare variable $svgSpan := ($maxYear - $minYear) * 365;
declare variable $svgMinYearPlot := ($minYear - $minYear) * 365;
declare variable $svgMaxYearPlot := ($maxYear - $minYear) * 365;

declare variable $ThisFileContent := 
<svg width="400" height="{$lineLength + 150}" viewBox="0 0 400 {($lineLength + 150)}">
   <g transform="translate(200, 100)">
      <line x1="100" y1="0" x2="100" y2="{$lineLength}" stroke="#5ec049" stroke-width="5"/>  
      
         {
         for $i in (0 to $yearNum)
         let $currentDate := $minYear + $i
         let $currentTitle := $episodeName[@year = $currentDate]/string()
                return
                 <g>
                <line x1="50" y1="{$i*200}" x2="155" y2="{$i*200}" stroke="#5ec049" stroke-width="3"/>
                <text class="styled" x="45" y="{($i*200) - 30}" fill="#00b0c7">{count($dates[contains(., $minYear + $i)])}</text>
            {for $c at $pos in $currentTitle
            return
                <text class="styled" x="-160" y="{($i*200) - 30 + $pos * 20}" fill="#00b0c7">{$c}</text>
                
            }
                <text class="styled" x="165" y="{($i*200) + 5}" fill="#00b0c7">{$minYear + $i}</text>
                
                <circle cx="50" cy="{$i*200}" r="{count($dates[contains(., $minYear + $i)]) * 5}" stroke="#5ec049" stroke-width="3" fill="#5ec049"/>
                
            </g>
         }
         
   </g>
</svg>;
let $filename := "SVGtimeline.svg"
let $doc-db-uri := xmldb:store("/db/rickandmorty", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/rickandmorty/SVGtimeline.svg :)
