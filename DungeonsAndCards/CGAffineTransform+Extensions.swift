//
//  CGAffineTransform+Extensions.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/1/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import UIKit

extension CGAffineTransform {
    static func transformFromRect(from: CGRect, toRect to: CGRect) -> CGAffineTransform {
        let transform = CGAffineTransform(translationX: 0, y: 0)
        return transform.scaledBy(x: to.width/from.width, y: to.height/from.height)
    }
}
