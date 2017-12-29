//
//  GTPathButton.swift
//  SwiftAnimation
//
//  Created by 阮沧晖 on 2017/12/26.
//  Copyright © 2017年 阮沧晖. All rights reserved.
//

import UIKit
import  QuartzCore
import AudioToolbox
import CoreGraphics

protocol GTPathButtonDelegate {
    func itemButtonTappedAtIndex(index: Int)
}

class GTPathButton: UIView,GTPathCenterButtonDelegate,GTPathItemButtonDelegate {
    //public
    var delegate: GTPathButtonDelegate?
    
    var itemButtonImages: NSMutableArray = []
    var itemButtonHighlightedImages: NSMutableArray = []
    
    var itemButtonBackgroundImage: UIImage = UIImage()
    var itemButtonBackgroundHighlightedImage: UIImage = UIImage()
    
    var bloomRadius: Float = 0.0
    
    
   
    //private
    var centerImage: UIImage = UIImage()
    var centerHighlightedImage: UIImage = UIImage()
    
    private(set) var bloom = false
    
    var foldedSize: CGSize = CGSize.zero
    var bloomSize: CGSize = CGSize.zero
    
    var foldCenter: CGPoint = CGPoint.zero
    var bloomCenter: CGPoint = CGPoint.zero

    var pathCenterButtonBloomCenter: CGPoint = CGPoint.zero
    
    var expandCenter:CGPoint = CGPoint.zero
    var bottomView: UIView?
    var pathCenterButton: GTPathCenterButton?
     var itemButtons: NSMutableArray = NSMutableArray()
    
    var bloomSound: SystemSoundID = 0
    var foldSound: SystemSoundID = 0
    var selectedSound: SystemSoundID = 0

   
    init(centerImg: UIImage,hilightedImage: UIImage) {
        self.centerImage = centerImg
        self.centerHighlightedImage = hilightedImage
        
        super.init(frame: CGRect.zero)
        
        // Configure views
        //
        self.configureViewsLayout()
        
        // Configure sounds
        //
        self.configureSounds()

    }
    
    
//   func createWithCenterImage(centerImg: UIImage,hilightedImage: UIImage) {
//        // Configure center and high light center image
//        //
//        self.centerImage = centerImg
//        self.centerHighlightedImage = hilightedImage
//    
//        // Init button and image array
//        //
//    
//    
//        // Configure views
//        //
//        configureViewsLayout()
//
//        // Configure sounds
//        //
//        configureSounds()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //super.init(coder: aDecoder)
    }
    
    
    
    func configureViewsLayout() {
        
        self.foldedSize = self.centerImage.size
        self.bloomSize = UIScreen.main.bounds.size
        
        self.bloom = false
        self.bloomRadius = 105.0
        
        // Configure the view's center, it will change after the frame folded or bloomed
        //原来self.foldCenter = CGPointMake(self.bloomSize.width / 2, self.bloomSize.height - 25.5f);
        self.foldCenter = CGPoint(x:self.bloomSize.width/2,y:self.bloomSize.height - 225.5)
        self.bloomCenter = CGPoint(x: self.bloomSize.width/2, y: self.bloomSize.height / 2)
        
        // Configure the DCPathButton's origin frame
        //
        self.frame = CGRect(x: 0, y: 0, width: self.foldedSize.width, height: self.foldedSize.height)
        self.center = self.foldCenter
        
        // Configure center button
        //
        self.pathCenterButton = GTPathCenterButton(image: self.centerImage, highlightedImage: self.centerHighlightedImage)
        self.pathCenterButton?.center = CGPoint(x:self.frame.size.width/2,y:self.frame.size.height/2)
        self.pathCenterButton?.delegate = self
        self .addSubview(self.pathCenterButton!)
        
        // Configure bottom view
        //
        self.bottomView = UIView(frame: CGRect(x: 0, y: 0, width: self.bloomSize.width, height: self.bloomSize.height))
        self.bottomView?.backgroundColor = UIColor.black
        self.bottomView?.alpha = 0.0
        
    }
    
    func configureSounds() {
        // Configure bloom sound
        //
        let bloomSoundPath = Bundle.main.path(forResource: "bloom", ofType: "caf")
        let bloomSoundURL = NSURL(fileURLWithPath: bloomSoundPath!)
        AudioServicesCreateSystemSoundID(bloomSoundURL, &self.bloomSound)
        
        // Configure fold sound
        //
        let foldSoundPath = Bundle.main.path(forResource: "fold", ofType: "caf")
        let foldSoundURL = NSURL(fileURLWithPath: foldSoundPath!)
        AudioServicesCreateSystemSoundID(foldSoundURL, &self.foldSound)
        
        // Configure selected sound
        //
        let selectedSoundPath = Bundle.main.path(forResource: "selected", ofType: "caf")
        let selectedSoundURL = NSURL(fileURLWithPath: selectedSoundPath!)
        AudioServicesCreateSystemSoundID(selectedSoundURL, &self.selectedSound)
        
    }

