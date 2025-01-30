# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.4.1
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# 作業ディレクトリを設定
WORKDIR /app

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Rails環境変数を設定
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_WITHOUT=""

# 必要な開発ツールをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Gemfileを先にコピーしてキャッシュを活用
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードをコピー
COPY . .

# 非rootユーザー作成
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

# rails ユーザーに権限を変更
RUN chown -R rails:rails /app

# ユーザーを変更（ここから先の処理は rails ユーザーで実行）
USER 1000:1000

# Rails起動時のポートを開放
EXPOSE 3000

# 起動コマンド
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
