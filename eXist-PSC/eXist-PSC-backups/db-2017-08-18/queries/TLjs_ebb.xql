xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0"; 
declare namespace htm="http://www.w3.org/1999/xhtml";

declare variable $col := collection ('/db/mitford');
declare variable $si := doc('http://digitalmitford.org/si.xml');
declare variable $letCol := collection ('/db/mitford/letters');
declare variable $letFiles := $letCol/*;
declare variable $letDates := $letCol//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];
declare variable $countLet := count($letFiles);
declare variable $distDates := distinct-values($letDates);

declare variable $max := max($distDates);
declare variable $min := xs:integer(min($distDates));
declare variable $year := xs:integer($max) - xs:integer($min);
declare variable $totDay := $year * 365;
declare variable $letterRecipients := $letFiles/descendant::tei:titleStmt/tei:title/tei:persName/@ref;
declare variable $distLetterRecips := distinct-values($letterRecipients);

declare variable $thisFile :=
    <htm:html>
    <htm:head>
    <htm:title>Timeline of Digital Mitford Letters</htm:title>
    </htm:head>
    <htm:body>
    <htm:h1>Timeline of Letters to Mitford’s Correspondents in the Digital Mitford Collection</htm:h1>
    <htm:div class="fieldset">
   <htm:fieldset>
       <htm:legend>Click to Reveal:</htm:legend>
       {for $w in $distLetterRecips
       let $fullName := $si//tei:person[@xml:id = substring-after($w, '#')]/tei:persName[1]/string()
       return
          <htm:span class="entry">
              <htm:input type="checkbox"
                         id="{substring-after($w, '#')}"
                         style="cursor:pointer"/>
                  {$fullName}<htm:br/>
       </htm:span>
       }
                  <!--<legend>Click to Highlight:</legend>
                  <input type="checkbox"
                         id="CHARtoggle"
                         onclick="toggle('character')"
                         style="cursor:pointer"/>
                  <span class="Testchars">Persons, Groups, and Mythic Entities</span>
                  <br/>-->
    </htm:fieldset>
    </htm:div>
    <htm:div class="svg">
    <svg width="3000" height="1000" viewBox="0 0 7000 2000">
    <g transform="translate(30, 100)">
        <rect x="0" y="0" width="{$totDay + 365}" height="50" style="fill:white;stroke:black;stroke-width:5;opacity:0.5"/>
          {for $i in (0 to $year)
                return
            <g>
                <line x1="{$i*365}" y1="0" x2="{$i*365}" y2="50" style="stroke:blue;stroke-width:4"/>
                <text x="{($i*365)}" y="-15" style="text-anchor: middle">{$min + $i}</text>
                <!--The +5 moves the date titles down to be level with the lines.-->
                <circle cx="{$i*365}" cy="25" r="{count($letDates[contains(., $min + $i)]) div 2}" stroke="orange" fill="cyan" stroke-width="2"/>
            </g>
          }
    {
for $r at $pos in $distLetterRecips
let $letter := $letFiles[descendant::tei:titleStmt/tei:title/tei:persName/@ref/string() = $r]
let $letterDate := $letter//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string()
let $rLetterCt := count($letter) 
let $minDate := min($letterDate)
let $minYearString := substring-before($minDate,'-')
let $maxDate := max($letterDate)
let $maxYearString := substring-before($maxDate,'-')
let $intMinDate := xs:integer(format-date($minDate, '[d1]'))
let $intMaxDate :=  xs:integer(format-date($maxDate, '[d1]'))
let $adjustedMinYear := (xs:integer($minYearString) - $min) * 365 
let $adjustedMaxYear := (xs:integer($maxYearString) - $min) * 365
let $minPlot := $adjustedMinYear + $intMinDate 
let $maxPlot := $adjustedMaxYear + $intMaxDate
let $output := if ($rLetterCt = 1) then 
    <g id="SVG_{substring-after($r, '#')}"><text x="{$minPlot + 5}" y="{$pos * 100}">{substring-after($r, '#')}: Date: {$minDate}.</text>
    <line x1="{$maxPlot}" x2="{$maxPlot}" y1="{($pos * 100) - 40}" y2="{($pos *100 + 10)}" style="stroke:darkblue; stroke-width:3"/>
    </g>
       else
           <g id="SVG_{substring-after($r, '#')}"><text x="{$minPlot + 5}" y="{$pos * 100}">{substring-after($r, '#')}: Count: {$rLetterCt}, Earliest: {$minDate}. 
    Latest: {$maxDate}.</text>
      <line x1="{$minPlot}" y1="{($pos *100) - 20}" x2="{$maxPlot}" y2="{($pos *100) - 20}" style="stroke:darkgreen; stroke-width:4"/>
      <!--ebb: hashes for start and end points -->
      <line x1="{$minPlot}" x2="{$minPlot}" y1="{($pos *100) - 40}" y2="{($pos *100 + 10)}" style="stroke:darkblue; stroke-width:3"/>
    <line x1="{$maxPlot}" x2="{$maxPlot}" y1="{($pos *100) - 40}" y2="{($pos *100 + 10)}" style="stroke:darkblue; stroke-width:3"/>
        
    </g>
    
return $output
}
    </g>
    </svg>
    </htm:div>
    </htm:body>
    </htm:html>;

let $filename := "TimelineForJS.html"
let $db := xmldb:store("/db/classExampleQueries", $filename, $thisFile)
return $db
(: Output: http://dxcvm05.psc.edu:8080/exist/rest/db/classExampleQueries/TimelineForJS.html :)

