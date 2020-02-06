$(function() {
  var list = ["ヴァンガード", "ヴァイスシュヴァルツ", "バディファイト", "Z/X"]
  
  function resetStyle() {
    $(".header__list--categories").css({
      "color":"",
      "background-color":"",
      "font-weight":"",
      "border-top":""
    });
    // $(".wrapper").css({
    //   "background-color":"",
    // });
    // $(".header__title").css({
    //   "background-color":"",
    // });
  }

  function resetAppend(){
    $(".not-article").remove();
  }

  function resetClick() {
    resetStyle();
    resetAppend();
    $(".article").show();
  }

  function styleChange(header) {
    resetStyle();
    $(header).css({
      "color":"#fff",
      "background-color":"rgb(119, 119, 119)",
      "font-weight":"bold",
      "border-top":"0.215em solid #666"
    });
    // $(".wrapper").css({
    //   "background-color":"rosybrown",
    // });
    // $(".header__title").css({
    //   "background-color":"indianred",
    // });
  }

  function append(word) {
    resetAppend();
    let item = $('<div class="not-article">').append(word);
    $(".articles").append(item);
    $(".not-article").css({
      "color":"#333",
      "font-size":"24px",
      "text-align":"center",
      "margin-top":"15px"
    });
  }

  $(".header__list--categories").on("click", function(e) {
    e.preventDefault();

    if ($(this).css("background-color") == "rgb(119, 119, 119)") {
      resetClick();
      return;
    } 

    styleChange(this);

    var category = $(this).text();
    $(list).each(function(){
      if (category.match(list)) {
        return category;
      }
    });

    $(".article").each(function(){
      var val = $(this).text();
      if (val.match(category)) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });

    if ($($(".article").is(":visible")).length == 0) {
      append("該当する記事はありません。");
    } else {
      resetAppend();
    }
  });

  $(".copyright__link").on("click", function(e) {
    e.preventDefault();
    if ($(".balloon").is(":hidden")) {
      $(".balloon").show();
    } else {
      $(".balloon").hide();
    }
  });
});
