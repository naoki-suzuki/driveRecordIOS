/*
 * Copyright 2020 Google Inc. All rights reserved.
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

// Created by 鈴木 on 2020/11/9
// Updated by 鈴木 on 2020/11/17

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    // 現在地
    var locationManager = CLLocationManager()
    
    //
    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        requestLoacion() //
    }
    
    private func setupMap() {
        
        // GoogleMapの初期位置(仮で東京駅付近に設定)
        let camera = GMSCameraPosition.camera(withLatitude: 35.6812226, longitude: 139.7670594, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        mapView.settings.myLocationButton = true //右下のボタン追加する
        mapView.isMyLocationEnabled = true //現在地
        view = mapView
    }
    
    // 現在地
    private func requestLoacion() {
        // ユーザにアプリ使用中のみ位置情報取得の許可を求めるダイアログを表示
        locationManager.requestWhenInUseAuthorization()
        // 常に取得したい場合はこちら↓
        // locationManager.requestAlwaysAuthorization()
    }
    
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("Tapped at coordinate: " + String(coordinate.latitude) + " "
                + String(coordinate.longitude))
    }
    
    
    /**
     マップにマーカを設置する処理
     - parameter title: マーカのタイトル
     - parameter coordinate: 位置
     - parameter iconName: アイコン名
     - parameter completion: Callback
     */
    private func putMarker(title: String?, coordinate: CLLocationCoordinate2D, iconName: String?, completion: @escaping ((GMSMarker) -> Void)) {
        // マーカの生成
        let marker = GMSMarker()
        marker.title = title
        marker.position = coordinate
        if iconName != nil {
            // アイコン名が指定されている場合は画像を設定
            marker.icon = UIImage.init(named: iconName!)
        }
        marker.map = self.mapView
        completion(marker)
    }
    
}

