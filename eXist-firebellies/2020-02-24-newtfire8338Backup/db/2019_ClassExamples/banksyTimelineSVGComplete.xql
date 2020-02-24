xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $sourceDesc := $banksyColl//sourceDesc;
declare variable $titles := $sourceDesc//title;
declare variable $medium := $sourceDesc//medium/@type/string();
declare variable $date := $sourceDesc//date/@when/string();
declare variable $minDate := $date => min();
(: minDate is 1999 :)
declare variable $maxDate := $date => max();
(: maxDate is 2018-12-19 :)
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
         let $thisYearTitles := $titles[following-sibling::date/@when ! tokenize(., '-')[1] = string($year)]/text() 
         let $countYearTitles := $thisYearTitles => count()
         let $thisYearMediums := $thisYearTitles/following::medium/@type
         let $distinctMediums := $thisYearMediums => distinct-values() => sort()
         let $SprayPaint := $thisYearMediums[. = "spray_paint"]
         let $countSprayPaint := $SprayPaint => count()
          let $CSPlabel := if ($countSprayPaint = 0) 
                              then ""
                        else $countSprayPaint
         let $Canvas := $thisYearMediums[. = "canvas"]
         let $countCanvas := $Canvas => count()
         let $CClabel := if ($countCanvas = 0) 
                              then ""
                        else $countCanvas
         return
          <g>     
            <circle cx="0" cy="{$i * $timelineSpacer}" r="{$countYearTitles * 2}" stroke="purple" stroke-width="3" fill="violet" />
            <text x="10" y="{$i * $timelineSpacer}" style="fill:navy; stroke-width: 2; text-anchor:start">{$year}</text>
             
            <text x="50" y="{$i * $timelineSpacer}" style="fill:navy; stroke-width: 2; text-anchor:start">{string-join($thisYearTitles, ', ')}</text>
        <rect x="75" y="{$i * $timelineSpacer + 20}" height="20" width="{$countSprayPaint * 10}"
        style="fill: aqua"/>
        <text x="78" y="{$i * $timelineSpacer + 35}" style="fill:navy; stroke-width: 2; text-anchor:start"> {$CSPlabel}</text>  
        <rect x="{75 + $countSprayPaint * 10}" y="{$i * $timelineSpacer + 20}" height="20" width="{$countCanvas * 10}"
        style="fill: lavender"/>
        <text x="{78 + $countSprayPaint * 10}" y="{$i * $timelineSpacer + 35}" style="fill:navy; stroke-width: 2; text-anchor:start"> {$CClabel}</text>  
            
      <!--    {for $m at $pos in $distinctMediums
            let $countm := $thisYearTitles/following::medium[@type/string() = $m] => count()
            let $color :=  if ($m = "spray_paint") 
                              then "aqua"
                     else if ($m = "canvas") 
                               then "pink"
                      else "lavender"
            return
        <g>
            <rect x="75" y="{$i * $timelineSpacer + $pos * 20}" height="20" width="{$countm * 10}"
        style="fill: {$color}"/>
       {$countm}
        <text x="78" y="{$i * $timelineSpacer + $pos * 20 + 15}" style="fill:navy; stroke-width: 2; text-anchor:start"> {$countm}</text>
       </g>
           
            } -->
         </g>
         }       

   </g> 
</svg>;

(:  :let $filename := "banksyTimeline.svg"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent)
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/banksyTimeline.svg :)    
:)