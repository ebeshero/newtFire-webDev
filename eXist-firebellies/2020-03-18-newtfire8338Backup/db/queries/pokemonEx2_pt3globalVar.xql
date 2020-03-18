xquery version "3.1";
(:  Illustrating uses of global variables with declare ...; and saving output to eXist-db  :)
 (: 1. Notice that we are able to declare a node type with a repetition indicator for our global variable: this is always a good idea. :)
 (: 2. The global variable $ThisFileContent is defined by the body of our XQuery document, and will close with just the semicolon toward the end of the file. Scroll to see where it closes. Typically we apply this **after**ad we have tested an XQuery script to make sure it's returning what we want, when we are ready to store a good script and its output to the database.
 :) 
declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon');
declare variable $ThisFileContent as element() := 
<html>
    <head><title>Pokemon Types and Locations</title></head>
    <body> 
        <h1>Where to Find Pokemon by Type</h1>
    <table>
        <tr><th>Type</th><th>Locations</th></tr>
{
(: We moved this to a global variable :let $pokemon := collection('/db/pokemonMap/pokemon') :)
let $types := $pokemon//typing/@type
(: Some Pokemon have multiple types, coded in the typing/@type as a white-space separated list. A few of these have commas in them, so along the way, we'll trim those out and get rid of any extra white spaces before taking distinct-values(). :)
let $distTypes := $types ! upper-case(.) ! substring-before(., ',') ! normalize-space() ! tokenize(., ' ') => distinct-values()
(: Now it's time for the for-loop. Let's walk through each type one by one and see if we can match them up to names of Pokemon and locations for Pokemon. We can create a directory of Pokemon types this way. :)
for $d in $distTypes
let $names := $pokemon//name
let $namesMatch := $names[following-sibling::typing/@type ! upper-case(.)[contains(., $d)]]
let $locations := $pokemon//locations/landmark
let $locsMatch := $locations[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@n/string()
let $distLM := $locsMatch => distinct-values() 
return 
  (:  concat($d, ' : where: ', string-join($distLM, ', ')) :)
    <tr>
       <td>{$d}</td>
       <!--<td>{string-join($distLM, ', ')}</td>--> 
<!-- 2019-03-04 ebb: In class, let's see if we can sort the landmarks, 
and organize the output differently, in an HTML list within the table cell. 
Two ways to do this: sort() function, and FLWOR Order by. 
Where would we put the sort() function? 
Where would we put the order by statement?
-->   
    </tr>
}
</table></body>
</html> ;

let $filename := "pokemonTypeLoc.html"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent)
return $doc-db-uri
(: The lines above create a filename and a filepath, and apply the eXist database function xmldb:store() to bundle these together with our XQuery-generated file content to create a new document and store it to the database. :)
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/pokemonTypeLoc.html :)     

