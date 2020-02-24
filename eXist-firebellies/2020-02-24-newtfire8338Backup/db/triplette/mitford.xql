xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";
<html><head><title>Persons Referenced in the Letters of Mary Russell Mitford</title></head>
<body><table> 
    {
let $coll := collection('/db/mitford')/*
let $texts := $coll/descendant::tei:text/descendant::tei:body
let $titles := $coll/descendant::tei:teiHeader/descendant::tei:titleStmt/descendant::tei:title
let $textTitles := $titles/data()
let $persons := $texts//tei:persName/@ref/string()
let $dvPersons := distinct-values($persons)
for $i in $dvPersons
let $matches := $coll//*[descendant::tei:persName/@ref = $i]
let $baseURI := $matches/tokenize(base-uri(), '/')[last()]
let $count :=count($matches)
where (count($matches)) > 15
order by $count descending
return 
    <tr><td>{$i}</td>
    <td>{string-join($baseURI, ', ')}</td>
        
    </tr>
        }
    
        
    </table></body>


</html>