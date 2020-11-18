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
    
    // 
    var locationManager = CLLocationManager()
    
    //
    var mapView = GMSMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //初期値はApple本社
        let camera = GMSCameraPosition.camera(withLatitude: 37.3318, longitude: -122.0312, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect(origin: .zero, size: view.bounds.size), camera: camera)
        mapView.settings.myLocationButton = true //右下のボタン追加する
        mapView.isMyLocationEnabled = true

        // User Location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        self.view.addSubview(mapView)
        self.view.bringSubviewToFront(mapView)
    }

    //現在地が更新されたら呼び出される
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last

        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                                          longitude: userLocation!.coordinate.latitude, zoom: 17.0)
        self.mapView.animate(to: camera)

        locationManager.stopUpdatingLocation()
    }
    
    
//    // マーカーのタップを検知するメソッド
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        return true
//    }
    
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

