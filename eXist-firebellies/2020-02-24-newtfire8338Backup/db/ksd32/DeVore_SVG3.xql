xquery version "3.1";
declare variable $ulysColl := collection('/db/ulysses');
declare variable $person := $ulysColl//person/@persName ! string();
declare variable $CountPers := count($person);
declare variable $allto := $ulysColl//allusion/@to;
declare variable $CountAllto := count($allto);
declare variable $allwho := $ulysColl//allusion/@who;
declare variable $CountAllwho := count($allwho);
declare variable $allPers := $ulysColl//allusion/@persName;
declare variable $CountAllPers := count($allPers);
declare variable $CountAll := sum($CountAllwho + $CountAllPers + $CountAllto);
declare variable $refto := $ulysColl//reference/@to;
declare variable $CountRefto := count($refto);
declare variable $refWho := $ulysColl//reference/@who;
declare variable $CountRefwho := count($refWho);
declare variable $CountRefAll := sum($CountRefto + $CountRefwho);
declare variable $graphSpacer := 10;
declare variable $ThisFileContent :=
 <svg width="2000" height="7000" viewBox = "0 0 2000 3000">
   <g transform="translate(50,30)">
      <rect x="{-$graphSpacer+75}" y="880" width="100" height="{$CountPers}" style="fill:rgb(255, 77, 77);stroke-width:3;stroke:rgb(0,0,0)" />
      <rect x="{-$graphSpacer + 200}" y="507" width="100" height="{$CountAll}" style="fill:rgb(128, 191, 255);stroke-width:3;stroke:rgb(0,0,0)" />
      <rect x="{-$graphSpacer + 325}" y="-200"width="100" height="{$CountRefAll}" style="fill:rgb(102, 255, 153);stroke-width:3;stroke:rgb(0,0,0)" />
      <text x="{-$graphSpacer +200}" y="920" fill="red">Allusion</text>
      <text x="{-$graphSpacer + 325}" y="920" fill="red">Reference</text>
      <text x="{-$graphSpacer+75}" y="920" fill="red">Person</text>
      <text x="{-$graphSpacer + 200}" y="505" fill="black">{$CountAll}</text>
      <text x="{-$graphSpacer + 325}" y="-202" fill="black">{$CountRefAll}</text>
      <text x="{-$graphSpacer+75}" y="875" fill="black">{$CountPers}</text>
      <text x="0" y="-200" fill="black">2000</text>
      <text x="20" y="901" fill="black">0</text>
      <text x="0" y="200" fill="black">1000</text>
      <text x="50" y="-275" fill="black">Number of People, References, and Allusions made in the Ulysses Text</text>
      <line x1="40" y1="900" x2="500" y2="900" style="stroke:rgb(0,0,0);stroke-width:2" />
      <line x1="41" y1="-200" x2="40" y2="901" style="stroke:rgb(0,0,0);stroke-width:2" />
     
      <line x1="40" y1="200" x2="20" y2="200" style="stroke:rgb(0,0,0);stroke-width:2" />
  </g>
</svg>;

let $filename := "DeVore_project.svg"
let $doc-db-uri := xmldb:store("/db/ksd32", $filename, $ThisFileContent)
return $doc-db-uri