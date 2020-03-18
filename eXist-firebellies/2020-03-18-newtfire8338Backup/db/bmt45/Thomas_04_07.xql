xquery version "3.1";
declare variable $u := doc('/db/ulysses/wanderings/Lotus_Eaters.xml');
declare variable $said := $u//said/@who ! string();
declare variable $distSaid := $said => distinct-values();
declare variable $saidCount := $distSaid => count();
declare variable $saidInt := $saidCount ! xs:integer(.);
declare variable $LineSpacerX := 50;
declare variable $LineSpacerY := 3;
declare variable $bar := 15;
declare variable $graphContent :=
 <svg width="6000" height="1000">
   <g transform="translate (30,450)">
   <line x1='100' y1='0' x2='{$saidInt * $LineSpacerX + 100}' y2='0' stroke='blue'/>
   <line x1='100' y1='0' x2='100' y2='-{$saidInt * $LineSpacerX - 50 }' stroke='blue'/>
   <text x='150' y='35'> _ </text>
   <text x='200' y='35'> M'Coy </text>
   <text x='250' y='35'> LB</text>
   <text x='300' y='35'> John Comme</text>
   <text x='350' y='35'> _ </text>
   <text x='400' y='35'> chemist </text>
   <text x='450' y='35'> Bantam Lyons </text>
   <text x='50'  y='-15'> 1 </text>
      <text x='50'  y='-15'> 1 </text>
         <text x='50'  y='-30'> 2 </text>
            <text x='50'  y='-45'> 3 </text>
               <text x='50'  y='-60'> 4 </text>
             <text x='50'  y='-75'> 5 </text>
                <text x='50'  y='-90'> 6 </text>
                  <text x='50'  y='-105'> 7 </text>
                    <text x='50'  y='-120'> 8 </text>
                      <text x='50'  y='-135'> 9 </text>
                        <text x='50'  y='-150'> 10 </text>
                           <text x='50'  y='-165'> 11</text>
                             <text x='50'  y='-180'> 12 </text>
                           <text x='50'  y='-195'> 13 </text>
                              <text x='50'  y='-210'> 14 </text>
               <text x='50'  y='-225'> 15 </text>
                  <text x='50'  y='-240'> 16 </text>
                     <text x='50'  y='-255'> 17 </text>
                        <text x='50'  y='-270'> 18 </text>
                         <text x='50'  y='-285'> 19 </text>
                         <text x='50'  y='-300'> 20 </text>   
<text x='250' y='-330'> Ulysses Said Chart </text>
   {
       for $s at $pos in $distSaid 
       let $speechCount := $u//said[@who = $s]=> count()
       let $speech := $u//said/@who = $s
       let $speakerPos := $pos
       return
           <g>
               <rect id='said' x='{$pos * $LineSpacerX + 100}' y='-{$speechCount * $bar}' height='{$speechCount * $bar }' width='30'/>


               </g>
   }
   </g>
   </svg>;
   let $filename := "Thomas_04_07.svg"
let $doc-db-uri := xmldb:store("/db/bmt45", $filename, $graphContent, "text/plain")
return $doc-db-uri (: I'm sending this in as a resubmit. :)

