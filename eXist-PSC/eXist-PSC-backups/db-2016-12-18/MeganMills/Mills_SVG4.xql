xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $coll :=doc('/db/decameron/engDecameronTEI.xml')/*;
declare variable $div := $coll/tei:text/tei:body/tei:div[@type="Day"];
declare variable $countDays := count($div);


declare variable $placeName := $div//tei:placeName;



declare variable $ThisFileContent := 

   

<svg width="3000" height="3000">
   <g transform="translate(50, 150)">
      <line y1="300" x1="200" y2="300" x2="1000" style="stroke:black;stroke-width:3" /> 
      <line y1="100" x1="200" y2="300" x2="200" style="stroke:black;stroke-width:3" />
    <text font-size="20" font-weight="bold" x="500" y="10"> Number of Places in each Day </text>
  
         {
           for $i in (1 to $countDays)
           let $Interval := $i * 70
           
           let $dist:=  count(distinct-values($div[$i]//tei:placeName))
           
             return 
                <g>
                    <text  font-weight="bold" y="{240-$dist}" x="{$Interval+215}" >{$dist}</text>
                   <text font-weight="bold" y="325" x="{$Interval + 205}">Day {$i} </text>
                      
                    <rect y="-300" x="{$Interval+210}" height="{$dist+50}" width="30" transform="scale(1,-1)"style="fill:maroon; stroke:black; "/>
                    </g>
         }
       </g>
         
</svg>;
let $filename := "Mills_SVG4.svg"
let $doc-db-uri := xmldb:store("/db/MeganMills", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://dxcvm05.psc.edu:8080/exist/rest/db/MeganMills/Mills_SVG4.svg :)     
    
