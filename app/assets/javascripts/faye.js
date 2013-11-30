$(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/chatlogs/update', function (data) {
    eval(data);
  });
});