$(function() {
  var faye = new Faye.Client('http://localhost:9292/faye');
  faye.subscribe('/chatposts/show', function (data) {
    eval(data);
  });
});