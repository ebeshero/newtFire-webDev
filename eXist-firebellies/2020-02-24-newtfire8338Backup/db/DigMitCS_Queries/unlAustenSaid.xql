xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $coll as document-node()+ := collection('/db/JaneAusten/');
let $said := $coll//tei:said
let $saidDirectAloud := $said[@direct="true" and @aloud="true"]
let $countSDA := count($saidDirectAloud)
let $saidDirectSilent := $said[@direct="true" and @aloud="false"]
let $countSDS := count($saidDirectSilent)
let $Indirect := $said[@direct="false"]
let $countIndirect := count($Indirect)
return ($countIndirect, $Indirect)

