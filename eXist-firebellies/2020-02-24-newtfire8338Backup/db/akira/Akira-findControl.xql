xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $akira := doc('/db/akira/Akira-Script.xql')/*
let $control := $akira
(: My goal here is to pring out a table of who says the word "control" in the script
 : and how many times. :)
(: A character list is upcoming :)
