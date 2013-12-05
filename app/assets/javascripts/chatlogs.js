$(document).ready(function(){
var objDiv = document.getElementById("chatscroll");
objDiv.scrollTop = objDiv.scrollHeight;
});

$(function() {
	$('[data-toggle="popover-right"]').popover({'show','placement': 'right', html: 'true'});
	$('[data-toggle="popover-bottom"]').popover({'placement': 'bottom', html: 'true'});
	$('[data-toggle="popover-top"]').popover({trigger: 'hover', 'placement': 'top'});
});
$(document).ready(function(){
        $("#menu-close").click(function(e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });
      $(function() {
        $('a[href*=#]:not([href=#])').click(function() {
          if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') 
            || location.hostname == this.hostname) {

            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
              $('html,body').animate({
                scrollTop: target.offset().top
              }, 1000);
              return false;
            }
          }
        });
      });});