xquery version "3.1";
let $brandNewColl := collection('/db/brandnew/Albums')
let $album := $brandNewColl//album/string() =>distinct-values()
for $x in $album
let $song := $brandNewColl//title[following-sibling::album = $x]
let $distSong := $song/string() => distinct-values()
for $y in $distSong
let $length := $brandNewColl//info[child::album = $x][child::title = $y]/songLength/string()
let $catLength :=
    if ($length ! tokenize(., ':')[2] ! translate(., '0', '') ! number(.) >= 4)
            then "Longer than 4 Minutes"
        else "Shorter than 4 minutes"
order by $x
return string-join(($x, $y, $catLength),"&#x9;"), "&#10;"
