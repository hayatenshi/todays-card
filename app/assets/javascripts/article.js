$(function() {
  var list = [
    "ヴァンガード",
    "ヴァイスシュヴァルツ",
    "バディファイト",
  ]

  // 初回設定
  var today = new Date();
  var day = (today.getFullYear() + "年 " + (today.getMonth() + 1) + "月" + today.getDate() + "日").match(/\d{4}年 \d月/, "");
  let clicked = false;
  articleShowHide();

  // 今月の記事のみ表示させる
  function articleShowHide() {
    $(".article").each(function(){
      var val = $(this).text();
      if (val.match(day)) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
    clicked = false;
    notArticleCheck();
  }

  // 表示する記事がない場合の文章作成
  function append(word) {
    resetAppend();
    var item =`
              <div class="not-article">
                ${word}
              </div>
              `
    $(".articles").append(item);
  }

  // 表示できる記事があるか判定する
  function notArticleCheck() {
    if ($($(".article").is(":visible")).length == 0) {
      append("該当する記事はありません。");
    } else {
      resetAppend();
    }
  }

  // カテゴリーリストの変更後cssを打ち消す
  function resetStyle() {
    $(".header__list--categories").css({
      "color":"",
      "background-color":"",
      "font-weight":"",
      "border-top":""
    });
  }

  // 追加したnot-articleを消す
  function resetAppend() {
    $(".not-article").remove();
  }

  // カテゴリーリストの変更を打ち消す
  function resetClick() {
    resetStyle();
    resetAppend();
    if (clicked) {
      $(".article").show();
    } else {
      articleShowHide();
    }
  }

  // カテゴリーリストのcssを変更する
  function styleChange(header) {
    resetStyle();
    $(header).css({
      "color":"#fff",
      "background-color":"rgb(119, 119, 119)",
      "font-weight":"bold",
      "border-top":"0.215em solid #666"
    });
  }

  // デートボタンの変更を打ち消す
  function resetStyle2(header) {
    $(header).text("今月の記事表示中");
    $(header).css({
      "color":"",
      "background-color":"",
      "font-weight":"",
      "border-top":""
    });
    $(".wrapper").css({"background-color":""});
    $(".header__title").css({"background-color":""});
  }

  // デートボタンのcssを変更する
  function styleChange2(header) {
    resetStyle2();
    $(header).text("全記事表示中");
    $(header).css({
      "color":"#fff",
      "background-color":"rgb(130, 130, 130)",
      "font-weight":"bold",
      "border-top":"0.215em solid #666"
    });
    $(".wrapper").css({"background-color":"rgb(255, 150, 150)"});
    $(".header__title").css({"background-color":"rgb(255, 100, 100)"});
  }

  // カテゴリーボタンを押した場合に発動する
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
      if (clicked) {
        if (val.match(category)) {
          $(this).show();
        } else {
          $(this).hide();
        }
      } else {
        if (val.match(category) && val.match(day)) {
          $(this).show();
        } else {
          $(this).hide();
        }
      }
    });
    notArticleCheck();
  });

  // デートボタンを押した場合に発動する
  $(".header__list--date").on("click", function(e) {
    e.preventDefault();
    resetClick();

    // すでに押されている場合にそれを打ち消す
    if (clicked) {
      resetStyle2(this);
      articleShowHide();
      return;
    } 

    clicked = true;
    styleChange2(this);
    $(".article").show();
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
