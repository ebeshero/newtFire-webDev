xquery version "3.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
(:  :declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes"; :)
let $input_search := request:get-parameter("input_search", "peace")
(: ebb: 2017-07-21 Note with Paul Hackett that in order to be able to search on multiple words separated by white space, we must
 : use "'string string"' syntax. We think that punctuation is stripped from the search by default. :)
let $close := concat($input_search, "~.6")
let $collection := collection('/db/waldenft')
let $articles_exact := $collection//div[ft:query(.,$input_search)]
(:  :let $articles_all := ($articles_exact, $articles_ngram, $articles_close) :)
let $exactEl := $articles_exact//body//*[ft:query(.,$input_search)]
return
    <div id="searchResults">
    <h3>Exact search results:</h3>
{
let $eResults :=
if (count($exactEl) > 0)
  then
    for $e in $exactEl
(:  :let $uri := $e/tokenize(base-uri(), '/')[last()]:)
let $link := $e/ancestor::article//hyperlink
order by $link
return kwic:summarize($e, <config width="60" link="{$link}"/>)
else <p>No results found.</p>
return $eResults
}
</div>