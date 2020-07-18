xquery version "3.1";
declare variable $ThisFileContent := string-join(

let $s1Coll := collection('/db/teentitans/season1')
let $spkr := $s1Coll//spkr[contains(@ref, 'Robin') or contains(@ref, 'Raven') or contains(@ref, 'Cyborg') or contains(@ref, 'Starfire') or contains(@ref, 'BeastBoy')][not(contains(@ref, 'Puppet')) and not(contains(@ref, 'Aqualad')) and not(contains(@ref, 'Pink')) and not(contains(@ref, 'Green')) and not(contains(@ref, 'Gray')) and not(contains(@ref, 'White')) and not(contains(@ref, ' '))]/@ref ! tokenize(., '#')[last()]
let $CountSpeeches := 
    let $distSpkr := distinct-values($spkr)
    for $d in $distSpkr
    let $countSpeech := $s1Coll//sp[spkr[@ref ! substring-after(., '#') = $d]] => count()
    return $countSpeech
let $distSpkr := $spkr => distinct-values()
for $d in $distSpkr
let $speech := $s1Coll//sp[spkr[@ref = $d]]
let $countSpeech := $speech => count()
let $char := $speech//char/@ref[. = $distSpkr] 
let $distChar := $char => distinct-values()
for $c in $distChar
let $mention := $s1Coll//sp[spkr[@ref = $d]]//char[@ref = $c] 
let $mentionCount := $mention => count()
return string-join(($d, $countSpeech,  $c, $mentionCount), "&#x9;"), "&#10;");

let $filename := "titans_speakerNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/amp293", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
