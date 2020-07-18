# XQuery Exercise 2: Where Are The Pokemon?

## Question 1:
**Write an expression to return a count of the number of files in the collection, using the count() function.**
* XPath: `collection('/db/pokemonMap/pokemon')/element() => count()`
* FLWOR: 
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')/element()
    let $count := count($pokemon)
    return $count
    ```

## Question 2:
**Return the filepaths of all the files in the Pokemon collection with the base-uri() function.**
* XPath: `collection('/db/pokemonMap/pokemon')/element()/base-uri()`
* FLWOR: 
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')/element()
    let $base := $pokemon/base-uri()
    return $base
    ```
**Then trim the results to return only the filenames: Tokenize the file paths on the / and retrieve the last token.**
* XPath:`collection('/db/pokemonMap/pokemon')/element()/base-uri() ! tokenize(., "/")[last()]`
* FLWOR: 
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')/element()
    for $p in $pokemon/base-uri()
    let $token := $p ! tokenize(., "/")
    return $token[last()]
    ```

## Question 3:
**We need to see how the XML in each file is structured to know how to query it. Starting from the collection(), write a basic XQuery expression to show you the coding of the files, using /*: This will show you the root element of each file (and thus each entire file).**
* XPath: `collection('/db/pokemonMap/pokemon')/element()`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    return $structure
    ```
**What XML element and attribute holds the type of a Pokemon?**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//typing/@type/string()`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    return $type
    ```
**Where can you find the locations associated with each Pokemon? (What element and attribute holds this information?)**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//locations/landmark/@n/string() => distinct-values()`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $landmark := $structure//locations
    let $location := $landmark/landmark
    let $locationAttribute := $location/@n/string()
    return $locationAttribute => distinct-values()
    ```
**If we started an XPath from the element holding the type of Pokemon, what XPath axis would we use to find the name of the Pokemon?**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//typing/preceding-sibling::name`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing
    let $name := $type/preceding-sibling::name
    return $name
    ```
**If we started an XPath from an element holding the landmark, what XPath axis would we use to find the type of Pokemon here? (We will need to express this relationship in our XQuery below.)**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//landmark/preceding::typing`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $landmark := $structure//landmark
    let $typing := $landmark/preceding::typing
    return $typing
    ```
## Question 4:
**Start by defining (and returning) a variable holding all the Pokemon types. We want to work with the @type attribute on the typing element, because this seems to return a list of standardized values. Note: To return an attribute value in eXist-db you will need to set string() at the end of your expression.**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//typing/@type/string()`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    return $type
    ```
**Look at your output: Do you see the white spaces? Several attributes hold a list of multiple type values separated by white space. Use the tokenize() function to break these apart on the white space separator, and return all of the individual values.**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//typing/@type ! tokenize(., ", ")`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    let $typeTokenComma := $type ! tokenize(., " ")
    return $typeTokenComma
    ```
**Second tokenize function**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//typing/@type ! tokenize(., ", ") ! tokenize(., " ")`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    let $typeTokenComma := $type ! tokenize(., ", ")
    let $typeTokenSpace := $typeTokenComma ! tokenize(., " ")
    return $typeTokenSpace
    ```
**You have a big list of multiple duplicate values now. Define a variable to get rid of those duplicates and return only the distinct values.**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//typing/@type ! tokenize(., ", ") ! tokenize(., " ") => distinct-values()`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    let $typeTokenComma := $type ! tokenize(., ", ")
    let $typeTokenSpace := $typeTokenComma ! tokenize(., " ")
    let $typeDist := $typeTokenSpace => distinct-values()
    return $typeDist
    ```
**Look at the return for the above list of distinct values. Do you see some duplicates? Here's a good opportunity to try the lower-case() or upper-case() function on your nodes before you send them to distinct-values. Do it. How many items do you see now in the sequence of values that you return?**
* XPath: `collection('/db/pokemonMap/pokemon')/element()//typing/@type ! tokenize(., ", ") ! tokenize(., " ") ! lower-case(.) => distinct-values()`
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    let $typeTokenComma := $type ! tokenize(., ", ")
    let $typeTokenSpace := $typeTokenComma ! tokenize(., " ")
    let $typeLower := $typeTokenSpace ! lower-case(.)
    let $typeDist := $typeLower => distinct-values()
    return $typeDist => string-join(", ")
    ```

## Question 5:
**Make a special for statement to create an index variable, to take each member of the distinct-values list of types one by one.**
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    let $typeToken := $type ! tokenize(., " ")
    let $typeLower := $typeToken ! lower-case(.)
    let $typeDist := $typeLower => distinct-values()
    for $p in $typeDist
    ```
