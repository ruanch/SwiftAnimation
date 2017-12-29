//
//  GroupAnimationVC.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit

class GroupAnimationVC: UIViewController {

    @IBOutlet weak var spirit: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func groupAnimation1(_ sender: Any) {
        
        let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        
//        //位移动画
//        let anima1 = CAKeyframeAnimation(keyPath: "position")
//        let value0 = NSValue(cgPoint: CGPoint(x: 0, y: SCREEN_HEIGHT/2-50))
//        let value1 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH/3, y: SCREEN_HEIGHT/2-50))
//        let value2 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH/3, y: SCREEN_HEIGHT/2+50))
//        let value3 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH*2/3, y: SCREEN_HEIGHT/2+50))
//        let value4 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH*2/3, y: SCREEN_HEIGHT/2-50))
//        let value5 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH, y: SCREEN_HEIGHT/2-50))
//        anima1.values = [value0,value1,value2,value3,value4,value5]
//        
//        //缩放动画
//        let anima2 = CABasicAnimation(keyPath: "transform.scale")
//        anima2.fromValue = NSNumber(floatLiteral: 0.8)
//        anima2.toValue = NSNumber(floatLiteral: 2.0)
//        
//        //旋转动画
//        let anima3 = CABasicAnimation(keyPath: "transform.rotation")
//        anima3.toValue = NSNumber(floatLiteral: .pi*4)
//        
//        //组动画
//        let groupAnimation = CAAnimationGroup()
//        groupAnimation.animations = [anima1,anima2,anima3]
//        groupAnimation.duration = 4.0
//        
//        self.spirit.layer .add(groupAnimation, forKey: "groupAnimation")
        
    //-------------如下，使用三个animation不分装成group，只是把他们添加到layer，也有组动画的效果。-------------
        
        //位移动画
        let anima1 = CAKeyframeAnimation(keyPath: "position")
        let value0 = NSValue(cgPoint: CGPoint(x: 0, y: SCREEN_HEIGHT/2-50))
        let value1 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH/3, y: SCREEN_HEIGHT/2-50))
        let value2 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH/3, y: SCREEN_HEIGHT/2+50))
        let value3 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH*2/3, y: SCREEN_HEIGHT/2+50))
        let value4 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH*2/3, y: SCREEN_HEIGHT/2-50))
        let value5 = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH, y: SCREEN_HEIGHT/2-50))
        anima1.values = [value0,value1,value2,value3,value4,value5]
        anima1.duration = 4.0
        self.spirit.layer .add(anima1, forKey: "aa")
        
        //缩放动画
        let anima2 = CABasicAnimation(keyPath: "transform.scale")
        anima2.fromValue = NSNumber(floatLiteral: 0.8)
        anima2.toValue = NSNumber(floatLiteral: 2.0)
        anima2.duration = 4.0
        self.spirit.layer .add(anima2, forKey: "bb")
        
        //旋转动画
        let anima3 = CABasicAnimation(keyPath: "transform.rotation")
        anima3.toValue = NSNumber(floatLiteral: .pi*4)
        anima3.duration = 4.0
        self.spirit.layer .add(anima3, forKey: "cc")
        
    }
    
    /**
     *  顺序执行的组动画
     */
    @IBAction func groupAnimation2(_ sender: Any) {
        
        let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    
        let currentTime = CACurrentMediaTime()
        
        //位移动画
        let anima1 = CABasicAnimation(keyPath: "position")
        anima1.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: SCREEN_HEIGHT/2-75))
        anima1.toValue = NSValue(cgPoint: CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2-75))
        anima1.beginTime = currentTime
        anima1.duration = 1.0
        anima1.fillMode = kCAFillModeForwards
        anima1.isRemovedOnCompletion = false
        self.spirit.layer .add(anima1, forKey: "aa")
        
        //绽放动画
        let anima2 = CABasicAnimation(keyPath: "transform.scale")
        anima2.fromValue = NSNumber(floatLiteral: 0.8)
        anima2.toValue = NSNumber(floatLiteral: 2.0)
        anima2.beginTime = currentTime+1.0
        anima2.duration = 1.0
        anima2.fillMode = kCAFillModeForwards
        anima2.isRemovedOnCompletion = false
        self.spirit.layer .add(anima2, forKey: "bb")
        
        //旋转动画
        let anima3 = CABasicAnimation(keyPath: "transform.rotation")
        anima3.toValue = NSNumber(floatLiteral: .pi*4)
        anima3.beginTime = currentTime+2.0
        anima3.duration = 1.0
        anima3.fillMode = kCAFillModeForwards
        anima3.isRemovedOnCompletion = false
        self.spirit.layer .add(anima3, forKey: "cc")
        
    }
}
