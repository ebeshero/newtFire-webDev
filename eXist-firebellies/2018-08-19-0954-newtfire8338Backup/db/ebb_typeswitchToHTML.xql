xquery version "3.1";
declare function local:dispatch($nodes as node()*) as item()* {
    for $node in $nodes
    return
    typeswitch($node)
        case text() return $node
        case element(Ozymandias) return element html {local:dispatch($node/node())}
        case element(Sentence1) return element div {local:dispatch($node/node())}
        case comment() return $node 
        case element(line) return local:line($node/node())
        default return local:passthru($node) 
};

declare function local:line($node as node()) as element() {
    <span class="line"><span class="lineNumber">{local:linecount($node)}</span>
    {local:dispatch($node)}</span>
};

declare function local:linecount($node as node()*) as item()* {
let $lines := $docToChange//line
for $l at $pos in $lines
where $l[.=$node]
return $pos
}; 

declare function local:passthru($node as node()) as item()* 
 {element {name($node)} {($node/@*, 
    for $child in $node/node()
        return local:dispatch($child))}
};

declare variable $docToChange := doc('/db/testing/ozymandias.xml')/*;
let $transformation := local:dispatch($docToChange)
return $transformation


