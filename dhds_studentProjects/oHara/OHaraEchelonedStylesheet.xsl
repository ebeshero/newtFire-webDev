<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" indent="yes"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>  
    
    <xsl:template match="/">
        <html>
            <head><title><xsl:apply-templates select="//head"/></title>
                <link rel="stylesheet" type="text/css" href="oHaraSite.css"/>
                
            </head>
            <body>
                
                <h1>Studying Referentiality in Frank O'Hara's Poetry</h1>
                <div class="taskbar">
                    <ul class="nav">
                        <li><a href="index.html">About</a></li>
                        <li><a href="oHaraMyGoal.html">My Goal</a></li>
                        <li><a href="myResults.html">My Results</a></li>
                        <li><a href="myCode.html">My Code</a></li>
                        <li><a href="samplePoem.html">Sample Poem</a></li>
                        <li><a href="myConclusions.html">Conclusions</a></li>
                    </ul>
                </div>
                
                <h2><xsl:apply-templates select="//head"/></h2>
                
                <div class="poem"> 
                    
                    
                    <xsl:for-each-group select="//l" group-starting-with="l[not(starts-with(., ' '))]"> 
                        
                        <xsl:for-each select="current-group()">
                            <xsl:choose> 
                                <xsl:when test="@n[ends-with(., '5')] | @n[ends-with(., '0')]"> <span class="lineNumber"><xsl:value-of select="@n"/></span><xsl:text>  </xsl:text></xsl:when>
                                
                                <xsl:otherwise><span class="hideMe"><span class="lineNumber"><xsl:value-of select="@n"/></span></span></xsl:otherwise>
                            </xsl:choose>
                            
                            
                            
                            
                            
                            <span class="hideMe"><xsl:value-of select="string-join(current-group()[. &lt;&lt; current()], ' ')"/></span><xsl:value-of select="."/><br/> 
                            
                            
                        </xsl:for-each>
                        
                    </xsl:for-each-group>
                    
                    
                    
                    
                    
                </div>
                
                <h3><xsl:apply-templates select="//date"/></h3>
                
                <div>Thank you to Dr. Elisa Beshero-Bondar for helping to render this poem's white space acurately.</div>
                
                <div class="footer">
                    <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
                </div>
                
            </body>
            
        </html>
        
    </xsl:template>
    
    
</xsl:stylesheet>