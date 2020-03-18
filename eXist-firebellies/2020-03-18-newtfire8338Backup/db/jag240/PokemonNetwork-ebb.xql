xquery version "3.1";
(: 2019-03-18 ebb: REVISE AND RESUBMIT I've added the tab and line-feed characters to this so you have them, but it's not going to work yet :)
(: ebb: You need to set up some for loops here so loop over each of your names and output its type. 
( : Think about your structure here. Do you want to connect each name, one by one, to its type?  :)
(: Our Cytoscape software wants input in this format: :)
(: SourceNode [tab] EdgeConnection [tab] TargetNode [hardReturn] :)
(: You'll probably want to set up two for-loops, one to run inside the other. :)
 (: One for-loop visits each SourceNode, and probably also outputs the EdgeConnector :)
 (: Then inside that, make another loop to find all the OTHER nodes that share this type. :) 
 (: Try to eliminate the SourceNode from the TargetNode list  :)
declare variable $ThisFileContent :=
string-join(   
    let $pokemon := collection("/db/pokemonMap/pokemon")
    let $names := $pokemon//name/string()
    let $type := $pokemon//typing/string()
    
    return concat($names, '&#x9;', $type), '&#x10;');
$ThisFileContent    
(:   let $filename := "PokemonNetwork.tsv"
    let $doc-db-uri := xmldb:store("/db/jag240", $filename, $ThisFileContent, "text/plain") :)

(: It generates a TSV file, but its completely empty. Im not sure why. :)

