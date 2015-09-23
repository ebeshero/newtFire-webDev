function makeHrefDate() {
           var anchorLink =  document.getElementsByClassName('dateRef');
             for (var i = 0; i < anchorLink.length; i++) {
                 var date = new Date().toISOString();
                 var today = date.split("T")[0];

                 //We need to find the dates actually encoded in the syllabus. When today's date is not a class day,
                 //we need to return the nearest preceding class day.
                 //Ref: http://stackoverflow.com/questions/4443070/given-an-associative-array-of-date-strings-find-the-next-closest-date
                 //Ref 2: http://stackoverflow.com/questions/7394089/getting-next-closest-date-from-json
                 //2015-09-23 ebb: CAUTION: THIS MAY BREAK ON A DAY THAT ISN'T EQUAL TO A SYLLABUS DAY
                 var dateRow = document.querySelectorAll("tr[id]");
                 //grab attribute values in javascript, tokenize and convert into an array
                 for (var j = 0; j < dateRow.length; j++) {
                     var dateAnchor = dateRow[j].getAttribute("id");
                     var Tokens = dateAnchor.split("d");
                     var dateToken = Tokens[Tokens.length - 1];
                     var dates = [];
                     for (var k in dateToken) {
                         if (new Date(dateToken[k]) < today) {
                             dates.push(new Date(dateToken[k]));
                             var maxDate = Math.max.apply(null, dates);
                             maxDate = new Date(maxDate);
                             today = maxDate;
                         }
                     }
                 }

                 var att = document.createAttribute("href");
                 att.value = '#d' + today;

                 anchorLink[i].setAttributeNode(att);
             }
         }
         window.addEventListener('DOMContentLoaded', makeHrefDate, false);