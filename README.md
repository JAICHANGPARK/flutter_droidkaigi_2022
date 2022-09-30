# flutter_droidkaigi_2022

## FlutterをROS(ロボティクス)と一緒使ったらマジですごかった話

通常、RoboticsではROSとAndroidまたはQTを組み合わせてユーザーアプリケーションを開発しています。今回Flutter3が発表され、デスクトップ、組み込み領域で使用できるように機能が拡張されました。生産性が高いユーザーアプリケーションを作成するためにロボットにFlutterを適用してみました。

そのためには、ロボットとアプリ間通信するためのプロトコルライブラリの開発が必要です。パッケージ開発方法と物語、そして実務で使用している例示を通じて使用機を紹介したいと思います。

<img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/ros/Screen%20Shot%202022-09-15%20at%202.34.25%20PM.png" width=600/>

## Android 

|  |  |  |
| -- | -- |  -- | 
| <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/aos/Screenshot_20220924_223654.png" width=200/> | <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/aos/Screenshot_20220924_223709.png" width=200/> | <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/aos/Screenshot_20220924_223716.png" width=200/> |

## iOS
|  |  |  |
| -- | -- |  -- | 
| <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/ios/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-09-24%20at%2022.38.39.png" width=200/> | <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/ios/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-09-24%20at%2022.38.50.png" width=200/> | <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/ios/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-09-24%20at%2022.39.00.png" width=200/> |

## macOS
|  | 
| -- | 
| <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/macos/Screen%20Shot%202022-09-24%20at%2010.36.01%20PM.png" width=400/> |
| <img src="https://github.com/JAICHANGPARK/flutter_droidkaigi_2022/blob/main/captures/macos/Screen%20Shot%202022-09-24%20at%2010.36.19%20PM.png" width=400/> | 


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
