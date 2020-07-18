xquery version "3.1";
(: lm: My idea was to make a table with the distinct values of @place on action tags and count how many times each titan shows up at that location. I also wanted to make a separate column on that table of the with attribute and episode numbers. I defined what I thought I would need to make this happen, but I don't understand where I should go from here. :)
let $teetit := collection('/db/teentitans/season2')
let $actionLoc := $teetit//action/@place/string()
let $distLoc := $actionLoc => distinct-values()
let $charWith := $teetit//action/@with/string()
let $actionMrkr := $teetit//action/@mrkr/string()
let $titans := $actionMrkr => distinct-values()
let $locTitan := $actionLoc/element::action/$actionMrkr
(: lm: This is where I'm getting stuck, how to find the relationship between the action and the titan to return the location and which titan has an action at that location. :)
return $locTitan



