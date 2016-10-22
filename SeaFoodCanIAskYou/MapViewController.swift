//
//  MapViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/22.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {
    @IBOutlet weak var myMapView: MKMapView!
    @IBAction func nowLocation(_ sender: UIButton) {
        let region = MKCoordinateRegion(center: myMapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.myMapView.region = region
        
        
    }
    
    //設定一個CLLocationManager物件，此物件需在class中為痊癒變數
    let locationManager = CLLocationManager()
    
    var firstLaunch = true
    override func viewDidLoad() {
        super.viewDidLoad()
        //向使用者請求使用者位置取用權限
        locationManager.requestWhenInUseAuthorization()
        //設定MapViewController為myMapView的delegate
        self.myMapView.delegate = self
        //把資料的點都套進addAnnotion
        for i in 0...(YelloLineData.count - 1){
            addAnnotion(title: YelloLineData[i].titleInfo!, subTitle: YelloLineData[i].parkingTimeInfo!, address: YelloLineData[i].addressInfo!)
        }
        let region = MKCoordinateRegion(center: myMapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.myMapView.region = region
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MapViewController:MKMapViewDelegate{
    //當使用者位置被更新時，會做什麼
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if firstLaunch{
            firstLaunch = false
            //以使用者最新位置為畫面中心展開地圖
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.myMapView.region = region
        }
    }
     //增加一個地標的方法
    func addAnnotion(title:String,subTitle:String,address:String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placeMarks:[CLPlacemark]?, error:Error?) in
            if error != nil{
                return
            }
            //若placeMarks不是nil，取出第一個值後賦值給placeMark，也就是得到的第一個地址
            if let placeMark = placeMarks?[0]{
                //取出location
                if let location = placeMark.location{
                    //生成annotation物件
                    let annotation = MKPointAnnotation()
                    //加入地址
                    annotation.coordinate = location.coordinate
                    //加入title
                    annotation.title = title
                    //加入subTitle
                    annotation.subtitle = "可停車時段:" + subTitle
                    //秀出剛剛設定好的annotion(也可以將多個annotation合成一個array)
                    self.myMapView.showAnnotations([annotation], animated: true)
                }
            }
        }
    }
}
