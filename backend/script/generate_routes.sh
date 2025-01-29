#!/bin/bash

ROUTES_FILE="config/routes.rb"
CONTROLLERS_DIR="app/controllers/api/v1"

# ルーティングを初期化
echo "Rails.application.routes.draw do" > $ROUTES_FILE
echo "  mount Rswag::Ui::Engine => '/api-docs'" >> $ROUTES_FILE
echo "  mount Rswag::Api::Engine => '/api-docs'" >> $ROUTES_FILE
echo "" >> $ROUTES_FILE
echo "  namespace :api do" >> $ROUTES_FILE
echo "    namespace :v1 do" >> $ROUTES_FILE

# コントローラーごとにルーティングを作成
for controller in $CONTROLLERS_DIR/*_controller.rb; do
  CONTROLLER_NAME=$(basename "$controller" | sed 's/_controller.rb//')
  
  # コントローラーファイルの中身を解析して、定義されているアクションを取得
  ACTIONS=$(grep -oP '^\s*def \K\w+' "$controller" | tr '\n' ' ')

  # 取得したアクションに応じて適切なルーティングを作成
  if [[ -n "$ACTIONS" ]]; then
    echo "      resources :$CONTROLLER_NAME, only: [:$(echo "$ACTIONS" | sed 's/ /, /g')]" >> $ROUTES_FILE
  fi
done

# ルーティングの閉じ括弧を追加
echo "    end" >> $ROUTES_FILE
echo "  end" >> $ROUTES_FILE
echo "end" >> $ROUTES_FILE

echo "ルーティングの更新が完了しました。"
