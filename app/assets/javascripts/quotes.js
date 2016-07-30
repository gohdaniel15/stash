$(document).ready(function() {
  $('#get-joke').click(function() {
    $.getJSON("http://api.icndb.com/jokes/random", function(object) {
      $(".content").html(JSON.stringify(object.value.joke));
    });
  });

  $('#get-quote').click(function() {
    $.getJSON("http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=jsonp&jsonp=?", function(object) {
      $(".content").html(JSON.stringify(object.quoteText));
      $(".content").append(JSON.stringify(object.quoteAuthor).replace(/\"/g, ""));
    });
  });
});
