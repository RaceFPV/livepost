$(function() {
  var faye = new Faye.Client('http://livepost-backend.herokuapp.com/faye');
  faye.subscribe('/chatlogs/update', function (data) {
    eval(data);
  });
});