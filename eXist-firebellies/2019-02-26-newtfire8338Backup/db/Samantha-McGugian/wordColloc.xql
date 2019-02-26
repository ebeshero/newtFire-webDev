xquery version "3.0";
declare variable $ThisFileContent:=
string-join(
let $articles := collection('/db/newsAnalysis/')
let $articleFiles := $articles/*
let $source := $articleFiles//siteInfo//@ref
let $distinctSources := distinct-values($source)
for $s in $distinctSources
let $emos := //article[descendant::siteInfo[@ref[.=$s]]]//emo

for $emo in $emos
 let $topic := //article[descendant::siteInfo[@ref[.=$s]]]//emo[.=$emo]/tokenize(base-uri(), '/')[4]
        for $i in $topic
let $otherEmos := //article[descendant::siteInfo[@ref[.=$s]]]//emo[. != $emo]
for $o in $otherEmos
       
       (: let $edge := //article[descendant::siteInfo[@ref[.=$s]]][descendant::emo[.=$emo]]//titleLine :)
       
    
 return
         concat($emo, "&#x9;", $s, "&#x9;", $i, "&#x9;",$o), "&#10;") ;
         
let $filename := "newsColloc.tsv"
let $doc-db-uri := xmldb:store("/db/Samantha-McGugian/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri