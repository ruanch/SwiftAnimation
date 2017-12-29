//
//  GTPathCenterButton.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/27.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit
import CoreGraphics

protocol GTPathCenterButtonDelegate {
    func centerButtonTapped()
}


class GTPathCenterButton: UIImageView {
    var delegate: GTPathCenterButtonDelegate?
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        
        self.isUserInteractionEnabled = true
        
        self.image = image
        self.highlightedImage = highlightedImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = true
        // Center button Begin Tapped
        if ((self.delegate?.centerButtonTapped()) != nil) {
            self.delegate?.centerButtonTapped()
        }
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
            return
        }
        
        // If moving in the 3x area, keep the highlight state
        //
        self.isHighlighted = true;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = false
    }
    
    func scaleRect(originRect:CGRect) -> CGRect {
        return CGRect(x: -originRect.size.width, y: -originRect.size.height, width: originRect.size.width*3, height: originRect.size.height*3)
    }
}
