xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
(:  :declare default element namespace "http://www.tei-c.org/ns/1.0";:)
let $austenColl := collection('/db/JaneAusten/')/*
(:let $emma := doc('/db/JaneAusten/ausEmma.xml')/*:)
let $said := $austenColl//tei:said
let $countSaid := count($said)
let $indirect := $said[@direct="false"]
let $countIndirect := count($indirect)
let $direct := $said[@direct="true"]
let $countDirect := count($direct)
let $percentIndirect := $countIndirect div $countSaid * 100
let $percentDirect := $countDirect div $countSaid * 100
return $percentDirect