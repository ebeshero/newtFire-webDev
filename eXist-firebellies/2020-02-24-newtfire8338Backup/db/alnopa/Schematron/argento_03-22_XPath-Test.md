Argento XPath Test Answers

1. Inspect one or two Banksy XML files to see where the titles of Banksy artwork are encoded. (Hint: look for this inside a <sourceDesc> element. Write an expression to return all of these titles, and record it on your test file.
  * ```
    let $banksy := collection("banksy_XML/?select=*.xml")
    let $titles := $banksy//sourceDesc//title => sort()
    return $titles
    ```

2. Write an expression to return all title elements that include two or more capital letters in a row. (Hint: you will need to use an XPath function that works with regular expressions to locate these.) Record your expression.
  * ```
    let $banksy := collection("banksy_XML/?select=*.xml")
    let $titles := $banksy//sourceDesc//title
    let $twoCaps := $titles[matches(., "[A-Z]{2,}")]
    return $twoCaps
    ```

3. Next, we will look for files that have locations encoded in them. Some of these have empty text nodes in the <location> element and we want to filter those out of our search.
  * Write an expression using a for loop that lets us look at each file in the banksy collection, one by one.
    * ```
      let $banksy := collection("banksy_XML/?select=*.xml")[descendant::location]
      let $titles := $banksy//sourceDesc//title => sort()
      for $t in $titles
      return $t
      ```
  * Then, work with your for-loop variable, and write expression(s) to help you return each file that has a location element that has more than zero characters of text in its text node.
    * ```
      let $banksy := collection("banksy_XML/?select=*.xml")[descendant::location]
      let $titles := $banksy//sourceDesc//title => sort()
      for $t in $titles
      let $locations := $banksy//sourceDesc[descendant::title[string() = $t]]//location
      let $locationString := $locations[string-length() gt 0]
      return $locationString
      ```
  * Now, return the titles of banksy's artworks from these files where locations are coded.
    * ```
      let $banksy := collection("banksy_XML/?select=*.xml")[descendant::location]
      let $titles := $banksy//sourceDesc//title => sort()
      for $t in $titles
      let $locations := $banksy//sourceDesc[descendant::title[string() = $t]]//location
      let $locationString := $locations[string-length() gt 0]
      for $l in $locationString
      let $locationTitle := $locationString/preceding-sibling::title
      return concat($locationTitle, " [", $locationString, "] &#10;")
      ```

4. Now let's look at the lengths of Banksy artwork titles and locate the shortest and longest title in the whole Banksy collection. Record your expressions to determine this here. (Hint: you will need to work with XPath functions that tell you how long a string is, and that calculate the maximum and minimum of a sequence of results.
  * ```
    let $banksy := collection("banksy_XML/?select=*.xml")
    let $titles := $banksy//sourceDesc//title
    let $titlesLength := $titles/string() ! string-length(.)
    let $titleMax := $titlesLength => max()
    let $titleMaxMatch := $banksy//sourceDesc//title[string-length() = $titleMax]/string()
    let $titleMin := $titlesLength => min()
    let $titleMinMatch := $banksy//sourceDesc//title[string-length() = $titleMin]/string()
    return concat("&#10;", "String-Length", "&#10;", "Max: ", $titleMaxMatch => string-join("; "), "&#10;", "Min: ", $titleMinMatch => string-join("; "))
    ```

5. Let's look at the filenames of the Banksy collection. Use base-uri() to return each filepath in the collection.
  * ```
    let $banksy := collection("banksy_XML/?select=*.xml")
    let $titles := $banksy//sourceDesc//title
    let $baseURI := $titles/base-uri()
    return $baseURI => string-join("&#10;")
    ```
  * Now, write expressions to return only the filenames (eliminating the rest of the filepath). Hint: There are a few different ways to do this, but you may want to try working with the tokenize() function.
    * ```
      let $banksy := collection("banksy_XML/?select=*.xml")
      let $titles := $banksy//sourceDesc//title
      let $baseURI := $titles/base-uri()
      let $baseToken := $baseURI ! tokenize(., '/')[last()]
      return $baseToken => string-join("&#10;")
      ```