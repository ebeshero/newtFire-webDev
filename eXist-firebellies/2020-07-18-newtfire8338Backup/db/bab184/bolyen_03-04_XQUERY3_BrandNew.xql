xquery version "3.1";

(: bb: Basically stolen from Fiona's stuff. :)

declare variable $albumYFW as document-node()+ := collection('/db/brandnew/Albums/YourFavoriteWeapon'); 
(: bb: 'All this science I don't understand.':)
declare variable $FileOutput as element() :=
<html> <!--bb: Begin table-->
    <head><title>Brand New Discography</title></head> 
    <body> 
        <h1>Beats Per Minute for songs in 'Your Favorite Weapon'</h1>
    <table>
        <tr><th>Song</th><th>BPM (kind of)</th></tr>
{
    
    (: bb: instantiate title variable and make it pretty:)
    let $title := $albumYFW//title ! lower-case(.) ! normalize-space()
    
    (: bb: create for loop with a value for each song in the ablum:)
    for $t in $title
    
    (: bb: nab dat tempo:)
    let $tempo := $albumYFW//tempo
    
    (: bb: go up the preceding tree, look for the title on this iteration of the variable, nab dat bpm attribute:)
    let $bpm := $tempo[preceding::title ! lower-case(.) ! normalize-space()[contains(., $t)]]/@bpm
    
    (: bb: When values for bpm were yet unknown, a single digit was used. This '$bpmFormat' variable was intended to illustrate that but the function doesn't ever appear to operate. Also for some reason we get 170 returned twice. I tihnk this might be a flaw in our data and we'll have to reconsider it.:)
    (:let $bpmFormat := $bpm[replace(.,"\d","NEED DATA")]:)
    
    return
        
    <tr><!--bb: end table-->
       <td>{$t}</td>
       <td>{string-join((:$bpmFormat:)$bpm, ', ')}</td> 
    </tr>
}
</table></body>
</html> 
;

(: bb: 'It's just my job five days a week.' :)
let $fileName := "bolyen_03-04_OUTPUT3_BrandNew.html"
let $doc-db-uri := xmldb:store("/db/bab184", $fileName, $FileOutput)
return $doc-db-uri

(: bb: Output at http://newtfire.org:8338/exist/rest/db/bab184/bolyen_03-04_OUTPUT3_BrandNew.html :)