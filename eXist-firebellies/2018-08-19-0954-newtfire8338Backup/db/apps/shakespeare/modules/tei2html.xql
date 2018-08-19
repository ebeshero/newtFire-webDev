module namespace tei2="http://exist-db.org/xquery/app/tei2html";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function tei2:tei2html($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return
                $node
            case element(tei:TEI) return
                tei2:tei2html($node/*)
            case element(tei:teiHeader) return
                tei2:header($node)
            case element(tei:text) return
                <div xmlns="http://www.w3.org/1999/xhtml" class="body">{ tei2:tei2html($node//tei:body) }</div>
            case element(tei:div) return
                let $level := count($node/ancestor-or-self::tei:div)
                let $type := if ($level eq 2) then "scene" else "act"
                return
                    <div xmlns="http://www.w3.org/1999/xhtml" id="{$node/@xml:id}" class="{$type}">
                        <a name="{$node/@xml:id}"></a>
                        { tei2:tei2html($node/node()) }
                    </div>
            case element(tei:head) return
                let $level := count($node/ancestor-or-self::tei:div)
                return
                    element { concat("h", $level) } {
                        tei2:tei2html($node/node())
                    }
            case element(tei:stage) return
                if ($node/ancestor::tei:l) then
                    <span xmlns="http://www.w3.org/1999/xhtml" class="stage">{ tei2:tei2html($node/node()) }</span>
                else
                    <p xmlns="http://www.w3.org/1999/xhtml" class="stage">{ tei2:tei2html($node/node()) }</p>
            case element(tei:sp) return
                if ($node/tei:l) then
                    <div xmlns="http://www.w3.org/1999/xhtml" class="sp" id="{tei2:get-id($node)}">{ tei2:tei2html($node/node()) }</div>
                else
                    <div xmlns="http://www.w3.org/1999/xhtml" class="sp" id="{tei2:get-id($node)}">
                        { tei2:tei2html($node/tei:speaker) }
                        <p class="p-ab">{ tei2:tei2html($node/tei:ab) }</p>
                    </div>
            case element(tei:lg) return
                <div xmlns="http://www.w3.org/1999/xhtml" class="lg" id="{tei2:get-id($node)}">
                { tei2:tei2html($node/node()) }
                </div>
            case element(tei:l) return
                <p xmlns="http://www.w3.org/1999/xhtml" class="line">{ tei2:tei2html($node/node()) }</p>
            (:NB: block to inline.:)
            case element(tei:ab) return 
                <span xmlns="http://www.w3.org/1999/xhtml" class="ab">{ tei2:tei2html($node/node()) }</span>
            case element(tei:speaker) return
                <h5 xmlns="http://www.w3.org/1999/xhtml" class="speaker">{ tei2:tei2html($node/node()) }</h5>
            
            case element(tei:publicationStmt) return
                <div xmlns="http://www.w3.org/1999/xhtml" class="publicationStmt">{ tei2:tei2html($node/node()) }</div>
            case element(tei:sourceDesc) return
                <div xmlns="http://www.w3.org/1999/xhtml" class="sourceDesc">{ tei2:tei2html($node/node()) }</div>
            case element(tei:p) return 
                <p xmlns="http://www.w3.org/1999/xhtml">{ tei2:tei2html($node/node()) }</p>
            case element(tei:title) return
                <em xmlns="http://www.w3.org/1999/xhtml">{ tei2:tei2html($node/node()) }</em>
            case element(exist:match) return
                <mark xmlns="http://www.w3.org/1999/xhtml">{ $node/node() }</mark>
            case element() return
                tei2:tei2html($node/node())
            default return
                $node/string()
};

declare function tei2:header($header as element(tei:teiHeader)) {
    let $titleStmt := $header//tei:titleStmt
    let $pubStmt := $header//tei:publicationStmt
    let $sourceDesc := $header//tei:sourceDesc
    return
        <div xmlns="http://www.w3.org/1999/xhtml" class="play-header">
            <h1>{$titleStmt/tei:title/text()}</h1>
            <h2>By {$titleStmt/tei:author/text()}</h2>
            <ul>
            {
                for $resp in $titleStmt/tei:respStmt
                return
                    <li>{$resp/tei:resp/text()}: {$resp/tei:name/text()}</li>
            }
            </ul>
            { tei2:tei2html($pubStmt/*) }
            { tei2:tei2html($sourceDesc/*) }
        </div>
};

declare %private function tei2:get-id($node as element()) {
    ($node/@xml:id, $node/@exist:id)[1]
};