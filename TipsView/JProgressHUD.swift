//
//  JProgressHUD.swift
//  1
//
//  Created by Johnson on 16/3/3.
//  Copyright © 2016年 Johnson. All rights reserved.
//

import UIKit

enum JDismissType{
    case Alpha
    case Scale
    case None
}

private let JAppdelegateWindow: UIView = ((UIApplication.sharedApplication().delegate?.window)!)!
private let JHudTag: Int = 983221


class JProgressHUD: UIView {
    
    //TODO: Properties
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
    
    var backgroundView: UIView?
    let activityIndicatorView: UIActivityIndicatorView  = UIActivityIndicatorView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(33, 33)))
    let label: UILabel = UILabel()
    let hudView: UIView = UIView()
    
    

    //TODO: Private Methods
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private init(text: String, shadow: Bool, canTouch: Bool) {
        super.init(frame: CGRectZero)
        
        self.show(text, shadow: shadow, canTouch: canTouch)
    }
    
    private func show(text: String, shadow: Bool, canTouch: Bool) {
        self.tag = JHudTag
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        self.userInteractionEnabled = !canTouch
        
        if shadow {
            self.backgroundView = UIView(frame: self.frame)
            self.backgroundView?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            
            self.userInteractionEnabled = true
            self.addSubview(self.backgroundView!)
        }
        
        self.label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.label.numberOfLines = 0
        self.label.font = UIFont.boldSystemFontOfSize(11)
        self.label.textAlignment = NSTextAlignment.Center
        self.label.textColor = UIColor.whiteColor()
        self.label.backgroundColor = UIColor.clearColor()
        
        
        self.addSubview(self.hudView)
        self.hudView.addSubview(self.activityIndicatorView)
        self.hudView.addSubview(self.label)
        
        self.setText(text)
    }
    
    
    private func setText(text: String) {
        self.label.text = text
        self.label.resetWidth(160)
        self.label.sizeToFit()
        
        
        self.hudView.frame = CGRectMake(0, 0, self.label.getWidth() < 50 ? 80 : self.label.getWidth() + 30, 0)
        self.hudView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.hudView.layer.cornerRadius = 8.8;
        
        
        self.activityIndicatorView.frame = CGRectMake((self.hudView.frame.size.width - self.activityIndicatorView.frame.size.width) / 2, 20, self.activityIndicatorView.frame.size.width, self.activityIndicatorView.frame.size.height)
        self.activityIndicatorView.startAnimating()
        
        
        self.label.center = self.activityIndicatorView.center
        self.label.resetY(self.activityIndicatorView.originY_SizeHeight() + 4)
    
        
        self.hudView.resetHeight(self.label.originY_SizeHeight() + 10)
        self.hudView.center = JAppdelegateWindow.center
    }
    
    
    private static func dismiss(view: UIView?, type: JDismissType) {

        if let hud: JProgressHUD = ((view != nil) ? view?.viewWithTag(JHudTag) as? JProgressHUD : JAppdelegateWindow.viewWithTag(JHudTag) as? JProgressHUD) {
            
            UIView.animateWithDuration(type == JDismissType.None ? 0 : 0.15, animations: { () -> Void in
                    if type == JDismissType.Scale {
                        hud.hudView.transform = CGAffineTransformMakeScale(0.7, 0.7)
                    }else {
                        
                        hud.alpha = 0.0;
                    }
                }, completion: { (completiom) -> Void in
                    hud.activityIndicatorView.stopAnimating()
                    hud.removeFromSuperview()
            })
            
        }
    }
    
    
    //TODO: Public Methods
    //显示在JAppdelegateWindow上面
    static func showInAppdelegateWindow(text: String) {
        showInAppdelegateWindow(text, canTouch: false)
    }
    
    static func showInAppdelegateWindow(text: String, canTouch: Bool) {
        JProgressHUD.showInAppdelegateWindow(text, shadow: false, canTouch: canTouch)
    }
    
    static func showInAppdelegateWindow(text: String, shadow: Bool, canTouch: Bool) {
        JProgressHUD.showInView(JAppdelegateWindow, text: text, shadow: shadow, canTouch: canTouch)
    }
    
    
    //显示在自定义视图上面
    static func showInView(view: UIView, text: String) {
        JProgressHUD.showInView(view, text: text, canTouch: false)
    }
    
    static func showInView(view: UIView, text: String, canTouch: Bool) {
        JProgressHUD.showInView(view, text: text, shadow: false, canTouch: canTouch)
    }
    
    static func showInView(view: UIView, text: String, shadow: Bool) {
        JProgressHUD.showInView(view, text: text, shadow: shadow, canTouch: false)
    }
    
    static func showInView(view: UIView, text: String, shadow: Bool, canTouch: Bool) {
        
        if let hud = JAppdelegateWindow.viewWithTag(JHudTag) {
            if view !== JAppdelegateWindow {
                hud.removeFromSuperview()
            }
        }
        
        
        if view.viewWithTag(JHudTag) == nil {
            view.addSubview(JProgressHUD(text: text, shadow: shadow, canTouch: canTouch))
        }else  {
            (view.viewWithTag(JHudTag) as? JProgressHUD)?.setText(text)
        }
    }
    
    
    //从JAppdelegateWindow上面dismiss
    static func dismissForScale() {
        JProgressHUD.dismiss(nil, type: JDismissType.Scale)
    }
    
    static func dismissForAlpha() {
        JProgressHUD.dismiss(nil, type: JDismissType.Alpha)
    }
    
    static func dismiss() {
        JProgressHUD.dismiss(nil, type: JDismissType.None)
    }
    
    //从固定视图上面dismiss
    static func dismissFromViewForScale(view: UIView) {
        JProgressHUD.dismiss(view, type: JDismissType.Scale)
    }
    
    static func dismissFromViewForAlpha(view: UIView) {
        JProgressHUD.dismiss(view, type: JDismissType.Alpha)
    }
    
    static func dismissFromView(view: UIView) {
        JProgressHUD.dismiss(view, type: JDismissType.None)
    }
    
}


//TODO: UIView extension for frame
extension UIView {
    
    func resetX(x: CGFloat) {
        var frame: CGRect = self.frame;
        frame.origin.x = x
        self.frame = frame
    }
    
    func resetY(y: CGFloat) {
        var frame: CGRect = self.frame;
        frame.origin.y = y
        self.frame = frame
    }
    
    func resetWidth(width: CGFloat) {
        var frame: CGRect = self.frame;
        frame.size.width = width
        self.frame = frame
    }
    
    func resetHeight(height: CGFloat) {
        var frame: CGRect = self.frame;
        frame.size.height = height
        self.frame = frame
    }
    
    
    func getX() -> CGFloat {
        return self.frame.origin.x
    }
    
    func getY() -> CGFloat {
        return self.frame.origin.y
    }
    
    func getWidth() -> CGFloat {
        return self.frame.size.width
    }
    
    func getHeight() -> CGFloat {
        return self.frame.size.height
    }
    
    
    func originX_SizeWidth() -> CGFloat {
        return self.getX() + self.getWidth()
    }
    
    func originY_SizeHeight() -> CGFloat {
        return self.getY() + self.getHeight()
    }
    
}
