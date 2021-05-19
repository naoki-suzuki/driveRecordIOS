//
//  AppDelegate.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit
// import GoogleMaps
import Siren
import GRDB

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var migrator = DatabaseMigrator()
    let userDefaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // APIキー登録
        // GMSServices.provideAPIKey("AIzaSyDiouaZuTdUSwZEtwhZbzLpnN-0mymORFY")
        
        // スプラッシュを3秒表示する
        sleep(3)
        
        // ナビゲージョンアイテムの文字色
        UINavigationBar.appearance().tintColor = UIColor.white
        // ナビゲーションバーのタイトルの文字色
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // sirenの強制アップデート設定用関数
        forceUpdate()
        
        // Override point for customization after application launch.
        return true
        
        
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // 初回起動かチェックを行い2回目以降の場合は
    /*func settingJustAfterUpdating() {
        let dicKey = "CFBundleShortVersionString"
        guard let version = Bundle.main.object(forInfoDictionaryKey: dicKey) else { return }
        let newVersionKey = "ver\(version as! String)"
        // 初回起動時のみ処理が呼ばれるようにフラグを立てる
        userDefaults.register(defaults: [newVersionKey : true])
        // もしも最新バージョンでのアプリ起動が初めてならば
        if !userDefaults.bool(forKey: newVersionKey) {
            // 次回起動以降は処理が呼ばれなくなるようにフラグを折る
            userDefaults.set(true, forKey: newVersionKey)

            // let queue = DatabaseQueue()
            // ここでアップデート直後のみ行なわせたい処理を呼び出す
            // Folderinfoのtableにcolumnを追加
            migrator.registerMigration("v2") { (db) in
                
                try db.alter(table: Folderinfo.databaseTableName) { (t) in
                    t.add(column: "Destination", .text)
                }
                
                try db.alter(table: Folderinfo.databaseTableName) { (t) in
                    t.add(column: "Departure", .text)
                }

            }
            //  マイグレーション
            /*do {
                try migrator.migrate(queue)
                }
                catch {
                    print("error")
                }*/
            
            // 不要となった過去バージョンにおけるフラグをUserDefaultsから削除する
            // verから始まる名前のキーが他の用途向けに無いよう設計に注意!
            if let dataList = userDefaults.persistentDomain(forName: Bundle.main.bundleIdentifier!) {
                let versionKeys = dataList.compactMap { $0.key.hasPrefix("ver") ? $0.key : nil }
                versionKeys.forEach { (key) in
                    userDefaults.removeObject(forKey: key)
                }
            }
        }
    }
    */

    
    
    func forceUpdate() {
        let siren = Siren.shared
        // 言語を日本語に設定
        siren.presentationManager = PresentationManager(forceLanguageLocalization: .japanese)
        
        // ruleを設定
        siren.rulesManager = RulesManager(globalRules: .critical)
        
        // sirenの実行関数
        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // 以下のように、完了時の処理を無視して記述することも可能
        // siren.wail()
    }
    
    
    
}

