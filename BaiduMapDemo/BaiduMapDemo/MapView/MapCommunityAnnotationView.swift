//
//  MapCommunityAnnotationView.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/6.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class MapCommunityAnnotationView: BMKAnnotationView {
    
    private let kVertMargin = CGFloat(3)
    private let KHoriMargin: CGFloat = 10
    private let kMaxWidth: CGFloat = 116
    private let kMaxHeight: CGFloat = 34
    
    private var titleLabel: UILabel!
    private var iconView: UIImageView!
    
    static let MapCommunityAnnotationViewID = "MapCommunityAnnotationViewID"

    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func dequeueView(mapView: BMKMapView, annotation: BMKAnnotation) -> MapCommunityAnnotationView {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapCommunityAnnotationViewID) as! MapCommunityAnnotationView?
        
        if annotationView == nil {
            annotationView = MapCommunityAnnotationView(annotation: annotation, reuseIdentifier: MapCommunityAnnotationViewID)
        }
        annotationView?.annotation = annotation
        annotationView?.canShowCallout = false
        annotationView?.displayData(title: annotation.title!())
        return annotationView!
    }
    
    func setupUI() {
        backgroundColor = .clear
        
        iconView = UIImageView(image: UIImage(named: "communityTip_Back"))
        addSubview(iconView)
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel)
        
    }

    func displayData(title: String?) {
        titleLabel.text = title
        
        if titleLabel.frame.size.width < kMaxWidth {
            titleLabel.frame = CGRect(x: 0, y: 0, width: kMaxWidth, height: kMaxHeight-20)
            iconView.frame = CGRect(x: 0, y: 0, width: kMaxWidth + KHoriMargin * 2, height: kMaxHeight)
            bounds = CGRect(x: 0, y: 0, width: kMaxWidth + KHoriMargin * 2, height: kMaxHeight)
        }else {
            titleLabel.frame = CGRect(x: 0, y: 0, width: titleLabel.frame.size.width, height: kMaxHeight-20)
            iconView.frame = CGRect(x: 0, y: 0, width: titleLabel.frame.size.width + KHoriMargin * 2, height: kMaxHeight)
            bounds = CGRect(x: 0, y: 0, width: titleLabel.frame.size.width + KHoriMargin * 2, height: kMaxHeight)
        }
        
        titleLabel.center = CGPoint(x: bounds.midX, y: bounds.midY - kVertMargin)
        self.layer.add(AnimationUtil.createScaleAnimation(), forKey: "ScaleAnimation")
    }
}
