# メモアプリ

## 概要

Vue.jsとRuby on Railsを使用したシンプルなメモアプリケーションです。  主な機能としてユーザー認証、アイコン画像の登録・更新、メモの登録・更新・削除が可能です。  インフラストラクチャにはVercel、Heroku、Docker、およびAWSを使用しています。

## 主要技術

- フロントエンド: Vue.js
- バックエンド: Ruby on Rails (アプリケーションサーバ: Puma)
- 非同期通信: Axios
- ユーザー認証: Devise (JWTを使用し、local storageに保存)
- データベース: PostgreSQL
- ストレージ: Amazon S3
- Webサーバ: Nginx (リバースプロキシ)
- コンテナ: Docker
- クラウドサービス: Vercel, Heroku, AWS

## 機能一覧

- サインアップ・サインイン機能
- アイコン画像の登録・更新機能
- メモの登録・更新・削除機能
- メモ一覧のページネーション機能

## インフラストラクチャ

- フロントエンド（Vue.js）: Vercelでデプロイ
- バックエンド（Ruby on Rails）: Herokuでデプロイし、PostgreSQLとAmazon S3を使用
- Webサーバ（Nginx）: Dockerを使用し、以下のAWSサービスで構成されています。
  - Amazon ECR（Elastic Container Registry）
  - Amazon ECS（Elastic Container Service）
  - AWS Fargate
  - Amazon ALB（Application Load Balancer）
  - AWS Certificate Manager
  - Amazon Route 53
  - Amazon VPC

## 使い方

1. サインアップまたはサインインしてください。
2. メモを作成するには、画面上部のフォームでTitleとContentを入力後にSaveを押下してください。
3. メモを編集するには、ペンのアイコン（編集ボタン）をクリックしてください。
4. メモを削除するには、ゴミ箱のアイコン（削除ボタン）をクリックしてください。
5. アイコン画像を登録または更新するには、画面上部のアイコン画像をクリックしてください。

## 開発環境

- フロントエンド: Vue.js (Vue CLI)
- バックエンド: Ruby on Rails
- データベース: データベース: SQLite (開発環境), PostgreSQL (デプロイ環境)
- Webサーバ: Nginx (リバースプロキシ)
