// This script will auto-scroll the chat window to the lastest post

window.onload=toBottom;

function toBottom()
{
	document.getElementById('chatscroll').scrollTop = 9999999;
}