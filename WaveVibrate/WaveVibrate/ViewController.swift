//
//  ViewController.swift
//  WaveVibrate
//
//  Created by huahuahu on 2017/10/8.
//  Copyright © 2017年 huahuahu. All rights reserved.
//

import UIKit

let tintFillColor = UIColor.init(red: 1, green: 0.647, blue: 0.137, alpha: 1)



class ViewController: UIViewController {
    
    let centerRadius:CGFloat = 40
    let outRadius:CGFloat = 75
    let animateViewCount = 10
    var animateViewArray:[CircleView]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let circleViewFrame = CGRect.init(x: view.frame.width/2 - centerRadius, y: view.frame.height/2 - centerRadius, width: centerRadius * 2, height: centerRadius * 2)
        
        let circleView = CircleView.init(frame: circleViewFrame)
        circleView.backgroundColor = UIColor.clear
        view.addSubview(circleView)
        self.createAnimateViews()
        self.animateViews()
    }
    
    func createAnimateViews() -> Void {
        animateViewArray = [CircleView]()
        
        for _ in 0..<animateViewCount {
            let subview = CircleView.init(frame: CGRect.zero)
            subview.backgroundColor = UIColor.clear
            subview.center = CGPoint.init(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
            subview.alpha = 0.9
            animateViewArray?.append(subview)
            view.addSubview(subview)
        }
    }
    
    
    func animateViews() -> Void {
        
        for circleView in animateViewArray! {
            self.animateView(circleView: circleView)
        }
    }
    
    func animateView(circleView:CircleView) -> Void {
        //通过同时改变view的alpha值和frame来达到效果
        let randomDuration = arc4random() % 40 + 10
        let randomDelay = arc4random() % 40 + 20
        UIView.animate(withDuration: TimeInterval(randomDuration/15), delay: TimeInterval(randomDelay/70), options: .curveEaseInOut, animations: {
            circleView.frame = CGRect.init(x: self.view.frame.width/2 - self.outRadius, y: self.view.frame.height / 2 - self.outRadius, width: self.outRadius * 2, height: self.outRadius * 2)
            circleView.alpha = 0
        }, completion: { (finished) in
            circleView.alpha = 0.9
            circleView.frame = CGRect.zero
            circleView.center = CGPoint.init(x: self.view.frame.width/2, y: self.view.frame.height/2)
            self.animateView(circleView: circleView)
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

