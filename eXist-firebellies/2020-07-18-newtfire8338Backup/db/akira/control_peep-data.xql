xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $akira := doc('db/akira/akira-tei.xml')/*
let $controlScenes := $akira//spGrp
for $i in $controlScenes
let $peeps := $i/sp/@who/string()
let $dPeeps := distinct-values($peeps)
for $p in $dPeeps 
let $match := $controlScenes[sp[@who=$p]]
let $otherPeeps := $match/sp[not(@who=$p)]/@who/string()
let $distoPeeps := distinct-values($otherPeeps)
let $countoP := count($distoPeeps)
for $d in $distoPeeps 
return $d

