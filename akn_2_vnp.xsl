<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ukl="https://www.legislation.gov.uk/namespaces/UK-AKN"
    
    
    
    
    xpath-default-namespace="http://docs.oasis-open.org/legaldocml/ns/akn/3.0"
    exclude-result-prefixes="xs ukl"
    version="2.0">
    <!-- xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" -->

    <xsl:output xmlns:saxon="http://saxon.sf.net/" method="html" indent="yes" saxon:line-length="1000" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="akomaNtoso">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="hcontainer">
        <!-- We expect first three elements to be num, heading, intro -->
        <p data-mce-style="text-align: center;" style="text-align: center;"><xsl:value-of select="num"/><xsl:text> </xsl:text><xsl:value-of select="heading"/></p>
        <p><xsl:if test="./intro[starts-with(normalize-space(string()),'That')]"><em>Resolved, </em><xsl:value-of select="intro"/></xsl:if></p>
        <xsl:apply-templates select="level|subsection|wrapUp"/>
        <hr style="margin: 80px;"/>
    </xsl:template>
    
    
    <xsl:template match="coverPage"></xsl:template>
    <xsl:template match="meta"></xsl:template>
    
    <xsl:template match="subsection">
        <p><xsl:value-of select="num"/><xsl:text> </xsl:text><xsl:apply-templates select="content|intro"/></p>
        <xsl:apply-templates select="content/p/mod/quotedStructure|level"/>
<!--        <xsl:choose>
            <xsl:when test="count(./descendant-or-self::mod) > 0">
                <xsl:apply-templates select="descendant-or-self::mod/quotedStructure"/>
                <p>There is a quoted structure</p>
            </xsl:when>
            <xsl:otherwise><p>No structure</p></xsl:otherwise>
        </xsl:choose>-->
    </xsl:template>


    <xsl:template match="content">
        <xsl:value-of select="p[not(mod)]"/>
        <xsl:value-of select="p/mod/text()"/>
    </xsl:template>
    
    <xsl:template match="intro">
        <xsl:apply-templates select="p"/>
    </xsl:template>
    
    <xsl:template match="level">
        
        <xsl:choose>
            <xsl:when test="@class='para1'">
                <p data-mce-style="padding-left: 30px;" style="padding-left: 30px;"><xsl:value-of select="num"/><xsl:text> </xsl:text><xsl:value-of select="content"/></p>
            </xsl:when>
            <xsl:otherwise><p><xsl:value-of select="num"/><xsl:text> </xsl:text><xsl:value-of select="content"/></p></xsl:otherwise>
        </xsl:choose>
        

    </xsl:template>


    <xsl:template match="mod/quotedStructure">
        <xsl:apply-templates select="hcontainer/content/p[def]"/>
        <xsl:apply-templates select="subsection"/>
        
    </xsl:template>
    
    <xsl:template match="hcontainer/content/p[def]">
        <p data-mce-style="padding-left: 30px;" style="padding-left: 30px;"><xsl:value-of select="def/@ukl:startQuote"/><xsl:value-of select="def"/><xsl:value-of select="def/@ukl:endQuote"/><xsl:value-of select="./text()"/></p>
    </xsl:template>


    <xsl:template match="wrapUp">
        <p><xsl:value-of select="."/></p>
    </xsl:template>
    
    <xsl:template match="p"><xsl:value-of select="./text()"/></xsl:template>
    
    <xsl:template match="*" mode='fallback'><p>!!!!!</p></xsl:template>
    
</xsl:stylesheet>