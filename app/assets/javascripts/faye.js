$(function() {
  var faye = new Faye.Client('http://livepost-backend/faye');
  faye.subscribe('/chatlogs/update', function (data) {
    eval(data);
  });
});