//: Playground - noun: a place where people can play

import UIKit

//
// Observerデザインパターン
// Listenerとも呼ばれます。
// オブジェクトの状態の変化を別のオブジェクトに通知する場合に用いられます。
//  https://ja.wikipedia.org/wiki/Observer_%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3

// swiftでは、NotificationCenterを使います。
// 通知が必要なVCクラスで、addObserverで登録しておき、
//　別なクラスからpostメソッドで通知します。
//
//  参考
//     http://dev.classmethod.jp/smartphone/swift-3-0-notificationcenter/
//     http://joyplot.com/documents/2016/11/01/swift-notificationcenter-app-state/

class Hoge : NSObject {
    override init() {
        super.init()
        // 受信側(登録)
        NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: Notification.Name(rawValue: "MyNotification"), object: nil)
    }

    // 通知を受けるメソッドです
    func update(notification: NSNotification?) {
        print("receive Notification!")
    }
}

var hoge = Hoge()

// 通知する
NotificationCenter.default.post(name: Notification.Name(rawValue: "MyNotification"), object: nil)


// ---------------------------------
// 通知の名前ですが、複数の名前が定義されています。
// NSNotification.Name.
// までを入力して一覧を見てください。
// 通知の名前は、
NSNotification.Name("myNotification")
//という記述もできるようです。
// その他、NSNotification.Nameを拡張することもできます。
//  参考
//     Swift 3 以降の NotificationCenter の正しい使い方 - Qiita http://qiita.com/mono0926/items/754c5d2dbe431542c75e
//  少しわかりにくいかもしれません。

// ---------------------------------
//  データの受け渡し
//   userInfoを使うとできるようです。
//  参考
//  http://dev.iachieved.it/iachievedit/notifications-and-userinfo-with-swift-3-0/

class Hoge2 : NSObject {
    override init() {
        super.init()
        // 受信側(登録)
        NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: Notification.Name(rawValue: "MyNotification2"), object: nil)
    }
    
    // 通知を受けるメソッドです
    func update(nsNotification: NSNotification?) {
        print("receive Notification!")
        
        guard let notification = nsNotification,
            let userInfo = notification.userInfo,
            let message  = userInfo["message"] as? String,
            let date     = userInfo["date"]    as? Date else {
                print("No userInfo found in notification")
                return
        }
        print(message);
        print(date);
    }
}

var hoge2 = Hoge2()

// 通知する
NotificationCenter.default.post(name: Notification.Name(rawValue: "MyNotification2"), object: nil, userInfo:["message":"Hello there!", "date":Date()])
