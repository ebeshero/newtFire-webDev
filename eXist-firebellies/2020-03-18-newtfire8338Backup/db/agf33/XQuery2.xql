xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $ThisFileContent :=

string-join(
 let $hamilton := collection('/db/hamilton/')/*
 let $people := $hamilton//persName
 let $distinctPeople := distinct-values($people)
 for $dP in $distinctPeople
 let $peers := 
    if ($people[. = $dP]/ancestor::)
    
    
)
