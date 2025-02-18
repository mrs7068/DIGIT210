<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="text()">
        <!-- Tag quoted passages -->
        <xsl:analyze-string select="." regex='"([^"]+)"'>
            <xsl:matching-substring>
                <q>
                    <xsl:value-of select="regex-group(1)"/>
                </q>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                
                <!-- Tag dates -->
                <xsl:analyze-string select="." regex='(\d{{1,2}} [A-Z][a-z]+)'>
                    <xsl:matching-substring>
                        <date>
                            <xsl:value-of select="regex-group(1)"/>
                        </date>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>

    </xsl:template>
    
    <!-- Template to tag journal headings -->
    <xsl:template match="p[matches(., '^[A-Z ]+’S JOURNAL(—continued)?[.+?]?$')]">
        <journal-heading>
            <xsl:apply-templates/>
        </journal-heading>
    </xsl:template>
    
    <!-- Template to tag letter headings -->
    <xsl:template match="p[matches(., '^Letter, .+')]">
        <letter-heading>
            <xsl:apply-templates/>
        </letter-heading>
    </xsl:template>

</xsl:stylesheet>