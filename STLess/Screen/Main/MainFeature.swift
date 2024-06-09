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
    let healthManager = HealthManager.share // dependency로 빼기
    
    @ObservableState
    struct State: Equatable {
        var path: StackState<MainNaviagtionPath.State> = .init()
        
        var stressLevel: StressLevel = .none
        var currentDate: Date = .now
        var recentlyInfoDate: Date = .now
        var dailyInfos: [DailyHRVInfo] = []
        var recentlyHRV: Double = 0
        var averageHRV: Double = 0
        var dateType: DateType = .daily
    }
    
    enum Action {
        case path(StackAction<MainNaviagtionPath.State, MainNaviagtionPath.Action>)
        
        case getHRVData
        case hrvDataResponse([DailyHRVInfo])
        case getRecentlyHRV
        case recentlyHRVResponse(Double, Date)
        case getAverageHRV
        case averageHRVResponse(Double)
        case setDate(date: Date)
        case setDateType(type: DateType)
        case setStressLevel(StressLevel)
        case _onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case .element(id: _, action: .setting(.main)):
                    state.path.append(.setting(.main))
                    return .none
                case .element(id: _, action: .setting(.delegate(.back))):
                    let _ = state.path.popLast()
                    return .none
                case .element(id: _, action: .stressInfo(.main)):
                    state.path.append(.stressInfo(.main))
                    return .none
                case .element(id: _, action: .stressInfo(.delegate(.back))):
                    let _ = state.path.popLast()
                    return .none
                default:
                    return .none
                }
            case .setDate(let date):
                state.currentDate = date
                return .none
            case .getHRVData:
                return .run { [date = state.currentDate, dateType = state.dateType] send in
                    let infos = await healthManager.getHRVInfo(date: date, dateType: dateType)
                    await send(.hrvDataResponse(infos))
                }
            case .hrvDataResponse(let infos):
                state.dailyInfos = infos
                return .none
            case .getRecentlyHRV:
                return .run { send in
                    let (hrv, date) = await healthManager.getRecentlyHRV(date: .now)
                    await send(.recentlyHRVResponse(hrv, date))
                    await send(.setStressLevel(hrv.getStressLevel))
                }
            case .recentlyHRVResponse(let hrv, let date):
                state.recentlyHRV = hrv
                state.recentlyInfoDate = date
                return .none
            case .getAverageHRV:
                return .run { send in
                    let hrv = await healthManager.getAverageHRV(date: .now)
                    await send(.averageHRVResponse(hrv?.sdnn ?? 0))
                }
            case .averageHRVResponse(let hrv):
                state.averageHRV = hrv
                return .none
            case .setDateType(let type):
                state.dateType = type
                return .send(.getHRVData)
            case .setStressLevel(let stressLevel):
                state.stressLevel = stressLevel
                return .none
            case ._onAppear:
                return .run { send in
                    await send(.getHRVData)
                    await send(.getRecentlyHRV)
                    await send(.getAverageHRV)
                }
            }
        }
        .forEach(\.path, action: \.path) {
            MainNaviagtionPath()
        }
    }
}
