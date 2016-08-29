declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $en := collection('/Users/ebb8/Documents/GitHub/TEI/P5/Source/Guidelines/en');
declare variable $fr := collection('/Users/ebb8/Documents/GitHub/TEI/P5/Source/Guidelines/fr');
declare variable $both := $en | $fr;
declare variable $atts := $both//@calendar | $both//@datingMethod;
declare variable $countAtts := count($atts);

<html>
<head><title>TEI Stuff</title></head>
<body>
<h1>@calendar and @datingMethod Values and their Files in the TEI-P5 Guidelines </h1>
<p>Count of all values: {$countAtts}
</p>
<table>
{
for $att in $atts
let $filePath := $att/parent::*/base-uri()
return 


<tr>
<td>{$att/string()}</td><td>{$filePath}</td>
</tr>
}
</table>
</body>
</html>