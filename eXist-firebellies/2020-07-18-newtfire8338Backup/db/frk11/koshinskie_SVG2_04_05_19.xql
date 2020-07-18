xquery version "3.1";
(: 2018-04-08 ebb: Good attempt here to build on the Timeline plot. There's a problem, though, with matching titles to specific years. You're actually plotting data all the titles in the whole collection,
for each year, instead of just the titles for a specific year.:)
  declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
 (: declare more global variables to pull data from the Banks collection. :)
  declare variable $timelineSpacer := 100;
  declare variable $sourceDesc := $banksyColl//sourceDesc;
  declare variable $dates :=  $sourceDesc//date/@when/string();
  declare variable $titles := $sourceDesc//title/string();
  declare variable $medium := $sourceDesc//medium/@type/string();
  declare variable $years := $dates ! tokenize(., '-')[1];
  declare variable $minYear := $years ! xs:integer(.) => min();
  declare variable $maxYear := $years ! xs:integer(.) => max();
  declare variable $lineLength := $maxYear - $minYear;
  
 declare variable $ThisFileContent := 
<svg width='2000' height='3000'>

   <g transform="translate(30, 30)">
      <line x1="0" y1="0" x2="0" y2="{$lineLength * $timelineSpacer}" style="stroke:blue;stroke-width:2"/>  
      
         {
            for $i in (0 to $lineLength)
            let $matchYear := $minYear + $i
            let $titlesByYear := $sourceDesc[($dates ! tokenize(.,'-')[1]) ! xs:integer(.)  = $matchYear]
(: 2019-04-08 ebb: Okay, let's take a look at why this "treewalker" variable isn't working. 
     You set out to define it with $sourceDesc, which is good (gets you back on the trees of the Banksy 
     collection). However, when you put $date in the predicate, you run into a problem because $date
     *literally* means $sourceDesc//date/@when/string(); It would mean that you're looking for sourceDesc
     elements that contain $banksyColl//sourceDesc elements inside. That's kind of like the old XPath 
     problem of writing a predicate like so: //sourceDesc[//date], where you're going back to the document node and getting all sourceDesc elements that exist in a condition where there's a date SOMEWHERE in the file. So what happened here? Exactly the same thing. There are 106 files in the Banksy collection, and all sourcesDesc elements in them exist in a condition in which there are sourceDesc elements in the Banksy collection. That is slightly cool and meta to contemplate, but not quite what we want to graph here, since
     it results in circles for each year representing a static count of 106 for each turn of the loop. :-)
     :)
            let $artworkCount := count($titlesByYear)
            return 
                
            <circle cx='0' cy='{$i * $timelineSpacer}' r='{$artworkCount}' stroke='purple' stroke-width='3' fill='violet'/>

         }
      
   </g>
   
    <g transform="translate(30, 30)">
    
        {
            for $i in (0 to $lineLength)
            return 
                
            <text x="50" y="{$i * $timelineSpacer}" fill="black" style="font-family:sans-serif;font-size:15px;">
            {$titles}</text>

         }
    </g>
</svg>;
$ThisFileContent
(:  :let $filename := "koshinskie_SVG2_04_05_19.svg"
let $doc-db-uri := xmldb:store("/db/frk11", $filename, $ThisFileContent)
return $doc-db-uri :)

      