<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions"
    xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:c="http://www.w3.org/ns/xproc-step"
    version="3.0">

    <!-- ================================================================ -->
    <!-- Fetch remote plain-text input                                    -->
    <!-- ================================================================ -->
    <p:input port="source" primary="true" content-types="text/plain"
        href="https://raw.githubusercontent.com/djbpitt/ixml/refs/heads/main/movies/movieData-short.txt" sequence="false"/>
    
    <!-- ================================================================ -->
    <!-- Output                                                           -->
    <!-- ================================================================ -->
    <p:output port="result" primary="true" sequence="true"/>
    <!-- ================================================================ -->
    <!-- Reads input from the input port and writes it unchanged to the   -->
    <!-- output port. If primary ports are configured correctly, will     -->
    <!-- output the original plain text input                             -->
    <!-- ================================================================ -->
    <p:identity/>
    
    <!-- ================================================================ -->
    <!--  Add structural markup with ixml                                 -->
    <!-- ================================================================ -->
    <p:invisible-xml cx:processor="markup-blitz">  <!-- oXygen doesn't like "p:invisible-xml" -->
        <p:with-input port="grammar">
            <p:document href="movies.ixml" content-type="text/plain"/>
        </p:with-input>
    </p:invisible-xml>
    <p:identity message="Added markup with ixml"/>
    
    <!-- ================================================================ -->
    <!-- Remove header row                                                -->
    <!-- ================================================================ -->
    <p:delete match="film[1]"/>
    <p:identity message="Deleted header row"/>
    
    <!-- ================================================================ -->
    <!-- XSLT to transform countries                                      -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="countries.xsl"/>
    </p:xslt>
    <p:identity message="Transformed countries"/>
    
    <!-- ================================================================ -->
    <!-- XSLT to remove min                                      -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="removeMin.xsl"/>
    </p:xslt>
    <p:identity message="remove 'min' from runtime elements"/>
    
    <p:validate-with-relax-ng>
        <p:with-input port="schema">
            <p:document href="movies.rnc" content-type="application/relax-ng-compact-syntax"/>
        </p:with-input>
    </p:validate-with-relax-ng>
    <p:identity message="Validated with Relax NG"/>
    
</p:declare-step>