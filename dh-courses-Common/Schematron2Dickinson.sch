<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
    <pattern>
        <rule context="tei:rdg">
            <assert test="./parent::tei:app/parent::tei:l/parent::tei:lg">
                The rdg tag must be contained within an app element, a l element, and a lg element!
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="tei:rdg">
            <report test="not(@wit)">
                The rdg element must have an @wit!
            </report>
        </rule>
    </pattern>
    
    <let name="witList" value="doc('Dickinson_listWit.xml')//@xml:id"/>
    <pattern>
        <rule context="@wit">
            <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i, '#')"/>
            <assert test="every $token in $tokens satisfies $token = $witList">
                The attribute, after the hashtag (#) must match a defined @xml:id in the witList file!
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="tei:head/tei:title[ancestor::tei:div[@type='poem']/following-sibling::tei:div]">
            <let name="number" value="string(number(substring(current(), 6, 2)) + 1)"/>
            <assert test="ancestor::tei:div[@type='poem']/following-sibling::tei:div//tei:title[matches(., $number)]">
                All poems should be in the correct counting order.
            </assert>
        </rule>
    </pattern>
    
    <!-- 2016-02-11: nll: This rule is in the optional part of the assignment!-->
    <pattern>
        <rule context="tei:app">
            <let name="wit" value="tokenize(replace(string-join(.//@wit, ' '), '#df16', ''), '\s+')"/>
            <assert test="count($wit) eq count(distinct-values($wit))">
                There should not be any repeating witnesses in a single app element other than the possibility of #df16.
            </assert>
        </rule>
    </pattern>
    

    
</schema>