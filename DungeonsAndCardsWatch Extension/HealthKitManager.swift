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
    public var timer = Timer()
    
    init(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(query), userInfo: nil, repeats: true)
        healthStore.requestAuthorization(toShare: [], read: [HKObjectType.activitySummaryType()]) { (success, error) in
            
            if success {
                print("success")
            }else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    //MARK: - Methods
    @objc func query() {
        i = i + 20
        var components = Calendar.current.dateComponents([.day, .month, .year, .era], from: Date())
        components.calendar = Calendar.current
        let predicate = NSPredicate(format: "%K = %@", argumentArray: [HKPredicateKeyPathDateComponents, components])
       
        let query = HKActivitySummaryQuery(predicate: predicate) {
            query, summaries, error in
            
            if let summary = summaries?.first {
                DispatchQueue.main.async {
                    self.delegate?.didUpdateSummary(
                        withExercise: self.i*0.7,
                        Move: self.i*0.3,
                        Stand: self.i*0.2,
                        andTap: self.i*0.6)

//                    self.delegate?.didUpdateSummary(
//                    withExercise: summary.appleExerciseTime.doubleValue(for: HKUnit.hour()),
//                    Move: summary.activeEnergyBurned.doubleValue(for: HKUnit.calorie()),
//                    Stand: summary.appleStandHours.doubleValue(for: HKUnit.count()),
//                    andTap: self.i)
                }
            }
        }
        
        healthStore.execute(query)
    }
    
}