// MARK: - Center Button Delegate
    func centerButtonTapped() {
        self.bloom ? pathCenterButtonFold() : pathCenterButtonBloom()
    }
    
// MARK:- Caculate The Item's End Point
    func createEndPointWithRadius(itemExpandRadius:CGFloat,angel:CGFloat) -> CGPoint {
        return CGPoint(x: self.pathCenterButtonBloomCenter.x - CGFloat(cosf(Float(angel * CGFloat(Double.pi) + CGFloat(Double.pi)))) * itemExpandRadius,
                       y:self.pathCenterButtonBloomCenter.y - CGFloat(sinf(Float(angel * CGFloat(Double.pi) + CGFloat(Double.pi)))) * itemExpandRadius)
    }
// MARK:- Center Button Fold
    func pathCenterButtonFold(){
        // Play fold sound
        //
        AudioServicesPlaySystemSound(self.foldSound);
        
        // Load item buttons from array
        //
        for i in 1...self.itemButtons.count {
            let itemButton: GTPathItemButton = self.itemButtons[i - 1] as! GTPathItemButton
            
            let currentAngel: Float = Float(i)/(Float(self.itemButtons.count+1))
            let farPoint: CGPoint = self.createEndPointWithRadius(itemExpandRadius: CGFloat(self.bloomRadius + 5.0), angel: CGFloat(currentAngel))
            
            //Animation CoreCode
            let foldAnimation = foldAnimationFromPoint(endPoint: itemButton.center, farPoint: farPoint)
            
            itemButton.layer .add(foldAnimation, forKey: "foldAnimation")
            itemButton.center = self.pathCenterButtonBloomCenter
        }
        
        self.bringSubview(toFront: self.pathCenterButton!)

        // Resize the DCPathButton's frame to the foled frame and remove the item buttons
        //
        resizeToFoldedFrame()
    }
    
    func pathCenterButtonBloom() {
        
        // Play bloom sound
        //
        AudioServicesPlaySystemSound(self.bloomSound);
        
        // Configure center button bloom
        //
        // 1. Store the current center point to 'centerButtonBloomCenter
        //
        self.pathCenterButtonBloomCenter = self.center;
        
        // 2. Resize the DCPathButton's frame
        //
        self.frame = CGRect(x:0, y:0, width:self.bloomSize.width, height:self.bloomSize.height);
        self.center = CGPoint(x:self.bloomSize.width / 2, y:self.bloomSize.height / 2);
        
       
        self.insertSubview(self.bottomView!, belowSubview: self.pathCenterButton!)
        

        // 3. Excute the bottom view alpha animation
        //
        UIView.animate(withDuration: 0.0618 * 3, delay: 0.0, options: .curveEaseIn, animations: { 
            self.bottomView?.alpha = 0.618
        }, completion: nil)

        // 4. Excute the center button rotation animation
        //
        UIView.animate(withDuration: 0.1575) { 
            self.pathCenterButton?.transform = CGAffineTransform(rotationAngle: CGFloat(-0.75 * Double.pi));
        }
        self.pathCenterButton?.center = self.pathCenterButtonBloomCenter
        
        // 5. Excute the bloom animation
        //
        let basicAngel: CGFloat = 180 / CGFloat((self.itemButtons.count + 1))
        for i in 1...self.itemButtons.count{
            let a: AnyObject = self.itemButtons[0] as AnyObject
            
            let pathItemButton = a as! GTPathItemButton
            
            pathItemButton.delegate = self
            pathItemButton.tag = i - 1
            pathItemButton.transform = CGAffineTransform(translationX: 1, y: 1);
            pathItemButton.alpha = 1.0
            
            // 1. Add pathItem button to the view
            //
            let currentAngel:CGFloat = CGFloat((basicAngel * CGFloat(i)) / 180)
            
            pathItemButton.center = self.pathCenterButtonBloomCenter
            
            self.insertSubview(pathItemButton, belowSubview: self.pathCenterButton!)
            
            // 2.Excute expand animation
            //
            let endPoint: CGPoint = self.createEndPointWithRadius(itemExpandRadius: CGFloat(self.bloomRadius), angel: currentAngel)
            let farPoint: CGPoint = self.createEndPointWithRadius(itemExpandRadius: CGFloat(self.bloomRadius+10.0), angel: currentAngel)
            let nearPoint: CGPoint = self.createEndPointWithRadius(itemExpandRadius: CGFloat(self.bloomRadius-5.0), angel: currentAngel)
            
            let bloomAnimation: CAAnimationGroup = self.bloomAnimationWithEndPoint(endPoint: endPoint, farPoint: farPoint, nearPoint: nearPoint)
            
            pathItemButton.layer .add(bloomAnimation, forKey: "bloomAnimation")
            pathItemButton.center = endPoint
            
        }
        
        self.bloom = true
        
    }
    
    func resizeToFoldedFrame() {
        
        UIView.animate(withDuration: 0.0618*3, delay: 0.0618*2, options: .curveEaseIn, animations: { 
            self.pathCenterButton?.transform = CGAffineTransform(rotationAngle: 0);
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.35, options: .curveLinear, animations: {
            self.bottomView?.alpha = 0.0
        }, completion: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            // your code here
            for itemButton in self.itemButtons{
                (itemButton as! GTPathItemButton).removeFromSuperview()
            }
            
            self.frame = CGRect(x: 0, y: 0, width: self.foldedSize.width, height: self.foldedSize.height)
            self.center = self.foldCenter
            self.pathCenterButton?.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
       
            self.bottomView?.removeFromSuperview()
        }
        
        self.bloom = false
        
    }
    
    func foldAnimationFromPoint(endPoint: CGPoint,farPoint: CGPoint) -> CAAnimationGroup {
        // 1.Configure rotation animation
        //
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.values = [NSNumber(value: 0),NSNumber(value: Double.pi),NSNumber(value: Double.pi*2)]
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotationAnimation.duration = 0.35
        
        // 2.Configure moving animation
        //
        let movingAnimation = CAKeyframeAnimation(keyPath: "position")
        
        
        // Create moving path
        //
//        let path: CGMutablePathRef = CGPathCreateMutable()
//        CGPathMoveToPoint(path, NULL, endPoint.x, endPoint.y)
//        CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y)
//        CGPathAddLineToPoint(path, NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y)
        
        let path: CGPath = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).cgPath
    
        movingAnimation.keyTimes = [NSNumber(value: 0), NSNumber(value: 0.75), NSNumber(value: 1.0)]
        
        
        
        
        movingAnimation.path = path
        movingAnimation.duration = 0.35
        //CGPathRelease(path)
        
        // 3.Merge animation together
        //
        let animations: CAAnimationGroup = CAAnimationGroup()
        animations.animations = [rotationAnimation, movingAnimation];
        animations.duration = 0.35;
        
        return animations;
    }
    
    func bloomAnimationWithEndPoint(endPoint: CGPoint,farPoint: CGPoint,nearPoint: CGPoint) -> CAAnimationGroup {
        
        // 1.Configure rotation animation
        //
        let rotationAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.duration = 0.3
        rotationAnimation.values = [NSNumber(value:0.0),NSNumber(value:-Double.pi),NSNumber(value:-Double.pi*1.5),NSNumber(value:-Double.pi*2)]
        rotationAnimation.keyTimes = [NSNumber(value:0.0),NSNumber(value:0.3),NSNumber(value:0.6),NSNumber(value:1.0)]
        
        // 2.Configure moving animation
        //
        let movingAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        
        // Create moving path
        //
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGPathMoveToPoint(path, NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y);
//        CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
//        CGPathAddLineToPoint(path, NULL, nearPoint.x, nearPoint.y);
//        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
//        
//        movingAnimation.path = path;
//        movingAnimation.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
//        movingAnimation.duration = 0.3f;
//        CGPathRelease(path);
        
        let path: CGPath = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).cgPath
        movingAnimation.path = path;
        movingAnimation.keyTimes = [NSNumber(value: 0), NSNumber(value: 0.75), NSNumber(value: 1.0)];
        movingAnimation.duration = 0.3;
        
        // 3.Merge two animation together
        //
        let animations: CAAnimationGroup = CAAnimationGroup()
        animations.animations = [rotationAnimation, movingAnimation];
        animations.duration = 0.3;
        
        return animations;
        
    }
    
    func itemButtonTapped(itemButton: GTPathItemButton) {
        
//        if ((self.delegate?.itemButtonTappedAtIndex(index: 0)) != nil)  {
//            
//        }
        
        let selectedButton = self.itemButtons[itemButton.tag] as! GTPathItemButton
        
        // Play selected sound
        //
        AudioServicesPlaySystemSound(self.selectedSound);
        
        // Excute the explode animation when the item is seleted
        //
        UIView.animate(withDuration: 0.0618*5) { 
            selectedButton.transform = CGAffineTransform(scaleX: 3, y: 3);
            selectedButton.alpha = 0.0
        }
        
        // Excute the dismiss animation when the item is unselected
        //
        for i in 0...self.itemButtons.count {
            if i == selectedButton.tag {
                continue
            }
            
            let unselectedButton = self.itemButtons[i] as! GTPathItemButton
            UIView.animate(withDuration: 0.0618 * 2, animations: { 
                unselectedButton.transform = CGAffineTransform(scaleX: 0, y: 0);
            })
        }
        
        // Excute the delegate method
        //
        self.delegate?.itemButtonTappedAtIndex(index: itemButton.tag)
        
        // Resize the DCPathButton's frame
        //
        self.resizeToFoldedFrame()
        
    }
    
//MARK: - Add PathButton Item
    func addPathItems(pathItemButtons: NSArray){
        self.itemButtons.setArray(pathItemButtons as! [Any])
    }
//MARK: - DCPathButton Touch Events 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pathCenterButtonFold()
    }
}
