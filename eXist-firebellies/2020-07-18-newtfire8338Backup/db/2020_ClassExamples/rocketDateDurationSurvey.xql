xquery version "3.1";
declare namespace ebb="http://newtfire.org";
declare variable $rocketColl as node()+ := collection('/db/rocket/');
declare variable $launchDateTimes as xs:dateTime+ := $rocketColl//launch/@sDateTime ! xs:dateTime(.) => sort();
declare variable $maxDateTime as xs:dateTime := $launchDateTimes => max();
declare variable $minDateTime as xs:dateTime := $launchDateTimes => min();

(: ebb: This script introduces you to user-defined functions in XQuery. 
These can be useful for taking values from your XQuery variables and performing a conversion, as we're doing here.
Since the Rocket Launches project has multiple attributes encoding launch dates and landing dates in the same xs:dateTime format, 
and since they work with the xs:duration datatype too, for coding how long a mission lasted, 
we can work with these data to do "date arithmetic" to make simple graphs and charts if we can convert it to a simple decimal notation.
Let's start reading this by skipping past the section I've marked off with asterisks as USER-DEFINED FUNCTIONS, and come back to it :) 

(: **************** USER-DEFINED FUNCTIONS **************************:) 
(: CONVERT DURATION TO DECIMAL :)
(: ebb: This user-defined function will convert the xs:duration datatype into a decimal value. 
 : Our function takes one input argument, a duration value, and it will output a decimal value. 
 : It then analyzes the xs:duration, unpacking its parts into four variables: 
 : $d (a value for the number of days), $h (a value for the number of hours),
 : $m (for the number of minutes), and $s (for the number of seconds). 
 : Next, here is what we're calculating to create a decimal value: 
 : We'll retain the total number of days as whole number, and convert the
 : rest to a decimal. There are 24 hours in a day. (Divide the $h portion by 24) and add it to the days.
 : There are 60 minutes in an hour, and 60 * 24 gives the total number of minutes in a day. 
 : So we divide the $m portion by 60 * 24) and add it to hours.
 : There are 60 seconds in a minute. and 60 * 60 * 24 gives us the total number of seconds in a day. 
 : We then divide the $s portion by 60 * 60 * 24 and add that value to minutes and hours to give us 
 : a decimal conversion of days in the duration. 
 : :)
 
declare function ebb:durationConverter($dur as xs:duration?)
as xs:decimal?
{
let $d as xs:integer := days-from-duration($dur)
let $h as xs:integer := hours-from-duration($dur)
let $m as xs:integer := minutes-from-duration($dur)
let $s as xs:decimal := seconds-from-duration($dur)
let $durDec as xs:decimal := $d + $h div (24) + $m div (24 * 60) + $s div (24 * 60 * 60)
return $durDec
}; 


(: CONVERT DATETIME to DECIMAL :)
(: 2020-04-01 ebb: UPDATING this so we're using pure date arithmetic rather than an estimated base date-in-year divided by 365. Our timeline will be based on a quantity of days separating each rocket launch from the earliest rocket launch.  :)


declare function ebb:dateDecimalConverter($dT as xs:dateTime?) 
as xs:decimal?
{
let $dateAsDuration as xs:duration := $dT - $minDateTime
let $dateAsDurDec as xs:decimal := ebb:durationConverter($dateAsDuration)
return $dateAsDurDec
};


(: *******************END USER-DEFINED FUNCTIONS ********************** :)

for $l in $launchDateTimes
(: ebb: To do date arithmetic, take a look at these functions: https://www.w3.org/TR/xpath-functions-31/#dates-times
 : We'll write a user-defined function to convert this datatype into a decimal notation. :)
let $lDec as xs:decimal := ebb:dateDecimalConverter($l)
let $m as element() := $rocketColl//launch[@sDateTime = $l]/preceding-sibling::sts
let $mID as xs:string := $m  ! tokenize(., ':')[1]

let $duration as xs:duration := $m/following-sibling::duration/@time ! xs:duration(.)
(: ebb: To do duration arithmetic, start by looking at the functions here: 
: https://www.w3.org/TR/xpath-functions-31/#durations
 : Let's try representing durations in terms of days with a decimal. 
 : We'll write a user-defined function to convert hours, minutes, and seconds into a fraction of the day. :)
(: ebb: In the next line, we send our variables to our user-defined function for turning date datatypes into decimal values. :)
let $durDayDec as xs:decimal := ebb:durationConverter($duration) 

return concat('Launch Date: ', $l, ', mission: ', $mID, ': This Launch Decimal Date: ', $lDec, 
': Duration: ', $duration, ': Decimal Notation:', $durDayDec)