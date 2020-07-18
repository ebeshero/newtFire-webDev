xquery version "3.1";
declare variable $ThisFileContent:=
string-join(
let $uly := collection('/db/ulysses/ulysses/')
let $name := $uly//person/@persName/string()
let $distName := $name => distinct-values()
for $i in $distName
let $parent:= $uly//*[child::person/@persName/string()=$i]/name()=>distinct-values()
(: 2019-03-18 ebb: Nice work with this tree-matching predicate! So you're getting the names of all the parent elements holding persNames. :)
for $p in $parent
let $Countp:= $uly//*[./name()=$p and child::person/@persName = $i] =>count()
(: Trying to get every persName and reference within the same parent element :)
(: ebb: Again, GREAT work here with the complex predicate to find the matches in the tree for $p and $i :)
let $ref:= $uly//allusion/@persName/string()
for $r in $ref
let $oref := $uly//*[./name()=$p and child::allusion/@persName=$i]//allusion/@persName[string()!=$i]
let $distref:= $oref=>distinct-values()
order by $Countp descending
return concat($i,"&#x9;",$p,"&#x9;",$Countp,"&#x9;",$r,"&#10;"));

let $filename := "DeVore_Net.tsv"
let $doc-db-uri := xmldb:store('/db/ksd32',$filename,$ThisFileContent,"text/plain")
return $doc-db-uri 
(: 2019-03-18 ebb: Check Plus! Excellent conceptual work for plotting your network of relationships! This is really interesting because you're showing which *characters* are connected with which literary allusions in particular kinds of passages. I think this will make a really interesting network analysis! :)

