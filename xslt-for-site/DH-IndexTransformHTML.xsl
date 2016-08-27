<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
   
    <xsl:output method="xhtml" doctype-system="about:legacy-compat" 
        omit-xml-declaration="yes"/> 
    <!--<xsl:strip-space elements="*"/>-->
    
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="syllsched.css" />
                <title>newtFire DH|DS</title>
            </head>
            <body>
                
                <xsl:comment>#include virtual="top-index.html" </xsl:comment>
                <h1><span class="banner">Digital Humanities Courses</span></h1>
                <!--<h3> for subheadings when you need them.</h3>-->
                <p>This site hosts Elisa Beshero-Bondar's courses in coding for the Digital Humanities.
                    Either of these
                    courses fulfills a core requirement for <a href="http://greensburg.pitt.edu/academics/info/digital-studies">the Digital Studies
                        Certificate</a> at <a href="http://greensburg.pitt.edu">Pitt-Greensburg</a>. The
                    other may serve as an elective for the certificate, offering students an option to
                    pursue a concentration in coding within the certificate. The courses may be taken
                    in
                    any order. (Pursuing the second course allows students a review of fundamentals learned
                    in the first one, but offers experience with a different set of processing tools for
                    humanities research.
                </p>
                <ul>
                    <li><a href="CDASyll.html"><strong>Coding and Digital Archives</strong></a> 
                    </li>
                    <li><strong><a href="CDVSyll.html">Coding and Data Visualization</a></strong> 
                    </li>
                </ul>
                <h3>Course Projects</h3>
                <p>In alternating semesters, the two coding courses will either involve students contributing
                    to faculty-led research projects, or building their own proposed research projects.
                    All projects investigate a research question using digital methods.
                </p>
                <ul>
                    <li><a href="studentProjects.html">Student Projects</a></li>
                    <li><a href="projectGuide.html">Project Preparation Guidelines</a></li>
                </ul>
            
            <h3>Explanatory Guides Used in Courses</h3>
               <xsl:apply-templates select="//div[@type='guides']/list"/>
            
            </body>
            
            
        </html>
       
    </xsl:template>
    
   <xsl:template match="list">
       <ul><xsl:apply-templates/>
    
           <!--<ul><xsl:apply-templates select="list"/></ul>-->
       </ul>
   </xsl:template>
<xsl:template match="item">
    <li><xsl:apply-templates/></li>
</xsl:template>
    <xsl:template match="ref">
        <a href="{@target}"><xsl:apply-templates/></a>
    </xsl:template>

</xsl:stylesheet>
