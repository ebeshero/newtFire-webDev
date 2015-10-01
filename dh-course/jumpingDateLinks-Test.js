function makeHrefDate() {
    /* 2015-09-30: Thanks to David Birnbaum for revising this JavaScript to make it functional on dates not marked in the syllabus! 
    * This JavaScript involves testing for today's date, and then seeking either a matching date marked in an attribute values on the syllabus 
    * or the earliest preceding date when today is not marked in the syllabus.
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
     *  Currently generates "dnope" as the @href value is the current date is before the beginning of the semester
     *  Currently jumps to the end after the end of the semester; is this what you want?
     *  */
    var anchorLink = document.getElementById('dateRef');
    var today = new Date().toISOString().split("T")[0];
    //Comment out the preceding line and uncomment the following one for testing
    //var today = '2016-10-01';
    var sessions = document.getElementsByTagName('tr');
    var dates =[]
    for (var i = 0, count = sessions.length; i < count; i++) {
        if (sessions[i].id != '') {
            dates.push(sessions[i].id.substr(1));
        }
    }
    if (dates.indexOf(today) != -1) {
        target = today;
    } else {
        dates.reverse();
        for (i = 0, count = dates.length; i < count; i++) {
            if (dates[i] < today) {
                target = dates[i];
                break;
            }
        }
        if (typeof target === 'undefined') {
            target = 'nope';
        }
        anchorLink.setAttribute('href', '#d' + target);
    }
}
window.addEventListener('DOMContentLoaded', makeHrefDate, false);