//
//  ViewController.swift
//  circleLoading
//
//  Created by huahuahu on 2017/10/8.
//  Copyright © 2017年 huahuahu. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    let circlePathLayer = CAShapeLayer.init()
    let circleRadius:CGFloat = 50
    let lineWidth:CGFloat = 2.0
    
    let strokePercent:CGFloat = 0.4//弧度的比例
    
    lazy var layerFrame: CGRect = {
    
        let viewWidth = view.bounds.width
        let viewHeight = view.bounds.height
        
        return CGRect.init(x: viewWidth/2 - circleRadius, y: viewHeight/2 - circleRadius, width: 2 * circleRadius, height: 2 * circleRadius)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configerBackGroundLayer()
        self.configerForeGroundLayer()
        self.darwCheckMark()
    }

    func configerBackGroundLayer() -> Void {
        let backGroundLayer = CAShapeLayer.init()
        
        backGroundLayer.frame = layerFrame
        backGroundLayer.lineWidth = lineWidth
        backGroundLayer.fillColor = UIColor.clear.cgColor
        backGroundLayer.strokeColor = UIColor.gray.cgColor
        view.layer.addSublayer(backGroundLayer)
        
        //要用bounds，而不是frame
        let path = UIBezierPath.init(ovalIn: backGroundLayer.bounds)
        backGroundLayer.path = path.cgPath
    }
    
    func configerForeGroundLayer() ->  Void {
        circlePathLayer.frame = layerFrame
        circlePathLayer.lineWidth = lineWidth
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.red.cgColor
        view.layer.addSublayer(circlePathLayer)
        
        //要用bounds，而不是frame
        let path = UIBezierPath.init(ovalIn: circlePathLayer.bounds)
        circlePathLayer.path = path.cgPath
        circlePathLayer.strokeStart = 0.0
        circlePathLayer.strokeEnd = strokePercent
        self.startAnimate()
    }

    func startAnimate() -> Void {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            
            //旋转
            //由于 strokeEnd 必须比 strokeStart 大，所以越界时不好处理。使用旋转整个layer的方法来实现
//            https://stackoverflow.com/questions/33185956/cashapelayer-draw-partially-through-path-end-points
            let targetTransForm = self.circlePathLayer.affineTransform().concatenating(CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/5)))
            self.circlePathLayer.setAffineTransform(targetTransForm)
        }
    }
    
    //一个对号
    func darwCheckMark() -> Void {
        let chekMarkLayer = CAShapeLayer.init()
        chekMarkLayer.frame = self.layerFrame
        chekMarkLayer.lineJoin = kCALineJoinRound
        chekMarkLayer.lineCap = kCALineCapRound
        chekMarkLayer.fillColor = UIColor.clear.cgColor
        chekMarkLayer.strokeColor = UIColor.blue.cgColor
        chekMarkLayer.lineWidth = lineWidth * 3
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: chekMarkLayer.frame.width/6, y: chekMarkLayer.frame.height/2))
        path.addLine(to: CGPoint.init(x: chekMarkLayer.frame.width * 5 / 12, y: chekMarkLayer.frame.height * 3 / 4))
        path.addLine(to: CGPoint.init(x: chekMarkLayer.frame.width * 5 / 6, y: chekMarkLayer.frame.height / 4))
        
        chekMarkLayer.path = path.cgPath
        let animation = CABasicAnimation.init()
        animation.duration = 2
        animation.fromValue = 0
        animation.toValue = 1
        //挑一个好的时间函数
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        chekMarkLayer.add(animation, forKey: "strokeEnd")
        
        
        view.layer.addSublayer(chekMarkLayer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

