//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import XCTest

public protocol PageObject {
  @MainActor init(app: XCUIApplication)
}
