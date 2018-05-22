//
//  SeaFoodCanIAskYouTests.swift
//  SeaFoodCanIAskYouTests
//
//  Created by Justin Huang on 2018/5/21.
//  Copyright © 2018年 Justin Huang. All rights reserved.
//

import XCTest
@testable import SeaFoodCanIAskYou
class SeaFoodCanIAskYouTests: XCTestCase {
    var viewModel:SFShowAnswerViewModel!
    override func setUp() {
        super.setUp()
        viewModel = SFShowAnswerViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testUpSinPower(){
        for _ in 1...1000{
        viewModel.sinPowerCount = self.createRandomInt()
        let powerCountBefore = viewModel.sinPowerCount
        viewModel.upSinPowerBarAndSinCounter()
        let powerCountAfter = viewModel.sinPowerCount
        let result = powerCountAfter - powerCountBefore
        XCTAssertTrue(result == 10 || result == 7 || result == 0, "before:\(powerCountBefore),After:\(powerCountAfter),result:\(result)")
        }
    }
    func testDownSinPower(){
        for _ in 1...1000{
            viewModel.sinPowerCount = self.createRandomInt()
            let powerCountBefore = viewModel.sinPowerCount
            viewModel.downSinPowerBarAndSinCounter()
            let powerCountAfter = viewModel.sinPowerCount
            let result = powerCountAfter - powerCountBefore
            XCTAssertTrue(result == -10 || result == -7 || result == 0, "before:\(powerCountBefore),After:\(powerCountAfter),result:\(result)")
        }
    }
    func testIsUpTo87Point(){
        for _ in 1...1000{
            viewModel.sinPowerCount = createRandomInt()
            if viewModel.sinPowerCount >= 87{
                XCTAssertTrue(viewModel.isUpTo87Point, "沒有提示87分")
            }
            if viewModel.sinPowerCount < 87{
                XCTAssertFalse(viewModel.isUpTo87Point, "沒有提示87分")
            }
        }
    }
    
    
    func createRandomInt() -> Int{
        let randomInt = Int(arc4random_uniform(88))
        if randomInt == 87{ return randomInt }
        return randomInt/10 * 10
    }
    
    
}
