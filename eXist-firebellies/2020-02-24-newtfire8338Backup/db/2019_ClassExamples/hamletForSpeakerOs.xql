xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $hamlet := doc('/db/apps/shakespeare/data/ham.xml')
let $speakers := distinct-values($hamlet//speaker)
for $speaker in $speakers
     let $speakerLength := string-length($speaker)
     where ends-with($speaker,'o')
       (:order by string-length($speaker):)  
          (:commenting out! :)
     order by $speakerLength
     return concat ($speaker, ' has ', $speakerLength , ' characters.')

