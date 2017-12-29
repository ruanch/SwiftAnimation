//
//  TransitionAnimationVC.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit

class TransitionAnimationVC: UIViewController {

    @IBOutlet weak var spirit: UIView!
    @IBOutlet weak var tip: UILabel!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        index = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /**
     *  逐渐消失
     */
    @IBAction func fadeAnimation(_ sender: Any) {
        changeView(isUp: true)
        
        let anima = CATransition()
        anima.type = kCATransitionFade //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.startProgress = 0.3//设置动画起点
        anima.endProgress = 0.8//设置动画终点
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "fadeAnimation")
        
    }

    @IBAction func moveInAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = kCATransitionMoveIn //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        //anima.startProgress = 0.3//设置动画起点
        //anima.endProgress = 0.8//设置动画终点
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "moveInAnimation")
    }
    
    @IBAction func pushAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = kCATransitionPush //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "pushAnimation")
    }
    
    @IBAction func revealAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = kCATransitionReveal //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "revealAnimation")
    }
    
    @IBAction func cubeAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "cube" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "cubeAnimation")

    }
    
    @IBAction func suckEffectAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "suckEffect" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "suckEffectAnimation")
    }
    
    @IBAction func oglFlipAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "oglFlip" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "oglFlipAnimation")
    }
    
    @IBAction func rippleEffectAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "rippleEffect" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "rippleEffectAnimation")
    }
    
    @IBAction func pageCurlAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "pageCurl" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "pageCurlAnimation")
    }
    
    @IBAction func pageUnCurlAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "pageUnCurl" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "pageUnCurlAnimation")
    }
    
    
    @IBAction func cameraIrisHollowOpenAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "cameraIrisHollowOpen" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "pageUnCurlAnimation")
    }
    
    
    @IBAction func cameraIrisHollowCloseAnimation(_ sender: Any) {
        changeView(isUp: true)
        let anima = CATransition()
        anima.type = "cameraIrisHollowClose" //设置动画的类型
        anima.subtype = kCATransitionFromRight//设置动画的方向
        anima.duration = 1.0
        spirit.layer .add(anima, forKey: "pageUnCurlAnimation")
    }
    
    func changeView(isUp:Bool) -> Void {
        if index > 3 {
            index = 0
        }
        if index < 0 {
            index = 3
        }
        
        let colors = [UIColor.cyan,UIColor.magenta,UIColor.orange,UIColor.purple]
        let titles = ["1","2","3","4"]
        spirit.backgroundColor = colors[index]
        tip.text = titles[index]
        if isUp {
            index += 1
        }else{
            index -= 1
        }
    }
    
    
}
