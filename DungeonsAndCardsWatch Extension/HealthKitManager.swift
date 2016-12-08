//
//  HealthKitManager.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 07/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import HealthKit

protocol HeathKitManagerDelegate {
    func didUpdateSummary(withExercise exercise: Double, Move move: Double, Stand stand: Double, andTap tap: Double)
}

class HealthKitManager {
    var i: Double = 0
    var delegate:HeathKitManagerDelegate?
    let healthStore = HKHealthStore()
    
    init(){
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(query), userInfo: nil, repeats: true)
        
        healthStore.requestAuthorization(toShare: [], read: [HKObjectType.activitySummaryType()]) { (success, error) in
            if success {
                print("success")
            }
        }
    }
    
    @objc func query() {
        i += 7
        var components = Calendar.current.dateComponents([.day, .month, .year, .era], from: Date())
        components.calendar = Calendar.current
        let predicate = NSPredicate(format: "%K = %@", argumentArray: [HKPredicateKeyPathDateComponents, components])
       
        let query = HKActivitySummaryQuery(predicate: predicate) {
            query, summaries, error in
            
            if let summary = summaries?.first {
                DispatchQueue.main.async {
                    self.delegate?.didUpdateSummary(
                    withExercise: self.i/*summary.appleExerciseTime.doubleValue(for: HKUnit.hour())*/,
                    Move: self.i/*summary.activeEnergyBurned.doubleValue(for: HKUnit.calorie())*/,
                    Stand: self.i/*summary.appleStandHours.doubleValue(for: HKUnit.count())*/,
                    andTap: self.i)
                }
            }
        }
        
        healthStore.execute(query)
    }
    
}
