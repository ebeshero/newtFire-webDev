<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <pattern>
        <rule context="gameResults">
            
            <assert test="every $i in second satisfies number($i) &lt; number(first)">
                <!--see Michael Kay p. 646-->
                The first-place score must always be greater than the second-place score.
            </assert>
        </rule>
    </pattern>
</sch:schema>