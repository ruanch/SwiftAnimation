//
//  BaseAnimationVC.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit



class BaseAnimationVC: UIViewController {

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
     *  位移动画演示
     */
    @IBAction func moveAnimation(_ sender: Any) {
        //使用CABasicAnimation创建基础动画
        let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//        let anima: CABasicAnimation = CABasicAnimation(keyPath: "position")
//        anima.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: SCREEN_HEIGHT/2-75))
//        anima.toValue = NSValue(cgPoint: CGPoint(x:SCREEN_WIDTH, y:SCREEN_HEIGHT/2-75))
//        anima.duration = 1.0
//        //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
//        //anima.fillMode = kCAFillModeForwards
//        //anima.isRemovedOnCompletion = false
//        
//        anima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        self.spirit.layer .add(anima, forKey: "moveAnimation")
        
        //使用UIView Animation 代码块调用
//        UIView.animate(withDuration: 1.0, animations: {
//            self.spirit.frame = CGRect(x: SCREEN_WIDTH, y: SCREEN_HEIGHT, width: 120, height: 120)
//        }) {(true) in
//            self.spirit.frame = CGRect(x: 0, y: 120, width: 120, height: 120)
//        }
        
        //使用UIView [begin,commit]模式
        UIView .beginAnimations(nil, context: nil)
        UIView .setAnimationDuration(1.0)
        self.spirit.frame = CGRect(x: SCREEN_WIDTH, y: SCREEN_HEIGHT, width: 120, height: 120)
        UIView .commitAnimations()
        
        
    }
    /**
     *  透明度动画
     */
    @IBAction func opacityAniamtion(_ sender: Any) {
        
        let anima: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        anima.fromValue = NSNumber(floatLiteral: 1.0)
        anima.toValue = NSNumber(floatLiteral: 0.2)
        anima.duration = 1.0
        self.spirit.layer .add(anima, forKey: "opacityAniamtion")
        
    }
    /**
     *  缩放动画
     */
    @IBAction func scaleAnimation(_ sender: Any) {
        
        let anima: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        anima.toValue = NSNumber(floatLiteral:2.0)
        anima.duration = 1.0
        self.spirit.layer .add(anima, forKey: "scaleAnimation")
        
    }
    /**
     *  旋转动画
     */
    @IBAction func rotateAnimation(_ sender: Any) {
        
        let anima: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotate.z")
        anima.toValue = NSNumber(floatLiteral:.pi)
        anima.duration = 1.0
        self.spirit.layer .add(anima, forKey: "rotateAnimation")
        
    }
    /**
     *  背景色变化动画
     */
    @IBAction func backgroundAnimation(_ sender: Any) {
        
        let anima: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        anima.toValue = UIColor(red: 122/255.0, green: 122/255.0, blue: 122/255.0, alpha: 1.0)
        anima.duration = 1.0
        self.spirit.layer .add(anima, forKey: "backgroundAnimation")
        
    }
}
