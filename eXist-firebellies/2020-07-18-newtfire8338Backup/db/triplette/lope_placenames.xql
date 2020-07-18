xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $coll := collection('/db/lope')/*;
declare variable $texts := $coll/descendant::tei:text/descendant::tei:body;
declare variable $titles := $coll/descendant::tei:teiHeader/descendant::tei:titleStmt/descendant::tei:title;
declare variable $textTitles := $titles/data();
declare variable $places := $texts//tei:placeName/string();
declare variable $dvPlaces := distinct-values($places);

<html><head><title>Places Referenced in the Lope plays</title></head>
<body> 
    <table>
        <tr><th>Filenames in which the names of places appear</th></tr>
    {for $i in $dvPlaces
    let $eval := $texts[.//tei:placeName eq $i]
    let $fileName := $eval/tokenize(base-uri(), "/") [last()]
    order by $i
    return
    <tr><td>{tokenize($i, "#")[last()]}</td>
    <td>{string-join(($fileName), ', ')}</td>
    </tr>
        }
    
        
    </table></body>


</html>


