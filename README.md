# README

# アプリケーション名
Youtube_app
# アプリケーション概要
youtubuの詳細な検索を行えるようにする
検索結果をスプレッドシートに出力しデータ収集を行えるようにする
# URL

# 利用方法
検索したいキーワード、カテゴリ、日付範囲を入力する
# 目指した課題解決
youtubuでは出来ない詳細な検索を行えるようにする

# 洗い出した要件
| 優先順位   | 目的       | 詳細 |ストーリー(ユースケース)|見積もり（所要時間）|
| ---------------- | ---------- | ----------------------------- |
| 3         | 検索機能 | null: false foreign_key: true |
| 2    | 詳細検索機能   | null: false                   |
| 1    | 検索結果出力シート作成機能 | null: false                   |

| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| purchase        | references | null: false foreign_key: true |
| post_code        | string     | null: false                   |
| prefecture_id    | integer    | null: false                   |
| city             | string     | null: false                   |
| address          | string     | null: false                   |
| build_name       | string     |                               |
| phone_number     | string     | null: false                   |


# 実装した機能についてのGIFと説明
検索したいキーワードやカテゴリ等から動画を検索する
キーワード無しならYoutubeの動画全体での検索を行う
# 実装予定の機能
検索結果をスプレッドシートに出力する
# データベース設計
https://gyazo.com/0cd0f8a73d3a5899fb080f7eda364dbc
# ローカルでの動作方法
