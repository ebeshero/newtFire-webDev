xquery version "3.1";

<html>
    <head><title>Rocket Launch Data</title>
  <!--Add a <link> element for your CSS here if you want.  -->
    </head>
    <body>
        <table>
            <tr><th>Year</th>
            <th>Launch Base(s)</th>
            <th>Launch Pad(s)</th>   
            </tr>

{
let $rocketColl := collection('/db/rocket/')
let $launchDateTimes := $rocketColl//launch/@sDateTime/string()
let $launchYears := $launchDateTimes ! tokenize(., '-')[1]
let $distinctYears := $launchYears => distinct-values()
for $y in $distinctYears
let $launchBases := $rocketColl//launch[@sDateTime ! substring-before(., '-') = $y]/preceding-sibling::launchPad/@sBase/string()
let $distinctBases := $launchBases => distinct-values() => string-join(', ')
let $launchPads := $rocketColl//launch[@sDateTime ! substring-before(., '-') = $y]/preceding-sibling::launchPad/@padNum/string()
let $distinctPads := $launchPads => distinct-values() => string-join(', ') 
order by $y
return 
   (: concat($y, ': Launch Base: ', $distinctBases, ': Launch Pads: ',  $distinctPads) :)
   
  <tr>
      <td>{$y}</td>
      <td>{$distinctBases}</td>
      <td>{$distinctPads}</td>
          
   </tr>
}


</table>
</body>
</html>
