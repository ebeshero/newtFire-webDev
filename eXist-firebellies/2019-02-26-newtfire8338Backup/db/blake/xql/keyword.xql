xquery version "3.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";


<html>
    <head>
        <title>Blake Keyword</title>
        <link rel="stylesheet" type="text/css" href="navigation.css" />
        <link rel="stylesheet" type="text/css" href="search.css" />
    </head>
    <body>
        <div id="navbar">
            <ul id="nav">
                <li><a href="http://blake.obdurodon.org/index.xhtml">Home</a></li>
                <li><a href="http://blake.obdurodon.org/about.xml">About</a></li>
                <li><a href="http://blake.obdurodon.org/blake.xml">Poems</a></li>
                <li><a href="http://blake.obdurodon.org/blakeprojectmarkups.xml" target="_blank">XML</a></li>
                <li><a href="schema_blakeproject.rnc" target="_blank">Schema</a></li>
                <li><a>Frequency Tables</a>
                    <ul>
                        <li><a>Full Text</a>
                            <ul>
                                <li><a href="http://blake.obdurodon.org/freq_full_alpha.xml">Sort Alphabetically</a></li>
                                <li><a href="http://blake.obdurodon.org/freq_full_num.xml">Sort by Frequency</a></li>
                            </ul></li>
                        <li><a>Comparison by book</a>
                            <ul>
                                <li><a href="http://blake.obdurodon.org/freq_comp_alpha.xml">Sort Alphabetically</a></li>
                                <li><a href="http://blake.obdurodon.org/freq_comp_num.xml">Sort by Frequency</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="http://blake.obdurodon.org/search.xhtml">Search</a></li>
                <li><a href="http://blake.obdurodon.org/conclusions.xml">Future Directions</a></li>
            </ul>
        </div>
        <h1>Keyword Search Results</h1>
        <hr/>
            
{
let $kwic_input := request:get-parameter("kwic_input", "0")
let $text_input := request:get-parameter("input_search", "love")
let $close := concat($text_input, "~.6")
let $collection := collection('/db/course/blake')
let $poems_exact := $collection//poem[ft:query(.,$text_input)]
let $poems_ngram := $collection//poem[ngram:wildcard-contains(., $text_input)]
let $poems_close := $collection//poem[ft:query(.,$close)]
(:let $poems_exact_innocence := collection('/db/course/blake')//poem[@id="innocence"][ft:query(.,$text_input)]:)
(:let $poems_exact_experience := collection('/db/course/blake')//poem[@id="experience"][ft:query(.,$text_input)]:)
let $poems_exact_innocence := collection('/db/course/blake')//poem[@id="innocence"]
let $poems_exact_experience := collection('/db/course/blake')//poem[@id="experience"]
return
let $poem_id :=  collection('/db/course/blake')//poem/@id
return

for $poem in $poems_exact
(:for $poem in ($poems_exact, $poems_ngram, $poems_close):)
return
 
<ul>
    <u>Poem Title:</u> 
    <br/>
    <i>{
$poem/title/string()
(:    let $title := $poem/title:)
(:    let $titleMatch := $poem//title[ft:query(.,$text_input)]:)
(:    let $expandedTitle := util:expand($titleMatch, "expand-xincludes=no"):)
(:    let $expandedT := transform:transform($expandedTitle, doc('test.xsl'), ()):)
(:    return ($expandedT, $title[not(ft:query(., $text_input))]/string()):)
        }</i>
    <br/>
    songs of <b>{
    $poem//$poem_id/string()
    }</b>
    <br/>
    <u>Lines:</u>
    <br/>
    {
    let $lines := ($poem//l| $poem/title)[ft:query(.,$text_input)]
    for $line in $lines
    let $expanded := util:expand($line, "expand-xincludes=no")
    return (transform:transform($expanded,doc('test.xsl'),()),<br/>)
    (:for $line in $poem//l[ft:query(.,$text_input)]
    return ($line, <br/>:)
    }

</ul>

}
</body>
</html>
