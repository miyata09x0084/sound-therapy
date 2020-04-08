# Sound-Therapy
- 曲をよくあるアーティスト単位でなく感情単位のフォルダに振り分け、
その時の感情に沿った音楽がすぐに聴けるサービスが欲しいと思い作成。
併せて、自身の気分を可視化・記録することも出来ます。
# URL
- http://soundtherapygroup.com
<img width="1440" alt="スクリーンショット 2020-04-08 11 23 50" src="https://user-images.githubusercontent.com/59190800/78737898-97a7e800-798b-11ea-9fdc-646daee546bd.png">

# 使用技術
- Ruby 2.5.1, Rails 5.0.7
- Haml,Sass
- Docker, Docker-compose
- nginx, unicorn
- AWS (VPC, EC2, RDS for MySQL, Route53, ACM, ALB)

# 機能一覧
- 認証機能
- プレイリスト作成機能
- 楽曲投稿機能
- 画像投稿機能
- 感情検知機能
- グラフ表示機能

# インフラ構成図
![AWS Networking (5)](https://user-images.githubusercontent.com/59190800/78738417-d38f7d00-798c-11ea-8786-d098b60efb21.png)
