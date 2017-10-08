//
//  CircleView.swift
//  WaveVibrate
//
//  Created by huahuahu on 2017/10/8.
//  Copyright © 2017年 huahuahu. All rights reserved.
//

import UIKit

class CircleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        self.drawCircle(posiont: CGPoint.init(x: rect.midX, y: rect.midY))
    }
    
    func drawCircle(posiont:CGPoint) -> Void {
        let ctx = UIGraphicsGetCurrentContext()
//        ctx?.saveGState()
        ctx?.setLineWidth(5)
        ctx?.setFillColor(tintFillColor.cgColor)
        let radius = min(self.bounds.size.width,self.bounds.size.height)/2
        
        ctx?.addArc(center: posiont, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        ctx?.fillPath()
        
    }

}
