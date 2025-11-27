//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import XCTest

@MainActor
class BaseUITest: XCTestCase {
  public var app = XCUIApplication()
  
  override func setUp() async throws {
    try await super.setUp()
    
    continueAfterFailure = false

    app.launch()
  }
  
  override func tearDown() async throws {
    app.terminate()
    
    try await super.tearDown()
  }

}
