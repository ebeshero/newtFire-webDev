xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0"; 
declare namespace htm="http://www.w3.org/1999/xhtml";

declare variable $mitfordColl := collection ('/db/mitford');
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];

declare variable $letterRecipients := $letterFiles/descendant::tei:titleStmt/tei:title/tei:persName/@ref;
declare variable $distLetterRecips := distinct-values($letterRecipients);
declare variable $si := doc('http://digitalmitford.org/si.xml');


declare variable $distinctYears := distinct-values($letterDates);
declare variable $minDY := xs:integer(min($distinctYears));
declare variable $maxDY := xs:integer(max($distinctYears));
declare variable $years := $maxDY - $minDY;
declare variable $days := $years* 365;
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
       {for $i in $distLetterRecips
       let $names := $si//tei:person[@xml:id = tokenize($i, '#')[2]]/tei:persName[1]/string()
       return
          <htm:span class="entry">
              <htm:input type="checkbox"
                         id="{tokenize($i, '#')[2]}"
                         style="cursor:pointer"/>
                  {$names}<htm:br/>
       </htm:span>
       }
    </htm:fieldset>
    </htm:div>
<htm:div class="svg">
<svg width="{700}" height="{200}" 
viewBox="0,0,{3000},{1000}">
   <g transform="translate(30, 100)">
      <line x1="0" y1="60" x2="{$days}" y2="60" style="stroke:blue;stroke-width:20"/>
      
         {
           for $i in (0 to $years)
    return
        <g>
            <line x1="{$i*365}" y1="40" x2="{$i*365}" y2="150" style="stroke:blue;stroke-width:5"/>
         <text x="{$i*365}" y="5">{$minDY+$i}</text>
         <circle cx="{$i*365}" cy="110" r="{(count($letterDates[contains(.,$minDY+$i)])) div 2}" stroke="red" fill="red" stroke-width="4"/>
         <text x="{$i*365}" y="155">{count($letterDates[contains(.,$minDY+$i)])}</text>
         </g>}
         {
             for $i at $pos in $distLetterRecips
let $Letters := $letterFiles[descendant::tei:titleStmt/tei:title/tei:persName/@ref=$i]
let $Dates :=$Letters//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string()
let $minDate :=min($Dates)
let $minDayInYear:=xs:integer(format-date($minDate, '[d]'))
let $maxDate :=max($Dates)
let $maxDayInYear:=xs:integer(format-date($maxDate, '[d]'))
let $Years :=$Letters//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1]
let $minYear:= xs:integer(min($Years))
let $maxYear:= xs:integer(max($Years))
let $startOfName:= ($minYear - $minDY)*365 + $minDayInYear
let $endOfName:= ($maxYear - $minDY)*365 + $maxDayInYear
return
        
     <g id="SVG_{substring-after($i, '#')}">
         <line x1="{$startOfName}" y1="{$pos*100}" x2="{$endOfName}" y2="{$pos*100}" style="stroke:green;stroke-width:10"/>
         <text x="{$startOfName}" y="{($pos*100)+25}">First Letter:{$minDate}</text>
         <text x="{$endOfName}" y="{($pos*100)+25}">Last Letter:{$maxDate}</text>
         <text x="{($startOfName + $endOfName) div 2}" y="{($pos*100)+25}">{tokenize($i, '#')[2]}</text>
         </g>
         }
             
         </g>
   
</svg>
</htm:div>
</htm:body>
</htm:html>;

let $filename := "java3.html"
let $db := xmldb:store("/db/Samantha-McGugian", $filename, $thisFile)
return $db
