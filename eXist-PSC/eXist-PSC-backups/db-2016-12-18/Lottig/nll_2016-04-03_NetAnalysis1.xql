xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $Dickinson := collection('/db/dickinson/f16/')
let $poemFiles := $Dickinson/*
let $apps := $poemFiles//text//body//l//app
let $rdgs := $apps/rdg
let $wits := $rdgs/@wit
let $rep1 := replace(string-join($wits, ' '), 'var0', '')
let $rep2 := replace(string-join($rep1, ' '), 'var1', '')
let $rep3 := replace(string-join($rep2, ' '), 'var2', '')
let $witNames := tokenize($rep3, '\s+')
let $distWits := distinct-values($witNames)
for $d in $distWits
    let $pubs := $wits[. = $d]/ancestor::body//app/rdg/@wit[not(. = $d)]/tokenize(., '\s+')
    let $edge := $wits[contains(., $d)]/parent::rdg[@wit[not(contains(., $d))]]
    let $edgeWeight := count($edge)
    for $pub in $pubs
    return
        concat($d, "&#x9;", $edge, "&#x9;", $edgeWeight, "&#x9;", $pub, "&#10;")
    