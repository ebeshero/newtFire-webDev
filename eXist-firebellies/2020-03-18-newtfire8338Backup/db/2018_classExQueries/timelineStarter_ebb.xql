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
<svg width="100" height="{$totalLetterYears * $stretchFactor + 500}">
   <g transform="translate(30, 100)">
      <!-- <line x1="50" y1="0" x2="50" y2="{($totalLetterYears * $stretchFactor)}" style="stroke: #3333ff; stroke-width:3;"/>  Using style attribute with css styling syntax inside.-->
      <line x1="50" y1="0" x2="50" y2="{$totalLetterYears * $stretchFactor}" stroke="#3333ff" stroke-width="3" /> 
      
         {
         for $i in (0 to $totalLetterYears)
         
         return
             <g>
             
        
        </g>
         }
      
   </g>
   
</svg>