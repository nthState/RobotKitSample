//
//  Copyright © 2025 nthState Ltd. All rights reserved.
//

import OSLog

extension Logger {
  private static let subsystem = Bundle.main.bundleIdentifier ?? "RobotKitSample"
  
  public static let sample = Logger(subsystem: subsystem, category: "RobotKitSample")
}
