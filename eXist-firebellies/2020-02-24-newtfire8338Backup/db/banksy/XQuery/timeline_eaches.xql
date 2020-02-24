xquery version "3.1";
declare variable $ThisFileContent :=
<root>
{
let $banksy := collection('/db/banksy')/element()
let $years := $banksy//date/@when
let $yearsDist := $years ! tokenize(., "-")[1] => sort() => distinct-values()
for $y in $yearsDist
let $names := $banksy//bibl/title
let $namesMatchCanvas := $names[following-sibling::date/@when[contains(., $y)]][following-sibling::medium[@type="canvas"]]/string() => sort()
let $namesMatchGraffiti := $names[following-sibling::date/@when[contains(., $y)]][following-sibling::medium[@type="spray_paint"]]/string() => sort()
let $namesMatchMisc := $names[following-sibling::date/@when[contains(., $y)]][following-sibling::medium[@type = ('book', 'film', 'installation')]]/string() => sort()
return
    <group>
        <year>{$y}</year>
        <works>
            <canvas>
                {"<title>", $namesMatchCanvas => string-join("</title><title>"), "</title>"}
            </canvas>
            <graffiti>
                    {"<title>", $namesMatchGraffiti => string-join("</title><title>"), "</title>"}
            </graffiti>
            <other>
                    {"<title>", $namesMatchMisc => string-join("</title><title>"), "</title>"}
            </other>
        </works>
    </group>
}
</root>;
let $filename := "timeline.xml"
let $doc-db-uri := xmldb:store("/db/banksy/XQuery", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri





