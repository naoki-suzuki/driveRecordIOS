//
//  Convention ViewControlle.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit

class ConventionViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLicenseList()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの個数を指定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licenseList.count
    }
    
    // セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルの取得
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //let labelLicense = cell.viewWithTag(1) as! UILabel
        
        // セルに表示する値を設定する
        // cell.textLabel!.text = (licenseList[indexPath.row] as Any as! String)
        cell.textLabel!.text = licenseList[indexPath.row] as Any as? String
        //labelLicense.text = LicenseInfo[indexPath.row]
        
        return cell
    
    }
    @IBOutlet weak var tableview: UITableView!
    // Licenseの情報を格納する配列
    private var licenseList: [LicenseInfo] = []
    // Licenseの構造体
    private struct LicenseInfo {
            var title: String
            var description: String
    }
    
    private func getLicenseList() {
        
        let url = Bundle.main.path(forResource: "com.mono0926.LicensePlist", ofType: "plist")!
      
        print(url)
        let liscensePlist = NSDictionary(contentsOfFile: url) as! [String: Any]
        let licenseArray = liscensePlist["PreferenceSpecifiers"] as! [[String: Any]]
        
        licenseArray.forEach { plist in
            let licenseTitle = plist["Title"] as! String
            guard !licenseTitle.isEmpty,
                  
                  let url = Bundle.main.path(forResource: "com.mono0926.LicensePlist/\(licenseTitle)", ofType: "plist" ) else {
                return
            }
            let p = NSDictionary(contentsOfFile: url) as! [String: Any]
            let array = p["PreferenceSpecifiers"] as! [[String: Any]]
            let licenseText = array[0]["FooterText"] as! String
            let licenseInfo = LicenseInfo(title: licenseTitle, description: licenseText)
            licenseList.append(licenseInfo)
        }
    }
}

