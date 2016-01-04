function init()
{
    var anchors = document.getElementsByClassName("anchor");
    for(var i = 0; i < anchors.length; i++)
    {
        anchors[i].onmouseover = show_footnote;
        anchors[i].onclick = show_footnote;
        anchors[i].onmouseout = hide_footnote;
    }
    
    
/*THOUGHTS for retooling color-clicks: set a new var for tagname input (for the checkboxes).
var checkbox = document.getElementsByTagName("input:)
checkbox.onclick = */   
}

function show_footnote()
{
    var footnote = this.firstElementChild;
    footnote.style.display = "inline";
}
function hide_footnote()
{
    var footnote = this.firstElementChild;
    footnote.style.display = "none";
}
function link_to_footnotes()
{
    var fn_class = this.className;
    document.getElementsByClassName("fn_class");
    var text_body = document.getElementById("text_body");
    var footnotes = text_body.getElementsByClassName(fn_class);
    footnotes[0].style.display="inline";
}



    function toggle(target)
{
var classchange = document.getElementsByClassName(target);

{
var e;
for (e=0; e < classchange.length; e++)

{classchange[e].classList.toggle("on") }

}
}

/* This event listener now appears to be unncessary:

window.onload = function()
{
//document.getElementById("CItoggle").addEventListener('click' , toggle(target) );

var checkbox = document.getElementsByName(input);
var c;
for (c=0; c < checkbox.length; c++)
{checkbox[c].addEventListener('click' , toggle(target) );}
}
*/

/*function changeCIClass()
{
var CI = document.getElementsByClassName("interact");
var CItoggle = document.getElementById("CItoggle");

{
var e;
for (e=0; e < CI.length; e++)

{CI[e].classList.toggle("on") }

}
}

window.onload = function()
{
document.getElementById("CItoggle").addEventListener('click' , changeCIClass );
}
*/ 
 

function CHAR_toggle()
{
var chars = document.getElementsByClassName ("character")
if (chars[0].style.color != "#FF3300")
{
for (var i = 0, length = chars.length; i < length; i++) {
            chars[i].style.color = "#FF3300";
}
}
else {
  for (var i = 0, length = chars.length; i < length; i++) 
{chars[i].style.color = "";}  
}
}

function PL_toggle()
{
var places = document.getElementsByClassName ("place") 
if (places [0].style.color != "#3333CC")
{
for (var i = 0, length = places.length; i < length; i++) {
            places [i].style.color = "#3333CC";
}
}
else {
  for (var i = 0, length = places.length; i < length; i++) 
{places [i].style.color = "";}  
}
}

function OB_toggle()
{
var objects = document.getElementsByClassName ("object") 
if (objects [0].style.color != "#336600")
{
for (var i = 0, length = objects.length; i < length; i++) {
            objects [i].style.color = "#336600";
}
}
else {
  for (var i = 0, length = objects.length; i < length; i++) 
{objects [i].style.color = "";}  
}
}

function Concept_toggle()
{
var concepts = document.getElementsByClassName ("concept") 
if (concepts [0].style.color != "#993399")
{
for (var i = 0, length = concepts.length; i < length; i++) {
            concepts [i].style.color = "#993399";
}
}
else {
  for (var i = 0, length = concepts.length; i < length; i++) 
{concepts [i].style.color = "";}  
}
}


function Conflict_toggle()
{
var conflicts = document.getElementsByClassName ("conflict") 
if (conflicts [0].style.backgroundColor != "#C2A385")
{
for (var i = 0, length = conflicts.length; i < length; i++) {
            conflicts [i].style.backgroundColor = "#C2A385";
}
}
else {
  for (var i = 0, length = conflicts.length; i < length; i++) 
{conflicts [i].style.backgroundColor = "";}  
}
}

function Blood_toggle()
{
var bloods = document.getElementsByClassName ("blood") 
if (bloods [0].style.backgroundColor != "#E69980")
{
for (var i = 0, length = bloods.length; i < length; i++) {
            bloods [i].style.backgroundColor = "#E69980";
}
}
else {
  for (var i = 0, length = bloods.length; i < length; i++) 
{bloods [i].style.backgroundColor = "";}  
}
}

function Imp_toggle()
{
var imps = document.getElementsByClassName ("imp") 
if (imps [0].style.backgroundColor != "#D1B2F0")
{
for (var i = 0, length = imps.length; i < length; i++) {
            imps [i].style.backgroundColor = "#D1B2F0";
}
}
else {
  for (var i = 0, length = imps.length; i < length; i++) 
{imps [i].style.backgroundColor = "";}  
}
}

function Trade_toggle()
{
var trades = document.getElementsByClassName ("trade") 
if (trades [0].style.backgroundColor != "#99B280")
{
for (var i = 0, length = trades.length; i < length; i++) {
            trades [i].style.backgroundColor = "#99B280";
}
}
else {
  for (var i = 0, length = trades.length; i < length; i++) 
{trades [i].style.backgroundColor = "";}  
}
}

function Cer_toggle()
{
var cers = document.getElementsByClassName ("cer") 
if (cers [0].style.backgroundColor != "#CCCCFF")
{
for (var i = 0, length = cers.length; i < length; i++) {
            cers [i].style.backgroundColor = "#CCCCFF";
}
}
else {
  for (var i = 0, length = cers.length; i < length; i++) 
{cers [i].style.backgroundColor = "";}  
}
}

function Affin_toggle()
{
var affins = document.getElementsByClassName ("affin") 
if (affins [0].style.backgroundColor != "#C4F1FF")
{
for (var i = 0, length = affins.length; i < length; i++) {
            affins [i].style.backgroundColor = "#C4F1FF";
}
}
else {
  for (var i = 0, length = affins.length; i < length; i++) 
{affins [i].style.backgroundColor = "";}  
}
}



window.onload = init;