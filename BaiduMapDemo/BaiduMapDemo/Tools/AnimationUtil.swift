//
//  AnimationUtil.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/7.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
class AnimationUtil: NSObject {
    static func createScaleAnimation(duration: TimeInterval = 0.15, fromValue: Any = 0, toValue: Any = 1.0) -> CABasicAnimation {
        let animation = CABasicAnimation.init(keyPath: "transform.scale")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = fromValue
        animation.toValue = toValue
        return animation
    }
}
