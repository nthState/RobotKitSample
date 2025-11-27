//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import XCTest

@MainActor
public final class HomePageObject: PageObject {
  var app: XCUIApplication
  
  public init(app: XCUIApplication) {
    self.app = app
    
    XCTAssertTrue(arView.waitForExistence(timeout: 5), "arView should be visible")
  }
  
  private var arView: XCUIElement {
    app.otherElements["arView"].firstMatch
  }
  
  private var addEntityButton: XCUIElement {
    app.buttons["addEntityButton"].firstMatch
  }
  
  private var selectedEntityName: XCUIElement {
    app.staticTexts["selectedEntityName"].firstMatch
  }
  
  @discardableResult
  func tapAddEntityButton() -> AddEntityOverlayPageObject {
    testStep("Tap Add Entity Button") {
      addEntityButton.tap()
    }
    return AddEntityOverlayPageObject(app: app)
  }
  
  @discardableResult
  func tapCenterOfScreen() -> Self {
    testStep("Tap center of screen") {
      let coordinate = arView.coordinate(withNormalizedOffset: .init(dx: 0.5, dy: 0.5))
      coordinate.tap()
    }
    return self
  }
  
  func assertSelectedEntity(named: String) {
    XCTAssertTrue(selectedEntityName.label == named, "Correct entity should have been selected")
  }
}
