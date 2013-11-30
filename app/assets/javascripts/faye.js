$(function() {
  var faye = new Faye.Client('http://livepost.herokuapp.com:9292/faye');
  faye.subscribe('/chatlogs/update', function (data) {
    eval(data);
  });
});