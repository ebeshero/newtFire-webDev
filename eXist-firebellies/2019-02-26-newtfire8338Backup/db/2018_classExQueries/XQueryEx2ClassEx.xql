xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";
<html>
    <head><title>Top Ten Most Referenced People in the Digital Mitford Project</title></head>
<body>
    <table>
    
{
let $coll := collection('/db/mitford')/*
let $title := $coll//tei:titleStmt/tei:title
let $persons := $coll//tei:persName
(: ebb: Do you want to change this to collect people instead? The info is in tei:persName/@ref :)
let $persRefs := $persons/@ref/string()
let $dvPersons := distinct-values($persRefs)
for $i in $dvPersons
let $matches := $coll//tei:text[descendant::tei:persName/@ref = $i]/ancestor::tei:TEI//tei:titleStmt/tei:title
let $baseURI := $matches/tokenize(base-uri(), '/')[last()]
(: You're missing the where statement here to limit the number of results: We were looking for a condition where the count of returns of $baseURI is greater than 15, so we're finding the most frequently and widely mentioned people in the collection. Let's go over this in class!  :)
return
<tr>
<td>{$i}</td>
<td>{string-join($matches, ',')}</td>
</tr>
}
    
</table>
</body>
</html>

