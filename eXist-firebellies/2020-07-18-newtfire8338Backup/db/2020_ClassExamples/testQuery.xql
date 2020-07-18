xquery version "3.1";
let $testDoc := doc('/db/2020_ClassExamples/testQuery/sts135.xml')
let $launchAndLand := $testDoc//launch | $testDoc//land
let $dateTimes := $launchAndLand//@*[name() ! contains(., 'DateTime')]
return $dateTimes

