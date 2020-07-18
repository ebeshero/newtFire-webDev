xquery version "3.1";
declare variable $rocketColl as document-node()+ := collection(/db/rocket);
declare variable $ThisFileContent as element() :=
<html>
    <head><title>Rocket Stuff</title></head>
    <body>
        <table>
            <tr><th>Year</th><th>Launch Base</th><th>Launch Pads</th></tr>
            
{
let $launchDateTimes := $rocketColl//launch/@sDateTime/string()
let $launchYears := $launchDateTimes ! tokenize(., '-')[1]
let $distinctYears := $launchYears => distinct-values()
for $y in $distinctYears
let $launchBases := $rocketColl//launch[@sDateTime ! substring-before(., '-')[1] = $y]/preceding-sibling::launchPad/@sBase/string()
let $distBases := $launchBases => distinct-values() => string-join(', ')
let $launchPads := $rocketColl//launch[@sDateTime ! substring-before(., '-')[1] = $y]/preceding-sibling::launchPad/@padNum/string()
let $distPads := $launchPads => distinct-values() => string-join(', ')
return (: concat($y, ': Launch Base: ', $distBases, '; Launch Pads: ', $distPads) :)
<tr>
    <td>{$y}</td>
    <td>{$distBases}</td>
    <td>{$distPads}</td>
</tr>
}
</table>
</body>
</html>
;
let $filename := "dunn_rocketExample.html"
let $doc-db-uri := xmldb:store('/db/shd79', $filename, $ThisFileContent)
return $doc-db-uri