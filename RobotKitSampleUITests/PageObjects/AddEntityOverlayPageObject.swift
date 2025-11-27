//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import XCTest

@MainActor
public final class AddEntityOverlayPageObject: PageObject {
  var app: XCUIApplication
  
  public init(app: XCUIApplication) {
    self.app = app
    
    XCTAssertTrue(arView.waitForExistence(timeout: 5), "arView should be visible")
  }
  
  private var arView: XCUIElement {
    app.otherElements["arView"].firstMatch
  }
  
  private var closeButton: XCUIElement {
    app.buttons["closeButton"].firstMatch
  }
  
  private var sphereButton: XCUIElement {
    app.buttons["sphereButton"].firstMatch
  }
  
  private var cubeButton: XCUIElement {
    app.buttons["cubeButton"].firstMatch
  }
  
  @discardableResult
  func tapPlaceSphere() -> Self {
    testStep("Tap Sphere") {
      sphereButton.tap()
    }
    return self
  }
  
  @discardableResult
  func tapPlaceCube() -> Self {
    testStep("Tap Cube") {
      cubeButton.tap()
    }
    return self
  }
  
  @discardableResult
  func tapCloseButton() -> HomePageObject {
    testStep("Tap Close") {
      closeButton.tap()
    }
    return HomePageObject(app: app)
  }
  
}


