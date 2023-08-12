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
        _ = R.Icon.add
        _ = R.Icon.alarm
        _ = R.Icon.archive
        _ = R.Icon.back
        _ = R.Icon.backward
        _ = R.Icon.barcode
        _ = R.Icon.blind
        _ = R.Icon.calendar
        _ = R.Icon.camera
        _ = R.Icon.clear
        _ = R.Icon.close
        _ = R.Icon.collapse
        _ = R.Icon.crown
        _ = R.Icon.delete
        _ = R.Icon.dropdown
        _ = R.Icon.forward
        _ = R.Icon.graph
        _ = R.Icon.heart
        _ = R.Icon.heartFill
        _ = R.Icon.home
        _ = R.Icon.infinity
        _ = R.Icon.key
        _ = R.Icon.link
        _ = R.Icon.loop
        _ = R.Icon.menu
        _ = R.Icon.minus
        _ = R.Icon.modify
        _ = R.Icon.movein
        _ = R.Icon.moveout
        _ = R.Icon.my
        _ = R.Icon.notice
        _ = R.Icon.off
        _ = R.Icon.on
        _ = R.Icon.password
        _ = R.Icon.search
        _ = R.Icon.settings
        _ = R.Icon.ticket
        _ = R.Icon.view
        _ = R.Icon.vision
        _ = R.Icon.warning
        
        // Then
    }
    
    func test_that_load_image() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_that_load_localization() {
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
