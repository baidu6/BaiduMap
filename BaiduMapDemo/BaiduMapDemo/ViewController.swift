//
//  ViewController.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/5.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mapView: BaseMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupMapView()

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        mapView.bmkMapView.viewWillAppear()
//    }
    
    func setupMapView() {
        mapView = BaseMapView(frame: view.bounds)
        view.addSubview(mapView)
    }

    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        mapView.bmkMapView.viewWillDisappear()
//    }

}
