xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $akira := doc('/db/akira/akira-tei.xml');
declare variable $faction := $akira//profileDesc//person//trait/label;
declare variable $distFaction:= distinct-values($faction);
declare variable $countRevolution := $faction[contains(., "Revolution")] => count();
declare variable $countClowns := $faction[contains(., "Clowns")] => count();
declare variable $countCapsules := $faction[contains(., "Capsules")] => count();
declare variable $countGovernment := $faction[contains(., "Government")] => count();
declare variable $ySpacer := 5;
declare variable $xSpacer := 50;

  <svg width="500" height="800">
    <desc>Sample Bar Graph</desc>
                <g transform="translate(30, 500)" stroke-width="50">
                <!-- title here
                x and y axis here -->
                {
                for $d at $pos in $distFaction
                let $treePeople := $akira/descendant::listPerson/person[following::label = $d]/@xml:id/string()
                let $treeCount := count($treePeople)
                return
                    <line x1="{$pos * $xSpacer}" y1="0" x2="{$pos * $xSpacer}" y2="-{$treeCount * $ySpacer}" stroke="red" stroke-width= "11"/> }
                    <!-- viewbox https://www.sarasoueidan.com/blog/svg-coordinate-systems/ -->
                    <!-- put text here -->
                </g>
</svg> 