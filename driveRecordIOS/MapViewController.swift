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
import CoreLocation

// 位置情報取得判定が14.0で廃止になってしまった為、設置
@available(iOS 14.0, *)
class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    // 現在地取得のためのメソッドをインスタンス化
    var manager = CLLocationManager()
    var marker = GMSMarker()
    // 地図に関するメソッドをインスタンス化
    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        // GPSの使用を開始
        // manager.startUpdatingLocation()
        // 更新に必要な最小移動距離
        manager.distanceFilter = 50
        // 位置情報の利用許可を変更する画面をポップアップ表示する
        manager.requestWhenInUseAuthorization()
        // GPSの使用を開始
        manager.startUpdatingLocation()
        // 位置情報を許可しているか判定
        let status = CLLocationManager.authorizationStatus()
        // 許可しない場合の処理
        if status == .notDetermined || status == .denied || status == .notDetermined {
            // 初期値を東京に設定
            let camera = GMSCameraPosition.camera(withLatitude: 35.6812226, longitude: 139.7670594, zoom: 12.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
        }
        
    }
    // 位置情報取得した場合、呼び出される
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
         return
        }
        // 現在地の取得
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view = mapView
        // view.addSubview(mapView)
//        // ピンの設置
//        marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        marker.map = mapView
            
        mapView.settings.myLocationButton = true // 右下の現在地ボタン追加する
        mapView.isMyLocationEnabled = true // 現在地表示
        
    }
    
    
    func showMarker(position : CLLocationCoordinate2D) {
        marker.position = position
        marker.isDraggable = true
        
    }
   
}

