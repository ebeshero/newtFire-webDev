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
                <text x="40" y="-500" style="font-family:sans-serif;font-size:25px" fill="black" font-stretch="expanded">Comment Tone Percentages (Youtube)</text>
                <text x="40" y="-460" style="font-family:sans-serif;font-size:10px" fill="black" font-stretch="expanded">Number of Obscenities used: <xsl:value-of select="count(//comment[@source='youtube']//obscenity)"/></text>
                <text x="40" y="-450" style="font-family:sans-serif;font-size:10px" fill="black" font-stretch="expanded">Number of Emotes used: <xsl:value-of select="count(//comment[@source='youtube']//emote)"/></text>
                <text x="40" y="-440" style="font-family:sans-serif;font-size:10px" fill="black" font-stretch="expanded">Number of Acronyms used: <xsl:value-of select="count(//comment[@source='youtube']//acronym)"/></text>
                <text x="40" y="-430" style="font-family:sans-serif;font-size:10px" fill="black" font-stretch="expanded">Number of Times Excessive Punctuation used: <xsl:value-of select="count(//comment[@source='youtube']//expunc)"/></text>
                <text x="40" y="-420" style="font-family:sans-serif;font-size:10px" fill="black" font-stretch="expanded">Number of Times All Caps used: <xsl:value-of select="count(//comment[@source='youtube']//caps)"/></text>
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
                
                <xsl:variable name="comment" select="count(//comment[@source='youtube'])"/>
                <xsl:variable name="positive" select="(count(//comment[@tone='positive'][@source='youtube'])) div $comment"/>
                <xsl:variable name="negative" select="(count(//comment[@tone='negative'][@source='youtube'])) div $comment"/>
                <xsl:variable name="neutral" select="(count(//comment[@tone='neutral'][@source='youtube'])) div $comment"/>
                <text x="100" y="{(-500*$positive)-10}" text-anchor="middle"><xsl:value-of select="round($positive*100)"/>%</text>
                <text x="250" y="{(-500*$negative)-10}" text-anchor="middle"><xsl:value-of select="round($negative*100)"/>%</text>
                <text x="400" y="{(-500*$neutral)-10}" text-anchor="middle"><xsl:value-of select="round($neutral*100)"/>%</text>
                <text x="100" y="20" text-anchor="middle">Positive</text>
                <text x="250" y="20" text-anchor="middle">Negative</text>
                <text x="400" y="20" text-anchor="middle">Neutral</text>
                <rect x="50" y="{-500*$positive}" fill="green" stroke="black" stroke-width="2" width="100" height="{500*$positive}"/>
                <rect x="200" y="{-500*$negative}" fill="red" stroke="black" stroke-width="2" width="100" height="{500*$negative}"/>
                <rect x="350" y="{-500*$neutral}" fill="blue" stroke="black" stroke-width="2" width="100" height="{500*$neutral}"/>
                
                
            </g>
        </svg>

    </xsl:template>
</xsl:stylesheet>