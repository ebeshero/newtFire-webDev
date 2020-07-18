xquery version "3.1";
declare variable $ulysses := collection('/db/ulysses/ulysses/')/*;
declare variable $telemachiad := $ulysses[descendant::section/@sectionName = 'The Telemachiad'];
declare variable $wanderings := $ulysses[descendant::section/@sectionName = 'The Wanderings of Ulysses'];
declare variable $homecoming := $ulysses[descendant::section/@sectionName = 'The Homecoming'];

declare variable $telemachiadRefs := $telemachiad//location//reference/@to/string() => count();
declare variable $telemachiadAllus := $telemachiad//location//allusion/@*/string() => count();
declare variable $telemachiadPers := $telemachiad//location//person/@who/string() => count();
declare variable $wanderingsRefs := $wanderings//location//reference/@to/string() => count();
declare variable $wanderingsAllus := $wanderings//location//allusion/@*/string() => count();
declare variable $wanderingsPers := $wanderings//location//person/@who/string() => count();
declare variable $homecomingRefs := $homecoming//location//reference/@to/string() => count();
declare variable $homecomingAllus := $homecoming//location//allusion/@*/string() => count();
declare variable $homecomingPers := $homecoming//location//person/@who/string() => count();

declare variable $telemachiadTotal := $telemachiadRefs + $telemachiadAllus + $telemachiadPers;
declare variable $wanderingsTotal := $wanderingsRefs + $wanderingsAllus + $wanderingsPers;
declare variable $homecomingTotal := $homecomingRefs + $homecomingAllus + $homecomingPers;
declare variable $ulyssesTotal := $telemachiadTotal + $wanderingsTotal + $homecomingTotal;

declare variable $telemachiadPercent := ($telemachiadTotal div $ulyssesTotal) * 100;
declare variable $wanderingsPercent := ($wanderingsTotal div $ulyssesTotal) * 100;
declare variable $homecomingPercent := ($homecomingTotal div $ulyssesTotal) * 100;

declare variable $ThisFileContent := 
<svg width="100%" height="100%" viewBox="0 0 42 42" class="donut">
  <circle class="donut-hole" cx="21" cy="21" r="15.91549430918954" fill="#fff"></circle>
  <circle class="donut-ring" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#d2d3d4" stroke-width="3"></circle>
<g>
  <circle class="donut-segment" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#ce4b99" stroke-width="3" stroke-dasharray="{$telemachiadPercent} {100 - $telemachiadPercent}" stroke-dashoffset="25"></circle>
  </g>
  <circle class="donut-segment" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#b1c94e" stroke-width="3" stroke-dasharray="{$wanderingsPercent} {100 - $wanderingsPercent}" stroke-dashoffset="{100 - $telemachiadPercent + 26}"></circle>
  
  <circle class="donut-segment" cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#377bbc" stroke-width="3" stroke-dasharray="{$homecomingPercent} {100 - $homecomingPercent}" stroke-dashoffset="{100 - $telemachiadPercent - $wanderingsPercent + 25}"></circle> 


</svg>

;
$ThisFileContent
