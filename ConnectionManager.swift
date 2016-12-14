//
//  ConnectionManager.swift
//  WheelOfMisfortune
//
//  Created by Matheus Vasconcelos de Sousa on 08/11/16.
//  Copyright © 2016 hananim-studios. All rights reserved.
//

import Foundation
import WatchConnectivity

protocol WatchConnectionManagerPhoneDelegate: class {
    func connectionManager(_ connectionManager: ConnectionManager, updatedWithResponse response: String)
}

class ConnectionManager: NSObject, WCSessionDelegate {
    
    static let sharedConnectionManager = ConnectionManager()
    
    // MARK: Attributes
    
    weak var delegate: WatchConnectionManagerPhoneDelegate?
    
    // MARK: Init
    
    private override init(){
        super.init()
    }
    
    // MARK: Convenience
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        guard let morseCode = userInfo["watchGold"] as? String else {
            // If the expected values are unavailable in the `userInfo`, then skip it.
            return
        }
        
        // Inform the delegate.
        delegate?.connectionManager(self, updatedWithResponse: morseCode)
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("session activation failed with error: \(error.localizedDescription)")
            return
        }
        
        print("session activated with state: \(activationState.rawValue)")
        #if os(iOS)
            print("session watch directory URL: \(session.watchDirectoryURL?.absoluteString)")
        #endif
        
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
    /*
     The `sessionDidBecomeInactive(_:)` callback indicates sending has been disabled. If your iOS app
     sends content to its Watch extension it will need to stop trying at this point. This sample
     doesn’t send content to its Watch Extension so no action is required for this transition.
     */
    
    print("session did become inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    print("session did deactivate")
    
    /*
     The `sessionDidDeactivate(_:)` callback indicates `WCSession` is finished delivering content to
     the iOS app. iOS apps that process content delivered from their Watch Extension should finish
     processing that content and call `activateSession()`. This sample immediately calls
     `activateSession()` as the data provided by the Watch Extension is handled immediately.
     */
    session.activate()
    }
    #endif
    
    
}


