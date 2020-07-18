xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];

let $distinctYears := distinct-values($letterDates)
for $distinctYear in $distinctYears
order by $distinctYear
return $distinctYear