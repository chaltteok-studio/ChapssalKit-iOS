//
//  ChapssalKitTests.swift
//
//
//  Created by JSilver on 2021/06/06.
//

import XCTest
@testable import ChapssalKit

final class ChapssalKitTests: XCTestCase {
    // MARK: - Property
    
    // MARK: - Lifecycle
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    // MARK: - Test
    func test_that_load_color() {
        // Given
        
        // When
        // Primary
        _ = R.Color.green01
        _ = R.Color.green03
        _ = R.Color.green04
        
        // Secondary
        _ = R.Color.blue01
        _ = R.Color.red01
        _ = R.Color.yellow01
        _ = R.Color.yellow02
        
        // Grayscale
        _ = R.Color.black
        _ = R.Color.gray01
        _ = R.Color.gray02
        _ = R.Color.gray03
        _ = R.Color.gray04
        _ = R.Color.gray05
        _ = R.Color.gray06
        _ = R.Color.white
        
        // Then
    }
    
    func test_that_load_font() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_that_load_icon() {
        // Given
        
        // When
        _ = R.Icon.ic24Add
        _ = R.Icon.ic24Alarm
        _ = R.Icon.ic24Archive
        _ = R.Icon.ic24Attach
        _ = R.Icon.ic24Back
        _ = R.Icon.ic24Backward
        _ = R.Icon.ic24Blind
        _ = R.Icon.ic24Calendar
        _ = R.Icon.ic24Chevron
        _ = R.Icon.ic24Clear
        _ = R.Icon.ic24Close
        _ = R.Icon.ic24Collapse
        _ = R.Icon.ic24Delete
        _ = R.Icon.ic24Down
        _ = R.Icon.ic24Dropdown
        _ = R.Icon.ic24Forward
        _ = R.Icon.ic24Graph
        _ = R.Icon.ic24Home
        _ = R.Icon.ic24Link
        _ = R.Icon.ic24Loop
        _ = R.Icon.ic24Menu
        _ = R.Icon.ic24Modify
        _ = R.Icon.ic24Movein
        _ = R.Icon.ic24Moveout
        _ = R.Icon.ic24My
        _ = R.Icon.ic24Notice
        _ = R.Icon.ic24Password
        _ = R.Icon.ic24Search
        _ = R.Icon.ic24Settings
        _ = R.Icon.ic24Up
        _ = R.Icon.ic24View
        _ = R.Icon.ic24Vision
        _ = R.Icon.ic24Warning
        
        // Then
    }
    
    func test_that_load_image() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_that_load_localizable() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_that_load_lottie() {
        // Given
        
        // When
        _ = R.Lottie.loadingGray
        _ = R.Lottie.loadingWhite
        _ = R.Lottie.loadingGreen
        
        // Then
    }
}
