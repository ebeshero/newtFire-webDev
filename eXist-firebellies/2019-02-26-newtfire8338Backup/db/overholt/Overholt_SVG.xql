xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $overholt := collection('/db/overholt');
declare variable $diaryFiles := $overholt/*;
declare variable $diaryDates := $overholt//tei:teiHeader//tei:profileDesc//tei:listPerson/tei:person/tei:birth/@when/string();
declare variable $diaryYears := $overholt//tei:teiHeader//tei:profileDesc//tei:listPerson/tei:person/tei:birth/@when/tokenize(string(), '-')[1];
declare variable $diaryNames := $overholt//tei:teiHeader//tei:profileDesc//tei:listPerson/tei:person/tei:persName;
declare variable $minDate := min($diaryDates);
declare variable $maxDate := max($diaryDates);
declare variable $minYear := min($diaryYears);
declare variable $maxYear := max($diaryYears);
declare variable $yearNum := xs:integer($maxYear) - xs:integer($minYear);
declare variable $lineLength := $yearNum * 365;


declare variable $ThisFileContent := 
<svg xmlns:xlink="http://www.w3.org/1999/xlink" width="800" height="{$lineLength + 1000}"  viewBox="(x50,y33945,x115,y33945)">
   <g transform="translate(30, 100)">
      <line x1="100" y1="0" x2="100" y2="{$lineLength}" stroke="maroon" stroke-width="5"/>  
      <!-- <text x="120" y="20">{string-join($diaryNames,' , ')}</text>-->
      
         {
         for $i in (0 to $yearNum)
         let $currentyear := xs:integer($minYear) + $i
         let $treematch := $diaryNames[contains(following-sibling::tei:birth/@when/string(), $currentyear)]
         let $countmatch := count($treematch)
                return
                 <g>
                <line x1="50" y1="{$i*365}" x2="115" y2="{$i*365}" stroke="black" stroke-width="3"/>
                <text x="120" y="{($i*365)}">{$currentyear}</text>
                <a xlink:href= "Personography.html#{$treematch/parent::tei:person/@xml:id}" xlink:title="View the Personography Entry">
                <text x="200" y="{($i*365)}">{string-join($treematch,' , ')}</text></a>
                               
        
                
            </g>
         }
         
   </g>
</svg>;

let $filename := "overholtSVG.svg"
let $doc-db-uri := xmldb:store("/db/overholt", $filename, $ThisFileContent)
return $ThisFileContent
(:  :Output at http://newtfire.org:8338/exist/rest/db/overholt/overholtSVG.svg :)

