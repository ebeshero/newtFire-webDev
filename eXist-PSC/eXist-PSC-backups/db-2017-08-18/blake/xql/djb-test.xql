declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd";      

let $kwic_input := request:get-parameter("kwic_input", ("0"))
let $text_input := request:get-parameter("input_search", ("love"))
let $keyword_exact := $text_input
let $keyword_close := concat($text_input, "*~.6")
let $poems_exact := collection('/db/course/blake')//poem[ft:query(.,$keyword_exact)]
let $poems_exact_innocence := collection('/db/course/blake')//poem[@id="innocence"][ft:query(.,$keyword_exact)]
let $poems_exact_experience := collection('/db/course/blake')//poem[@id="experience"][ft:query(.,$keyword_exact)]
let $poems_close := collection('/db/course/blake')//poem[ft:query(.,$keyword_close)]
let $poems_close_innocence := collection('/db/course/blake')//poem[@id="innocence"][ft:query(.,$keyword_close)]
let $poems_close_experience := collection('/db/course/blake')//poem[@id="experience"][ft:query(.,$keyword_close)]
let $match_type := request:get-parameter("match_type", ("close"))
let $word_total_full := 5322
let $word_total_innocence := 2450
let $word_total_experience := 2874
let $kwic_count_exact_full := count(kwic:summarize($poems_exact, <config width="0"/>))
let $kwic_count_exact_full_freq := $kwic_count_exact_full div $word_total_full * 100
let $kwic_count_exact_innocence := count(kwic:summarize($poems_exact_innocence, <config width="0"/>))
let $kwic_count_exact_innocence_freq := $kwic_count_exact_innocence div $word_total_innocence * 100
let $kwic_count_exact_experience := count(kwic:summarize($poems_exact_experience, <config width="0"/>))
let $kwic_count_exact_experience_freq := $kwic_count_exact_experience div $word_total_experience * 100
let $kwic_count_close_full := count(kwic:summarize($poems_close, <config width="0"/>))
let $kwic_count_close_full_freq := $kwic_count_close_full div $word_total_full * 100
let $kwic_count_close_innocence := count(kwic:summarize($poems_close_innocence, <config width="0"/>))
let $kwic_count_close_innocence_freq := $kwic_count_close_innocence div $word_total_innocence * 100
let $kwic_count_close_experience := count(kwic:summarize($poems_close_experience, <config width="0"/>))
let $kwic_count_close_experience_freq := $kwic_count_close_experience div $word_total_experience * 100
return if ($match_type eq "close")

