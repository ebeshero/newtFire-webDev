<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xhtml" encoding="utf-8" indent="yes"
        doctype-system="http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"/> 
    
    <xsl:template match="/">
        
        <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
            <desc></desc>
            <g transform="translate(50,550)">
                <text x="40" y="-500" style="font-family:sans-serif;font-size:25px" fill="black" font-stretch="expanded">Sentence Quality Ratios</text>
               <text x="40" y="-470" style="font-family:sans-serif;font-size:15px" fill="black" font-stretch="expanded">Green = Good Structure</text>
               <text x="40" y="-450" style="font-family:sans-serif;font-size:15px" fill="black" font-stretch="expanded">Red = Poor Structure</text>
                <line x1="20" y1="0" x2="500" y2="0" color="black" stroke="black" stroke-width="2"/>
                <line x1="20" y1="0" x2="20" y2="-525" color="black" stroke="black" stroke-width="2"/>
                
                <text x="5" y="0" text-anchor="middle">0</text>
                <text x="5" y="-50" text-anchor="middle">10</text>
                <text x="5" y="-100" text-anchor="middle">20</text>
                <text x="5" y="-150" text-anchor="middle">30</text>
                <text x="5" y="-200" text-anchor="middle">40</text>
                <text x="5" y="-250" text-anchor="middle">50</text>
                <text x="5" y="-300" text-anchor="middle">60</text>
                <text x="5" y="-350" text-anchor="middle">70</text>
                <text x="5" y="-400" text-anchor="middle">80</text>
                <text x="5" y="-450" text-anchor="middle">90</text>
                <text x="5" y="-500" text-anchor="middle">100</text>
                
                <xsl:variable name="comment" select="count(//comment)"/>
               <xsl:variable name="commentYoutube" select="count(//comment[@source='youtube'])"/>
               <xsl:variable name="commentNbc" select="count(//comment[@source='nbc'])"/>
                <xsl:variable name="allGood" select="(count(//comment/sentence[@structure='good'])) div $comment"/>
                <xsl:variable name="allPoor" select="(count(//comment/sentence[@structure='poor'])) div $comment"/>
                <xsl:variable name="youtubeGood" select="(count(//comment[@source='youtube']/sentence[@structure='good'])) div $commentYoutube"/>
                <xsl:variable name="youtubePoor" select="(count(//comment[@source='youtube']/sentence[@structure='poor'])) div $commentYoutube"/>
                <xsl:variable name="nbcGood" select="(count(//comment[@source='nbc']/sentence[@structure='good'])) div $commentNbc"/>
                <xsl:variable name="nbcPoor" select="(count(//comment[@source='nbc']/sentence[@structure='poor'])) div $commentNbc"/>
                <text x="80" y="{(-500*$allGood)-10}" text-anchor="middle"><xsl:value-of select="round($allGood*100)"/>%</text>
                <text x="130" y="{(-500*$allPoor)-10}" text-anchor="middle"><xsl:value-of select="round($allPoor*100)"/>%</text>
                <text x="230" y="{(-500*$youtubeGood)-10}" text-anchor="middle"><xsl:value-of select="round($youtubeGood*100)"/>%</text>
               <text x="280" y="{(-500*$youtubePoor)-10}" text-anchor="middle"><xsl:value-of select="round($youtubePoor*100)"/>%</text>
               <text x="380" y="{(-500*$nbcGood)-10}" text-anchor="middle"><xsl:value-of select="round($nbcGood*100)"/>%</text>
               <text x="430" y="{(-500*$nbcPoor)-10}" text-anchor="middle"><xsl:value-of select="round($nbcPoor*100)"/>%</text>
                <text x="100" y="20" text-anchor="middle">Overall</text>
                <text x="250" y="20" text-anchor="middle">Youtube</text>
                <text x="400" y="20" text-anchor="middle">NBC</text>
                <rect x="50" y="{-500*$allGood}" fill="green" stroke="black" stroke-width="2" width="50" height="{500*$allGood}"/>
                <rect x="100" y="{-500*$allPoor}" fill="red" stroke="black" stroke-width="2" width="50" height="{500*$allPoor}"/>
                <rect x="200" y="{-500*$youtubeGood}" fill="green" stroke="black" stroke-width="2" width="50" height="{500*$youtubeGood}"/>
                <rect x="250" y="{-500*$youtubePoor}" fill="red" stroke="black" stroke-width="2" width="50" height="{500*$youtubePoor}"/>
                <rect x="350" y="{-500*$nbcGood}" fill="green" stroke="black" stroke-width="2" width="50" height="{500*$nbcGood}"/>
                <rect x="400" y="{-500*$nbcPoor}" fill="red" stroke="black" stroke-width="2" width="50" height="{500*$nbcPoor}"/>
                
            </g>
        </svg>

    </xsl:template>
</xsl:stylesheet>