xquery version "3.1";
declare option exist:serialize "method=text media-type=text/plain omit-xml-declaration=yes";
declare variable $hello as xs:string := 'Hi';
declare variable $name as xs:string := 'Greg';
string-join(($hello, $name), ', ')