// This script allows bootstrap 3 popover functionality
$(function() {
	$('[data-toggle="popover-right"]').popover({'placement': 'right', html: 'true'});
	$('[data-toggle="popover-bottom"]').popover({trigger: 'hover', 'placement': 'bottom'});
  $('[data-toggle="popover-top"]').popover({trigger: 'hover', 'placement': 'top'});
});