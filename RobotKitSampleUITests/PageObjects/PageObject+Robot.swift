//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

extension PageObject {
  
  func moveRobot(closure: () async throws -> Void) async throws -> Self {
    try await closure()
    return self
  }
}
