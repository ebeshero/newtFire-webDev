xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0"; 
declare namespace htm="http://www.w3.org/1999/xhtml";

declare variable $col := collection ('/db/mitford');
(: Need 'si' for a proper name grab. :)
declare variable $si := doc('http://digitalmitford.org/si.xml');

declare variable $letCol := collection ('/db/mitford/letters');
declare variable $letFiles := $letCol/*;
declare variable $letDates := $letCol//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];
declare variable $countLet := count($letFiles);
declare variable $distDates := distinct-values($letDates);

declare variable $max := max($distDates);
declare variable $min := xs:integer(min($distDates));
declare variable $year := xs:integer($max) - xs:integer($min);
declare variable $day := $year * 365;

(:  :declare variable $HaydonLet := $letFiles[descendant::tei:titleStmt/tei:title/tei:persName/@ref="#Haydon"];
declare variable $HaydonDates :=$HaydonLet//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string(); 
declare variable $distDateHLb := xs:integer(format-date($HaydonDates[9], '[d1]'));
declare variable $distDateHLe := xs:integer(format-date($HaydonDates[11], '[d1]));
declare variable $HaydonMax := max($distDateHLe); 
declare variable $HaydonLast := xs:integer($max) - xs:integer($HaydonMax);
:)

declare variable $letterRecipients := $letFiles/descendant::tei:titleStmt/tei:title/tei:persName/@ref;
declare variable $distLetterRecips := distinct-values($letterRecipients);

declare variable $color_1 := "#77DD77";
declare variable $color_2 := "#FDFD96";
declare variable $color_3 := "#779ECB";
declare variable $color_4 := "#FFB347";
declare variable $color_5 := "#CB99C9";
declare variable $color_6 := "#FF6961";
declare variable $color_7 := "#CFCFC4";
declare variable $colorArray := ("#77DD77","#FDFD96","#779ECB","#FFB347","#CB99C9","#FF6961","#CFCFC4");

declare variable $colorSelect :=
    for $i at $pos in $distLetterRecips
    let $colorValue :=
        for $c at $pos2 in $colorArray
        where $pos = $pos2
        return $c
    return concat($i, "~", $colorValue);

declare variable $thisFile :=
    <htm:html>
    <htm:head>
    <htm:title>Timeline</htm:title>
    </htm:head>
    <htm:body>
    <htm:div class="buttons">
    <htm:h1>Timeline for Letters Sent to Known Correspondents in the Mitford Collection</htm:h1>
    <htm:h4>Click to toggle (ON/OFF) an overlay for a specific correspondent:</htm:h4>
    <htm:h4>{$colorSelect}</htm:h4>
    {
for $b at $pos in $distLetterRecips
let $siGrab := $si//tei:person[@xml:id = substring-after($b, '#')]/tei:persName[1]/string()
let $colorButton := 
    for $c at $pos2 in $colorArray
    where $pos = $pos2
    return $c
return
    <htm:table>
    <htm:tr>
    <htm:td>
    <htm:button id="{substring-after($b, '#')}" style="cursor:pointer; background-color: {$colorButton}; border: none; color: black; padding: 8px 30px; text-align: center; font-size: 16px; border-radius: 12px">{$siGrab}</htm:button>
    </htm:td>
    </htm:tr>
    </htm:table>
       }
    </htm:div>
    <htm:div class="timeline">
    <svg width="3000" height="650" viewBox="0 0 5000 1000">
    <g transform="translate(30, 100)">
        <rect x="0" y="0" width="{$day + 365}" height="50" style="fill:white;stroke:black;stroke-width:5"/>
    {for $i in (0 to $year)
        return
        <g>
            <line x1="{$i*365}" y1="0" x2="{$i*365}" y2="50" style="stroke:black;stroke-width:4"/>
            <text x="{($i*365)}" y="-15" style="text-anchor: middle">{$min + $i}</text>
            <circle cx="{$i*365}" cy="25" r="{count($letDates[contains(., $min + $i)]) div 2}" stroke="black" fill="white" stroke-width="2"/>
        </g>
          }
    {
for $r at $pos in $distLetterRecips
let $letter := $letFiles[descendant::tei:titleStmt/tei:title/tei:persName/@ref/string() = $r]
let $letterDate := $letter//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string()
let $letterTotals := count($letter)
(: Min Variables :)
let $minDate := min($letterDate)
let $minDateString := substring-before($minDate,'-')
let $intMinDate := xs:integer(format-date($minDate, '[d1]'))
let $mathMinDate := (xs:integer($minDateString) - $min) * 365
let $minPosition := $mathMinDate + $intMinDate
(: Max Variables :)
let $maxDate := max($letterDate)
let $maxDateString := substring-before($maxDate,'-')
let $intMaxDate :=  xs:integer(format-date($maxDate, '[d1]'))
let $mathMaxDate := (xs:integer($maxDateString) - $min) * 365
let $maxPosition := $mathMaxDate + $intMaxDate
(: Color assignment via the array above :)
let $reg := substring-after($colorSelect, '~')
let $colorRect :=
         for $v in $colorSelect
         where $reg = substring-before($v, '~')
         return substring-after ($v, '~')
(: if/else statment for checking for totals of one :)
let $graph := if ($letterTotals = 1) then
    
    <g id="overlay_{substring-after($r, '#')}">
        <rect x="{$minPosition}" y="0" width="1.5" height="50" style="fill:{$colorRect};stroke:{$colorRect};stroke-width:5;opacity:0.3"/>
    </g>

    else

    <g id="overlay_{substring-after($r, '#')}">
        <rect x="{$minPosition}" y="0" width="{$maxPosition - $minPosition}" height="50" style="fill:{$colorRect};stroke:{$colorRect};stroke-width:5;opacity:0.3"/>
    </g>

return $graph
}
    </g>
    </svg>
    </htm:div>
    </htm:body>
    </htm:html>;
(:ebb: For minDate and maxDate, retrieve the year value. CHECK
 : Then calculate its position in relation to your $min and $max global variables.
 : In order to position it in relation to $min, find the difference between the two values. 
 : Define a variable that calculates the difference between the 
 : lowest year in the collection 
 : and the lowest $r letter (simple subtraction).
 : Then declare a variable for $lowestRYear  that adds the difference to the lowest year ($min)
 :  To get the SVG position of the lowest $r, you'll need to add $lowestRYear to $intMinDate
 :  :)


(:  :<svg width="500" height="3000" viewBox="0 0 550 3500">
    <g transform="translate(30, 100)">
        <line x1="50" y1="0" x2="50" y2="{$day}" style="stroke:blue;stroke-width:4"/>
        <line x1="90" y1="{$distDateHLb+365}" x2="90" y2="{($distDateHLe)+($HaydonLast)+($distDateHLe)}" style="stroke:green;stroke-width:4"/>
            <text x="100" y="{($distDateHLb+350)}" style="font-size: 30px;">Haydon Letters</text>
            <text x="100" y="{($distDateHLb+365)+10}">First Letter (2/13/1819)</text>
            <!--The +10 moves the date titles down to be level with the lines.-->
            <text x="100" y="{($distDateHLe*2)+$HaydonLast}">Last Letter (10/1/1823)</text>
        {
        for $i in (0 to $year)
                return
            <g>
                <line x1="25" y1="{$i*365}" x2="50" y2="{$i*365}" style="stroke:blue;stroke-width:4"/>
                <text x="-10" y="{($i*365)+5}">{$min + $i}</text>
                <!--The +5 moves the date titles down to be level with the lines.-->
                <circle cx="50" cy="{$i*365}" r="{count($letDates[contains(., $min + $i)]) div 2}" stroke="orange" fill="cyan" stroke-width="2"/>
            </g>
        }
    </g>
</svg>;:)

let $filename := "TimelineForJS.html"
let $db := xmldb:store("/db/jonhoranic", $filename, $thisFile)
return $db
(: Output: http://dxcvm05.psc.edu:8080/exist/rest/db/jonhoranic/TimelineForJS.html :)