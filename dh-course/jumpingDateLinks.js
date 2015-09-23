 function makeHrefDate() {
           var anchorLink =  document.getElementsByClassName('dateRef');
             for (var i = 0; i < anchorLink.length; i++) {
                 var date = new Date().toISOString();
                 var shorter = date.split("T")[0];
                 var att = document.createAttribute("href");
                 att.value = '#d' + shorter;
                 console.log([att]);
                 anchorLink[i].setAttributeNode(att);
             }
         }
         window.addEventListener('DOMContentLoaded', makeHrefDate, false);