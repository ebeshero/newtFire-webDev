xquery version "3.1";
let $table := doc('/db/railroad/companytable.xml')
let $plants := $table//company/plant
for $plant in $plants
where $plant = .
order by $plant/ancestor::company/name
return concat($plant/ancestor::company/name,', ',($plant/plantname),' = ',$plant/@plantid)
