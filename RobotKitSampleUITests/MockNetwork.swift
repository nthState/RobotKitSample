//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import OSLog
import TestingReality

/**
 Mock Network delays and sends back the input
 */
final class MockNetwork: Networkable, Sendable {
  
  let delay: UInt64
  
  init(delay: UInt64) {
    self.delay = delay
  }
  
  func send(data: Data) async throws -> Data {
    try await Task.sleep(nanoseconds: delay * 1_000_000_000)
    return data
  }
}
