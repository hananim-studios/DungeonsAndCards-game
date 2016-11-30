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
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEnteredWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath)
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragLeftWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath)
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEndedWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath)
}

class HeroCollectionView : DIOCollectionView, DIOCollectionViewDestination {
    
    var heroDelegate: HeroCollectionViewDelegate?
    
    var receiveDrag: Bool = false
    
    var lastIndexPathTarget = IndexPath(row: -1, section: -1)
    
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        
        switch dragState {
        case .entered:
            cellInteractionsEnabled(false)
        case let .moved(location):
            handleDragMoved(dragInfo: dragInfo, atLocation: location)
        case let .ended(location):
            cellInteractionsEnabled(true)
            handleDragEnded(dragInfo: dragInfo, atLocation: location)
        default:
            break
        }
    }
    
    func cellInteractionsEnabled(_ enabled: Bool) {
        
        self.visibleCells.forEach( { $0.isUserInteractionEnabled = enabled })
    }
    
    func handleDragEntered(dragInfo: DIODragInfo?, atLocation location: CGPoint) {
        if let indexPath = self.indexPathForItem(at: location) {
            self.heroDelegate?.heroCollectionView(self, dragEnteredWithDragInfo: dragInfo, atIndexPath: indexPath)
        }
    }
    
    func handleDragMoved(dragInfo: DIODragInfo?, atLocation location: CGPoint) {
        
        // if drag is over an item
        if let indexPath = self.indexPathForItem(at: location) {
            
            if(indexPath != self.lastIndexPathTarget) {
                // if last drag was different
                self.heroDelegate?.heroCollectionView(self, dragEnteredWithDragInfo: dragInfo, atIndexPath: indexPath)
                
                if(self.lastIndexPathTarget.row != -1) {
                    
                    //self.heroDelegate?.heroCollectionView(self, dragLeftWithDragInfo: dragInfo, atIndexPath: indexPath)
                }
            }
            
            self.lastIndexPathTarget = indexPath
            
        } else {
        // if drag is not over an item
            if(self.lastIndexPathTarget.row != -1) {
                
                self.heroDelegate?.heroCollectionView(self, dragLeftWithDragInfo: dragInfo, atIndexPath: self.lastIndexPathTarget)
                
                self.lastIndexPathTarget = IndexPath(row: -1, section: -1)
            }
        }
    }
    
    func handleDragEnded(dragInfo: DIODragInfo?, atLocation location: CGPoint) {
        if let indexPath = self.indexPathForItem(at: location) {
            self.heroDelegate?.heroCollectionView(self, dragEndedWithDragInfo: dragInfo, atIndexPath: indexPath)
        }
    }
}
