/* 2017-04-06 ebb: JavaScript to respond to checkboxes in HTML input elements with @id attributes, to show/hide SVG elements whose @id attributes contain matching substrings. */
window.onload = init;
/* or window.addEventListener('DOMContentLoaded',init,false); */
function init() {
window.alert("hi there!");
  var checkboxSelect = document.querySelectorAll('input[id]');
  for (var i = 0; i < checkboxSelect.length; i++) {
  checkboxSelect[i].addEventListener('click', lineShow, true);
    } 
  }

function lineShow() {
    /*  window.alert("function lineShow is firing, and this.id is: " + this.id); */
     var svgID = 'SVG_' + this.id
{
          /*  alert("CheckBox checked."); */
            svgLine = document.getElementById(svgID);
  
  if (svgLine.style.display == 'block') {
        svgLine.style.display = 'none';
    } else {
        svgLine.style.display = 'block';
    }
            ;
        } 
    
    
}
