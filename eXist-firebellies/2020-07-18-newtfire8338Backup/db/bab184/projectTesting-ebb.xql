xquery version "3.1";

(:The goal of this XPath is to count XML elements from multiple directories and output the average value from each directory:)

let $discog := collection('/db/brandnew/XML/Albums')
let $albumRef := $discog//album/@ref/string() ! normalize-space()
let $albumDist := $albumRef => distinct-values()

(: Target title @ref from album @ref :)
for $albumIndex in $albumDist

let $titleRef := $discog//title[following-sibling::album/@ref = $albumIndex]/@ref/string() ! normalize-space()
let $titleDist := $titleRef => distinct-values()

(: Put this all in the right order :)
order by $albumIndex

(: Initialize variable for a cumulative sum of count in the next structure:)
let $partAddend := number('0')

let $albumCounts := 
(: Target count from title and album @refs :)
   for $titleIndex in $titleDist

     let $partRef := $discog//song[preceding::album/@ref = $albumIndex][preceding::title/@ref = $titleIndex]/(child::intro | prelude | interlude| postlude | verse | chorus | bridge | outro | preChorus | instrumental) ! name()
     let $partCount := $partRef=> count()

(:Now that we have the values, is it possible to take the average of the collection? The avg() function won't return values we want because it operates on the current index of the loop and would be redundant. Below I have an algorithm for getting a running total, but its output renders it redundant as well. It seems as though partAddend isn't staying initialized to the sum and may be returning to zero, but albumIndex shouldn't be iterating until titleIndex has finished a full revolution? Maybe there's a bug in my loops that could also be causing this.:)

     let $partSum := sum(($partCount, $partAddend))
     let $partAddend := $partSum

    return $partSum
    
return concat($albumIndex, ': ', (string-join($albumCounts, ', ')))

(:  :(: Get string info for output :)
let $titleString := $discog//title[@ref = $titleIndex][following-sibling::album/@ref = $albumIndex]/string() ! normalize-space()
let $titleDistString := $titleString => distinct-values()

let $albumString := $discog//album[@ref = $albumIndex][preceding-sibling::title/@ref = $titleIndex]/string() ! normalize-space()
let $albumDistString := $albumString => distinct-values():)

(:  (: Get track info for output :)
let $trackNo := $discog//track[preceding-sibling::album/@ref = $albumIndex][preceding-sibling::title/@ref = $titleIndex]/@n/string() ! number()
for $trackIndex in $trackOutput
order by $trackIndex

for $titleOutput in $titleString:)
