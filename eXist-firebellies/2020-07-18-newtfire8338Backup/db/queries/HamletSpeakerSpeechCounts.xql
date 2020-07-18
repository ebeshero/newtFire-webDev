xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
<html>
         <head><title>Speakers and counts of their 
         speeches in Hamlet</title></head>
         <body>
         <table>
         
         {
         let $hamlet := doc('/db/apps/shakespeare/data/ham.xml')
         let $speeches := $hamlet//sp
         let $speakers := $hamlet//speaker
         let $distinctsp := distinct-values($speakers)
         for $sp in $distinctsp
         let $count := count($speeches[speaker = $sp])
         order by $count descending
         return
         
         <tr>
         <td>{$sp}</td>
         <td>{$count}</td>
         </tr>
         }
         </table>
         
         </body>
         </html>
      

