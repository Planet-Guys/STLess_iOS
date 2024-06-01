//
//  SplashView.swift
//  STLess
//
//  Created by iOS신상우 on 6/1/24.
//

import SwiftUI
import ComposableArchitecture

struct SplashView: View {
    var store: StoreOf<SplashFeature>
    
    @State var size: CGSize = .init(width: 0, height: 0)
    
    var body: some View {
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            Image.images(.logo)
                .resizable()
                .frame(width: size.width, height: size.height, alignment: .center)
                .offset(y: -40)
                .onAppear(perform: {
                    withAnimation(.spring(.bouncy)) {
                        size.width = 134
                        size.height = 48
                    }
                    store.send(._onAppear)
                })
        }
    }
}

#Preview {
    SplashView(store: .init(initialState: SplashFeature.State.init(), reducer: {
        SplashFeature()
    }))
}
