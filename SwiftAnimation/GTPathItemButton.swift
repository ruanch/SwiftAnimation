//
//  GTPathItemButton.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/27.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit

protocol GTPathItemButtonDelegate {
    func itemButtonTapped(itemButton: GTPathItemButton)
}

class GTPathItemButton: UIImageView {

    var delegate: GTPathItemButtonDelegate?
    
    var index = 0
    
    private(set) var backgroundImageView: UIImageView?
    

    init(image: UIImage?, highlightedImage: UIImage?,backgroundImage: UIImage?,backgroundHighlightedImage: UIImage?) {
        
        super.init(image: image, highlightedImage: highlightedImage)
        
        // Make sure the iteam has a certain frame
        //
        let itemFrame = CGRect(x: 0, y: 0, width: (backgroundImage?.size.width)!, height: (backgroundImage?.size.height)!)
        self.frame = itemFrame
        
        // Configure the item image
        //
        self.image = backgroundImage
        self.highlightedImage =  backgroundHighlightedImage
        
        self.isUserInteractionEnabled = true
        
        // Configure background
        //
        self.backgroundImageView = UIImageView(image: image, highlightedImage: highlightedImage)
        
        self.backgroundImageView?.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        
        self .addSubview(self.backgroundImageView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = true
        self.backgroundImageView?.isHighlighted = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var currentLocation: CGPoint?
        for touch: AnyObject in touches {
            let t:UITouch = touch as! UITouch
            currentLocation = t.location(in: self)
        }
        
        // Cancel button highlight when the touch location is out of 5x area
        //
        if !scaleRect(originRect: self.bounds).contains(currentLocation!) {
            self.isHighlighted = false
            self.backgroundImageView?.isHighlighted = false
            return
        }
        
        self.isHighlighted = true
        self.backgroundImageView?.isHighlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate?.itemButtonTapped(itemButton: self)
        
        self.isHighlighted = false
        self.backgroundImageView?.isHighlighted = false
    }
    
    func scaleRect(originRect:CGRect) -> CGRect {
        return CGRect(x: -originRect.size.width*2, y: -originRect.size.height*2, width: originRect.size.width*5, height: originRect.size.height*5)
    }
}

