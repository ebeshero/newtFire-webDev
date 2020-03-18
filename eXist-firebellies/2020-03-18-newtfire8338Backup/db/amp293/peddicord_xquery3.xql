xquery version "3.1";
declare variable $s1Coll as document-node()+ := collection('/db/teentitans/season1');
declare variable $ThisFileContent as element() := 

<html>
    <head><title>Max Speech Count per Episode</title></head>
    <body>
        <h1>Max Speech Count per Episode</h1>
        <table>
            <tr>
                <th>Episode Title</th>
                <th>Character Name</th>
                <th>Speech Count</th>
            </tr>
            
            
{
let $episode := $s1Coll//episode/string()
for $e in $episode
let $spkr := $s1Coll//spkr[ancestor::root/head/episode[string()= $e]][contains(@ref, 'Robin') or contains(@ref, 'Raven') or contains(@ref, 'Cyborg') or contains(@ref, 'Starfire') or contains(@ref, 'BeastBoy')]/@ref ! tokenize(., '#')[last()]
let $CountSpeeches := 
    let $distSpkr := distinct-values($spkr)
    for $d in $distSpkr
    let $countSpeech := $s1Coll//sp[ancestor::root/head/episode[string()= $e]][spkr[@ref ! substring-after(., '#') = $d]] =>       count()
    return $countSpeech
let $maxCountSpeeches := $CountSpeeches => max()
let $distSpkr := $spkr => distinct-values()
for $d in $distSpkr
let $speech := $s1Coll//sp[ancestor::root/head/episode[string()= $e]][spkr[@ref ! substring-after(., '#') = $d]]
let $countSpeech := $speech => count()
where $countSpeech = $maxCountSpeeches
order by $maxCountSpeeches
return 
    <tr>
        <td>{$e}</td>
        <td>{$d}</td>
        <td>{$countSpeech}</td>
    </tr>
(:  :return concat($e, ': ', string-join(concat($d, ': Speech Count: ', $countSpeech))):)
}

</table>
</body>
</html>
;
let $filename := "peddicord_xquery3.html"
let $doc-db-uri := xmldb:store('/db/amp293', $filename, $ThisFileContent)
return $doc-db-uri

