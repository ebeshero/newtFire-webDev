xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
    let $pokemon := collection("/db/pokemonMap/pokemon")
    let $names := $pokemon//name/string()
        for $n in $names
        let $type := $pokemon//name[string() = $n]/following-sibling::typing
            for $t in $type
            let $otherName := $pokemon//name[string() != $n][following-sibling::typing = $t]
                for $o in $otherName
    return concat($n, '&#x9;', $t, '&#x9;', $o), '&#10;');
    let $filename := "PokemonNetwork.tsv"
    let $doc-db-uri := xmldb:store("/db/alnopa", $filename, $ThisFileContent, "text/plain")
    return $doc-db-uri
