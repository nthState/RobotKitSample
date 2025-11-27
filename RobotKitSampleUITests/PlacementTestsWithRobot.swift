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
  
  var robot: Robotable!
  
  override func setUp() async throws {
    try await super.setUp()
    
    robot = try Robot(configuration: .init(ipAddress: "192.168.1.183", timeout: 10))
    
    // Note: Use Mock Network if no robot available
    // robot = Robot(network: MockNetwork(delay: 5))
  }
  
  func testCanAddSphereAfterMovingEachStep() async throws {
    
    try await robot.defaultPose()
    
    try await HomePageObject(app: app)
      .tapAddEntityButton()
      .tapPlaceSphere()
      .moveRobot {
        try await robot.rotateToLandscape()
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
        async let _ = robot.rotateToPortrait()
      }
      .tapPlaceCube()
      .moveRobot {
        async let _ = robot.panRight()
      }
      .tapCloseButton()
      .tapCenterOfScreen()
      .assertSelectedEntity(named: "cube")
  }
  
}
