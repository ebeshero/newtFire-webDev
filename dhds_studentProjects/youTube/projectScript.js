function init() 
	{
	var button = document.getElementsByTagName("button");
	button[0].addEventListener('click', setMood, false);
	}

function setMood()
	{
	var comment = document.getElementsByClassName('positive');
	for (var i = 0; i < comment.length; i++)
               	comment[i].classList.toggle("on");

	var comment = document.getElementsByClassName('negative');
	for (var i = 0; i < comment.length; i++)
                comment[i].classList.toggle("on");

	var comment = document.getElementsByClassName('neutral');
	for (var i = 0; i < comment.length; i++)
                comment[i].classList.toggle("on");
	}
	
window.onload = init;
