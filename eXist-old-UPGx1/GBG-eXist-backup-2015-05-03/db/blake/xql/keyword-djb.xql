xquery version "3.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";

<html>
    <head>
        <title>djb</title>
        <link rel="stylesheet" type="text/css" href="navigation.css" />
        <link rel="stylesheet" type="text/css" href="search.css" />
        </head>
        <body>
            <table border="1">
                <tr>
                    <th>Poem title</th>
                    <th>Lines that match</th>
                </tr>
    {
let $kwic_input := request:get-parameter("kwic_input", "0")
let $text_input := request:get-parameter("input_search", "infant")
let $collection := collection('/db/course/blake')
let $poems_exact := $collection//poem[ft:query(.,$text_input)]
let $poems_exact_innocence := collection('/db/course/blake')//poem[@id="innocence"]
let $poems_exact_experience := collection('/db/course/blake')//poem[@id="experience"]
return
(:  :<tr>
<td>
    {
        let $poemLine_exactInn := $poems_exact_innocence//l//ft:query(.,$text_input)
        let $poemTitle_exactInn := $poems_exact_innocence//poem//title//ft:query(.,$text_input)
        let $exact_Innocence := ($poemTitle_exactInn, $poemLine_exactInn)
        return string-join($exact_Innocence, "-----")
    }
</td>
<td>
    {
        let $poemTitle_exactExp := $poems_exact_experience//title//ft:query(.,$text_input)
        let $poemLine_exactExp := $poems_exact_experience//poem[@id="experience"]//l//ft:query(.,$text_input)
        let $exact_experience := ($poemTitle_exactExp, $poemLine_exactExp)
        return string-join($exact_experience, "-----")
    }
</td>
</tr>:)
for $poem in $poems_exact
return
<tr>
    <td>{$poem/title/string()}</td>
    <td>{
        for $line in $poem//l[ft:query(.,$text_input)]
        let $expanded := util:expand($line, "expand-xincludes=no")
        return (transform:transform($expanded,doc('test.xsl'),()),<br/>)
    }</td>
</tr>
}
</table>
</body>
</html>
