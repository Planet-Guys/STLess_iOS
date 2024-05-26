//
//  MainFeature.swift
//  STLess
//
//  Created by iOS신상우 on 5/12/24.
//

import ComposableArchitecture
import HealthKit

@Reducer
struct MainFeature {
    let healthManager = HealthManager.share
    
    @ObservableState
    struct State: Equatable {
        var currentDate: Date = .now
        var recentlyInfoDate: Date = .now
        var dailyInfos: [DailySDNNInfo] = []
        var recentlyHRV: Double = 0
        var averageHRV: Double = 0
        var dateType: DateType = .daily
    }
    
    enum Action {
        case getDailyData
        case dailyDataResponse([DailySDNNInfo])
        case getRecentlyHRV
        case getRecentlyHRVResponse(Double, Date)
        case setDate(date: Date)
        case setDateType(type: DateType)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setDate(let date):
                state.currentDate = date
                return .none
            case .getDailyData:
                return .run { [date = state.currentDate] send in
                    let infos = await healthManager.getDailySDNNInfo(date: date)
                    await send(.dailyDataResponse(infos))
                }
            case .dailyDataResponse(let infos):
                state.dailyInfos = infos
                return .none
            case .getRecentlyHRV:
                return .run { send in
                    let (hrv, date) = await healthManager.getRecentlyHRV(date: .now)
                    await send(.getRecentlyHRVResponse(hrv, date))
                }
            case .getRecentlyHRVResponse(let hrv, let date):
                state.recentlyHRV = hrv
                state.recentlyInfoDate = date
                return .none
            case .setDateType(let type):
                state.dateType = type
                return .none
            }
        }
    }
}
