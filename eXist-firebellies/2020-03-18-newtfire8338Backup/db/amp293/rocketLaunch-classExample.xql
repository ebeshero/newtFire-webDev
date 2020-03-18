xquery version "3.1";
let $rocketColl := collection('/db/rocket/')
let $launchDateTimes := $rocketColl//launch/@sDateTime
let $launchYears := $launchDateTimes ! tokenize(., '-')[1]
let $distinctYears := $launchYears => distinct-values()
for $y in $distinctYears
let $launchBases := $rocketColl//launch[@sDateTime ! substring-before(., '-')[1] = $y]/preceding-sibling::launchPad/@sBase/string()
let $distinctBases := $launchBases => distinct-values() => string-join(';')
let $launchPads := $rocketColl//launch[@sDateTime ! substring-before(., '-')[1] = $y]/preceding-sibling::launchPad/@padNum/string()
let $distinctPads := $launchPads => distinct-values() => string-join('; ')
return concat($y, ': Launch Base: ', $distinctBases, ': Launch Pads: ', $distinctPads)