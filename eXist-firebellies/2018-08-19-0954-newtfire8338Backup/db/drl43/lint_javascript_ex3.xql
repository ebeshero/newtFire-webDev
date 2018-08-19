xquery version "3.1";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $mitfordColl := collection ('/db/mitford');
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $countLetterFiles := count($letterFiles);
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when;
declare variable $letterYears := $letterDates/tokenize(string(), '-')[1];

declare variable $distDates := distinct-values($letterYears);
declare variable $minLetterYear := xs:integer(min($letterYears));
declare variable $maxLetterYear := xs:integer(max($letterYears));
declare variable $totalLetterYears := $maxLetterYear - $minLetterYear;

declare variable $yearNum := xs:integer($maxLetterYear) - xs:integer($minLetterYear);
declare variable $lineLength := $yearNum * 365;
declare variable $stretchFactor := 365;

declare variable $letterRecipients := $letFiles/descendant::tei:titleStmt/tei:title/tei:persName/@ref;
declare variable $distLetterRecips := distinct-values($letterRecipients);
declare variable $si := doc('http://digitalmitford.org/si.xml');

