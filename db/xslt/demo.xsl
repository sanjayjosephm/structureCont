<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:mf="http://example.com/mf" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="mf xs functx xlink mml" xmlns:functx="http://www.functx.com" xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon" version="1.0">
    <xsl:output method="xml" encoding="utf-8"/>
    <xsl:output method="xml" indent="yes"/>

    <!-- Identity transform to copy all nodes by default -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Template to match <sec> elements and apply templates to their children, but not copy the <sec> element itself -->
    <xsl:template match="sec">
        <xsl:apply-templates select="* | text()"/>
    </xsl:template>
</xsl:stylesheet>
