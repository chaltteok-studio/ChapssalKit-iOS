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
        public var leftAccessory: any View = EmptyView()
        @Config
        public var rightAccessory: any View = EmptyView()
        
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
                
                TitleLabel()
                
                RightAccessoryContainer()
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
                    AnyView(config.leftAccessory)
                        .overlay(
                            GeometryReader { reader in
                                Color.clear
                                    .onAppear {
                                        leftAccessoryWidth = reader.size.width
                                    }
                            }
                        )
                    Spacer(minLength: 0)
                }
                .frame(
                    maxWidth: accessoryWidth(
                        left: leftAccessoryWidth,
                        right: rightAccessoryWidth
                    )
                )
            } else {
                AnyView(config.leftAccessory)
                    .overlay(
                        GeometryReader { reader in
                            Color.clear
                                .onAppear {
                                    leftAccessoryWidth = reader.size.width
                                }
                        }
                    )
            }
        }
        
        @ViewBuilder
        private func RightAccessoryContainer() -> some View {
            if alignment == .center {
                HStack {
                    Spacer(minLength: 0)
                    AnyView(config.rightAccessory)
                        .overlay(
                            GeometryReader { reader in
                                Color.clear
                                    .onAppear {
                                        rightAccessoryWidth = reader.size.width
                                    }
                            }
                        )
                }
                .frame(
                    maxWidth: accessoryWidth(
                        left: leftAccessoryWidth,
                        right: rightAccessoryWidth
                    )
                )
            } else {
                AnyView(config.rightAccessory)
                    .overlay(
                        GeometryReader { reader in
                            Color.clear
                                .onAppear {
                                    rightAccessoryWidth = reader.size.width
                                }
                        }
                    )
            }
        }
        
        // MARK: - Property
        private let title: String
        private let alignment: Alignment
        
        @State
        private var leftAccessoryWidth: CGFloat?
        @State
        private var rightAccessoryWidth: CGFloat?
        
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
        private func accessoryWidth(left: CGFloat?, right: CGFloat?) -> CGFloat {
            switch (left, right) {
            case let (.some(lhs), .some(rhs)):
                return max(lhs, rhs)
                
            case (let .some(lhs), _):
                return lhs
                
            case (_, let .some(rhs)):
                return rhs
                
            default:
                return .infinity
            }
        }
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
