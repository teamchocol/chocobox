// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage

//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-sprockets
//= require cropper.min.js
//= require jquery-cropper.min.js
//= require activestorage
//= require turbolinks
//= require jquery_ujs
//= require Chart.min
//= require_tree .

$(function(){
  $('theTarget').slick({
      // アクセシビリティ。左右ボタンで画像の切り替えをできるかどうか
      accessibility: true,
      // 自動再生。trueで自動再生される。
      autoplay: true,
      // 自動再生で切り替えをする時間
      autoplaySpeed: 100000,
      // 自動再生や左右の矢印でスライドするスピード
      speed: 100,
      // 自動再生時にスライドのエリアにマウスオンで一時停止するかどうか
      pauseOnHover: true,
      // 自動再生時にドットにマウスオンで一時停止するかどうか
      pauseOnDotsHover: true,
      // 切り替えのアニメーション。ease,linear,ease-in,ease-out,ease-in-out
      cssEase: 'ease',
      // 画像下のドット（ページ送り）を表示
      dots: false,
      // ドットのclass名をつける
      dotsClass: 'dot-class',
      // ドラッグができるかどうか
      draggable: true,
      // 切り替え時のフェードイン設定。trueでon
      fade: false,
      // 左右の次へ、前へボタンを表示するかどうか
      arrows: true,
      // 無限スクロールにするかどうか。最後の画像の次は最初の画像が表示される。
      infinite: true,
      // 最初のスライダーの位置
      initialSlide: 10,
      // 画像の遅延表示。‘ondemand’or'progressive'
      lazyLoad: 'ondemand',
      // スライドのエリアにマウスオーバーしている間、自動再生を止めるかどうか。
      pauseOnHover: true,
      // スライドのエリアに画像がいくつ表示されるかを指定
      slidesToScroll: 1,
      // タッチスワイプに対応するかどうか
      swipe: true,
      // 縦方向へのスライド
      vertical: false,
      // 表示中の画像を中央へ
      centerMode: true,
      // 中央のpadding
      centerPadding: '160px'
    })
  });

  $(function(){
    var back = $('#back');
    // ボタン非表示
    back.hide();
    // 100px スクロールしたらボタン表示
    $(window).scroll(function () {
       if ($(this).scrollTop() > 100) {
            back.fadeIn();
       } else {
            back.fadeOut();
       }
    });
    $('#back').on('click',function(){
      $('body, html').animate({
        scrollTop:0
      }, 800);
        return false;
    });  
    // back.click(function () {
    //    $('body').animate({ scrollTop: 0 }, 500);
    //    return false;
    // });
  });

  $(document).on('turbolinks:load', function() {
     //マウスを乗せたら発動
     $('#back').mouseover(function() {
      $(this).css('opacity', '0.5');
    }).mouseout(function() {
      $(this).css('opacity', '1.0'); 
    });
    // ハンバーガーメニュー出した時にロゴ消えるように
    $('.menu-trigger').on('click', function() {
      $(this).toggleClass('active');
      $('#sp-menu').fadeToggle();
      $('#chocobox-logo').fadeToggle();
      $('#chocobox-text').fadeToggle();

      return false;
    });
   
   });