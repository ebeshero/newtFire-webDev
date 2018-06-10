xquery version "3.1";
<html><head><title>SPEECH COUNTS IN MACBETH</title></head><body>
    <table>
{let $plays := collection('/db/shakespeare/plays')/*
for $i in $plays
let $speakers := $i//SPEAKER
let $distspeakers := distinct-values($speakers)
let $desired := $i[(count($distspeakers)) gt 40]
let $desiredspeakers := distinct-values($desired/descendant::SPEAKER)
for $ds in $desiredspeakers
let $matchds := $desired//SPEAKER[.=$ds]
let $countmatchedds := count($matchds)
return <tr>
    <td>{$ds}</td>
    <td>{$countmatchedds}</td>
    </tr>
    
    
}
</table>
</body></html>







            