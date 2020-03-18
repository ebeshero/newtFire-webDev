xquery version "3.1";

declare variable $brandNewColl as document-node()+ := collection('/db/brandnew/Albums');
declare variable $ThisFileContent as element() := 
<html>
    <head><title>Brand New Albums and Songs</title></head>
    <body> 
        <h1>Which Album Contains What Songs?</h1>
    <table>
        <tr><th>Albums</th><th>Songs</th></tr>
{
(:  :let $brandNewColl := collection('/db/brandnew/Albums'):)
let $album := $brandNewColl//song/info/album => distinct-values()
for $s in $album
let $songsMatch := $brandNewColl//title[following-sibling::album = $s]
let $songs := $songsMatch/string()
return (:concat($s, ': Contains Songs: ', string-join($songs, ', ')):)
<tr>
       <td>{$s}</td>
       <td>{string-join($songs, ', ')}</td> 
    </tr>
}
</table></body>
</html>
;

let $filename := "brandNewInfo.html"
let $doc-db-uri := xmldb:store("/db/bec80", $filename, $ThisFileContent)
return $doc-db-uri