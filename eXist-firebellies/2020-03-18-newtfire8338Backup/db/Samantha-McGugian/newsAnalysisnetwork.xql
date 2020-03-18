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
        let $edgeAtt := //article[descendant::siteInfo[@ref[.=$s]]]//emo[.=$emo]/tokenize(base-uri(), '/')[4]
        for $i in $edgeAtt
        let $edge := //article[descendant::siteInfo[@ref[.=$s]]][descendant::emo[.=$emo]]//titleLine/normalize-space
        (string())
        for $e in $edge
 return
         concat($s, "&#x9;", $e, "&#x9;", $i, "&#x9;",$emo), "&#10;") ;
         
let $filename := "newsAnalysisNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/Samantha-McGugian/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri