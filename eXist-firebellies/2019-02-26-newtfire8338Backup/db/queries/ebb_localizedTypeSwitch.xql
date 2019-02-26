xquery version "3.1";
declare variable $doc := doc('/db/testing/ozymandias.xml')/*;
declare function local:line($node as node()) as item() {
    local:dispatch($node)
};
declare function local:dispatch($nodes as node()) as item()* {
    for $node in $nodes
    return
    typeswitch($node)
        case text() return $node
        case comment() return $node 
        case element(line) return local:line($node/node())
        default return local:passthru($node)
};

declare function local:passthru($node as node()) as item()* 
 {element {node-name($node)} {($node/@*, 
    for $child in $node/node()
        return local:dispatch($child))}
};

let $lines := $doc//line
return 
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head><title>Ozymandias</title>
        </head>
        <body>
            {for $l at $pos in $lines 
            return
               <span class="line"><span class="n">{$pos}</span>{local:line($l)}</span>
            }
        </body>
    </html>
