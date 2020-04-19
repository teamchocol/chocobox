# chocobox

#### 生粋のチョコレート好きが「健康」「美味しさ」「コスパ」の３点を踏まえて共有する口コミサービスです。

あなたの好きなチョコレートは他者からどのように評価されているのかを知ることができたり、あなたの知らないチョコレートに出会うためのツールとしてご活用ください。

## 機能

- インフラ(Heroku)
- 単体・統合テスト(RSpec, factory_bot, capybara)　
- データベース(sqlite3)
- 画像アップロード(Amason S3, carrierwave, mini_magick, fog)
- ページネーション(kaminari)
- お問い合わせメール送信(ActionMailer)
- アイテム情報取得(Amazon Product API, amazon-ecs)
- 検索(ransack)
- アクセス解析(google-analytics-rails)
- サイトマップ(sitemap_generator)
- メタタグ(meta-tags)
- パンくずリスト(gretel)
- デザイン(Bootstrap)
- 認証関連(ログイン, 管理者ユーザー)
- ユーザー関連（フォロー・フォロワー）
- アイテム関連（お気に入り登録, ランキング表示）
https://docs.google.com/spreadsheets/d/1NXsMrgiNHxxUn-QMmJDiDwA4DyEj4TUREjnRHki6xT4/edit#gid=0
## 使用技術
- フロント
    - HTML Scss 
    - Javascript
        - jQuery
        - Ajax
- バックエンド
    - Ruby　
    - Rails 
- インフラ
    - Docker
         
    - AWS
    
## アプリ制作の背景
健康ブームが騒がれる中、２０１７年ごろからお菓子売り場にて乳酸菌入りチョコレートが並び始め、現在では当たり前の光景になっています。

果たして本当に健康にいいのか？

私は健康オタクなので、乳酸菌チョコレートについて調べていると面白い記事を見つけました。

「ダークチョコレートを食べることで紫外線に強くなる」

まさかとは思いましたが、そのような論文がいくつか発表されており、ダークチョコレートに含まれるカカオフラボノイドが紫外線ダメージを受けた肌の回復を早める効果があるようです。

チョコレートは美味しさだけでなく、健康面にも与える影響が大きいということから、健康的に安く美味しいチョコレートを見つけられる口コミサイトを作りたいと思いました。