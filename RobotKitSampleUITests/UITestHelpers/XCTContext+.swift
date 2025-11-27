//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import XCTest

// Makes the output nicer in the test report
@MainActor
public func testStep<T>(_ description: String, block: () throws -> T) rethrows -> T {
  try XCTContext.runActivity(named: description, block: { _ in
    try block()
  })
}
