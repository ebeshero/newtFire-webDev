xquery version "3.1";

(: Two imperfections with this code =
  1. This TSV is pretty visually ugly on account of the lengths of song titles being unstandardized.
  2. I'm not sure our exide db is updated with our most recent round of XML yet.:)

(: Begin file :)
declare variable $fileContent := string-join(

(: discog = discography
   Steps through file, then into the album entity and returns a distinct string. :)
let $discog := collection('/db/brandnew/Albums')
let $albums := $discog//album/string()! normalize-space()
let $distAlbums := $albums => distinct-values()

(: Used long names for 'for' loops because I'm special. :] 
 : Finds title elements where the following sibling matches the index of distinct albums, returns a distinct string for title.    (Redundant as all titles are unique anyway but meh)
 : Our XML has an attribute called "song ref" that contains only the first character of every word in a song title. Finding that    will make a nicer looking TSV but for visualization purposes I'm not worried about that atm.:)
for $albumIndex in $distAlbums
let $songTitle := $discog//title[following-sibling::album = $albumIndex]/string() ! normalize-space()
let $distTitle := $songTitle => distinct-values()

(: Finds tempo elements where the preceding siblings match the album and title (which, again, is probably overkill for the context of the project but good practice in general) and returns the specific bpm attribute
 : One of the issues I had with this was looking through the wrong node for :)
for $titleIndex in $distTitle
let $songBPM := $discog//tempo[preceding-sibling::album = $albumIndex][preceding-sibling::title = $titleIndex]/@bpm ! string() ! normalize-space()
let $distBPM := $songBPM => distinct-values()

for $bpmIndex in $distBPM
let $sharedBPM := $discog//title[not(. = $titleIndex)][following-sibling::tempo/@bpm=$bpmIndex]

for $sharedIndex in $sharedBPM

return string-join(($titleIndex,"in album:", $albumIndex, "Song's BPM:", $bpmIndex, "Shares with:", $sharedIndex), "&#x9;"), "&#10;");

let $fileName := "brandNewBPMandHarmony.tsv"
let $doc-db-uri := xmldb:store("/db/bab184/", $fileName, $fileContent, "text/plain")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/bab184/brandNewBPMandHarmony.tsv :) 