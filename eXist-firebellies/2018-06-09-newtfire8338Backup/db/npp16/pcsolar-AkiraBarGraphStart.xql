xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $AkiraFile := doc('/db/akira/akira-tei.xml');
declare variable $AkiraAll := $AkiraFile/*;
declare variable $allPowers := $AkiraAll//tei:text//tei:body//tei:milestone/@powers;
declare variable $allControlScene := $AkiraAll//tei:text//tei:body//tei:spGrp/@controlScene;






declare variable $ThisFileContent :=
<svg width="1200" height="900" viewbox="0 0 800 600">
    <g transform="translate(200, 100)">
    
        <line x1="200" y1="5" x2="200" y2="5" stroke="Brown" stroke-width="3" />
    {
        for $i in 
    </g>
    return
        <g>
            </g>
    }
</svg>;


let $filename := "psolar-AkiraBarGraph.svg"
let $doc-db-uri := xmldb:store("/db/npp16", $filename, $ThisFileContent)
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/npp16/pcsolarTimeline.svg :) 