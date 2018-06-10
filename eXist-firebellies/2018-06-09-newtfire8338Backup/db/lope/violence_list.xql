xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $coll := collection('/db/lope/plays')/*;
declare variable $texts := $coll/descendant::tei:text/descendant::tei:body;
declare variable $titles := $coll/descendant::tei:teiHeader/descendant::tei:titleStmt/descendant::tei:title;
declare variable $textTitles := $titles/data();
declare variable $vioWords := $texts//tei:w[@type='violence']/string();
declare variable $dvVio := distinct-values($vioWords);
<html><head><title>The diction of violence in two Lope plays</title></head>
<body> 
    <table>
        <tr><th>Filenames in which words for violence appear</th></tr>
    {for $i in $dvVio
    let $eval := $texts[.//tei:w eq $i]/ancestor::tei:TEI//tei:titleStmt/tei:title
    let $fileName := $eval/tokenize(base-uri(), "/") [last()]
    order by $i
    return
    <tr><td>{$i}</td>
    <td>{string-join(($eval), ', ')}</td>
    </tr>
        }
    
        
    </table></body>


</html>

