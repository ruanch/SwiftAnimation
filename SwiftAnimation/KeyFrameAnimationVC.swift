//
//  KeyFrameAnimationVC.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit

class KeyFrameAnimationVC: UIViewController,CAAnimationDelegate {

    @IBOutlet weak var spirit: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
     *  关键帧动画
     */
    @IBAction func keyFrameAnimation(_ sender: Any) {
        
        
        
        let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        
        let anima = CAKeyframeAnimation(keyPath: "position")
        let value0 = NSValue(cgPoint: CGPoint(x: 0, y: SCREEN_HEIGHT/2-50))
        let value1 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH/3, y: SCREEN_HEIGHT/2-50))
        let value2 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH/3, y: SCREEN_HEIGHT/2+50))
        let value3 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH*2/3, y: SCREEN_HEIGHT/2+50))
        let value4 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH*2/3, y: SCREEN_HEIGHT/2-50))
        let value5 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH, y: SCREEN_HEIGHT/2-50))
        
        anima.values = [value0,value1,value2,value3,value4,value5]
        anima.duration = 2.0
        anima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anima.delegate = self
        self.spirit.layer .add(anima, forKey: "keyFrameANimation")
        
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        NSLog("开始动画");
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        NSLog("结束动画");
    }
    /**
     *  path动画
     */
    @IBAction func pathAnimation(_ sender: Any) {
        
        let anima = CAKeyframeAnimation(keyPath: "position")
        let path: CGPath = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).cgPath
        anima.path = path
        anima.duration = 2.0
        self.spirit.layer .add(anima, forKey: "pathAnimation")
    }
    
    /**
     *  抖动效果
     */
    @IBAction func shakeAnimation(_ sender: Any) {
        
        let anima = CAKeyframeAnimation(keyPath: "transform.rotation")
        let value1 = NSNumber(floatLiteral:-.pi/180*4)
        let value2 = NSNumber(floatLiteral:.pi/180*4)
        let value3 = NSNumber(floatLiteral:-.pi/180*4)
        anima.values = [value1,value2,value3]
        anima.repeatCount = MAXFLOAT
        self.spirit.layer .add(anima, forKey: "shakeAnimation")
        
    }
}
