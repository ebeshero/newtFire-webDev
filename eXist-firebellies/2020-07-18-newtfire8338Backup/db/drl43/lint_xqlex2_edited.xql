xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";

<html>
    <head><title>Top Ten Most Referenced People in the Digital Mitford Project
        
    </title></head>
<body>
    <table>
    
{
let $coll := collection('/db/mitford')/*
let $title := $coll//tei:titleStmt/tei:title
let $persons := $coll//tei:persName
let $persRefs := $persons/@ref/string()
let $dvPers := distinct-values($persRefs)
for $i in $dvPers
let $matches := $coll//*[descendant::tei:persName/@ref = $i]
let $baseURI := $matches/tokenize(base-uri(), '/')[last()]
where count ($matches) gt 15
order by $i descending
return 

<tr>
        <td>{$i}</td>
        <td>{string-join($baseURI, ', ')}</td>
</tr>
}
    
</table>
</body>
</html>
