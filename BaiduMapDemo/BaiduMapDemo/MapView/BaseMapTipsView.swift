//
//  BaseMapTipsView.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/8.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class BaseMapTipsView: UIView {
    
    private var titleLabel: UILabel!
    private var bgView: UIImageView!
    private var type: MapZoomType?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        bgView = UIImageView(frame: bounds)
        bgView.image = UIImage(named: "tip_back")
        addSubview(bgView)
        
        titleLabel = UILabel(frame: bounds)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        self.alpha = 0
    }
    
    func changeStatus(_ type: MapZoomType) {
        if self.type == type {
            return
        }
        self.type = type
        self.alpha = 0
        self.transform = CGAffineTransform(translationX: 0, y: -100)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        })
        
        switch type {
        case .city:
            titleLabel.text = "放大地图加载小区"
        case .community:
            titleLabel.text = "点击小区进入详情"
        }
    }
    
}
