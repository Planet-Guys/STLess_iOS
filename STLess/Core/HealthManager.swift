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
        // 해당 장치가 healthkit을 지원하는지 여부
        if HKHealthStore.isHealthDataAvailable() {
            requestAuthorization()
        }
    }
    
    func getDailySDNNInfo(date: Date) async -> [DailySDNNInfo] {
        var infos: [DailySDNNInfo] = []
        
        let calendar = Calendar.current
        let type = HKQuantityType(.heartRateVariabilitySDNN)
        //        let sort = NSSortDescriptor.init(key: HKSampleSortIdentifierEndDate, ascending: true)
        
        var startOfDay = calendar.startOfDay(for: date)
        
        // 임시 : 지울 문장
        startOfDay = calendar.date(byAdding: .day,
                                   value: -1,
                                   to: startOfDay) ?? startOfDay
        guard let endOfDay = calendar.date(byAdding: .day,
                                           value: 1,
                                           to: startOfDay) else {
            fatalError("날짜를 계산할 수 없습니다.")
        }
        
        let interval = DateComponents(hour: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                    end: endOfDay,
                                                    options: .strictStartDate)
        
        let query = HKStatisticsCollectionQuery(
            quantityType: type,
            quantitySamplePredicate: predicate,
            options: .discreteAverage,
            anchorDate: .anchorDate,
            intervalComponents: interval
        )
        
        return await withCheckedContinuation { continuation in
            query.initialResultsHandler = { query, results, error in
                if let error = error {
                    print("쿼리 에러: \(error.localizedDescription)")
                    return
                }
                
                results?.enumerateStatistics(from: startOfDay,
                                             to: endOfDay,
                                             with: { (statistics, stop) in
                    if let quantity = statistics.averageQuantity() {
                        let date = statistics.startDate
                        let value = quantity.doubleValue(for: .secondUnit(with: .milli))
                        let info = DailySDNNInfo(date: date, sdnn: value)
                        infos.append(info)
                    }
                })
                continuation.resume(returning: infos)
            }
            healthStore.execute(query)
        }
    }
    
    func getRecentlyHRV(date: Date) async -> (Double, Date) {
        let infos = await getDailySDNNInfo(date: date)
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
