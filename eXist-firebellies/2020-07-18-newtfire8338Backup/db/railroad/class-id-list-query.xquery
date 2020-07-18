xquery version "3.1";
let $table := doc('/db/railroad/carclasstable.xml')
let $classes := $table//class
for $class in $classes
return concat($class/road,' ',($class/classname),' = ',$class/classid)
