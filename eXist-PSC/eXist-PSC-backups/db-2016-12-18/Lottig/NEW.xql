xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $Dickinson := collection('/db/dickinson/f16/')
let $poemFiles := $Dickinson/*
let $apps := $poemFiles//text//body//l//app
let $rdgs := $apps/rdg
let $wits := $rdgs/@wit
let $witArray :=
    for $wit in $wits
    let $rep1 := replace($wit, 'var0', '')
    let $rep2 := replace($rep1, 'var1', '')
    let $rep3 := replace($rep2, 'var2', '')
    return $rep3
for $w in $witArray
    let $pubs := $witArray[. = $w]/ancestor::body//app/rdg/@wit[not(. = $w)]
(:let $firstWitNames := tokenize($rep3, ' ')[1]:)
(:let $witNames := tokenize($rep3, '\s+'):)
(:let $distWits := distinct-values($witNames):)
(:let $witNames := tokenize($rep3, '\s+'):)
(:let $distWits := distinct-values($witNames):)
(:for $d in $witNames:)
(:    let $pubs := distinct-values($wits[contains(., $d)]/ancestor::body//app/rdg/@wit[not(contains(., $d))]):)
(:    let $edge := $rdgs[$pubs]:)
(:    let $edgeWeight := count($edge):)
(:    for $pub in $pubs:)
(:    return:)
(:        concat($d, "&#x9;", $edge, "&#x9;", $edgeWeight, "&#x9;", $pub, "&#10;"):)
(:return $pubs:)