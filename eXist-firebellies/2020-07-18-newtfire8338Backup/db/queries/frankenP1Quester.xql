xquery version "3.1";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";
<html>
    <head><title>Frankenstein Variorum Data</title></head>
    <body>

{
let $frankenColl as document-node()+ := collection('/db/P1-output')
let $apps := $frankenColl//tei:app
for $a in $apps
let $rdgGrps := $a//tei:rdgGrp
return
    <section id="{$a/@xml:id/string()}">
    <h3>Section: {$a/@xml:id/string()}</h3>
            
            {for $g in $rdgGrps
             let $groupID := $g/@xml:id/string()
             let $rdgs := $g/tei:rdg
            return
                <div class="rdgGrp">
              <h4 id="{$groupID}">Reading Group: {$groupID}</h4>
                <table id="{$groupID}">
                    
                     { 
                       for $r in $rdgs
                      return
                          <tr id="{$r/@wit}">
                           <td class="wit">{$r/@wit}</td>
                           <td class="passage">{$r}</td>
                           </tr>   
                     }
                </table>
            </div>
            }
            </section>
}
</body>
</html>