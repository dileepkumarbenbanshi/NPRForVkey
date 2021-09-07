//
//  NPRRectView.swift
//  NPR_census
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NPRRectView: UIView {

   var transParentView =  UIView()
   var customView = UIView()
    
    func addSubViewToParentWindow(view:UIView,withFrame:CGRect,isCenter:Bool){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let ParentView = appDelegate?.window?.frame
        view.frame = withFrame
        //view.backgroundColor = .green
        self.transParentView = UIView(frame:ParentView!)
        if isCenter{view.center =  self.transParentView.center}
        self.customView = view
        self.transParentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeSubviewFromParentWidnow))
        tapGesture.delegate = self
        //self.transParentView.addGestureRecognizer(tapGesture)
        self.transParentView.addSubview(self.customView)
        appDelegate?.window?.addSubview(self.transParentView)
    }
    
    @objc func removeSubviewFromParentWidnow(){
        self.transParentView.removeFromSuperview()
    }
    
    func animateView(view:UIView,key:Bool){
          var transform = CGAffineTransform()
          UIView.beginAnimations(nil, context: nil)
          UIView.setAnimationDuration(0.4)
          transform = key ? CGAffineTransform(translationX: 0, y: -view.frame.height) : CGAffineTransform(translationX: 0, y: view.frame.height)
          view.transform = transform
          UIView.commitAnimations()
      }

}

extension NPRRectView:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of:self.customView))!{
            return false
        }
        return true
    }
}
