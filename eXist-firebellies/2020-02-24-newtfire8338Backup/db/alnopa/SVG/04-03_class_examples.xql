xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $dates := $banksyColl/descendant::bibl/child::date/attribute::when/string() => sort();
declare variable $timelineSpacer := 100;
declare variable $years := $dates ! tokenize(., "-")[1];
declare variable $yearMax := $years ! xs:integer(.) => max();
declare variable $yearMin := $years ! xs:integer(.) => min();
declare variable $yLength := $yearMax - $yearMin;
  declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30, 30)">
      <line x1="0" y1="0" x2="0" y2="{$yLength * $timelineSpacer}" style="stroke:blue;stroke-width:2;"/>  
      
        {for $i in (0 to $yLength)
            return
        <circle cx="0" cy="{$i * $timelineSpacer}" r="2" stroke="purple" stroke-width="3" fill="violet"/>
        }
      
   </g>
</svg>;
$ThisFileContent
(: 2019-04-04 ebb: check minus. This got as far as our in-class work on Wed. 4/3, and you're outputting a line with circles indicating each year. Note that the for-loop is just cycling through the numbers 0 to 19, so you won't be able to find a collection with a year matching those integers. You want to define a variable to calculate the current year, by adding $i to $yearMin. You'd next need to go looking for files in the Banksy collection that match the current year you've calculated.
 : Let me know if you have any questions about the posted solution! 
 :  :)
