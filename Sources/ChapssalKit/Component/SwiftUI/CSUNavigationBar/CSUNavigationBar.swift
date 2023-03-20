//
//  CSUNavigationBar.swift
//  
//
//  Created by JSilver on 2023/02/24.
//

import SwiftUI

public struct CSUNavigationBar: View {
    struct ConfigurationKey: EnvironmentKey {
        static var defaultValue = Configuration()
    }
    
    public struct Configuration {
        @Config
        public var textColor: Color = Color(uiColor: R.Color.gray01)
        @Config
        public var font: Font = Font(R.Font.font(ofSize: 18, weight: .medium))
        @Config
        public var backgroundColor: Color = Color(uiColor: R.Color.white)
        
        @Config
        public var leftAccessories: [any View] = []
        @Config
        public var leftInterAccessoriesSpacing: CGFloat = 16
        @Config
        public var rightAccessories: [any View] = []
        @Config
        public var rightInterAccessoriesSpacing: CGFloat = 16
        
        @Config
        public var style: any CSUNavigationBarStyle = .plain
    }
    
    public enum Alignment: CaseIterable {
        case leading
        case trailing
        case center
    }
    
    private struct Content: View {
        // MARK: - View
        var body: some View {
            HStack(spacing: 16) {
                LeftAccessoryContainer()
                    .layoutPriority(1)
                
                TitleLabel()
                
                RightAccessoryContainer()
                    .layoutPriority(1)
            }
                .padding(16)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(config.backgroundColor)
        }
        
        @ViewBuilder
        private func TitleLabel() -> some View {
            HStack(spacing: 0) {
                if alignment == .trailing || alignment == .center {
                    Spacer(minLength: 0)
                }
                
                Text(title)
                    .foregroundColor(config.textColor)
                    .font(config.font)
                    .lineLimit(1)
                
                if alignment == .leading || alignment == .center {
                    Spacer(minLength: 0)
                }
            }
        }
        
        @ViewBuilder
        private func LeftAccessoryContainer() -> some View {
            if alignment == .center {
                HStack {
                    LeftAccessories()
                    Spacer(minLength: 0)
                }
                    .frame(
                        maxWidth: max(
                            leftAccessoriesWidth,
                            rightAccessoriesWidth
                        )
                    )
            } else {
                if config.leftAccessories.isEmpty {
                    EmptyView()
                } else {
                    LeftAccessories()
                }
            }
        }
        
        @ViewBuilder
        private func LeftAccessories() -> some View {
            let accessories = config.leftAccessories.map { AnyView($0) }
            
            HStack(spacing: config.leftInterAccessoriesSpacing) {
                ForEach(0 ..< accessories.count, id: \.self) {
                    accessories[$0]
                }
            }
                .overlay(
                    GeometryReader { reader in
                        Color.clear
                            .onAppear {
                                leftAccessoriesWidth = reader.size.width
                            }
                    }
                )
        }
        
        @ViewBuilder
        private func RightAccessoryContainer() -> some View {
            if alignment == .center {
                HStack {
                    Spacer(minLength: 0)
                    RightAccessories()
                }
                    .frame(
                        maxWidth: max(
                            leftAccessoriesWidth,
                            rightAccessoriesWidth
                        )
                    )
            } else {
                if config.rightAccessories.isEmpty {
                    EmptyView()
                } else {
                    RightAccessories()
                }
            }
        }
        
        @ViewBuilder
        private func RightAccessories() -> some View {
            let accessories = config.rightAccessories.map { AnyView($0) }
            
            HStack(spacing: config.rightInterAccessoriesSpacing) {
                ForEach(0 ..< accessories.count, id: \.self) {
                    accessories[$0]
                }
            }
                .overlay(
                    GeometryReader { reader in
                        Color.clear
                            .onAppear {
                                rightAccessoriesWidth = reader.size.width
                            }
                    }
                )
        }
        
        // MARK: - Property
        private let title: String
        private let alignment: Alignment
        
        @State
        private var leftAccessoriesWidth: CGFloat = 0
        @State
        private var rightAccessoriesWidth: CGFloat = 0
        
        @Environment(\.csuNavigationBar)
        private var config: Configuration
        
        // MARK: - Initialier
        init(
            title: String,
            alignment: Alignment
        ) {
            self.title = title
            self.alignment = alignment
        }
        
        // MARK: - Public
        
        // MARK: - Private
    }
    
    // MARK: - View
    public var body: some View {
        AnyView(
            style.makeBody(.init(
                label: .init(
                    Content(
                        title: title,
                        alignment: alignment
                    )
                )
            ))
        )
    }
    
    // MARK: - Property
    private let title: String
    private let alignment: Alignment
    
    @Environment(\.csuNavigationBar.style)
    private var style: any CSUNavigationBarStyle
    
    // MARK: - Initializer
    public init(_ title: String, alignment: Alignment = .center) {
        self.title = title
        self.alignment = alignment
    }
    
    // MARK: - Public
    
    // MARK: - Private
}

#if DEBUG
struct CSUNavigationBar_Preview: View {
    var body: some View {
        CSUNavigationBar("ChapssalKit")
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct CSUNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CSUNavigationBar_Preview()
            .previewLayout(.sizeThatFits)
    }
}
#endif
