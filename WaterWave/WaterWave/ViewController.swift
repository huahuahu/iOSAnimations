//
//  ViewController.swift
//  WaterWave
//
//  Created by huahuahu on 2017/10/8.
//  Copyright © 2017年 huahuahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let lineWidth:CGFloat = 2.0
    let lineColor = UIColor.blue.cgColor
    var waveLength:Double?
    let waveheight:Double = 10 //振幅
    let wavePeriod:Double = 0.5  //周期
    
    let waveLayer1 = CAShapeLayer.init()
    let waveLayer2 = CAShapeLayer.init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        waveLength =  Double.init(view.bounds.size.width/2)

        //wavelayer1
        waveLayer1.frame = self.view.bounds
        waveLayer1.strokeColor = UIColor.clear.cgColor
        waveLayer1.fillColor = lineColor
        waveLayer1.lineWidth = lineWidth
        view.layer.addSublayer(waveLayer1)
        
        //wavelayer2
        waveLayer2.frame = self.view.bounds
        waveLayer2.strokeColor = UIColor.clear.cgColor
        waveLayer2.fillColor = UIColor.green.cgColor
        waveLayer2.lineWidth = lineWidth
        view.layer.addSublayer(waveLayer2)

        let displayLink = CADisplayLink.init(target: self, selector: #selector(configerLayer))
        displayLink.add(to: RunLoop.main , forMode: .defaultRunLoopMode)
    }
    

    @objc func configerLayer() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate

        //wave1
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: waveLayer1.bounds.size.width, y: waveLayer1.bounds.size.height))
        path.addLine(to: CGPoint.init(x: 0, y: waveLayer1.bounds.size.height))
        
        
        
        for x in 0...Int(waveLayer1.bounds.size.width) {
            let phase = 2 * Double.pi * currentTime / wavePeriod - 2 * Double.pi * Double(x) / waveLength!
            let y = waveheight * sin(phase) + Double(waveLayer1.bounds.size.height / 2)
            path.addLine(to: CGPoint.init(x: Double(x), y: y))
            
        }
        path.addLine(to: CGPoint.init(x: waveLayer1.bounds.size.width, y: waveLayer1.bounds.size.height))
        waveLayer1.path = path.cgPath
        
        //wave2
        let path1 = UIBezierPath.init()
        path1.move(to: CGPoint.init(x: waveLayer1.bounds.size.width, y: waveLayer1.bounds.size.height))
        path1.addLine(to: CGPoint.init(x: 0, y: waveLayer1.bounds.size.height))
        
        for x in 0...Int(waveLayer1.bounds.size.width) {
            let phase = 2 * Double.pi * currentTime / wavePeriod - 2 * Double.pi * Double(x) / waveLength! - Double.pi
            let y = waveheight * sin(phase) + Double(waveLayer1.bounds.size.height / 2)
            path1.addLine(to: CGPoint.init(x: Double(x), y: y))
            
        }
        path1.addLine(to: CGPoint.init(x: waveLayer1.bounds.size.width, y: waveLayer1.bounds.size.height))
        waveLayer2.path = path1.cgPath
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

