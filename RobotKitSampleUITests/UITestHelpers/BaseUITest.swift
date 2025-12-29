//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import XCTest

@MainActor
class BaseUITest: XCTestCase {
  public var app = XCUIApplication()
  
  override func setUp() async throws {
    try await super.setUp()
    
    addUIInterruptionMonitor(withDescription: "Local Network Alert") { alert in
      if alert.buttons["OK"].exists {
        alert.buttons["OK"].tap()
        return true
      }
      if alert.buttons["Allow"].exists {
        alert.buttons["Allow"].tap()
        return true
      }
      return false
    }
    
    continueAfterFailure = false
    
    app.launch()
  }
  
  override func tearDown() async throws {
    app.terminate()
    
    try await super.tearDown()
  }
  
  func waitFor(aSecond seconds: TimeInterval) {
    let expectation = expectation(description: "waiting for \(seconds)")
    let timer = Timer(timeInterval: seconds, repeats: false) { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: seconds)
  }
  
  func connectToLocalNetwork(url: URL) {
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      if let data {
        print("Data: \(String(data: data, encoding: .utf8) ?? "")")
      }
    }.resume()
  }
}
