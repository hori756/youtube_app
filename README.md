# README

# アプリケーション名
Youtube_app
# アプリケーション概要
youtubuの詳細な検索を行えるようにする
検索結果をスプレッドシートに出力しデータ収集を行えるようにする
# URL
https://yourube-app-756.herokuapp.com/
# 利用方法
検索したいキーワード、カテゴリ、日付範囲を入力する
# 目指した課題解決
youtubuでは出来ない詳細な検索を行えるようにする

# 洗い出した要件
youtubeのAPIを用いてキーワードから検索をし、データ収集を行う<br>
youtubeのAPIを用いて日付の範囲選択や再生数や高評価数などの詳細な情報も表示されるようにする<br>
検索結果をcsvファイルに出力しデータ収集を効率化することが出来る<br>
# 実装した機能についてのGIFと説明
検索したいキーワードやカテゴリ等から動画を検索する<br>
キーワード無しならYoutubeの動画全体での検索を行う
# 実装予定の機能
検索結果をスプレッドシートに出力する
# データベース設計
https://gyazo.com/0cd0f8a73d3a5899fb080f7eda364dbc
# ローカルでの動作方法
cd youtube_app <br>
bundle install<br>
yarn install<br>
rails db:create<br>
rails db:migrate<br>

環境<br>
rails6.0<br>
ruby2.6.5
