xquery version "3.1";
declare variable $coll as document-node()+ := collection(/db/teentitans/season1);
declare variable $ThisFileContent as element() :=
<html>
    <head><title>Looking At Which Act BeastBoy Transforms the Most In During Season 1</title></head>
    <body>
        <table>
            <tr><th>Act</th><th>Num of Transforms</th></tr>
            <!--03-04-2020 shd: sorry that this is a small thing and probably will be unusable for season 2; we'll put up season 2 xml hopefully tonight and get something done with that -->
            
{
let $distAct := $coll//act/@n/string() => distinct-values()
for $a in $distAct 
let $class := $coll//transform/@class
let $distClass := $class[ancestor::act/@n = $a] => count()
order by $distClass
return (: concat('Act: ', $a, ' Transformations: ', string-join($distClass, ', ')) :)
<tr>
    <td>{$a}</td>
    <td>{string-join($distClass, ', ')}</td>
</tr>
}
</table>
</body>
</html>
;
let $filename := "dunn_bbTransforms.html"
let $doc-db-uri := xmldb:store('/db/shd79', $filename, $ThisFileContent)
return $doc-db-uri