//
//  HeroCollectionView.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/29/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import UIKit

protocol HeroCollectionViewDelegate {
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, receivedDragWithDragInfo dragInfo: DIODragInfo?, withDragState dragState: DIODragState, atIndexPath indexPath: IndexPath)
}

class HeroCollectionView : DIOCollectionView, DIOCollectionViewDestination {
    
    var heroDelegate: HeroCollectionViewDelegate?
    
    var receiveDrag: Bool = false
    
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        
        switch dragState {
        case .began:
            self.visibleCells.forEach( { $0.isUserInteractionEnabled = false })
        case let .moved(location):
            movedDragInfo(dragInfo, atLocation: location)
        case .ended:
            self.visibleCells.forEach( { $0.isUserInteractionEnabled = true })
        default:
            break
        }
    }
    
    func movedDragInfo(_ dragInfo: DIODragInfo?, atLocation location: CGPoint) {
        if let indexPath = self.indexPathForItem(at: location),
            self.receiveDrag {
            heroDelegate?.heroCollectionView(self, receivedDragWithDragInfo: dragInfo, withDragState: .moved(location: location), atIndexPath: indexPath)
        }
    }
}
