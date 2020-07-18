xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $waldenFT := collection('/db/waldenft/')
let $segs := $waldenFT//seg

let $divsXPath := $waldenFT//div//*/name() => distinct-values()
let $divsWText := $waldenFT//div//*[text() and matches(., '[A-z]')]/name() => distinct-values()
let $parNotNote := $waldenFT//div//*[not(parent::note) and text() and matches(., '[A-z]')]/name() => distinct-values()
let $childText := $waldenFT//div//*/text()[matches(., '[A-z]')]/parent::element()/name() => distinct-values()
let $tableText := $waldenFT//div//table/text()[matches(., '[A-z]')]
let $rowText := $waldenFT//div//row/text()[matches(., '[A-z]')]
let $lPar := $waldenFT//div//l/parent::element()/name() => distinct-values()
let $pPar := $waldenFT//div//p/parent::element()/name() => distinct-values()
let $addPar := $waldenFT//div//add/parent::element()/name() => distinct-values()
let $descPar := $waldenFT//div//desc/parent::element()/name() => distinct-values()
let $quotePar := $waldenFT//div//quote/parent::element()/name() => distinct-values()
let $headPar := $waldenFT//div//head/parent::element()/name() => distinct-values()
let $itemPar := $waldenFT//div//item/parent::element()/name() => distinct-values()
let $delPar := $waldenFT//div//del/parent::element()/name() => distinct-values()
let $segPar := $waldenFT//div//seg/parent::element()/name() => distinct-values()
let $lemPar := $waldenFT//div//lem/parent::element()/name() => distinct-values()
let $rdgPar := $waldenFT//div//rdg/parent::element()/name() => distinct-values()
let $hiPar := $waldenFT//div//hi/parent::element()/name() => distinct-values()
let $unclearPar := $waldenFT//div//unclear/parent::element()/name() => distinct-values()
let $cellPar := $waldenFT//div//cell/parent::element()/name() => distinct-values()
let $bylinePar := $waldenFT//div//byline/parent::element()/name() => distinct-values()
let $regPar := $waldenFT//div//reg/parent::element()/name() => distinct-values()
let $phrPar := $waldenFT//div//phr/parent::element()/name() => distinct-values()
let $namePar := $waldenFT//div//name/parent::element()/name() => distinct-values()
let $placeNamePar := $waldenFT//div//placeName/parent::element()/name() => distinct-values()
let $descLoc := $waldenFT//div//desc/text()
let $itemLoc := $waldenFT//div//item
let $itemURI := $itemLoc/base-uri()
let $lemLoc := $waldenFT//div//lem
let $regLoc := $waldenFT//div//reg
let $regURI := $regLoc/base-uri()

let $bodyChildren := $waldenFT//body//element()[text()]/name() => distinct-values()

let $divChildren := $waldenFT//div/element()/name() => distinct-values()
let $divText := $waldenFT//div/element()[text()]/name() => distinct-values()
let $divTextAz := $waldenFT//div/element()/text()[matches(., '[A-z]')]/parent::*/name() => distinct-values()
let $aChild := $waldenFT//div/anchor

let $pChildren := $waldenFT//p//element()/name() => distinct-values()
let $pText := $waldenFT//p//element()[text()]/name() => distinct-values()

let $aChildren := $waldenFT//anchor/text()

let $descendants := $waldenFT//body//element()/name() => distinct-values()
let $descText := $waldenFT//body//element()[text()]/name() => distinct-values()

let $anchor := $waldenFT//anchor/element()
let $lb := $waldenFT//lb/element()
let $choice := $waldenFT//choice/element()
let $space := $waldenFT//space
let $lem := $waldenFT//lem
let $figure := $waldenFT//figure
let $graphic := $waldenFT//graphic
let $desc := $waldenFT//desc
let $list := $waldenFT//list
let $ab := $waldenFT//ab
let $l := $waldenFT//l
let $app := $waldenFT//app/element()/name() => distinct-values()
let $rdg := $waldenFT//rdg/element()/name() => distinct-values()
let $lem := $waldenFT//lem/element()/name() => distinct-values()
let $w := $waldenFT//w
let $span := $waldenFT//span
let $sic := $waldenFT//sic
let $lg := $waldenFT//lg/element()/name() => distinct-values()
let $seg := $waldenFT//seg


return $seg


