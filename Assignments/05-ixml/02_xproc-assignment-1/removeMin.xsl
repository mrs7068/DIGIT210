<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:math="http://www.w3.org/2005/xpath-functions/math"
        exclude-result-prefixes="xs math"
        version="3.0">

    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="runtime">
        <xsl:choose>
            <xsl:when test="text() = 'N/A'">
                <runtime><xsl:value-of select="."/></runtime>
            </xsl:when>
            <xsl:otherwise>
                <runtime>
                    <xsl:value-of select="normalize-space(translate(., ' min', ''))"/>
                </runtime>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>