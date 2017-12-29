//
//  AffineAnimationVC.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit

class AffineAnimationVC: UIViewController {

    @IBOutlet weak var spirit: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func positionAnimation(_ sender: Any) {
    
        UIView.animate(withDuration: 1.0) { 
            self.spirit.transform = __CGAffineTransformMake(0, 0, 100, 100, 100, 100)
        }
        
    }

    @IBAction func scaleAnimation(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0) {
             
        }
        
    }
    
    @IBAction func rotateAnimation(_ sender: Any) {
    }
    
    
    @IBAction func combinationAnimation(_ sender: Any) {
    }
    
    @IBAction func invertAnimation(_ sender: Any) {
    }
}
