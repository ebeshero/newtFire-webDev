xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $mitfordColl := collection ('/db/mitford');
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];
declare variable $HaydonRefs := $lettersColl//tei:titleStmt/tei:title//tei:persName[@ref="#Haydon"];
declare variable $countHaydonRefs := count($HaydonRefs/@ref/string(.));
declare variable $distinctYears := distinct-values($letterDates);

<svg>
   <g>
      <line x1="??" y1="??" x2="??" y2="??" style="??;??;"/>  
       <!--ebb: FLWOR statements will go here, inside a pair of curly braces-->
         {
        
       
       let $maxDY := max($distinctYears)
       let $minDY := min($distinctYears)
       for $i in $distinctYears
       let $haydon_in_year := $HaydonRefs[ancestor::tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1]=$i]
       let $countHPY := count($haydon_in_year)
       order by $i
       return ($i, $countHPY)
       
         }
      
   </g>
   
</svg>
              

