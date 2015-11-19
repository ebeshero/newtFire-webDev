<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
  <!--  <xsl:variable name="SSIfile" select="document('../dh-course/top.html')"/>
  ebb: This doesn't work, almost certainly because my SSI file, top.html, isn't a well-formed XML document.
  -->
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="comment()[contains(. , '#include')][contains(., 'top.html')]">
    <div id="top"><div id="bannerImage"><a href="http://ebeshero.github.io/newtfire/dh/"><img
        src="newt-mosaic4.png"
        alt="NewtFire logo: a mosaic rendering of a firebelly newt"/></a></div>
        <div id="title"><a href="http://ebeshero.github.io/newtfire/">newtFire</a> <a href="http://ebeshero.github.io/newtfire/dh/">{dh|ds}</a></div>
        <div class="boilerplate"><span><strong>Maintained by: </strong> Elisa E. Beshero-Bondar
            (ebb8 at pitt.edu)   <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://licensebuttons.net/l/by-nc-sa/4.0/80x15.png" /></a><a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"></a> <strong>Last modified:
            </strong><script type="application/javascript">
                document.write(document.lastModified);
            </script>. <a href="http://ebeshero.github.io/newtfire/firebellies.html">Powered by firebellies</a>.</span></div>	
    </div>
    <hr/>
    </xsl:template>
    
    <xsl:template match="comment()[contains(. , '#include')][contains(., 'top-index.html')]">
        <div id="top"><div id="bannerImage"><a href="http://ebeshero.github.io/newtfire/dh/"><img
            src="newt-mosaic4.png"
            alt="NewtFire logo: a mosaic rendering of a firebelly newt"/></a></div>
            <div id="title"><a href="http://ebeshero.github.io/newtfire">newtFire</a> <a href="http://ebeshero.github.io/newtfire/dh">{dh|ds}</a></div>
            <div class="boilerplate"><span><strong>Maintained by: </strong> Elisa E. Beshero-Bondar
                (ebb8 at pitt.edu)   <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://licensebuttons.net/l/by-nc-sa/4.0/80x15.png" /></a><a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"></a>
                <strong>Read the <a href="dhCDA-2015.xml">course description and
                    syllabus in TEI XML</a>. </strong><strong>Last modified:
                    </strong><script type="application/javascript">
                        document.write(document.lastModified);
                    </script>. <a href="http://ebeshero.github.io/newtfire/firebellies.html">Powered by firebellies</a>.</span></div>	
        </div>
        <hr/>
    </xsl:template>
    
</xsl:stylesheet>