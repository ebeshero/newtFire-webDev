# XQuery Exercise 1

## Question 1
**Find all of the main titles of each of the 42 Shakespeare plays in the collection, by stepping down the descendant axis from the collection.**
  * XPath: `collection('/db/apps/shakespeare/data/')/TEI//titleStmt/title`
  * FLWOR:
  ```
  let $shake := collection('/db/apps/shakespeare/data')
  let $title := $shake//titleStmt/title
  return $title
  ```
## Question 2
**Modify your XPath above to return just the text of the titles, without the tags.**
  * XPath: `collection('/db/apps/shakespeare/data/')/TEI//titleStmt/title/text()`
  * FLWOR:
  ```
  let $shake := collection('/db/apps/shakespeare/data')/TEI
  let $title := $shake//titleStmt/title
  return $title/text()
  ```

## Question 3
**Write an XPath expression that isolates the root element TEI of each play.**
  * XPath: `collection('/db/apps/shakespeare/data')/TEI`
  * FLWOR:
  ```
  let $shakes := collection('/db/apps/shakespeare/data/')/TEI
  return $shakes
  ```

## Question 4
**Write an expression that locates a play holding a speaker named Ferdinand. Which play is it? Record your expression.**
  * XPath: `collection('/db/apps/shakespeare/data')/TEI[descendant::speaker[matches(., "Ferdinand")]]//titleStmt`
  * FLWOR:
  ```
  
  ```
  * Love's Labour's Lost
  * The Tempest

## Question 5
**Modify your expression to return only the main title of that play, and record your expression.**
  * `collection('/db/apps/shakespeare/data')/TEI[descendant::speaker[matches(., "Ferdinand")]]//titleStmt/title/text()`

## Question 6
**Now, let’s see if we can find three very special plays that contains a count of more than 58 unique (distinct) speakers!**
  * `collection('/db/apps/shakespeare/data')/TEI[count(distinct-values(descendant::speaker)) gt 58]//titleStmt/title`

## Question 7
**Modify your solution to the preceding question to return just the text of the three play titles, without the <title> tags.**
  * `collection('/db/apps/shakespeare/data')/TEI[count(distinct-values(descendant::speaker)) gt 58]//titleStmt/title/text()`
 **Try appending base-uri() to your XQuery expression and run it: What result do you see in the output window, and what is it telling you?**
  * `collection('/db/apps/shakespeare/data')/TEI[count(distinct-values(descendant::speaker)) gt 58]//titleStmt/title/base-uri()`
  * This finds the file path to each file in the directory
**How would you write your XQuery to return just the last part of the results of the base-uri() function, the part that appears after the last forward slash character? Record your expression.**
  * `collection('/db/apps/shakespeare/data')/TEI[count(distinct-values(descendant::speaker)) gt 58]//titleStmt/title/tokenize(base-uri(), "/")[last()]`

## Question 8
**FLWOR Statement or XPath expression? Whichever way you chose to write your XQuery in the previous steps, try the other way and see if you can duplicate your results. Record your XQuery expressions in your text file.**         
