xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $mitfordColl := collection ('/db/mitford');
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $countLetterFiles := count($letterFiles);
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when;
declare variable $letterYears := $letterDates/tokenize(string(), '-')[1];
declare variable $minLetterYear := xs:integer(min($letterYears));
declare variable $maxLetterYear := xs:integer(max($letterYears));
declare variable $totalLetterYears := $maxLetterYear - $minLetterYear;
declare variable $stretchFactor := 365;
declare variable $HaydonLetters := $letterFiles[descendant::tei:titleStmt/tei:title/tei:persName/@ref="#Haydon"];
declare variable $HaydonDates := $HaydonLetters//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string();  
declare variable $minHaydon := min($HaydonDates);
declare variable $maxHaydon := max($HaydonDates);
declare variable $minHaydonYear := xs:integer(tokenize($minHaydon, '-')[1]);
declare variable $maxHaydonYear := xs:integer(tokenize($maxHaydon, '-')[1]);
declare variable $svgPlotMinHaydon := ($minHaydonYear - $minLetterYear) * 365;
declare variable $svgPlotMaxHaydon := ($maxHaydonYear - $minLetterYear) * 365;
declare variable $minHaydonDay := xs:integer(format-date($minHaydon, '[d]'));
declare variable $minHaydonDate := ($minHaydonDay + $svgPlotMinHaydon);
declare variable $maxHaydonDay := xs:integer(format-date($maxHaydon, '[d]'));
declare variable $maxHaydonDate := ($maxHaydonDay + $svgPlotMaxHaydon);


<svg width="500" height="{$totalLetterYears * $stretchFactor + 500}">
    <g transform="translate(150, 100)">
        <line x1="50" y1="0" x2="50" y2="{$totalLetterYears * $stretchFactor}" stroke="red" stroke-width="5"/>
        <line x1="-5" y1="{$minHaydonDate}" x2="-5" y2="{$maxHaydonDate}" stroke="green" stroke-width="5"/>
        <!--ebb: Nice work with plotting the Haydon line from its earliest to latest date! -->
        <text x="-120" y="1300">Haydon Letters</text>
        {
            for $i in (0 to $totalLetterYears)
            let $currentYear := $minLetterYear + $i
            let $lettersCurrentYear := $letterFiles[contains(descendant::tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/string(), $currentYear)]
             (:ebb: This is your "tree-walker" variable, and once we figured this out, you were able to get a count of the letters in a given year. If you wanted to, you could write another variable to find out how many letters to Haydon were written in this current year, or really anything you need from the current year's batch of letters. :)
            let $countCurrentLetters := count($lettersCurrentYear)
            return
                <g>
        <line x1="45" y1="{$i * $stretchFactor}" x2="60" y2="{$i * 365}" stroke="black" stroke-width="3"/>
        <text x="10" y="{$i * $stretchFactor}">{$currentYear}</text>
        <circle cx="110" cy="{$i * $stretchFactor}" r="{$countCurrentLetters}" stroke="red" fill="blue" stroke-width="4"/>
        </g>
        }
    </g>
</svg>
(: 2018-04-04 ebb: Excellent work with customizing this timeline assignment. We'll be continuing this exercise as our last JavaScript assignment (and last homework of the term), and you have a great code-base here to start with. (In case you're looking ahead, what we'll do is output more people's timespans of correspondence, and toggle them on or off on click of a selection box.) 
 Score: 10/10
 :  :)

