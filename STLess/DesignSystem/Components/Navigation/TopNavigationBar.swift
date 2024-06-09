//
//  TopNavigationBar.swift
//  STLess
//
//  Created by iOS신상우 on 6/8/24.
//

import SwiftUI

public struct TopNavigationBar: View {
    
    public typealias NavigationItem = (Image, String?, () -> Void)
    
    private let leadingItem: NavigationItem?
    private let leadingButton: (String, () -> Void)?
    
    private let centerTitle: String?
    private let centerItem: NavigationItem?
    
    private let trailingItems: [NavigationItem]
    private let trailingButton: (String, () -> Void)?
    
    public init(
        leadingItem: NavigationItem? = .none,
        leadingButton: (String, () -> Void)? = .none,
        centerTitle: String? = .none,
        centerIcon: NavigationItem? = .none,
        trailingItems: [NavigationItem] = [],
        trailingButton: (String, () -> Void)? = .none
    ) {
        self.leadingItem = leadingItem
        self.leadingButton = leadingButton
        self.centerTitle = centerTitle
        self.centerItem = centerIcon
        self.trailingItems = trailingItems
        self.trailingButton = trailingButton
    }
    
    
    public var body: some View {
        HStack(spacing: 0) {
            if let leadingItem {
                navigationItem(leadingItem)
            }
            if let leadingButton {
                Button(action: {
                    leadingButton.1()
                }, label: {
                    Text(leadingButton.0)
                        .font(.pdBold16)
                        .foregroundStyle(Color.black.opacity(0.9))
                        .padding(.horizontal, 16)
                })
            }
            
            Spacer()
            if let trailingButton {
                Button(action: {
                    trailingButton.1()
                }, label: {
                    Text(trailingButton.0)
                        .font(.pdMedium16)
                        .foregroundStyle(Color.black.opacity(0.9))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .tint(Color.black.opacity(0.9))
                })
            }
            
            if trailingItems.isNotEmpty {
                ForEach(0..<trailingItems.count, id: \.self) { i in
                    let item = trailingItems[i]
                    navigationItem(item)
                }
            }
        }
        .padding(.horizontal, 4)
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .overlay {
            HStack(spacing: 4) {
                if let centerTitle {
                    Text(centerTitle)
                        .font(.pdBold16)
                        .foregroundStyle(Color.black.opacity(0.95))
                }
                
                if let centerItem {
                    Button(action: {
                        centerItem.2()
                    }, label: {
                        centerItem.0
                            .frame(width: 20, height: 20)
                            .tint(Color.black.opacity(0.8))
                        
                        if let title = centerItem.1{
                            Text(title)
                                .font(.pdMedium14)
                                .foregroundStyle(Color.black.opacity(0.8))
                        }
                    })
                }
            }
        }
    }
    
    @ViewBuilder
    private func navigationItem(_ item: NavigationItem) -> some View {
        Button(action: {
            item.2()
        }, label: {
            HStack {
                item.0
                    .frame(width: 48, height: 48)
                if let title = item.1{
                    Text(title)
                        .font(.pdMedium14)
                        .foregroundStyle(Color.black.opacity(0.8))
                }
            }
        })
    }
}

