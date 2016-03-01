xquery version "3.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html5 process-xsl-pi=yes add-exist-id=all highlight-matches=both media-type=text/html omit-xml-declaration=yes indent=yes";


(: ebb: 16-Feb-2015: Something's not working. Check what needs to be done to index and serialize. Is everything configured? Mitford Lucene searches work here :)
(:  :<html>
    <head>
        <title>Nell Nelson tester: fuzzy and close searches, and highlighting matches</title>
      
        </head>
        <body>
            <table border="1">
                <tr>
                    <th>File title</th>
                    <th>Chunks of text that match</th>
                </tr>
    { 
        :)
let $kwic_input := request:get-parameter("kwic_input", "0")
let $text_input := request:get-parameter("input_search", "trouble")
let $collection := collection('/db/NellNelson/book')
let $texts_exact := $collection//root[ft:query(.,$text_input)]
return $texts_exact
(:  :for $text in $texts_exact
return
<tr>
    <td>{$text/title/string()}</td>
    <td>{
       for $p in $text//p[ft:query(.,$text_input)]
        let $expanded := util:expand($p, "expand-xincludes=no")
   (: return ($expanded[.//exist:match], <br/>):)
  return ($p,<br/>)
    }</td>
</tr>
}

</table>
</body>
</html>:)