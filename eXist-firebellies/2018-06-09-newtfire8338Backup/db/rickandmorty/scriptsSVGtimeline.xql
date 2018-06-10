xquery version "3.1";
declare namespace svg= "http://www.w3.org/2000/svg";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $coll := collection('/db/rickandmorty/finalScripts/')/*;
declare variable $titles := $coll//tei:body;
declare variable $refTitle := $titles/tei:trailer/tei:name/text();
declare variable $dates := $titles/tei:trailer/tei:date/string();
declare variable $episodeName := $coll//tei:teiHeader//tei:titleStmt/tei:title;

declare variable $minYear := xs:integer(min($dates));
declare variable $maxYear := xs:integer(max($dates));
declare variable $yearNum := xs:integer($maxYear) - xs:integer($minYear);
declare variable $lineLength := $yearNum * 200;
declare variable $svgSpan := ($maxYear - $minYear) * 365;
declare variable $svgMinYearPlot := ($minYear - $minYear) * 365;
declare variable $svgMaxYearPlot := ($maxYear - $minYear) * 365;

declare variable $ThisFileContent := 
<svg:svg width="300" height="{$lineLength + 150}" viewBox="0 0 400 {($lineLength + 150)}">
   <svg:g transform="translate(30, 100)">
      <svg:line x1="100" y1="0" x2="100" y2="{$lineLength}" stroke="#5ec049" stroke-width="5"/>  
      
         {
         for $i in (0 to $yearNum)
         let $currentDate := $minYear + $i
         let $currentTitle := $episodeName[ancestor::tei:TEI//tei:trailer//tei:date = $currentDate]/string()
                return
                 <svg:g>
                <svg:line x1="50" y1="{$i*200}" x2="155" y2="{$i*200}" stroke="#5ec049" stroke-width="3"/>
                <svg:text class="styled" x="45" y="{($i*200) - 30}" fill="#00b0c7">{count($dates[contains(., $minYear + $i)])}</svg:text>
                <svg:text class="styled" x="45" y="{($i*200) - 30}" fill="#00b0c7">{string-join($currentTitle, "; ")}</svg:text>
                <svg:text class="styled" x="165" y="{($i*200) + 5}" fill="#00b0c7">{$minYear + $i}</svg:text>
                
                <svg:circle cx="50" cy="{$i*200}" r="{count($dates[contains(., $minYear + $i)]) * 5}" stroke="#5ec049" stroke-width="3" fill="#5ec049"/>
                
            </svg:g>
         }
         
         
   </svg:g>
</svg:svg>;
let $filename := "scriptsSVGtimeline.svg"
let $doc-db-uri := xmldb:store("/db/rickandmorty", $filename, $ThisFileContent)
return $doc-db-uri

(: Output at http://newtfire.org:8338/exist/rest/db/rickandmorty/scriptsSVGtimeline.svg :)
