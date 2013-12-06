$(document).ready(function(){
var objDiv = document.getElementById("chatscroll");
objDiv.scrollTop = objDiv.scrollHeight;
});

$(function() {
	$('[data-toggle="popover-right"]').popover({'placement': 'right', html: 'true'});
	$('[data-toggle="popover-bottom"]').popover({'placement': 'bottom', html: 'true'});
	$('[data-toggle="popover-top"]').popover({trigger: 'hover', 'placement': 'top'});
});