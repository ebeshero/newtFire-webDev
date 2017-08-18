xquery version "3.0";
declare default element namespace "http://www.w3.org/2000/svg"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $lettersColl := collection('/db/mitford/letters');
declare variable $letterFiles := $lettersColl/*;
declare variable $letterDates := $lettersColl//tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1];
declare variable $HaydonRefs := $lettersColl//tei:titleStmt/tei:title//tei:persName[@ref="#Haydon"];
declare variable $countHaydonRefs := count($HaydonRefs/@ref/string(.));
declare variable $distinctYears := distinct-values($letterDates);
declare variable $DYears_Integers := 
  for $i in $distinctYears
  order by $i ascending
  return xs:integer($i);
(:ebb: Notice that I can make a variable's value be calculated by a FLWOR statement.:)
declare variable $Years_in_Coll :=
   let $maxDY := max($distinctYears)
   let $minDY := min($distinctYears)
   return xs:integer($maxDY) - xs:integer($minDY);
(:ebb: The variable calculation above gives me the total number of years represented in the collection. :)
declare variable $CountHaydonInYear := 
     for $i in $distinctYears
     let $HaydonPerYear := $HaydonRefs[ancestor::tei:teiHeader//tei:msDesc//tei:head/tei:date/@when/tokenize(string(), '-')[1] = $i]
     let $countHPY := count($HaydonPerYear)
     order by $countHPY descending
     return $countHPY;
declare variable $maxHaydonInYear := max($CountHaydonInYear);
(:ebb: In the two variables above, I first return an **array**, or a list of the number of Haydon letters written in each year, with the for-loop. In the next variable, I ask for the maximum value in that for-loop, and that's useful for me to see because it tells me the largest value I'll want to plot. :)
(:ebb: The next variables  :)
declare variable $Year_Space := 100;
declare variable $Year_Space_Graph2 := 50;
declare variable $LetterCount_Space := 10;
declare variable $barWidth := 25;
declare variable $graph1_Ytranslate := $maxHaydonInYear * $LetterCount_Space + 5* $LetterCount_Space;
declare variable $graph2_Ytranslate := 2.5 * $graph1_Ytranslate;
declare variable $centeredHeading := ($Years_in_Coll * $Year_Space + 2* $Year_Space) div 2;
($graph2_Ytranslate, $centeredHeading)
