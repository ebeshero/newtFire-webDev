xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $coll := collection('/db/lope/plays')/*;
declare variable $anzueloDoc := doc('/db/lope/plays/anzuelo_tei.xml')/*;
declare variable $text_anzuelo := $anzueloDoc/descendant::tei:text/descendant::tei:body;
declare variable $vioWordsAnzuelo := $text_anzuelo//tei:w[@type='violence']/string();
declare variable $countVioAnzuelo := xs:integer(count($vioWordsAnzuelo));
declare variable $juezDoc := doc('/db/lope/plays/juez_tei.xml')/*;
declare variable $text_juez := $juezDoc/descendant::tei:text/descendant::tei:body;
declare variable $vioWordsJuez := $text_juez//tei:w[@type='violence']/string();
declare variable $countVioJuez := xs:integer(count($vioWordsJuez));
declare variable $yMultiplier := xs:integer(2);

<svg width="1000" height="1500">
<g alignment-baseline="baseline" transform="translate (25, 500)">
        <line x1="25" y1="0" x2="700" y2="0" stroke="black" stroke-width="3"/>
        <line x1="25" y1="0" x2="25" y2="-500" stroke="black" stroke-width="3"/>
        
        
        <text x="70" y="-430" fill="black" style="font-family:avenir;font-size:25px;">Number of Violent Words in Two Lope Plays</text>
        <line x1="120" y1="-1.5" x2="120" y2="-{$countVioAnzuelo * $yMultiplier}" stroke="#91FF33" stroke-width="100"/>
        <text x="105" y="-{($countVioAnzuelo * $yMultiplier) + 10}"fill="black" style="font-family:avenir;font-size:20px;">{count($vioWordsAnzuelo)}</text> 
        <line x1="320" y1="-1.5" x2="320" y2="-{$countVioJuez * $yMultiplier}" stroke="magenta" stroke-width="100"/>
        <text x="305" y="-{($countVioJuez * $yMultiplier) + 10}"fill="black" style="font-family:avenir;font-size:20px;">{count($vioWordsJuez)}</text>
        </g></svg>
