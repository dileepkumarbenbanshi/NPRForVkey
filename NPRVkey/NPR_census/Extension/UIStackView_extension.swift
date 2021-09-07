//
//  UIStackView_extension.swift
//  NPR_census
//
//  Created by admin on 06/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

   @IBDesignable

   class StackView: UIStackView {
    
      @IBInspectable private var color: UIColor?
       override var backgroundColor: UIColor? {
           get { return color }
           set {
               color = newValue
               self.setNeedsLayout() // EDIT 2017-02-03 thank you @BruceLiu
           }
       }

       private lazy var backgroundLayer: CAShapeLayer = {
           let layer = CAShapeLayer()
           self.layer.insertSublayer(layer, at: 0)
           return layer
       }()
    
       override func layoutSubviews() {
           super.layoutSubviews()
           backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
           backgroundLayer.fillColor = self.backgroundColor?.cgColor
       }
    
   }


