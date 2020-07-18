xquery version "3.1";
(: Facets for sorting/filtering; find where to use them :)
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
let $input_search := request:get-parameter("input_search", "peace")
let $input_sort := request:get-parameter("input_sort", "pars")
let $close := concat($input_search, "~.6")
let $collection := collection('/db/waldenft')
let $search_exact := $collection//body[ft:query(.,$input_search)]
let $search_close := $collection//body[ft:query(.,$close)]
let $exactEl := $search_exact//body//*[ft:query(.,$input_search)]
let $closeEl := $search_close//body//*[ft:query(.,$close)]
return
    <section id="results">
        <article class="result-header">
            <h2>{$exactEl => count()} results for <b>"peace"</b></h2>
            <ul class="result-row">
                <li class="col-1">Results</li>
                <li class="col-2">Fluid-Text Location</li>
                <li class="col-3">IIIF Manuscript Location</li>
            </ul>
        </article>
        
        {
        let $eResults :=
        if (count($exactEl) > 0)
          then
            for $e in $exactEl
        (:  :let $uri := $e/tokenize(base-uri(), '/')[last()]:)
        let $link := $e
        order by $input_sort
        return
                <article class="result-item">
                    <ul class="result-row">
                        <li class="col-1"><h3>{$e ! kwic:summarize}</h3></li>
                        <li class="col-2">{<a href="{$link}"/>}</li>
                        <li class="col-3">{<a href="{$link}"/>}</li>
                    </ul>
                </article>
        else <p>No results found.</p>
        return $eResults
        }
    </section>