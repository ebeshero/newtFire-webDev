xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html5 process-xsl-pi=yes add-exist-id=all highlight-matches=both media-type=text/html omit-xml-declaration=yes indent=yes";

<html>
    <head>
        <title>Mitford tester: fuzzy and close searches, and highlighting matches</title>
      
        </head>
        <body>
            <table border="1">
                <tr>
                    <th>File title</th>
                    <th>Chunks of text that match</th>
                </tr>
    {
let $kwic_input := request:get-parameter("kwic_input", "0")
let $text_input := request:get-parameter("input_search", "puppy")
let $collection := collection('/db/letters')
let $texts_exact := $collection//tei:text[ft:query(.,$text_input)]

return
for $text in $texts_exact
return
<tr>
    <td>{$text/ancestor::tei:TEI//tei:titleStmt/tei:title/string()}</td>
    <td>{
      for $match in $text//tei:p[ft:query(.,$text_input)]
        let $expanded := util:expand($match, "expand-xincludes=no")
    return ($expanded[.//exist:match]/string(), <br/>)
      (:  return ($line,<br/>):)
    }</td>
</tr>
}
</table>
</body>
</html>