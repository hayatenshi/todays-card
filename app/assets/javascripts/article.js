$(function() {
  var list = [
    "ヴァンガード",
    "ヴァイスシュヴァルツ",
    "バディファイト",
    "Z/X",
  ]

  function resetStyle() {
    $(".header__list--categories").css({
      "color":"",
      "background-color":"",
      "font-weight":"",
      "border-top":""
    });
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
  }

  function append(word) {
    resetAppend();
    $(".articles").append($('<div class="not-article">').append(word));
  }

  $(".header__list--categories").on("click", function(e) {
    e.preventDefault();

    // 直前に同じカテゴリを押しているならその変更を打ち消す
    if ($(this).css("background-color") == "rgb(119, 119, 119)") {
      resetClick();
      return;
    } 

    // 押されたカテゴリのCSSを変更する
    styleChange(this);

    // 押されたカテゴリを判別する
    var category = $(this).text();
    $(list).each(function(){
      if (category.match(list)) {
        return category;
      }
    });

    // 押されたカテゴリと同カテゴリだけ表示する
    $(".article").each(function(){
      var val = $(this).text();
      if (val.match(category)) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });

    // 表示されている記事が１つもない場合の表示
    if ($($(".article").is(":visible")).length == 0) {
      append("該当する記事はありません。");
    } else {
      resetAppend();
    }
  });

  // "著作権について"をクリックでバルーンのON,OFFを切り替える
  $(".copyright__link").on("click", function(e) {
    e.preventDefault();
    if ($(".balloon").is(":hidden")) {
      $(".balloon").show();
    } else {
      $(".balloon").hide();
    }
  });
});
