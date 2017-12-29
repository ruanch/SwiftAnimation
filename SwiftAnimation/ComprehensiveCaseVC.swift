//
//  ComprehensiveCaseVC.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit

class ComprehensiveCaseVC: UIViewController,GTPathButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
     
    @IBAction func pathClickAction(_ sender: Any) {
        
        configureGTPathButton()
    }

    @IBAction func dingdingClickAction(_ sender: Any) {
    }
     
    @IBAction func goodClickAction(_ sender: Any) {
    }
    
    
    func configureGTPathButton(){
        // Configure center button
        //
        let img1: UIImage = UIImage(named: "chooser-button-tab")!
        let img2: UIImage = UIImage(named: "chooser-button-tab-highlighted")!
        let  gtPathButton = GTPathButton(centerImg: img1, hilightedImage: img2)
        gtPathButton.delegate = self
    
        
        
        // Configure item buttons
        //
        let itemButton_1: GTPathItemButton = GTPathItemButton(image: UIImage(named: "chooser-moment-icon-music"), highlightedImage: UIImage(named: "chooser-moment-icon-music-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        
        gtPathButton .addPathItems(pathItemButtons: [itemButton_1])
    
        self.view .addSubview(gtPathButton)
    }
    
    func itemButtonTappedAtIndex(index: Int) {
        
    }
}
