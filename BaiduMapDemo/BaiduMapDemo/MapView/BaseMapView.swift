//
//  BaseMapView.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/7.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

let CityZoomLevel: Float = 12
let CommunityZoomLevel: Float = 17

enum MapZoomType {
    case city
    case community
}

class BaseMapView: UIView {
    var bmkMapView: BMKMapView!
    private var tipsView: BaseMapTipsView!
    private var cityAnnotations: [BMKPointAnnotation] = []
    private var currentZoomType = MapZoomType.city
    private var currentZoomLevel: Float?
    private var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupUI()
        
         NotificationCenter.default.addObserver(self, selector: #selector(loadMapAreaDatas), name: NSNotification.Name.init(rawValue: GetCityListSuccessNoti), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        bmkMapView = BMKMapView(frame: bounds)
        bmkMapView.delegate = self
        bmkMapView.minZoomLevel = 6
        bmkMapView.maxZoomLevel = 19
        bmkMapView.showMapScaleBar = true
        bmkMapView.zoomLevel = CityZoomLevel
        bmkMapView.isSelectedAnnotationViewFront = true
        bmkMapView.logoPosition = BMKLogoPositionLeftBottom
        addSubview(bmkMapView)
        
        tipsView = BaseMapTipsView(frame: CGRect(x: 0, y: 20, width: 120, height: 30))
        tipsView.center.x = self.center.x
        addSubview(tipsView)

    }
    
    //MARK:- 加载地图区块信息
    @objc func loadMapAreaDatas() {
        NetWorkTool.loadMapAreaData { [weak self] (result) in
            
            if result?.stringForKey("code") == Code_Success {
                
                if let datas = result?.arrayDictionaryForKey("data"), datas.count > 0 {
                    
                    self?.cityAnnotations = datas.map({ dict -> BMKPointAnnotation? in
                        if let X = dict.doubleForKey("X"), let Y = dict.doubleForKey("Y") {
                            let annotation = self?.createPointAnnotation(X: Y, Y: X, title: dict.stringForKey("NAME"), subTitle: dict.stringForKey("AREA_ID"))
                            
                            return annotation
                        }
                        return nil
                    }).flatMap{$0}
                    
                    self?.showAreaAnnotations()
                }
            }
        }
    }

    //MARK:- 加载区块对应小区信息
    func addCommunityAnnotations(coordinate: CLLocationCoordinate2D) {
        bmkMapView.removeAnnotations(cityAnnotations)
        tipsView.changeStatus(.community)
        
        NetWorkTool.loadMapCommunityData(X: coordinate.latitude, Y: coordinate.longitude) { [weak self] (result) in
            
            if result?.stringForKey("code") == Code_Success {
                self?.currentZoomType = .community
                
                if let datas = result?.arrayDictionaryForKey("data") {
                    for dict in datas {
                        if let X = dict.doubleForKey("LATITUDE"), let Y = dict.doubleForKey("LONGITUDE") {
                            
                            let annotation = self?.createPointAnnotation(X: X, Y: Y, title: dict.stringForKey("COMMUNITYNAME"), subTitle: dict.stringForKey("ADDRESS_ID"))
                            
                            //判断是否有重复的数据
                            if self?.bmkMapView.annotations.contains(where: {($0 as! BMKPointAnnotation).subtitle == annotation!.subtitle}) == true {
                                continue
                            }
                            self?.bmkMapView.addAnnotation(annotation)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- 展示cityAnnotations
    func showAreaAnnotations() {
        currentZoomType = .city
        tipsView.changeStatus(.city)
        bmkMapView.removeAnnotations(bmkMapView.annotations)
        bmkMapView.addAnnotations(cityAnnotations)
    }
    
    //MARK:- 快捷创建BMKPointAnnotation
    func createPointAnnotation(X: Double, Y: Double, title: String?, subTitle: String?) -> BMKPointAnnotation {
        let annotation = BMKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: X, longitude: Y)
        annotation.title = title
        annotation.subtitle = subTitle
        return annotation
    }
}

extension BaseMapView: BMKMapViewDelegate {
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if currentZoomType == .city {
            let annotationView = MapCityAnnotationView.dequeueView(mapView: mapView, annotation: annotation)
            return annotationView
        }else if currentZoomType == .community {
            let annotationView = MapCommunityAnnotationView.dequeueView(mapView: mapView, annotation: annotation)
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        if currentZoomType == .city {
            mapView.setCenter(view.annotation.coordinate, animated: false)
            mapView.zoomLevel = CommunityZoomLevel
            
        }else if currentZoomType == .community {
            print(view.annotation.title!())
        }
    }
    
    func mapView(_ mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        currentZoomLevel = mapView.zoomLevel
        print(currentZoomLevel)
    }
    
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        if mapView.zoomLevel >= CommunityZoomLevel {
            let point1 = BMKMapPointForCoordinate(currentCoordinate)
            let point2 = BMKMapPointForCoordinate(mapView.centerCoordinate)
            let distance = BMKMetersBetweenMapPoints(point1,point2)
            if distance <= 600 && currentZoomLevel == mapView.zoomLevel {
                return
            }
            currentCoordinate = mapView.centerCoordinate
            addCommunityAnnotations(coordinate: mapView.centerCoordinate)
        }else if mapView.zoomLevel <= CityZoomLevel {
            if currentZoomLevel == mapView.zoomLevel {
                return
            }
            showAreaAnnotations()
        }
    }
}
