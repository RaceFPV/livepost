// This script will auto-scroll the chat window to the lastest post

window.onload=toBottom;

function toBottom()
{
	document.getElementById('chatscroll').scrollTop = 9999999;
}

//before we leave the window change the count
window.onunload = window.onbeforeunload = (function(){
	$.ajax({
	url:    leftchatpath,
	type:   'get',
	async:  false
	});
});