$(function() {
  var list = ["遊戯王", "ヴァンガード", "Z/X", "WIXOSS"]
  
  function resetStyle() {
    $(".header__list--categories").css({
      "color":"",
      "background-color":"",
      "font-weight":""
    });
  }

  function styleChange(header) {
    resetStyle();
    $(header).css({
      "color":"#fff",
      "background-color":"rgb(119, 119, 119)",
      "font-weight":"bold"
    });
  }

  function resetAppend(){
    $(".not-article").remove();
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

  function resetClick() {
    resetStyle();
    resetAppend();
    $(".article").show();
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
      val = $(".category__name").text();
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
});
