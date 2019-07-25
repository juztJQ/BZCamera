//
//  CameraFocusSquare.swift
//  BZCamera
//
//  Created by Juanelo on 7/25/19.
//  Copyright © 2019 Juanelo. All rights reserved.
//

import UIKit

class CameraFocusSquare: UIView , CAAnimationDelegate{
    
    var view: UIView!
    internal let zSelectionAnimation: String = "selectionAnimation"
    internal let kScaleAnimation: String = "scaleAnimation"
    
    fileprivate var _selectionBlink : CABasicAnimation?
    fileprivate var _scaleAnimation : CABasicAnimation?
    
    convenience init(touchPoint: CGPoint) {
        self.init()
        self.updatePoint(touchPoint)
        self.backgroundColor = UIColor.clear
        /** BLINK EFFECT */
        //self.layer.borderWidth = 2.0
        //self.layer.borderColor = UIColor.orange.cgColor
        //initBlink()
        
        self.xibSetup()
        self.animateSolidAway()
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        xibSetup()
    }
    
    fileprivate func initBlink(){
        self._selectionBlink = CABasicAnimation(keyPath: "borderColor")
        self._selectionBlink?.toValue = (UIColor.white.cgColor as AnyObject)
        self._selectionBlink?.repeatCount = 3
        // number blinks
        self._selectionBlink!.duration = 0.4
        // duration blinks
        self._selectionBlink?.delegate = self
    }
    
    func animateSolidAway() {
        _scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        _scaleAnimation!.fromValue = 1
        _scaleAnimation!.toValue = 1.5
        _scaleAnimation!.duration = 0.7
        _scaleAnimation!.delegate = self
        _scaleAnimation?.fillMode = CAMediaTimingFillMode.forwards
        _scaleAnimation!.isRemovedOnCompletion = false
        _scaleAnimation!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init Coder hast not been implemented")
    }
    
    func xibSetup(){
        view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView{
        let nib = UINib(nibName: "cameraFocusSquare", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    /**
     Updates the location of the view based on the incoming touchPoint.
     */
    func updatePoint(_ touchPoint : CGPoint){
        let squareWidth: CGFloat = 80
        let frame: CGRect = CGRect(x: touchPoint.x - squareWidth / 2, y: touchPoint.y - squareWidth / 2, width: squareWidth, height: squareWidth)
        self.frame = frame
    }
    /**
     This unhides the view and initiates the animation by adding it to the layer.
     */
    func animateFocusingAction() {
        if let blink = _selectionBlink {
            // make the view visible
            self.alpha = 1.0
            self.isHidden = false
            // initiate the animation
            self.layer.add(blink, forKey: zSelectionAnimation)
        }
        
        if let scale = _scaleAnimation {
            // make the view visible
            self.alpha = 1.0
            self.isHidden = false
            // initiate the animation
            self.layer.add(scale, forKey: kScaleAnimation)
        }
    }
    
    /**
     Hides the view after the animation stops. Since the animation is automatically removed,
     we don't need to do anything else here.
     */
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if flag {
            // hide the view
            //self.alpha = 0.0
            //self.isHidden = true
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.alpha = 0.0
            }, completion: { (completed) in
                self.isHidden = true
            })
        }
    }

}
