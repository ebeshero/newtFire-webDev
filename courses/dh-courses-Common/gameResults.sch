<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <pattern>
        <rule context="gameResults">
            
            <assert test="number(first) gt number(second)">
                The first-place score must be greater than the second-place score.
            </assert>
            <report test="not(number(second) gt number(third))">
                The second-place score must be greater than the  third-place score.
            </report>
        </rule>
    </pattern>
</sch:schema>