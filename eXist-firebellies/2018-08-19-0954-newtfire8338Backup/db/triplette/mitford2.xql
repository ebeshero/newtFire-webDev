xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";
<html><head><title>Referenced Places in Mitford</title></head><body><table> {
    let $coll := collection('/db/mitford')/*
let $places := $coll//tei:placeName
let $placeRefs := $places/@ref/string()
let $dvPlaces := distinct-values($placeRefs)
for $i in $dvPlaces
let $matches := $coll//*[descendant::tei:placeName/@ref = $i]
let $baseURI := $matches/tokenize(base-uri(), '/')[last()]
return 
    <tr><td>{$i}</td>
    <td>{string-join($baseURI, ', ')})}</td></tr>
        }
    </table></body>


</html>