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

protocol WatchConnectionManagerWatchDelegate: class {
    func connectionManager(_ connectionManager: ConnectionManager, updatedWithCardText text: String, cardTitle title: String, andAttributes attributes: [String])
    //func connectionManager(_ connectionManager: ConnectionManager, sessionIsActive isActive: Bool)
}

class ConnectionManager: NSObject, WCSessionDelegate {
    
    static let sharedConnectionManager = ConnectionManager()
    
    // MARK: Attributes
    
    #if os(iOS)
    weak var delegate: WatchConnectionManagerPhoneDelegate?
    #else
    weak var delegate: WatchConnectionManagerWatchDelegate?
    #endif
    
    // MARK: Init
    
    private override init(){
        super.init()
    }
    
    // MARK: Convenience
    
    func configureDeviceDetailsWithApplicationContext(applicationContext: [String: Any]){
        #if os(iOS)
            //Configura iOS Interface com dados do Context (usar delegate)
            guard let response = applicationContext["response"] as? String else {
                //Standard response in case of expected values are unavailable in `applicationContext`
                //delegate?.connectionManager(self, updatedWithResponse: "-")
                return
            }
            delegate?.connectionManager(self, updatedWithResponse: response)
        #endif
        #if os(watchOS)
            //Configura Watch Interface com dados do Context (usar delegate)
            guard let text = applicationContext["text"] as? String, let title = applicationContext["title"] as? String, let attributes = applicationContext["attributes"] as? [String] else {
                //delegate?.connectionManager(self, updatedWithCardText: "-", cardTitle: "-", andAttributes: ["-"])
                return
            }
            delegate?.connectionManager(self, updatedWithCardText: text, cardTitle: title, andAttributes: attributes)
        #endif
    }
    
    
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("session (in state: \(session.activationState.rawValue)) received application context \(applicationContext)")
        
        configureDeviceDetailsWithApplicationContext(applicationContext: applicationContext)
        
        #if os(iOS)
            print("session watch directory URL: \(session.watchDirectoryURL?.absoluteString)")
        #endif
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


