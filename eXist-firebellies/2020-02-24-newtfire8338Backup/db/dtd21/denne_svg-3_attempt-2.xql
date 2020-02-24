xquery version "3.1";
declare namespace svg="http://www.w3.org/2000/svg";
declare variable $akira := collection('/db/akira-tei/');
declare variable $faction := $akira//fileDesc//person//trait/label/string();
declare variable $countRevolution := $faction[contains(., "Revolution")] => count();
declare variable $countClowns := $faction[contains(., "Clowns")] => count();
declare variable $countCapsules := $faction[contains(., "Capsules")] => count();
declare variable $countGovernment := $faction[contains(., "Government")] => count();
<svg width="900" height="500">
    <desc>Sample Bar Graph</desc>
                <g transform="translate(30, 30)" stroke-width="50">
                    <line x1="200" y1="0" x2="200" y2="{$countRevolution}" stroke="red"/>
                    <line x1="350" y1="0" x2="350" y2="{$countClowns}" stroke="green"/>
                    <line x1="500" y1="0" x2="500" y2="{$countCapsules}" stroke="blue"/>
                    <line x1="500" y1="0" x2="500" y2="{$countGovernment}" stroke="blue"/>
                    <text x="150" y="400" fill="black">Revolution</text>
                    <text x="300" y="400" fill="black">Clowns</text>
                    <text x="450" y="400" fill="black">Capsules</text>
                    <text x="600" y="400" fill="black">Government</text>
                </g>
</svg>