//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import RobotKit
import XCTest

/**
 Note:
 
 These Physical UI Tests are shown as a *What you could do* - there are plenty
 of different approaches to doing this, one size may not fit all.
 
 Enter YOUR Robot IP Address
 */
final class PlacementTestsWithRobot: BaseUITest {
  
  var robot: Robot!
  
  private let setupLocalNetwork: Bool = false
  
  override func setUp() async throws {
    try await super.setUp()
    
    robot = try Robot(configuration: .init(ipAddress: "192.168.1.183", timeout: 10))
    
    // Note: You can use Mock Network if no robot available
    // robot = Robot(network: MockNetwork(delay: 5))
  }
  
  // Must be called to initalize a network connection otherwise you get "Local network prohibited"
  // https://developer.apple.com/forums/thread/668729
//  func testXCTRunnerToAskForLocalNetworkPermission() {
//
//    guard setupLocalNetwork else { return }
//
//    // without bringing xctrunner to front, permission alert won't be shown.
//    let app = XCUIApplication(bundleIdentifier: "com.nthstate.RobotKitSampleUITests.xctrunner")
//    app.activate()
//
//    connectToLocalNetwork(url: URL(string: "http://192.168.1.183")!)
//
//    waitFor(aSecond: 1)
//
//    let springBoard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
//    // Allows local network permission.
//    let button = springBoard.alerts.firstMatch.buttons["Allow"]
//    if button.exists {
//      button.tap()
//      // local network is allowed in current running ui test.
//      connectToLocalNetwork(url: URL(string: "http://192.168.1.183")!) // try to connect, as it's allowed now.
//    }
//
//    // Keep XCUITest running forever, though sometimes it stops automatically
//    wait(for: [expectation(description: "keep running")], timeout: .infinity)
//  }
  
  func testCanAddSphereAfterMovingEachStep() async throws {
    
    try await robot.defaultPose()
    
    try await HomePageObject(app: app)
      .tapAddEntityButton()
      .moveRobot {
        try await robot.panLeft()
      }
      .tapPlaceSphere()
      .moveRobot {
        try await robot.rotateToLandscape()
        try await robot.panRight()
      }
      .tapCloseButton()
      .tapCenterOfScreen()
      .assertSelectedEntity(named: "sphere")
  }
  
  func testCanAddCubeWhilstMoving() async throws {
    
    try await robot.defaultPose()
    
    try await HomePageObject(app: app)
      .tapAddEntityButton()
      .moveRobot {
        try await robot.rotateToPortrait()
      }
      .tapPlaceCube()
      .moveRobot {
       // async let _ = robot.panRight()
        try await robot.panRight()
        try await robot.rotateToLandscape()
        try await robot.panLeft()
      }
      .tapCloseButton()
      .tapCenterOfScreen()
      .assertSelectedEntity(named: "cube")
  }
  
  func testMovementOfRobot() async throws {
    
    try await robot.defaultPose()
    
    try await HomePageObject(app: app)
      .moveRobot {
        try await robot.rotateToPortrait()
        try await robot.moveUp()
        try await robot.panLeft()
        try await robot.rotateToLandscape()
        try await robot.moveDown()
        try await robot.moveUp()
        try await robot.moveAway()
        try await robot.moveCloser()
      }
      .tapAddEntityButton()
  }
  
}
