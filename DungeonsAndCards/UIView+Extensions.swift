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
