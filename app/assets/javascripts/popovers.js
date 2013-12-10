// This script allows bootstrap 3 popover functionality
$(function() {
	$('[data-toggle="popover-right"]').popover({'placement': 'right', html: 'true'});
	$('[data-toggle="popover-bottom"]').popover({'placement': 'bottom', html: 'true'});
	$('[data-toggle="popover-top"]').popover({trigger: 'hover', 'placement': 'top'});
});