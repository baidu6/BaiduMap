//
//  MapCityAnnotationView.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
class MapCityAnnotationView: BMKAnnotationView {
    
    var titleLabel: UILabel!
    var iconView: UIImageView!
    static let MapCityAnnotationViewID = "MapCityAnnotationViewID"
    
    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func dequeueView(mapView: BMKMapView, annotation: BMKAnnotation) -> MapCityAnnotationView {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapCityAnnotationViewID) as? MapCityAnnotationView
        
        if annotationView == nil {
            annotationView = MapCityAnnotationView(annotation: annotation, reuseIdentifier: MapCityAnnotationViewID)
        }
        annotationView?.annotation = annotation
        annotationView?.canShowCallout = false
        annotationView?.displayData(title: annotation.title!())
        return annotationView!
    }
    
    func setupUI() {
        bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        backgroundColor = UIColor.clear
   
        iconView = UIImageView(frame: self.bounds)
        iconView.image = UIImage(named: "MapPop_Back")
        addSubview(iconView)
        
        titleLabel = UILabel(frame: self.bounds)
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(titleLabel)
        
        self.layer.add(AnimationUtil.createScaleAnimation(), forKey: "ScaleAnimation")
    }
    
    func displayData(title: String?) {
        titleLabel.text = title
    }

}
