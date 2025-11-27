//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import RobotKit
import XCTest

@MainActor
final class PlacementTestsWithoutRobot: BaseUITest {
    
  func testAddingSphere() async throws {
    HomePageObject(app: app)
      .tapAddEntityButton()
      .tapPlaceSphere()
      .tapCloseButton()
      .tapCenterOfScreen()
      .assertSelectedEntity(named: "sphere")
  }
  
  func testAddingCube() async throws {
    HomePageObject(app: app)
      .tapAddEntityButton()
      .tapPlaceCube()
      .tapCloseButton()
      .tapCenterOfScreen()
      .assertSelectedEntity(named: "cube")
  }
  
}
