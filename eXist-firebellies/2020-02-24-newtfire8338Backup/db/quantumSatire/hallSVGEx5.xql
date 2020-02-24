xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $coll := collection('/db/hamilton/');
declare variable $hamCount := count($coll//tei:sp[@who="#hamilton"]);
declare variable $burrCount := count($coll//tei:sp[@who="#burr"]);
declare variable $elizaCount := count($coll//tei:sp[@who="#eliza"]);
declare variable $jeffCount := count($coll//tei:sp[@who="#jefferson"]);
declare variable $laurCount := count($coll//tei:sp[@who="#laurens"]);
declare variable $washCount := count($coll//tei:sp[@who="#washington"]);
(:ebb: Why did you choose these particular speakers? This seems a bit arbitrary. Try writing a FLWOR that looks at all the speakers in the collection, and loops through the based on the distinct-values of @who. For each distinct value of @who as $i, go back to the tree and get a count of how many speakers matches it. Then, return the counts and order them by their count: set the "o" of your FLWOR to "order by $yourCountVariable descending. You can read out the counts and make a decision to cut off drawing a plot for characters below a certain count. Use a "where" statement to indicate your cutoff point: where $countVariable gt 25 . And that's how you'd write your return. Okay, you can also set colors to be different depending on counts, but most likely you'd just plot the bars all the same color.   :)

 declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="110%">
    <g alignment-baseline="baseline" transform="translate (25, 40)">
    
        <text x="60" y="-10" fill ="black" style="font-size:25px">Speaker Counts in Hamilton</text>
    
        <line x1="25" y1="500" x2="400" y2="500" stroke="black" stroke-width="3"/>
        <line x1="25" y1="500" x2="25" y2="0" stroke="black" stroke-width="3"/>
    
        <line stroke-dasharray="2, 3"  x1="25" y1="200" x2="400" y2="200" stroke="black" stroke-width="2"/>
        <text x="-10" y="200" fill ="black" style="font-size:17px;">150</text>
        <line stroke-dasharray="2, 3"  x1="25" y1="100" x2="400" y2="100" stroke="black" stroke-width="2"/>
        <text x="-10" y="100" fill ="black" style="font-size:17px;">250+</text>
        <line stroke-dasharray="2, 3"  x1="25" y1="400" x2="400" y2="400" stroke="black" stroke-width="2"/>
        <text x="-10" y="400" fill ="black" style="font-size:17px;">100</text>
        <line stroke-dasharray="2, 3"  x1="25" y1="300" x2="400" y2="300" stroke="black" stroke-width="2"/>
        <text x="-10" y="300" fill ="black" style="font-size:17px;">200</text>
            
        <text x="-10" y="500" fill ="black" style="font-size:17px;">0</text>
    
    <rect x="50" y="0" width="30" height="{$hamCount * 1.4}" fill="red" />
        <text x="65" y="510" fill="red" style="font-size:17px; writing-mode: tb; glyph-orientation-vertical: 5">Hamilton 356</text>
        
        <rect x="100" y="50" width="30" height="{$burrCount * 2}" fill="orange"/>
        <text x="115" y="510" fill="orange" style="font-size:17px; writing-mode: tb; glyph-orientation-vertical: 5">Burr 224</text>
        
        <rect x="150" y="294" width="30" height="{$elizaCount * 2}" fill="yellow"/>
        <text x="165" y="510" fill ="yellow" style="font-size:17px; writing-mode: tb; glyph-orientation-vertical: 5">Eliza 102</text>
        
        <rect x="200" y="347" width="30" height="{$jeffCount * 2}" fill="green"/>
        <text x="215" y="510" fill ="green" style="font-size:17px; writing-mode: tb; glyph-orientation-vertical: 5">Jefferson 76</text>
        
        <rect x="250" y="417" width="30" height="{$laurCount * 2}" fill="blue"/>
        <text x="265" y="510" fill ="blue" style="font-size:17px; writing-mode: tb; glyph-orientation-vertical: 5">Laurens 41</text>
        
        <rect x="300" y="260" width="30" height="{$washCount * 2}" fill="purple"/>
        <text x="315" y="510" fill ="purple" style="font-size:17px; writing-mode: tb; glyph-orientation-vertical: 5">Washington 120</text>
        
    </g>
</svg>;

let $filename := "hallSVGEx5.svg"
let $doc-db-uri := xmldb:store("/db/quantumSatire", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/quantumSatire/hallSVGEx5.svg :)
 (: ebb: Preliminary Score: 8/10 because this is a bit too easy. I'd like you to Revise and Resubmit this as a FLWOR looping through all the Hamilton speakers to retrieve counts, order them, and output only the top several (cut-off count is up to you) as described here. :)