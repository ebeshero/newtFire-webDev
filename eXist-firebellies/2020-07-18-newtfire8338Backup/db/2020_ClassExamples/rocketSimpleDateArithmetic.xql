xquery version "3.1";
declare variable $rocketColl := collection('/db/rocket/');
let $launchDateTimes := $rocketColl//launch/@sDateTime ! xs:dateTime(.) => sort()
let $ldt-one := $launchDateTimes[1]
let $ldt-two := $launchDateTimes[2]
let $ldt-max := $launchDateTimes => max()
let $ldt-min := $launchDateTimes => min()
return string-join(($ldt-max, $ldt-min, ($ldt-max - $ldt-min)), ', ')
