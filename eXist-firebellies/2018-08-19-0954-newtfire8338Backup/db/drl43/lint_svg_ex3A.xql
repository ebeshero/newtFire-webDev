xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $mitfordColl := collection ('/db/mitford');
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $countLetterFiles := count($letterFiles);
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when;
declare variable $letterYears := $letterDates/tokenize(string(), '-')[1];

declare variable $distDates := distinct-values($letterYears);
declare variable $minLetterYear := xs:integer(min($letterYears));
declare variable $maxLetterYear := xs:integer(max($letterYears));
declare variable $totalLetterYears := $maxLetterYear - $minLetterYear;

declare variable $yearNum := xs:integer($maxLetterYear) - xs:integer($minLetterYear);
declare variable $lineLength := $yearNum * 365;
declare variable $HaydonLetters := $lettersColl[descendant::tei:titleStmt/tei:title/tei:persName/@ref="#Haydon"];
declare variable $HaydonDates :=$HaydonLetters//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string(); 
declare variable $minHaydon := min($HaydonDates);
declare variable $maxHaydon := max($HaydonDates);
declare variable $minHaydonYear := xs:integer(tokenize($minHaydon, '-')[1]);
declare variable $maxHaydonYear := xs:integer(tokenize($maxHaydon, '-')[1]);
declare variable $svgHaydenSpan := ($maxHaydonYear - $minHaydonYear)*365;
declare variable $svgHaydonMinYearPlot := ($minHaydonYear - $minLetterYear)*365;
declare variable $svgHaydonHARDMaxYearPlot := ($maxLetterYear - $maxHaydonYear);
declare variable $svgHaydonMaxYearPlot := ($maxHaydonYear - $minLetterYear) * 365;
declare variable $minHaydonDayAdd := xs:integer(format-date($minHaydon, '[d]'));
declare variable $maxHaydonDayAdd := xs:integer(format-date($maxHaydon, '[d]'));
declare variable $svgMinHaydonDate := $svgHaydonMinYearPlot + $minHaydonDayAdd;
declare variable $svgMaxHaydonDate := $svgHaydonMaxYearPlot + $maxHaydonDayAdd;

declare variable $stretchFactor := 365;

(:  :declare variable $ThisFileContent := :)
<svg width="500" height="{$totalLetterYears * $stretchFactor + 500}"> <!--add additional space for title -->
   <g transform="translate(30, 100)"> <!-- moving 0,0 to 30,-100 :)-->
      <!-- <line x1="50" y1="0" x2="50" y2="{($totalLetterYears * $stretchFactor)}" style="stroke: #3333ff; stroke-width:3;"/>  Using style attribute with css styling syntax inside.-->
      <line x1="50" y1="0" x2="50" y2="{$totalLetterYears * $stretchFactor}" stroke="#3333ff" stroke-width="3" /> 
      
         {
         for $i in (0 to $totalLetterYears)
         let $currentYear := $minLetterYear + $i
         let $matchingDates := $letterYears[contains(., $currentYear)]
         return
             <g>
             <line x1="40" y1="{$i * $stretchFactor}" x2 ="60" y2="{$i * $stretchFactor}" stroke="purple" stroke-width="2"/>
        <text x="60" y="{$i * $stretchFactor}" color="green">{$currentYear}</text>
        <circle cx="20" cy="{$i * $stretchFactor}" r="{count($matchingDates)}" stroke="black" fill="red" stroke-width="4" />
        <text x="100" y="{$i * $stretchFactor}" color="yellow">{count($matchingDates)}</text>
        </g>
         } 
    </g>
   
</svg> (:;

let $filename := "timeline3.svg"
let $doc-db-uri := xmldb:store("/db/drl43/", $filename, $ThisFileContent)
return $doc-db-uri :)