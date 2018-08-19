xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $ThisFileContent:=
<html>
    <head><title>Top Ten Peeps in DM Project</title></head>
 <body>  
     <table>
         <tr><th>Person Refs</th><th>Files</th>
             </tr>
{
let $mitfordColl := collection('/db/mitford')/*
let $uri := $mitfordColl/tokenize(base-uri(), '/')[last()]
let $bodies := $mitfordColl//tei:body
let $titles := $mitfordColl//tei:teiHeader//tei:titleStmt/tei:title
let $peeps := $bodies//tei:persName/@ref
let $dvPeeps := distinct-values($peeps)
for $i in $dvPeeps
let $matchFiles := $bodies[descendant::tei:persName[@ref = $i]]/tokenize(base-uri(), '/')[last()]
where count($matchFiles) gt 15
let $cleanI := substring-after($i, '#')
order by count($matchFiles) descending
return 
<tr>
   <td>{$cleanI}</td><td>{string-join($matchFiles)}</td> 
</tr>    
}   
 
</table> 
 </body>
 </html>;   
let $filename := "TopTenMitfordPeeps.html"
let $doc-db-uri := xmldb:store("/db/jmh237", $filename, $ThisFileContent, "html")
return $doc-db-uri
