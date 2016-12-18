xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
(:  declare default element namespace tei="http://www.tei-c.org/ns/1.0"; :)
let $lettersColl := collection('/db/letters')/*
let $literaryColl := collection('/db/literary')/*
let $lettersPeeps := $lettersColl//tei:persName
let $literaryPeeps := $literaryColl//tei:persName
let $allPeeps := ($lettersPeeps, $literaryPeeps)
let $distinctPeeps := distinct-values($allPeeps)
let $datesLetters := $lettersColl//tei:date
let $normDatesLetters := $datesLetters/@when/string()
let $datesLiterary := $literaryColl//tei:date
let $normDatesLiterary := $datesLiterary/@when/string()
let $allDates := ($normDatesLetters, $normDatesLiterary)
let $distinctDates := distinct-values($allDates)
let $lucenePerson := $lettersColl//tei:p[ft:query(tei:persName, "T.N. Talfourd")]
let $luceneDate := $lettersColl//tei:p[ft:query(tei:date, "1819")] 
return 
    <stuff>
<lucenePerson>{$lucenePerson}</lucenePerson>
        <luceneDate>{$luceneDate}</luceneDate> 
<names>    {string-join($distinctPeeps, ', ')}</names>
<dates>{string-join($distinctDates, ', ') }</dates>
</stuff>