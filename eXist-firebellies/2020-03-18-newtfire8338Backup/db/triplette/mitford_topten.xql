xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $coll := collection('/db/mitford')/*;
declare variable $texts := $coll/descendant::tei:text/descendant::tei:body;
declare variable $titles := $coll/descendant::tei:teiHeader/descendant::tei:titleStmt/descendant::tei:title;
declare variable $textTitles := $titles/data();
declare variable $persons := $texts//tei:persName/@ref/string();
declare variable $dvPersons := distinct-values($persons);

<html><head><title>Top Ten Persons Referenced in the Letters of Mary Russell Mitford</title></head>
<body> 
    <table>
        <tr><th>Filenames in which the @ref appears</th></tr>
    {for $i in $dvPersons
    let $eval := $texts[.//tei:persName[@ref eq $i]]
    let $fileName := $eval/tokenize(base-uri(), "/") [last()]
    where count($eval) gt 15
    order by $i descending
    return
    <tr><td>{tokenize($i, "#")[last()]}</td>
    <td>{string-join(($fileName), ', ')}</td>
    </tr>
        }
    
        
    </table></body>


</html>

