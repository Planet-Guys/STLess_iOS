//
//  HealthManager.swift
//  STLess
//
//  Created by iOS신상우 on 5/19/24.
//

import Foundation
import HealthKit

final class HealthManager {
    static let share = HealthManager()
    
    private init() { }
    
    let healthStore = HKHealthStore()
    
    let read = Set([
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
    ])
    
    let share = Set([
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
    ])
    
    func configure() {
        if HKHealthStore.isHealthDataAvailable() {
            requestAuthorization()
        }
    }
    
    func getHRVInfo(date: Date, dateType: DateType) async -> [DailyHRVInfo] {
        var infos: [DailyHRVInfo] = []
        let quantityType = HKQuantityType(.heartRateVariabilitySDNN)
        let startOfDay = date.startOfDay(dayOffset: -dateType.period)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: date)
        
        let query = HKStatisticsCollectionQuery(
            quantityType: quantityType,
            quantitySamplePredicate: predicate,
            options: .discreteAverage,
            anchorDate: startOfDay,
            intervalComponents: dateType.interval
        )
        
        return await withCheckedContinuation { continuation in
            query.initialResultsHandler = { query, results, error in
                if let error = error {
                    print("Query Error: \(error.localizedDescription)")
                    return
                }
                
                results?.enumerateStatistics(from: startOfDay, to: date) { (statistics, stop) in
                    if let quantity = statistics.averageQuantity() {
                        let date = statistics.startDate
                        let value = quantity.doubleValue(for: .secondUnit(with: .milli))
                        let info = DailyHRVInfo(date: date, sdnn: value)
                        infos.append(info)
                    }
                }
                
                continuation.resume(returning: infos)
            }
            healthStore.execute(query)
        }
    }
    
    func getAverageHRV(date: Date) async -> DailyHRVInfo? {
        let quantityType = HKQuantityType(.heartRateVariabilitySDNN)
        
        let startOfDay = date.startOfDay(dayOffset: -1)
        let interval = DateComponents(day: 1)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: date)
        
        let query = HKStatisticsCollectionQuery(
            quantityType: quantityType,
            quantitySamplePredicate: predicate,
            options: .discreteAverage,
            anchorDate: startOfDay,
            intervalComponents: interval
        )
        
        return await withCheckedContinuation { continuation in
            query.initialResultsHandler = { query, results, error in
                if let error = error {
                    print("쿼리 에러: \(error.localizedDescription)")
                    return
                }
                
                results?.enumerateStatistics(from: startOfDay,
                                             to: date,
                                             with: { (statistics, stop) in
                    if let quantity = statistics.averageQuantity() {
                        let date = statistics.startDate
                        let value = quantity.doubleValue(for: .secondUnit(with: .milli))
                        let info = DailyHRVInfo(date: date, sdnn: value)
                        continuation.resume(returning: info)
                    }
                })
            }
            healthStore.execute(query)
        }
    }
    
    func getRecentlyHRV(date: Date) async -> (Double, Date) {
        let infos = await getHRVInfo(date: date, dateType: .daily)
        return (infos.last?.sdnn ?? 0, infos.last?.date ?? date)
    }
}

private extension HealthManager {
    func requestAuthorization() {
        self.healthStore.requestAuthorization(toShare: share, read: read) { success, error in
            if error != nil {
                print(error.debugDescription)
            }else{
                if success {
                    print("권한이 허락되었습니다")
                }else{
                    print("권한이 없습니다")
                }
            }
        }
    }
}
