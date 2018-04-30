//
//  UIAlert+UIViews.swift
//  BaseServiceCall
//
//  Created by Abdul Samad on 4/29/18.
//  Copyright © 2018 Abdul Samad. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public func addSubview(_ view: UIView, top: CGFloat?, left: CGFloat?, bottom: CGFloat?, right: CGFloat?) {
        self.addSubview(view)
        if let top = top {
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: top).isActive = true
        }
        if let left = left {
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: left).isActive = true
        }
        if let bottom = bottom {
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom * -1).isActive = true
        }
        if let right = right {
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: right * -1).isActive = true
        }
    }
}

extension UIViewController {
    
    public func show(title:String, text:String?, completionHandler: (() -> ())? = nil ) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
            completionHandler?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
