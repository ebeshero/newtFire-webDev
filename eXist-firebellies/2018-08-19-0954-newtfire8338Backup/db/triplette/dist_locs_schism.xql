xquery version "3.1";
string-join(
let $schism := collection('/db/Schism')/*
let $locs := $schism/descendant::location
let $normLocs := $locs/normalize-space()
let $distLocs := distinct-values($normLocs)
return 
    $distLocs, '&#10;')



