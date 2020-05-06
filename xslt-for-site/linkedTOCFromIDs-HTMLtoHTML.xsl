<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
  <!--  <xsl:output method="xhtml" encoding="utf-8" omit-xml-declaration="yes"/>-->
    <!--2020-05-06 eb: This stylesheet reads ids from any heading element in the content of an HTML document, 
        and creates a linked table of contents at the top of the document following the first top-level title.
    -->
    <xsl:mode on-no-match="shallow-copy"/>
    
   <xsl:template match="body">
       <xsl:copy-of select="processing-instruction()"/>
       
       
      
   </xsl:template>
    
</xsl:stylesheet>