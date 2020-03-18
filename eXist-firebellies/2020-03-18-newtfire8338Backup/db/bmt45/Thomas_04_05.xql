xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $when := $banksyColl//sourceDesc//bibl//date/@when ! string();
declare variable $title := $banksyColl//sourceDesc//bibl//title ! string();
declare variable $whenYear := $when ! tokenize(., "-")[1];

declare variable $medium := $banksyColl//sourceDesc//bibl//medium/@type ! string();
declare variable $maxYear := $whenYear ! xs:integer(.) => max();
declare variable $minYear := $whenYear ! xs:integer(.) => min();
declare variable $lineLength := $maxYear - $minYear;
declare variable $whenCount := $when => count();
 declare variable $timelineSpacer := 100;
 declare variable $ThisFileContent :=
 <svg width="2500" height="3000">
   <g transform="translate (30,30)">
      <line x1="0" y1="0" x2="0" y2="{$lineLength * $timelineSpacer}" style="stroke:blue"/>  
{
    for $i in (0 to $lineLength)
    let $matchYear := $minYear + $i
    let $dateSearch := $banksyColl//sourceDesc[descendant::date/@when ! tokenize(., "-") ! xs:integer(.)= $matchYear]
    let $titleSearch := $dateSearch//title
    let $titleCount := $titleSearch => count()
    let $medium_Spray := $banksyColl//sourceDesc//medium[@type='spray_paint'] => count()
    let $medium_Canvas := $banksyColl//sourceDesc//medium[@type='canvas'] => count()
    return
<g>
    <circle cx="0" cy="{$i * $timelineSpacer}" r="{$titleCount}" stroke="purple" stroke-width="3" fill="violet"></circle>
    <text x='5' y='{$i * $timelineSpacer}'>{$matchYear}</text>
    <rect text='canvas' x='50' y='{$medium_Canvas}' height='100' width='100' stroke='blue' fill='blue'>{$medium_Canvas}</rect>
    <rect text='spray_paint' x='50' y='{$medium_Spray}' height="50" width="50" stroke="red" fill='red'></rect> 
</g>

}
   </g>
</svg>;
$ThisFileContent
(: I could not figure out how to set the y so that a red rectangle would show a canvas painting and a blue rectangle to show a spray painted painting. :)
(:  :let $filename := "Thomas_04_05.svg"
let $doc-db-uri := xmldb:store("/db/bmt45", $filename, $ThisFileContent)
return $doc-db-uri :)
(: 2019-04-09 ebb: check minus. You've output the timeline with circles of varying sizes related to count. But you had trouble getting the ratio of spray painted vs. canvas paintings per year. As you see in the output, you're getting one big blue rectangle and one smaller red on top. Why aren't you getting MULTIPLE boxes, one for each year? Well, you need to think about how to space these. The y attribute needs to indicate the top left corner of each box, and it needs to come in relation to your $i, which spaces things in relation to each year. Also, you need to get your counts for spray paint and canvas from THAT PARTICULAR YEAR. You should rewrite your variables to reach that information, working with your $dateSearch variable where you MADE that match: 
 :   let $dateSearch := $banksyColl//sourceDesc[descendant::date/@when ! tokenize(., "-") ! xs:integer(.)= $matchYear]
 : Can you rewrite your variables for $medium_Spray and for $medium_Canvas to start with $dateSearch and then locate the canvas and spray_paint info from there? Counting those will get you variable counts for each year, which you should then be able to plot in your rectangles running down the screen. Happy to improve your score on this if you'd like to resubmit it. 
 :  :)



