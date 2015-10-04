/* 2015-10-03: Thanks to David Birnbaum for revising this JavaScript.
    * This script involves pulling all the dates coded into my syllabus, putting them into an array and checking to see if today's date matches or not.
    * If the date doesn't match, the javascript reverses the syllabus date array from latest to earliest and pulls the closest date preceding today. 
    * 2015-10-03 ebb: I've now revised this so that after the last date on the syllabus, the JavaScript returns to the first date, and if it's before the beginning of the semester, it returns to the first date as well.
*/
function makeHrefDate() {
    /*
     *  Variables:
     *
     *  anchorLink: element that will get the new @href
     *  today: today's date as a string in yyyy-mm-dd format
     *  sessions: all <tr> elements (some of which are don't include dates; these get filtered out later)
     *  dates: array of all dates as strings in yyyy-mm-dd format
     *  target: eventual value of @href attribute
     *
     *  To fix:
     *  Currently push all dates onto sessions array; could filter out late ones first
 */
    var anchorLink = document.getElementById('dateRef');
    // var today = new Date().toISOString().split("T")[0];
    //Comment out the preceding line and uncomment the following one for testing
    var today = '2013-10-02';
    var sessions = document.getElementsByTagName('tr');
    var dates =[];
    for (var i = 0, count = sessions.length; i < count; i++) {
        if (sessions[i].id != '') {
            dates.push(sessions[i].id.substr(1));
        }
    }
    if (dates.indexOf(today) != -1) {
        var target = today;
    } else {
        dates.reverse();
        for (i = 0, count = dates.length; i < count; i++) {
            if (dates[i] < today && today < dates[0] ) {
                target = dates[i];
                break;
            }
            if (today > dates[0]) {
           
                target=dates[dates.length - 1];
                break;
                
            }
        }
        if (typeof target === 'undefined') {
            /*target = 'nope';*/
            target=dates[dates.length - 1]
            /*ebb I think this will pull the first date in the array, or the first date on the syllabus.*/
        }
    }
    console.log('today  = ' + today + ' (type = ' + typeof today + ')');
    console.log('target = ' + target + ' (type = ' + typeof target + ')');
    console.log('dates = ' + dates + ' (type = ' + typeof dates + ')');
    console.log(dates.indexOf(today));
    anchorLink.setAttribute('href', '#d' + target);
}
window.addEventListener('DOMContentLoaded', makeHrefDate, false);