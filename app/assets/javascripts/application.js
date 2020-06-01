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
      pauseOnHover: false,
      // 自動再生時にドットにマウスオンで一時停止するかどうか
      pauseOnDotsHover: true,
      // 切り替えのアニメーション。ease,linear,ease-in,ease-out,ease-in-out
      cssEase: 'ease',
      // 画像下のドット（ページ送り）を表示
      dots: false,
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

   $(function () {
    let $image = $('#imageModal'),
      $img_field = $('#comment_image'),
      $croppedImage = $('#croppedImage'),
      $cropModal = $('#cropModal'),
      $beforeUpload = $('#beforeUpload'),
      $button = $('#btn-save'),
      $dataX = $('#dataX'),
      $dataY = $('#dataY'),
      $dataWidth = $('#dataWidth'),
      $dataHeight = $('#dataHeight');

  
    let options = {
      dragmode: 'crop',
      aspectRatio: 1/1,
      restore: false,
      guides: false,
      center: false,
      highlight: true,
      cropBoxMovable: true,
      cropBoxResizable: true,
      modal: true,
      crop: (e) => {
        $dataX.val(Math.round(e.detail.x));
        $dataY.val(Math.round(e.detail.y));
        $dataWidth.val(Math.round(e.detail.width));
        $dataHeight.val(Math.round(e.detail.height));
      }
    };
  
    $img_field.on('focus',function(e) {
      $(this).val('');
    });
    // when file upload
    $img_field.on('change',function(e) {
      $image.cropper('destroy').removeAttr('src');
      file = e.target.files[0];
      reader = new FileReader();
      
      reader.onload = ((e) => {
        $image.attr('src',"");
        $image.attr('src', e.target.result);
        $cropModal.modal('show');
        $cropModal.on('shown.bs.modal', () => {
          $image.cropper(options);
        });
      });
      reader.readAsDataURL(file);
    })
    // onclick save button
    $button.click(() => {
      imgCropping();
    });
  
    // modalを閉じたとき、cropper要素を初期化
    $cropModal.on('hidden.bs.modal',function() {
      $image.cropper('destroy');
      $image.removeAttr('src');
      let $cropperContainer = $('.cropper-container');
      $cropperContainer.remove();
    });
  
    function imgCropping() {
      $beforeUpload.hide();
      let croppedData = $image.cropper('getCroppedCanvas').toDataURL();
      $croppedImage.attr('src', croppedData);
      $cropModal.modal('hide');
    }
  });

  // 無限スクロール
  $(document).on('turbolinks:load', function() {
    $('.comments-all').jscroll({
      // 無限に追加する要素は、どこに入れる？
      contentSelector: '.comments-all', 
      // 次のページにいくためのリンクの場所は？ ＞aタグの指定
      nextSelector: 'a.next',
      // 読み込み中の表示はどうする？
      loadingHtml: '読み込み中'
    });
  });