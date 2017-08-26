xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $shakespeare := collection('/db/shakespeare/plays')
let $filepaths := $shakespeare/base-uri()
let $allElementNames := $shakespeare/descendant::*/name()
let $distinctElNames := distinct-values($allElementNames)
let $countElementNames := count($distinctElNames)
 (:  An XQuery Comment:)
return
    <html>
        <head><title>Count and List of all XML Elements Used in Shakespeare Play Collection</title></head>
        <body>
    <p>{$countElementNames}</p>
    <table>
    
       <!-- Write XML comments here!
        {for $i in $distinctElNames
        return <li>{$i}</li>}-->
        {for $i in $distinctElNames
        (:ebb: Let's try to return each name, and a count of how many times it appears in the collection:)
        return
            <tr><td><!--This cell will hold the element name --></td>
            <td><!--This cell will contain its count. --></td></tr>
        }
    </table>
    </body>
    </html>






