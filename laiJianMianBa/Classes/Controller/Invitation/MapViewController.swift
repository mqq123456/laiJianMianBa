//
//  MapViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/10.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//import JMServicesKit
class MapViewController: RootViewController {
    /// 定位管理器
    fileprivate lazy var locationManager: CLLocationManager = {
        let tempLocationManager = CLLocationManager()
        tempLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            tempLocationManager.requestAlwaysAuthorization()
            tempLocationManager.requestWhenInUseAuthorization()
        }
        tempLocationManager.delegate = self
        return tempLocationManager
    }()
    /// mapView
    fileprivate lazy var mapView: MKMapView! = {
        let tempMapView = MKMapView(frame: self.view.bounds)
        tempMapView.mapType = MKMapType.standard
        tempMapView.delegate = self
        tempMapView.showsUserLocation = true
        tempMapView.userTrackingMode = .followWithHeading
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        let center:CLLocation = CLLocation(latitude: 39.998629, longitude: 116.478513)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        tempMapView.setRegion(currentRegion, animated: false)
        return tempMapView
    }()
    fileprivate var address: String!
    fileprivate var lat: Double!
    fileprivate var lon: Double!
    init(_ address: String, lat: Double, lon: Double) {
        super.init(nibName: nil, bundle: nil)
        self.address = address
        self.lat = lat
        self.lon = lon
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 地图
        title = self.address
        self.view.addSubview(mapView)
        /// 定位
        locationManager.startUpdatingLocation()
        let coordinate = CLLocationCoordinate2DMake(lat, lon)
        /// 添加位置
        addAnnotation(coordinate, title: self.address)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    //自定义大头针样式
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if ((annotation as? FDAnnotation) != nil) {
            let reuserId = "location_animation"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuserId) as! MKPinAnnotationView!
            if pinView == nil {
                //创建一个大头针视图
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuserId)
                pinView?.canShowCallout = true
            }else{
                pinView?.annotation = annotation
            }
            pinView?.isSelected = true
            pinView?.pinColor = .red
            return pinView
        }else{
            return nil
        }
    }
    
}
// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let newLocation = locations.last
        //取得locations数组的最后一个
        let location:CLLocation = locations[locations.count-1]
        //判断是否为空
        if(location.horizontalAccuracy > 0){
            let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
            let center:CLLocation = location
            let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
            //停止定位
            locationManager.stopUpdatingLocation()
            //设置显示区域
            mapView.setRegion(currentRegion, animated: false)
           
        }
    }
    fileprivate func addAnnotation(_ coordinate: CLLocationCoordinate2D, title: String) {
        let annotation: FDAnnotation = FDAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: false)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        FDLog("定位失败")
    }
}
