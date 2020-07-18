xquery version "3.1";

declare variable $ulysses as document-node()+ := collection('/db/ulysses/ulysses');

declare variable $ThisFileContent as element() := 

<html>

    <head><title>Nestor Speakers vs. References</title></head>

    <body> 

        <h1>How Many References Each Speaker in "Nestor" Made</h1>

    <table>

        <tr><th>Speaker</th><th>Number of References</th></tr>

{

let $nestor := $ulysses[descendant:: chapter[@chapterName = "Nestor"]]//*

let $speakers := $nestor//said/@persName//string()=>distinct-values()

for $i in $speakers

let $references := $nestor//said[@persName = $i]/*=>count()

return 

        <tr>

       <td>{$i}</td>

       <td>{$references}</td>

           </tr>

}

</table></body>

</html> ;



let $filename := "NestorSpeakersvRef.html"

let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent)

return $doc-db-uri

(: Output at http://newtfire.org:8338/exist/rest/db/frc23/NestorSpeakersvRef.html :)    