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
declare variable $X_Spacer := 50;
declare variable $Y_Spacer := 10;
declare variable $ThisFileContent := 
<svg width="{($difference * $X_Spacer) + 100 }" height="500">
   <g transform="translate(30, 200)">
   <!--X axis line below: -->
          <line x1="-5" y1="0" x2="{$difference * $X_Spacer + 20}" y2="0" style="stroke:blue;stroke-width:2;"/> 
   <!--Y axis line below: -->
        <line x1="-5" y1="0" x2="-5" y2="{-20 * $Y_Spacer}" style="stroke:blue;stroke-width:2;"/> 
    
        
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
         
            <text x="{$i * $X_Spacer}" y="20" style="fill:navy; stroke-width: 2; text-anchor:start">{$year}</text>
             
        <rect x="{$i * $X_Spacer}" y="-{$countSprayPaint * $Y_Spacer}" height="{$countSprayPaint * 10 - 1}" width="20" style="fill: aqua"/>
 <!--This next rectangle is stacked on top of the first one. Rectangles are drawn from the top down, so the y attribute marks the top. we add the total count of SprayPainted art to the total count of Canvas art. -->      
        <rect x="{$i * $X_Spacer}" y="-{($countSprayPaint * $Y_Spacer) + ($countCanvas * $Y_Spacer)}" height="{$countCanvas * 10}" width="20" style="fill: violet"/>
         <text x="{$i * $X_Spacer + 3}" y="-{($countSprayPaint * $Y_Spacer) - 15}" style="fill:navy; stroke-width: 2; text-anchor:start">{$CSPlabel}</text>  
         <text x="{$i * $X_Spacer + 3}" y="-{($countSprayPaint * $Y_Spacer) + ($countCanvas * $Y_Spacer)}" style="fill:navy; stroke-width: 2; text-anchor:start">{$CClabel}</text> 
            
         </g>
         }       
  <!--Labelled hash lines drawn at 5, 10, and 15; drawn last to cut across the bars -->  
     <line x1="-5" y1="{-5 * $Y_Spacer}" x2="{$difference * $X_Spacer + 20}" y2="{-5 * $Y_Spacer}" style="stroke:green;stroke-width:1; stroke-dasharray:7,5"/> 
      <text x="-25" y="{-5 * $Y_Spacer + 2}" style="fill:green; stroke-width: 1; text-anchor:start">5</text>
        <line x1="-5" y1="{-10 * $Y_Spacer}" x2="{$difference * $X_Spacer + 20}" y2="{-10 * $Y_Spacer}" style="stroke:green;stroke-width:1; stroke-dasharray:7,5"/> 
      <text x="-25" y="{-10 * $Y_Spacer + 2}" style="fill:green; stroke-width: 1; text-anchor:start">10</text>
      
        <line x1="-5" y1="{-15 * $Y_Spacer}" x2="{$difference * $X_Spacer + 20}" y2="{-15 * $Y_Spacer}" style="stroke:green;stroke-width:1; stroke-dasharray:7,5"/> 
      <text x="-25" y="{-15 * $Y_Spacer + 2}" style="fill:green; stroke-width: 1; text-anchor:start">15</text>
<!-- Legend -->
<!--Spray Paint -->
 <rect x="{$difference * $X_Spacer - 50}" y="{-17 * $Y_Spacer}" height="15" width="20" style="fill: aqua"/>
<text x="{$difference * $X_Spacer - 50 + 30}" y="{-17 * $Y_Spacer + 10}" style="fill:black; stroke-width: 2; text-anchor:start">Spray Paint</text>
<!--Canvas -->
 <rect x="{$difference * $X_Spacer - 50}" y="{-19 * $Y_Spacer}" height="15" width="20" style="fill: violet"/>
<text x="{$difference * $X_Spacer - 50 + 30}" y="{-19 * $Y_Spacer + 10}" style="fill:black; stroke-width: 2; text-anchor:start">Canvas</text>
<!--Title of the graph: -->
<text x="100" y="{-18 * $Y_Spacer}" style="fill:black; stroke-width: 2; text-anchor:start; font-size:23">Banksy artworks each year, proportion of spray-painted to canvas media</text>
   </g> 
</svg>;
$ThisFileContent
(:  :let $filename := "banksyTimeline.svg"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent)
return $doc-db-uri:) 
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/banksyTimeline.svg :)    
