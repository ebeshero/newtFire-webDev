xquery version "3.1";

 let $rocket := collection('/db/rocket/')
 let $mission := $rocket//mission
 let $missionTitle := $mission/text()
 let $xml := $rocket//xml
 let $padNum := $xml//launchPad/@padNum/string()
 let $padNum39A := $xml[descendant::launchPad/@padNum[string()='39A']]
 let $padNum39AMission := $padNum39A//mission
 let $inclination := $xml//inclination/@deg/string()
 
 return $inclination 