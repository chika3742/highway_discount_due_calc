# 高速道路障害者割引期限計算アプリ

申請者の情報を入力するだけで、新しい有効期限とフォームの記入が必要な事項を確認できます。

## 機能

- 手続きの種類（新規・更新・変更）、生年月日、手帳（身体／療育）の期限などから、新しい有効期限を自動計算
- 西暦と和暦の両方で結果を表示
- 入力内容に応じて必要書類を自動で一覧表示
- 申請書記入欄を画像として生成し、申請者欄（赤）と担当者欄（青）を色分け表示
- 生成された画像はタップで拡大表示が可能
- 期限前に成人を迎える場合や、更新で誕生日まで2ヶ月以上ある場合などの注意点を警告表示
- 1タップで入力内容をクリアして最初からやり直し可能

## ダウンロード

### Android
https://play.google.com/store/apps/details?id=net.chikach.kigenkeisann

### iOS/iPadOS
https://apps.apple.com/jp/app/id6479892250

## セットアップ

```bash
flutter pub get
dart run build_runner build
flutter run
```

## ビルド

```bash
./build-android.sh
./build-ios.sh
```