then (
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="navigation.css" />
        <link rel="stylesheet" type="text/css" href="search.css" />
        <title>Search</title>
    </head>
    <body>
        <!--navigation menu bar-->
        <div id="navbar">
            <ul id="nav">
                <li><a href="http://blake.obdurodon.org/index.xhtml">Home</a></li>
                <li><a href="http://blake.obdurodon.org/about.xml">About</a></li>
                <li><a href="http://blake.obdurodon.org/blake.xml">Poems</a></li>
                <li><a href="http://blake.obdurodon.org/blakeprojectmarkups.xml">XML</a></li>
                <li><a href="http://blake.obdurodon.org/schema_blake%20project.rnc">Schema</a></li>
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
        <!--end menu bar -->
        <!-- Start of Search Form -->
                <div id="search_form">
            <h2>Search Text for Keywords (all values must be completed)</h2>
            <h4><i>Instructions: input a keyword in search, select a match type, and enter a KWIC integer value.</i></h4><hr/>
            <form name="search"
                action="http://obdurodon.org:8081/rest/db/course/blake/xql/keyword.xql" method="get">
                Enter keyword <input type="text" name="input_search" /><br />
                Match Type <br />
                <input type="radio" name="match_type" value="exact" /> Exact Match (<i>Search will return only exact match of word selected, i.e. "love" only matches "love"</i>)<br />
                <input type="radio" name="match_type" value="close" /> Close Match (<i>i.e. "Love" will match "lovely", "bird" will match "birds", etc...</i>)<br />
                Enter KWIC Number (# of characters on either side of the keyword that you want to see displayed) <input type="text" name="kwic_input" /><br />
                <input type="submit" value="Submit" />
            </form>
        </div>
        <!-- end of search form -->
<div id="results">        
<h2 class="your_results">Your Results (Close Match) for "{$text_input}", {$kwic_count_close_full}:</h2>
<b class="frequency">Approximate matches for "{$text_input}" occur {$kwic_count_close_full} ({round-half-to-even($kwic_count_close_full_freq, 1)}%) times in full text, {$kwic_count_close_innocence} ({round-half-to-even($kwic_count_close_innocence_freq, 1)}%) times in <i>Innocence</i> and {$kwic_count_close_experience} ({round-half-to-even($kwic_count_close_experience_freq, 1)}%) times in <i>Experience</i></b>
<ul id="results">
{for $i in $poems_close
let $kwic := kwic:summarize($i, <config width="{$kwic_input}"/>)
return 
<li class="poem">
<b class="poem_title">"{$i/title/text()}", <i class="book_name">{$i/preceding-sibling::heading/text()}</i>, {count($kwic)} Matches</b>
<ol class="results">{ for $i in $kwic
return
<li class="kwic">{$i}</li>
}</ol>
</li>}
</ul>
</div>
</body>
</html>)

else(
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="navigation.css" />
        <link rel="stylesheet" type="text/css" href="search.css" />
        <title>Search</title>
    </head>
    <body>
        <!--navigation menu bar-->
        <div id="navbar">
            <ul id="nav">
                <li><a href="http://blake.obdurodon.org/index.xhtml">Home</a></li>
                <li><a href="http://blake.obdurodon.org/about.xml">About</a></li>
                <li><a href="http://blake.obdurodon.org/blake.xml">Poems</a></li>
                <li><a href="http://blake.obdurodon.org/blakeprojectmarkups.xml">XML</a></li>
                <li><a href="http://blake.obdurodon.org/schema_blake%20project.rnc">Schema</a></li>
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
        <!--end menu bar -->
        <!-- Start of Search Form -->
                        <div id="search_form">
            <h2>Search Text for Keywords (all values must be completed)</h2>
            <h4><i>Instructions: input a keyword in search, select a match type, and enter a KWIC integer value.</i></h4><hr/>
            <form name="search"
                action="http://obdurodon.org:8081/rest/db/course/blake/xql/keyword.xql" method="get">
                Enter keyword <input type="text" name="input_search" /><br />
                Match Type <br />
                <input type="radio" name="match_type" value="exact" /> Exact Match (<i>Search will return only exact match of word selected, i.e. "love" only matches "love"</i>)<br />
                <input type="radio" name="match_type" value="close" /> Close Match (<i>i.e. "Love" will match "lovely", "bird" will match "birds", etc...</i>)<br />
                Enter KWIC Number (# of characters on either side of the keyword that you want to see displayed) <input type="text" name="kwic_input" /><br />
                <input type="submit" value="Submit" />
            </form>
        </div>
        <!-- end of search form -->
<div id="results">
<h2 class="your_results">Your Results (Exact Match) for "{$text_input}", {$kwic_count_exact_full}:</h2>
<b class="frequency"> Exact matches for "{$text_input}" occur {$kwic_count_exact_full} ({round-half-to-even($kwic_count_exact_full_freq, 1)}%) times in full text, {$kwic_count_exact_innocence} ({round-half-to-even($kwic_count_exact_innocence_freq, 1)}%) times in <i>Innocence</i> and {$kwic_count_exact_experience} ({round-half-to-even($kwic_count_exact_experience_freq, 1)}%) in <i>Experience</i></b>
<ul id="results">
{for $i in $poems_exact
let $kwic := kwic:summarize($i, <config width="{$kwic_input}"/>)
return 
<li class="poem">
<b class="poem_title">"{$i/title/text()}", <i class="book_name">{$i/preceding-sibling::heading/text()}</i>,  {count($kwic)} Matches</b>
<ol class="results">{ for $i in $kwic
return
<li class="kwic">{$i}</li>
}</ol>
</li>}
</ul>
</div>
</body>
</html>)
