$(function(){
  $('.theTarget').slick({
      // アクセシビリティ。左右ボタンで画像の切り替えをできるかどうか
      accessibility: true,
      // 自動再生。trueで自動再生される。
      autoplay: true,
      // 自動再生で切り替えをする時間
      autoplaySpeed: 3000,
      // 自動再生や左右の矢印でスライドするスピード
      speed: 400,
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
      initialSlide: 0,
      // 画像の遅延表示。‘ondemand’or'progressive'
      pauseOnHover: true,
     
      // 表示中の画像を中央へ
      centerMode: true,
      // 中央のpadding
      centerPadding: '200px'
    })
  });
