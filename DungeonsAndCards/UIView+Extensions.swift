//
//  UIView+Extensions.swift
//  DIOCollectionViewExample
//
//  Created by Matheus Martins on 11/28/16.
//  Copyright © 2016 matheusmcardoso. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func hitTest(_ point: CGPoint, filter: (UIView) -> Bool) -> UIView? {
        
        if let targetView = self.hitTest(point, with: nil) {
            
            if filter(targetView) {
                return targetView
            } else {
                return nil
            }
            
        } else {
            return nil
        }
    }
}

// UILabel+Ghost.swift
// UILabel with Ghost Animation
// https://github.com/matheusmcardoso/MMUIKitExtensions

import UIKit

extension UILabel {
    
    func doGhostAnimation(text: String? = nil, color: UIColor = UIColor.green,
                          tX: CGFloat = 0, tY: CGFloat = -50, sX: CGFloat = 0.5, sY: CGFloat = 0.5,
                          duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
        
        let oldSize = self.frame.size
        var size = self.frame.size
        
        let oldColor = self.textColor
        self.textColor = color
        
        let oldText = self.text
        if let text = text {
            self.text = text
            size = self.text!.size(attributes: [NSFontAttributeName: self.font!])
            self.frame.size = size
        }
        self.superview!.layoutIfNeeded()
        
        guard let view = self.snapshotView(afterScreenUpdates: true) else { return }
        
        self.textColor = oldColor
        self.text = oldText
        self.frame.size = oldSize
        
        self.addSubview(view)
        
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
            view.frame = view.frame.applying(CGAffineTransform(translationX: tX, y: tY)).applying(CGAffineTransform(scaleX: sX, y: sY))
        }, completion: {
            completed in
            view.removeFromSuperview()
            completion?(completed)
        })
    }
}