**Define a variable with a let statement in the for loop that returns to the Pokemon XML collection and looks for all the landmark elements (inside the location elements).**
* FLWOR:
  * ```
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $structure := $pokemon/element()
    let $type := $structure//typing/@type/string()
    let $typeToken := $type ! tokenize(., " ")
    let $typeLower := $typeToken ! lower-case(.)
    let $typeDist := $typeLower => distinct-values()
    for $p in $typeDist
    
    ```
**Work-Around**
* FLWOR:
  * ```
    (: concat("Dragon: ", collection('/db/pokemonMap/pokemon')/pokemon[descendant::typing[matches(., "Dragon")]]//landmark/text() => distinct-values() => string-join(", ")) :)
    (: collection('/db/pokemonMap/pokemon')/pokemon//@type/string() ! lower-case(.) ! tokenize(., ", ") ! tokenize(., " ") => distinct-values() => string-join(", ") :)
    (: "grass, poison, fire, flying, water, bug, type(s), normal, electric, raichu, ground, fairy, psychic, fighting, rock, ice, dragon" :)
    let $pokemon := collection('/db/pokemonMap/pokemon')
    let $grass := $pokemon/pokemon[descendant::typing[matches(., "Grass")]]//landmark/text() => distinct-values()
    let $poison := $pokemon/pokemon[descendant::typing[matches(., "Posion")]]//landmark/text() => distinct-values()
    let $fire := $pokemon/pokemon[descendant::typing[matches(., "Fire")]]//landmark/text() => distinct-values()
    let $flying := $pokemon/pokemon[descendant::typing[matches(., "Flying")]]//landmark/text() => distinct-values()
    let $water := $pokemon/pokemon[descendant::typing[matches(., "Water")]]//landmark/text() => distinct-values()
    let $bug := $pokemon/pokemon[descendant::typing[matches(., "Bug")]]//landmark/text() => distinct-values()
    let $type := $pokemon/pokemon[descendant::typing[matches(., "Type")]]//landmark/text() => distinct-values()
    let $normal := $pokemon/pokemon[descendant::typing[matches(., "Normal")]]//landmark/text() => distinct-values()
    let $electric := $pokemon/pokemon[descendant::typing[matches(., "Electric")]]//landmark/text() => distinct-values()    
    let $raichu := $pokemon/pokemon[descendant::typing[matches(., "Raichu")]]//landmark/text() => distinct-values()
    let $fairy := $pokemon/pokemon[descendant::typing[matches(., "Fairy")]]//landmark/text() => distinct-values()    
    let $psychic := $pokemon/pokemon[descendant::typing[matches(., "Psychic")]]//landmark/text() => distinct-values()
    let $fighting := $pokemon/pokemon[descendant::typing[matches(., "Fighting")]]//landmark/text() => distinct-values()
    let $rock := $pokemon/pokemon[descendant::typing[matches(., "Rock")]]//landmark/text() => distinct-values()
    let $ice := $pokemon/pokemon[descendant::typing[matches(., "Ice")]]//landmark/text() => distinct-values()
    let $dragon := $pokemon/pokemon[descendant::typing[matches(., "Dragon")]]//landmark/text() => distinct-values()
    return (concat("TYPE: Grass :LANDMARK: ", $grass => string-join(", ")),
    concat("TYPE: Poison :LANDMARK: ", $poison => string-join(", ")), concat("TYPE: Fire :LANDMARK: ", $fire => string-join(", ")),
    concat("TYPE: Flying :LANDMARK: ", $flying => string-join(", ")), concat("TYPE: Water :LANDMARK: ", $water => string-join(", ")),
    concat("TYPE: Type :LANDMARK: ", $type => string-join(", ")), concat("TYPE: Bug :LANDMARK: ", $bug => string-join(", ")),
    concat("TYPE: Electric :LANDMARK: ", $electric => string-join(", ")), concat("TYPE: Normal :LANDMARK: ", $normal => string-join(", ")),
    concat("TYPE: Raichu :LANDMARK: ", $raichu => string-join(", ")), concat("TYPE: Fairy :LANDMARK: ", $fairy => string-join(", ")),
    concat("TYPE: Psychic :LANDMARK: ", $psychic => string-join(", ")), concat("TYPE: Fighting :LANDMARK: ", $fighting => string-join(" ")),
    concat("TYPE: Rock :LANDMARK: ", $rock => string-join(", ")), concat("TYPE: Ice :LANDMARK: ", $ice => string-join(", ")),
    concat("TYPE: Dragon :LANDMARK: ", $dragon => string-join(", ")))
    ```