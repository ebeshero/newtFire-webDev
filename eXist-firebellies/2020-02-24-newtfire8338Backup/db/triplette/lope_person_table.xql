xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $coll := collection('/db/lope')/*
let $texts := $coll/descendant::tei:text/descendant::tei:body
let $titles := $coll/descendant::tei:teiHeader/descendant::tei:titleStmt/descendant::tei:title
let $textTitles := $titles/data()
let $persons := $texts//tei:persName/string()
let $dvPersons := distinct-values($persons)
return

<html><head><title>Persons Referenced in the Lope plays</title></head>
<body> 
    <table>
        <tr><th>Filenames in which the names of persons appear</th></tr>
    {for $i in $dvPersons
    let $eval := $texts[.//tei:persName eq $i]/ancestor::tei:TEI//tei:titleStmt/tei:title
    let $fileName := $eval/tokenize(base-uri(), "/") [last()]
    order by $i
    return
    <tr><td>{$i}</td>
    <td>{string-join(($eval), ', ')}</td>
    </tr>
        }
    
        
    </table></body>


</html>



