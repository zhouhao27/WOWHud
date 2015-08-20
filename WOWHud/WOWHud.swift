//
//  WOWHud.swift
//  WOWHud
//
//  Created by Zhou Hao on 20/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

public final class WOWHud: UIView {

    static let kIndicatorWidth : CGFloat = 48
    static let kPadding : CGFloat = 10
    
    private static var instance : WOWHud? = nil
    private var rippleIndicator : WOWRippleIndicator? = nil
    
    public var text : String = ""
    
    public class func showHudInView(parentView : UIView) -> WOWHud {
        
        if WOWHud.instance == nil {
            WOWHud.instance = WOWHud(frame: parentView.bounds)
        }
        
        let hud = WOWHud.instance!
        hud.opaque = false
        
        if hud.superview != nil {
            hud.removeFromSuperview()
        }
        
        parentView.addSubview(hud)
        hud.userInteractionEnabled = false
        hud.showAnimated()
    
        hud.createRippleIndicator()
        hud.setNeedsDisplay()
        
        // apply blur effect
//        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        let effectView = UIVisualEffectView (effect: blur)
//        effectView.frame = hud.frame
//        parentView.addSubview(effectView)
//        parentView.sendSubviewToBack(effectView)
        
        return hud
    }
    
    public class func dismissHud() {

        if WOWHud.instance != nil {
            let hud = WOWHud.instance!
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                hud.alpha = 0

            }) { (finished) -> Void in

                hud.removeFromSuperview()
                WOWHud.instance = nil
            }
        }
    }
    
    private func showAnimated() {
        
        self.alpha = 0.0
        self.transform = CGAffineTransformMakeScale(1.3,1.3)
        UIView.animateWithDuration(0.4) { () -> Void in
            self.alpha = 1.0
            self.transform = CGAffineTransformIdentity
        }
    }
    
    private func createRippleIndicator() {
        rippleIndicator = WOWRippleIndicator()
        let frame = CGRectMake(self.center.x - WOWHud.kIndicatorWidth / 2 , self.center.y - WOWHud.kIndicatorWidth / 2 - WOWHud.kPadding * 2 / 3,  WOWHud.kIndicatorWidth, WOWHud.kIndicatorWidth)
        rippleIndicator!.frame = frame
        rippleIndicator!.backgroundColor = UIColor.clearColor()
        rippleIndicator!.degree = 0
        rippleIndicator!.rippleColor = UIColor.whiteColor()
        rippleIndicator!.rippleLineWidth = 2
        self.addSubview(rippleIndicator!)
        rippleIndicator!.startAnimation()
    }
    
    override public func drawRect(rect: CGRect) {

        let mytext = self.text as NSString
        var textSize = mytext.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(14)])
        if textSize.width == 0 {
            textSize.height = 0
        }
        
        let w = max(textSize.width, WOWHud.kIndicatorWidth) + 2 * WOWHud.kPadding
        let h = WOWHud.kIndicatorWidth + textSize.height + 2 * WOWHud.kPadding
        
        // assum bounds width is > w, bounds height > h
        let boxRect = CGRectMake( (self.bounds.size.width - w) / 2.0, (self.bounds.size.height - h) / 2.0, w,h);
        let roundedRect = UIBezierPath(roundedRect: boxRect, cornerRadius: 10.0)
        UIColor(white: 0, alpha: 0.75).setFill()
        roundedRect.fill()
        
        // TODO: the calculation is not very correct
//        let textPoint = CGPointMake( self.center.x - textSize.width / 2.0, self.center.y + WOWHud.kIndicatorWidth / 2 + WOWHud.kPadding / 3)
        let textPoint = CGPointMake( self.center.x - textSize.width / 2.0, self.center.y + WOWHud.kIndicatorWidth / 2)

        mytext.drawAtPoint(textPoint, withAttributes:
            [NSFontAttributeName : UIFont.systemFontOfSize(14),
            NSForegroundColorAttributeName : UIColor.whiteColor()])
    }

}
