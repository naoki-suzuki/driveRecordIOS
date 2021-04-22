
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

// Created by　長阪　2021/4/15

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // キーボード以外を触るとキーボードが閉じるようにする
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //outputText.text = inputText.text
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestAlwaysAuthorization()
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        //位置情報の取得を要求する。
        // locationManger.requestLocation()
        map.delegate = self
        
        // 現在地のトラッキングボタン配備
        let trakingBtn = MKUserTrackingButton(mapView: map)
        trakingBtn.layer.backgroundColor = UIColor(white: 1, alpha: 0.7).cgColor
        trakingBtn.frame = CGRect(x:40, y:740, width:40, height:40)
        self.view.addSubview(trakingBtn)
        
    }
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var getDirection: UIButton!
    @IBOutlet weak var map: MKMapView!
    var locationManger = CLLocationManager()
    
    
    
    @IBAction func getDirection(_ sender: Any) {
        // このタイミングでマップ上にある経路を削除する必要あり
        // map.removeOverlays(map.overlays)
        
        getAddress()
    }
    
    
    func getAddress() {
        let geoCooder = CLGeocoder()
        geoCooder.geocodeAddressString(text.text!) { [self] (placemarks, Error)
            in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else {
                return
            }
            self.mapPing(destinationCord: location.coordinate)
            map.setCenter(location.coordinate, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]){
        //print(CLLocation)
    }
    
    //マップビュー長押し時の呼び出しメソッド
    @IBAction func pressMap(sender: UILongPressGestureRecognizer) {
        
        self.map.removeAnnotations(map.annotations)
        //マップビュー内のタップした位置を取得する。
        let location:CGPoint = sender.location(in: map)
        
        if (sender.state == UIGestureRecognizer.State.ended){
            
            //タップした位置を緯度、経度の座標に変換する。
            let mapPoint:CLLocationCoordinate2D = map.convert(location, toCoordinateFrom: map)
            
            self.mapPing(destinationCord: mapPoint)
            
        }
    }
    // 検索した場所にピンを立てるメソッド
    func mapPing(destinationCord : CLLocationCoordinate2D){
        
        
        //ピンを作成してマップビューに登録する。
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(destinationCord.latitude, destinationCord.longitude)
        annotation.title = "目的地候補"
        annotation.subtitle = "ボタンタップで経路を表示"
        map.addAnnotation(annotation)
        
    }
    
    // map上に経路表示するメソッド
    func mapThis(destinationCord : CLLocationCoordinate2D){
        // map上のルートを全部消去するメソッド
        map.removeOverlays(map.overlays)
        
        
        let souceCordinate = (locationManger.location?.coordinate)!
        
        let soucePlaceMark = MKPlacemark(coordinate: souceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: soucePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        //ピンを作成してマップビューに登録する。
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(destinationCord.latitude, destinationCord.longitude)
        annotation.title = "目的地候補"
        annotation.subtitle = "ボタンタップで経路を表示"
        map.addAnnotation(annotation)
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (responce, error) in
            guard let response = responce else {
                if error != nil {
                    print("somthing")
                }
                return
            }
            
            let route = response.routes[0]
            // マップ内のルートを一旦全て削除してから新しいルートを表示する
            // self.map.removeOverlay(route.polyline)
            
            self.map.addOverlay(route.polyline)
            self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        render.lineWidth = 5
        return render
        
    }
    //アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //現在位置の点滅がピンにならないように、アノテーションがUserLocationの場合は何もしないようにする。
        if( annotation is MKUserLocation ) {
            return nil
        }
        
        //アノテーションビューを生成する。
        let testView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        //吹き出しを表示可能にする。
        testView.canShowCallout = true
        
        //経路ボタンをアノテーションビューに追加する。
        let button = UIButton()
        button.frame = CGRect(x: 0,y: 0,width: 40,height: 30)
        button.setTitle("経路", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for:.highlighted)
        testView.rightCalloutAccessoryView = button
        
        return testView
    }
    
    //経路ボタン押下時の呼び出しメソッド
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //マップアプリに渡す目的地の位置情報を作る。
        let coordinate = CLLocationCoordinate2DMake(view.annotation!.coordinate.latitude, view.annotation!.coordinate.longitude)
        _ = MKPlacemark(coordinate:coordinate, addressDictionary:nil)
        // let mapItem = MKMapItem(placemark: placemark)
        
        // 経路表示メソッドを呼び出す
        self.mapThis(destinationCord: coordinate)
        
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation{
            print(annotation.title!!)
            
        }
        
        
    }
}
